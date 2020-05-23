Return-Path: <SRS0=2ft+=7F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D0AC433E0
	for <rcu@archiver.kernel.org>; Sat, 23 May 2020 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7EC20849
	for <rcu@archiver.kernel.org>; Sat, 23 May 2020 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590253152;
	bh=sJKPAoS2JphcJsCNgw/SfE8Hx7/rTddjhOwUyHhfCZw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bbV+vy0fyyUmbTyMdB8QVKKZIF3vhuww/pU48cZie5+zhLAtrVyGP9O8qqKGA/QBy
	 C+x0z7yXolM7GvwrTO6YnvcQghon8R7ZaQKAxRcg9XXoMGyTx8cPbO/xgG1S5v7+WF
	 HMG/fhK6vEw2Vy5DL6AWtguCOTQ3GzuFwLJyAj3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgEWQ7M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 May 2020 12:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgEWQ7M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 May 2020 12:59:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9808920738;
        Sat, 23 May 2020 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590253151;
        bh=sJKPAoS2JphcJsCNgw/SfE8Hx7/rTddjhOwUyHhfCZw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TnLemG7d+DdfKLmwDBpwm1W89zi3EHFbF2aXLJM0sbJJGF2WRyrld4TDAahCwRkqW
         hZ8o3uez1QcUnB+D/w47tqlG/00RTDzlQ333Q8dMDRd1Jtk9ntpsOVU0OEuxzLqrBB
         qx2HIk9qL9kbwrSUmg9QbzuULIICxleSVfBGCKxE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C8213522680; Sat, 23 May 2020 09:59:11 -0700 (PDT)
Date:   Sat, 23 May 2020 09:59:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200523165911.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
 <20200522173953.GI2869@paulmck-ThinkPad-P72>
 <20200523150831.wdrthklakwm6wago@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523150831.wdrthklakwm6wago@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 23, 2020 at 05:08:31PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-22 10:39:53 [-0700], Paul E. McKenney wrote:
> > It looks good to me, but I have not yet tested it.  (Happy to let you
> > take the first crack at rcutorture in any case, scenarios SRCU-P and
> > SRCU-N.)
> 
> on it.
> 
> > > That check_init_srcu_struct() is needed, because otherwise:
> > > 
> > > | BUG: spinlock bad magic on CPU#2, swapper/0/1
> > > |  lock: 0xffff88803ed28ac0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> > > | CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6+ #81
> > > | Call Trace:
> > > |  dump_stack+0x71/0xa0
> > > |  do_raw_spin_lock+0x6c/0xb0
> > > |  _raw_spin_lock_irqsave+0x33/0x40
> > > |  synchronize_srcu+0x24/0xc9
> > > |  wakeup_source_remove+0x4d/0x70
> > > |  wakeup_source_unregister.part.0+0x9/0x40
> > > |  device_wakeup_enable+0x99/0xc0
> > > 
> > > I'm not sure if there should be an explicit init of `wakeup_srcu' or if
> > > an srcu function (like call_srcu()) is supposed to do it.
> > 
> > It is fine.  Beforehand, that check_init_srcu_struct() would have been
> > invoked very shortly thereafter from __call_srcu(), and there is no
> > instead harm invoking it a few microseconds earlier.  ;-)
> 
> Oki. I wasn't sure if an explizit initialized on wakeup_srcu's side was
> missing or if this is new since we use the lock earlier.

If you want to worry, the cause for concern that comes to mind is lock
contention.  Except that this is a per-CPU lock, and it isn't acquired
all that often.  And when it is acquired often (call_srcu() floods, for
example), it is acquired on the CPU in question.  So seems unlikely.

But should lock contention nevertheless become a problem:

1.	Tighten up any acquisitions to avoid unncessary off-CPU
	acquisition of this lock.

2.	Convert this particular lock acquisition into a trylock,
	and make trylock failure return such that a non-expedited
	grace period results.

But again, I don't see the need for these at the moment.

							Thanx, Paul
