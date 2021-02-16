Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C86C433E6
	for <rcu@archiver.kernel.org>; Tue, 16 Feb 2021 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E0364E2B
	for <rcu@archiver.kernel.org>; Tue, 16 Feb 2021 17:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhBPRax (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhBPRao (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Feb 2021 12:30:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C31B64E07;
        Tue, 16 Feb 2021 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613496604;
        bh=q8o+n9wdMcLOe4+09NLvFllthhDbuG79whasE32Labs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=seHd5EfLXG5hxdi7tM3mf3nL+kDCc2IH5fjNTl6hfgmWuri4FASUlbMuTKGumJXgf
         dbVcHWyPBg3KZ/tVlKkgc3CBTQgVrJS24qrLgnq2tqeHSMtw8H233Ii5hPL6w/lrE0
         KBPNcaU6pGbRNdcFmaTdjAiF+QaIACS9hAOwNYvh1odjfBB20Yrcj4yxHyT4ri+V/h
         qvDOTB9iF+wGm2Fv/iQmCky0midOsoA/ATLLDebsT45NcopFiQ+RTFDAouDrVWPQ96
         lPYqU1FMQow3bY23WAj3r4Q2GnNcqFM9uOJPMcnCOy5UtjeLrSVv5D+Ngr8YgN4Tq4
         Nsh/HV1SvLpfg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C1C2935238D3; Tue, 16 Feb 2021 09:30:03 -0800 (PST)
Date:   Tue, 16 Feb 2021 09:30:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20210216173003.GX2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
 <20210212211207.GA2046@pc638.lan>
 <20210212234851.GP2743@paulmck-ThinkPad-P72>
 <20210213003709.GA27846@paulmck-ThinkPad-P72>
 <20210213004328.GB27846@paulmck-ThinkPad-P72>
 <20210213113030.GA1878@pc638.lan>
 <20210213164554.GS2743@paulmck-ThinkPad-P72>
 <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 15, 2021 at 12:28:26PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-13 08:45:54 [-0800], Paul E. McKenney wrote:
> > Glad you like it!  But let's see which (if any) of these patches solves
> > the problem for Sebastian.
> 
> Looking at that, is there any reason for doing this that can not be
> solved by moving the self-test a little later? Maybe once we reached at
> least SYSTEM_SCHEDULING?

One problem is that ksoftirqd and the kprobes use are early_initcall(),
so we cannot count on ksoftirqd being spawned when kprobes first uses
synchronize_rcu_tasks().  Moving the selftest later won't fix this
problem, but rather just paper it over.

> This happens now even before lockdep is up or the console is registered.
> So if something bad happens, you end up with a blank terminal.

I was getting a splat, but I could easily believe that there are
configurations where the hang is totally silent.  In other words, I do
agree that this needs a proper fix.  All we need do is work out an
agreeable value of "proper".  ;-)

> There is nothing else that early in the boot process that requires
> working softirq. The only exception to this is wait_task_inactive()
> which is used while starting a new thread (including the ksoftirqd)
> which is why it was moved to schedule_hrtimeout().

Moving kprobes initialization to early_initcall() [1] means that there
can be a call to synchronize_rcu_tasks() before the current spawning of
ksoftirqd.  Because synchronize_rcu_tasks() needs timers to work, it needs
softirq to work.  I know two straightforward ways to make that happen:

1.	Spawn ksoftirqd earlier.

2.	Suppress attempts to awaken ksoftirqd before it exists,
	forcing all ksoftirq execution on the back of interrupts.

Uladzislau and I each produced patches for #1, and I produced a patch
for #2.

The only other option I know of is to push the call to init_kprobes()
later in the boot sequence, perhaps to its original subsys_initcall(),
or maybe only as late as core_initcall().  I added Masami and Steve on
CC for their thoughts on this.

Is there some other proper fix that I am missing?

						Thanx, Paul

[1] 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
