Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF979C2D0E4
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732A9206E3
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 19:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgKWTcw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:32:52 -0500
Received: from foss.arm.com ([217.140.110.172]:38780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbgKWTcv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Nov 2020 14:32:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97DE4101E;
        Mon, 23 Nov 2020 11:32:50 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDCC93F71F;
        Mon, 23 Nov 2020 11:32:46 -0800 (PST)
Date:   Mon, 23 Nov 2020 19:32:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201123193241.GA45639@C02TD0UTHF1T.local>
References: <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
 <20201120103031.GB2328@C02TD0UTHF1T.local>
 <20201120140332.GA3120165@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120140332.GA3120165@elver.google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 03:03:32PM +0100, Marco Elver wrote:
> On Fri, Nov 20, 2020 at 10:30AM +0000, Mark Rutland wrote:
> > On Thu, Nov 19, 2020 at 10:53:53PM +0000, Will Deacon wrote:
> > > FWIW, arm64 is known broken wrt lockdep and irq tracing atm. Mark has been
> > > looking at that and I think he is close to having something workable.
> > > 
> > > Mark -- is there anything Marco and Paul can try out?
> > 
> > I initially traced some issues back to commit:
> > 
> >   044d0d6de9f50192 ("lockdep: Only trace IRQ edges")
> > 
> > ... and that change of semantic could cause us to miss edges in some
> > cases, but IIUC mostly where we haven't done the right thing in
> > exception entry/return.
> > 
> > I don't think my patches address this case yet, but my WIP (currently
> > just fixing user<->kernel transitions) is at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/irq-fixes
> > 
> > I'm looking into the kernel<->kernel transitions now, and I know that we
> > mess up RCU management for a small window around arch_cpu_idle, but it's
> > not immediately clear to me if either of those cases could cause this
> > report.
> 
> Thank you -- I tried your irq-fixes, however that didn't seem to fix the
> problem (still get warnings and then a panic). :-/

I've just updated that branch with a new version which I hope covers
kernel<->kernel transitions too. If you get a chance, would you mind
giving that a spin?

The HEAD commit should be:

  a51334f033f8ee88 ("HACK: check IRQ tracing has RCU watching")

Otherwise, I intend to clean that up and post it tomorrow (without the
additional debug hacks). I've thrown my local Syzkaller instance at it
in the mean time (and if I get the chance tomrrow I'll try to get
rcutorture setup), and the only report I'm seeing so far looks genuine:

| BUG: sleeping function called from invalid context in sta_info_move_state

... as that was reported on x86 too, per:

https://syzkaller.appspot.com/bug?id=6c7899acf008be2ddcddb46a2567c2153193632a

Thanks,
Mark.
