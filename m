Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51837C25B47
	for <rcu@archiver.kernel.org>; Wed, 25 Oct 2023 11:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjJYLZT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Oct 2023 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLZS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Oct 2023 07:25:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7FE8;
        Wed, 25 Oct 2023 04:25:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00141C433C8;
        Wed, 25 Oct 2023 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698233116;
        bh=5uusWVbXG7Uj0EgQfGTXqjuq5lmrkasn/FKrRVX44Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGt+g5V3Zl8EzuEQB/2XMI1bQKtETncmWYWEUQ0FEpbBG6M2SijVhsO2PvAkKhwlh
         C9u2aW5XQdYwdOAeTVnpZKWV2b+HQlyB8z6ZD42jahfYo9+5KniKu7rW8+0XaetlRK
         y/b7ioD3YA+om5644/nJ3XRucMPIdgFrvJJ5FFRtrkoQjDRIFsD7n1HBEntjfACtVS
         Ns5lgeoxDXnBaJWEAiFZsihJr4Y1hkTrmfJasFa1UK85QLYk5hANmnW1E/TbC3o4nR
         vZGjtttm66STNLOb9yhA6eVArcSoSFwhsUCTC/WDgirZDEWPBEGW/YqwjTOO+k47F2
         3YBp932cghCCA==
Date:   Wed, 25 Oct 2023 13:25:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 4/4] sched: Exclude CPU boot code from PF_IDLE area
Message-ID: <ZTj7GYUcU950X-Mc@localhost.localdomain>
References: <20231024214625.6483-1-frederic@kernel.org>
 <20231024214625.6483-5-frederic@kernel.org>
 <20231025084833.GE37471@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025084833.GE37471@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Wed, Oct 25, 2023 at 10:48:33AM +0200, Peter Zijlstra a écrit :
> On Tue, Oct 24, 2023 at 11:46:25PM +0200, Frederic Weisbecker wrote:
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8885be2c143e..ad18962b921d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1945,7 +1945,7 @@ extern struct task_struct *idle_task(int cpu);
> >   */
> >  static __always_inline bool is_idle_task(const struct task_struct *p)
> >  {
> > -	return !!(p->flags & PF_IDLE);
> > +	return !!(READ_ONCE(p->flags) & PF_IDLE);
> >  }
> >  
> >  extern struct task_struct *curr_task(int cpu);
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 3b9d5c7eb4a2..3a1991010f4e 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
> >  {
> >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> >  
> > +	WRITE_ONCE(current->flags, current->flags & ~PF_IDLE);
> >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> > +
> >  	rcutree_report_cpu_dead();
> >  	st->state = CPUHP_AP_IDLE_DEAD;
> >  	/*
> > @@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
> >  {
> >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> >  
> > +	WRITE_ONCE(current->flags, current->flags | PF_IDLE);
> > +
> >  	/* Happens for the boot cpu */
> >  	if (state != CPUHP_AP_ONLINE_IDLE)
> >  		return;
> 
> Without changing *ALL* ->flags stores to WRITE_ONCE() I don't see the
> point of this. Also, since we only care about a single bit, how does
> store tearing affect things?
> 
> Not to mention if we're really paranoid, what are the SMP ordering
> considerations :-)
> 
> [ also, PF_ is used for Protocol Family, Page Flag and Process Flag,
>   grepping is a pain in the arse :-( ]

Indeed. Also cpuhp_online_idle() is called with preemption disabled
and cpuhp_report_idle_dead() with interrupts disabled. As for idle
injection in play_idle_precise(), the flag is set and cleared with
preemption disabled.

This means that all writes are in an RCU read side critical section
that RCU-tasks pre-gp's synchronize_rcu() waits for. So I don't think
we need those WRITE_ONCE/READ_ONCE.

Paul are you ok with that?

Thanks.
