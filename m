Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C4C4332B
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79C76146D
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhBRQnQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhBROcC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 09:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C94364EAF;
        Thu, 18 Feb 2021 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613658581;
        bh=gBMWOqPhxwjnX0NxSeBxiAJyvG9RA9NvneE118cKIFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhCW+4mIljUv1RdMZ/cI/+kGRWbSQyA78JYmjqGVZf4fq/iiXPmxH/kczEk3FEmMf
         Mi7XlAApMcug88F30edufsfffCQGat9i1ICAu+sdpHnQf4J1O2zr1N09i5LsFHhzt0
         qLF1o6soFn8x3utTjRaBjnCRQQR3ioVKdkDPCHal3WjN5SdvEwVdxhczWKf0MPbdVe
         To5gKfUZEPkUm4DQMEpvqw4YvhVBgnTeGDN8Cr8jr8ueju2Zua4y+6Pat99NBHv0xU
         pntiJTeZZrcBcGfpFqI4xjx84BthlLclQdQWdpbs66PbPoSQqaAqNSJly5Yl7NjIj7
         59wFwpsGnrzVw==
Date:   Thu, 18 Feb 2021 23:29:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-Id: <20210218232936.c3158cc304e13151484de3c2@kernel.org>
In-Reply-To: <20210218083636.GA2030@pc638.lan>
References: <20210212234851.GP2743@paulmck-ThinkPad-P72>
        <20210213003709.GA27846@paulmck-ThinkPad-P72>
        <20210213004328.GB27846@paulmck-ThinkPad-P72>
        <20210213113030.GA1878@pc638.lan>
        <20210213164554.GS2743@paulmck-ThinkPad-P72>
        <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
        <20210216173003.GX2743@paulmck-ThinkPad-P72>
        <20210217234759.b82e39049a2e99cf6358e1c2@kernel.org>
        <20210217181738.GE2743@paulmck-ThinkPad-P72>
        <20210218140307.71f475248ebefa0ca613c09e@kernel.org>
        <20210218083636.GA2030@pc638.lan>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 18 Feb 2021 09:36:36 +0100
Uladzislau Rezki <urezki@gmail.com> wrote:

> On Thu, Feb 18, 2021 at 02:03:07PM +0900, Masami Hiramatsu wrote:
> > On Wed, 17 Feb 2021 10:17:38 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > > > 1.	Spawn ksoftirqd earlier.
> > > > > 
> > > > > 2.	Suppress attempts to awaken ksoftirqd before it exists,
> > > > > 	forcing all ksoftirq execution on the back of interrupts.
> > > > > 
> > > > > Uladzislau and I each produced patches for #1, and I produced a patch
> > > > > for #2.
> > > > > 
> > > > > The only other option I know of is to push the call to init_kprobes()
> > > > > later in the boot sequence, perhaps to its original subsys_initcall(),
> > > > > or maybe only as late as core_initcall().  I added Masami and Steve on
> > > > > CC for their thoughts on this.
> > > > > 
> > > > > Is there some other proper fix that I am missing?
> > > > 
> > > > Oh, I missed that the synchronize_rcu_tasks() will be involved the kprobes
> > > > in early stage. Does the problem only exist in the synchronize_rcu_tasks()
> > > > instead of synchronize_rcu()? If so I can just stop optimizer in early stage
> > > > because I just want to enable kprobes in early stage, but not optprobes.
> > > > 
> > > > Does the following patch help?
> > > 
> > > It does look to me like it would!  I clearly should have asked you about
> > > this a couple of months ago.  ;-)
> > > 
> > > The proof of the pudding would be whether the powerpc guys can apply
> > > this to v5.10-rc7 and have their kernel come up without hanging at boot.
> > 
> > Who could I ask for testing this patch, Uladzislau?
> > I think the test machine which enough slow or the kernel has much initcall
> > to run optimization thread while booting.
> > In my environment, I could not reproduce that issue because the optimizer
> > was sheduled after some tick passed. At that point, ksoftirqd has already
> > been initialized.
> > 
> From my end i did some simulation and had a look at your change. So the
> patch works on my setup. I see that optimization of kprobes is deferred
> and can be initiated only from the subsys_initcall() phase. So the sequence
> should be correct for v5.10-rc7:
> 
> 1. ksoftirq is setup early_initcall();

    also kprobe framework is initialized in early_initcall() and
    kprobes smoketest (register/unregister probes) executed.

> 2. rcu_spawn_tasks_* are setup in the core_initcall();

    and kprobe events are setup in core_initcall_sync() (via trace_boot);

> 3. an optimization of kprobes are invoked from subsys_initcall().

   At this point, all kprobes which can be optimized will be actually
   optimized.


> For real test on power-pc you can ask Daniel Axtens <dja@axtens.net> for help. 

OK, I'll CC to Daniel.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
