Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDBAEEAA4E
	for <rcu@archiver.kernel.org>; Thu, 14 Sep 2023 15:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbjINPXq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Sep 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjINPXq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Sep 2023 11:23:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFEC1
        for <rcu@vger.kernel.org>; Thu, 14 Sep 2023 08:23:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF3C433C7;
        Thu, 14 Sep 2023 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694705021;
        bh=oLGFUxOb68mW6lcsswV0aw0TMqztVwDDdlNFHem5Tfc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l+QFcmeB5ANt9v7hKWxRYH9q8XH5GJiiuWN8LIf+1Q+IbqT/HgghcISsjjm925P6L
         QFDRnDDPVVJ1Vg2racw+1xtbqz79IH44Sb/rtk8F0Ijehn+CjGLQ31FG2YT6gqpEtk
         syaX2o/FGwDEzVHfP7WBKqzmfrBOmhREMFYAzi5LnvJdbDGU4YgnvyGO3zblOIFGZB
         inZDBhD4AL6Q2XRd4RrAjJdNxKlp0n0y70FADtnDzdO3Y62c/RFaYlCwC1UzrYADj8
         SMmvbBie93VzmlD24Cq9Op1Ze2h48ZjsHjniAbTcWzhBgtEu8FP/y82ZonEw63+HEE
         DUJ/eQv5uzPyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B8A0CE093C; Thu, 14 Sep 2023 08:23:38 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:23:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230910201445.GA1605059@google.com>
 <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914131351.GA2274683@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 14, 2023 at 01:13:51PM +0000, Joel Fernandes wrote:
> On Thu, Sep 14, 2023 at 04:11:26AM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 13, 2023 at 04:30:20PM -0400, Joel Fernandes wrote:
> > > On Mon, Sep 11, 2023 at 4:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > [..]
> > > > > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > > > > and then I'll also look at why is it being pushed out in the first place.
> > > > >
> > > > > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > > > > for several hours.
> > > >
> > > > Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> > > > the problem still occurs?  If yes, then there is definitely some reason
> > > > other than CPU hotplug that makes this happen.
> > > 
> > > Hi Paul,
> > > So looks so far like onoff_interval=0 makes the issue disappear. So
> > > likely hotplug related. I am ok with doing the cpus_read_lock during
> > > boost testing and seeing if that fixes it. If it does, I can move on
> > > to the next thing in my backlog.
> > > 
> > > What do you think? Or should I spend more time root-causing it? It is
> > > most like runaway RT threads combined with the CPU hotplug threads,
> > > making scheduling of the rcu_preempt thread not happen. But I can't
> > > say for sure without more/better tracing (Speaking of better tracing,
> > > I am adding core-dump support to rcutorture, but it is not there yet).
> > 
> > This would not be the first time rcutorture has had trouble with those
> > threads, so I am for adding the cpus_read_lock().
> > 
> > Additional root-causing might be helpful, but then again, you might
> > have higher priority things to worry about.  ;-)
> 
> No worries. Unfortunately putting cpus_read_lock() around the boost test
> causes hangs. I tried something like the following [1]. If you have a diff, I can
> quickly try something to see if the issue goes away as well.

The other approaches that occur to me are:

1.	Synchronize with the torture.c CPU-hotplug code.  This is a bit
	tricky as well.

2.	Rearrange the testing to convert one of the TREE0* scenarios that
	is not in CFLIST (TREE06 or TREE08) to a real-time configuration,
	with boosting but without CPU hotplug.	Then remove boosting
	from TREE04.

Of these, #2 seems most productive.  But is there a better way?

> I am also interested in tracing further the state of CPUs when the back and
> forth migration happens. That code is really hairy (select_fallback_rq())
> with some scary code comments about more audit being needed, so I would not
> be surprised if something is off there. I left some trace prints in there [2]
> to see if I can gather more information. I'll let you know if I find
> anything there.

Looking forward to seeing what you come up with!

> [ btw I'm officially OOO from Mon-Thurs next week, that's mostly Ok since the
> last set stable releases just got done. Though I might cheat and attend to
> low-hanging fruit type of tasks like documentation during the OOO :-D ]

Have a good time away!

							Thanx, Paul

> [1]
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 9c028b118abc..4354f87f522a 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1115,6 +1115,7 @@ static int rcu_torture_boost(void *arg)
>  		}
>  
>  		// Do one boost-test interval.
> +		cpus_read_lock();
>  		endtime = oldstarttime + test_boost_duration * HZ;
>  		while (time_before(jiffies, endtime)) {
>  			// Has current GP gone too long?
> @@ -1164,7 +1165,7 @@ static int rcu_torture_boost(void *arg)
>  			}
>  			schedule_timeout_uninterruptible(1);
>  		}
> -
> +		cpus_read_unlock();
>  		/* Go do the stutter. */
>  checkwait:	if (stutter_wait("rcu_torture_boost"))
>  			sched_set_fifo_low(current);
> -- 
> 
> [2]
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1569e9591654..1e79e059e578 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2552,6 +2552,12 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
>  	rq = cpu_rq(new_cpu);
>  
>  	rq_lock(rq, rf);
> +	if (rq->curr) {
> +		trace_printk("Curr on new_cpu (%d) is: %s[%d]\n",
> +				new_cpu, rq->curr->comm, task_pid_nr(rq->curr));
> +	} else {
> +		trace_printk("Curr on new_cpu (%d) is NULL\n", new_cpu);
> +	}
>  	WARN_ON_ONCE(task_cpu(p) != new_cpu);
>  	activate_task(rq, p, 0);
>  	check_preempt_curr(rq, p, 0);
> @@ -9490,6 +9496,11 @@ static int __balance_push_cpu_stop(void *arg)
>  		trace_printk("attempt push task %d currently on cpu %d to...\n", task_pid_nr(p), rq->cpu);
>  		cpu = select_fallback_rq(rq->cpu, p);
>  		trace_printk("to new cpu %d\n", cpu);
> +		trace_printk("is_cpu_allowed(%d), md(p)=%d, pf_kthread=%d, kthread_is_per_cpu=%d, cpu_online=%d, cpu_dying=%d\n",
> +				cpu,
> +				is_migration_disabled(p),
> +				p->flags & PF_KTHREAD, kthread_is_per_cpu(p),
> +				cpu_online(cpu), cpu_dying(cpu));
>  		rq = __migrate_task(rq, &rf, p, cpu);
>  		trace_printk("After __migrate_task, new cpu = %d\n", rq->cpu);
>  	}
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
