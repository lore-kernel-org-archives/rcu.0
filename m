Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B544C433DB
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 05:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1246564D7F
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 05:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhBRFDz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 00:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhBRFDy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 00:03:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92FBC64DA8;
        Thu, 18 Feb 2021 05:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613624593;
        bh=BiZSHcxv8WWzDhcxoQsCPxk7cnJSi3PjK2CmEvrCw6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WWUnQt3jhz4DBOiq/9gWeyyHj0wq+gYQiCGvLM7QhwozF2wxr960YniXx4RVUPpnY
         NkonaOKbPTmJL5t+JjymvZxhlm+WAgsaYGqSY9+bNJR0Pjos5zyJz8K7KloaBkaoEX
         RoYtAJXDMVVCGa8uVoy6QAtnbsb1Lat18fAf7HsfPaoUvtNjCLjeRyNvNDZbZ6ilGT
         Q1HKljFmlkkw8aBypwbB9cuXqF9EfkGC6wMFrtniTNPUrmP0aKw0qZYd4BUhrqtbq8
         bJoZJLkiD9oDWmi5mzEl9xnCCuXPNiS0ST0shHQ9BAAjTKQirRuOvJpVg/HyvFlwPZ
         cusTnFCd9mRuA==
Date:   Thu, 18 Feb 2021 14:03:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
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
Message-Id: <20210218140307.71f475248ebefa0ca613c09e@kernel.org>
In-Reply-To: <20210217181738.GE2743@paulmck-ThinkPad-P72>
References: <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
        <20210212211207.GA2046@pc638.lan>
        <20210212234851.GP2743@paulmck-ThinkPad-P72>
        <20210213003709.GA27846@paulmck-ThinkPad-P72>
        <20210213004328.GB27846@paulmck-ThinkPad-P72>
        <20210213113030.GA1878@pc638.lan>
        <20210213164554.GS2743@paulmck-ThinkPad-P72>
        <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
        <20210216173003.GX2743@paulmck-ThinkPad-P72>
        <20210217234759.b82e39049a2e99cf6358e1c2@kernel.org>
        <20210217181738.GE2743@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 17 Feb 2021 10:17:38 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > 1.	Spawn ksoftirqd earlier.
> > > 
> > > 2.	Suppress attempts to awaken ksoftirqd before it exists,
> > > 	forcing all ksoftirq execution on the back of interrupts.
> > > 
> > > Uladzislau and I each produced patches for #1, and I produced a patch
> > > for #2.
> > > 
> > > The only other option I know of is to push the call to init_kprobes()
> > > later in the boot sequence, perhaps to its original subsys_initcall(),
> > > or maybe only as late as core_initcall().  I added Masami and Steve on
> > > CC for their thoughts on this.
> > > 
> > > Is there some other proper fix that I am missing?
> > 
> > Oh, I missed that the synchronize_rcu_tasks() will be involved the kprobes
> > in early stage. Does the problem only exist in the synchronize_rcu_tasks()
> > instead of synchronize_rcu()? If so I can just stop optimizer in early stage
> > because I just want to enable kprobes in early stage, but not optprobes.
> > 
> > Does the following patch help?
> 
> It does look to me like it would!  I clearly should have asked you about
> this a couple of months ago.  ;-)
> 
> The proof of the pudding would be whether the powerpc guys can apply
> this to v5.10-rc7 and have their kernel come up without hanging at boot.

Who could I ask for testing this patch, Uladzislau?
I think the test machine which enough slow or the kernel has much initcall
to run optimization thread while booting.
In my environment, I could not reproduce that issue because the optimizer
was sheduled after some tick passed. At that point, ksoftirqd has already
been initialized.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
