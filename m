Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C11C9B99;
	Wed,  9 Oct 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507409; cv=none; b=l446kOWZaVBuLsvuJ8JmVydCmZd1EccGdQtEd5cpBMzZlQqyNDwclGj0RcXcL1VoD9VRcZBF5wuCZ2QEjT0ebLte+1I3qYbxbTBK0wL0CznQJ0QwT5I2iwcGVUF3flmRjt6FapyCxcMLimAhtHeBJp1JIEkH/NNdEWLVoBk7Xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507409; c=relaxed/simple;
	bh=MQn5pIzSNKNxCJ4TyVpTFxXGMIrdzloKUY4LYoTkavM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkOzyCidkMo0umIZ2wsbBBA/1DHCwjN/exo01kUh7w9AvGzzUcolDQ5Qp+VW6Qayjx+b3oa50LAd8bZl0ZDTNbuIEVnUC4pdEv+/FFRRMdX+uQyJEx5TG2nLjwXQPaFsklDicBKU9+SqtTkx8jwkPChF8JbPlQ5mogBCZgBQWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv48pitJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv48pitJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C8C4CEC3;
	Wed,  9 Oct 2024 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728507409;
	bh=MQn5pIzSNKNxCJ4TyVpTFxXGMIrdzloKUY4LYoTkavM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv48pitJTSx3GjCMKb0KzKzJMd10mBWDtGD0BpbOl00bN9oI7iY8I8A1vpG15Q1z3
	 VL0OKIwqedK5yWpWdK0BEHSnux/X+LleTMZO11lGT5Wmsdxz4tuC/mVAzQFfk5kp8a
	 qhizYvyIb5Y4wQkSH5woJJpMzp+cA3JQw7Nzf/+9cuprTjukwTlf+TStoSwzhSMlAz
	 nb0MD9IMbswmWR5eGtj55eocrs/poh6BT4OECVN1au3+lPzCH22oWenlCVlBfFOe4V
	 kjkS3GHtjVv5iM+Og91tWOMszzKGg7XtRuFT00AXWiDzXZ6VIaB+X6oBGddzgjgDAD
	 fh038QupYP+4g==
Date: Wed, 9 Oct 2024 22:56:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 2/3] rcu/nocb: Fix rcuog wake-up from offline softirq
Message-ID: <ZwbuDj_tjpWzQDhL@pavilion.home>
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-3-frederic@kernel.org>
 <CAEXW_YQSBwGME1+vKHSM8+svtosunk-QO2oMygFKgapPE3b45w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQSBwGME1+vKHSM8+svtosunk-QO2oMygFKgapPE3b45w@mail.gmail.com>

Le Wed, Oct 09, 2024 at 02:23:15PM -0400, Joel Fernandes a écrit :
> Hi Frederic,
> 
> On Wed, Oct 2, 2024 at 10:57 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > After a CPU has set itself offline and before it eventually calls
> > rcutree_report_cpu_dead(), there are still opportunities for callbacks
> > to be enqueued, for example from an IRQ. When that happens on NOCB, the
> > rcuog wake-up is deferred through an IPI to an online CPU in order not
> > to call into the scheduler and risk arming the RT-bandwidth after
> > hrtimers have been migrated out and disabled.
> >
> > But performing a synchronized IPI from an IRQ is buggy as reported in
> > the following scenario:
> >
> >         WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_single
> >         Modules linked in: rcutorture torture
> >         CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00012-g9139f93209d1 #1
> >         Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120
> >         RIP: 0010:smp_call_function_single
> >         <IRQ>
> >         swake_up_one_online
> >         __call_rcu_nocb_wake
> >         __call_rcu_common
> >         ? rcu_torture_one_read
> >         call_timer_fn
> >         __run_timers
> >         run_timer_softirq
> >         handle_softirqs
> >         irq_exit_rcu
> 
> This call stack seems a bit confusing with the context of the first
> paragraph. In the beginning of changelog, you had mentioned the issue
> happens from IRQ, but in fact the callstack here is from softirq
> right? The IRQ issue should already be resolved in current code
> AFAICS.

Indeed, I need to s/IRQ/softirq for clarity.

> 
> >         ? tick_handle_periodic
> >         sysvec_apic_timer_interrupt
> >         </IRQ>
> >
> > The periodic tick must be shutdown when the CPU is offline, just like is
> > done for oneshot tick. This must be fixed but this is not enough:
> > softirqs can happen on any hardirq tail and reproduce the above scenario.
> >
> > Fix this with introducing a special deferred rcuog wake up mode when the
> > CPU is offline. This deferred wake up doesn't arm any timer and simply
> > wait for rcu_report_cpu_dead() to be called in order to flush any
> > pending rcuog wake up.
> [...]
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index a9a811d9d7a3..7ed060edd12b 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -290,6 +290,7 @@ struct rcu_data {
> >  #define RCU_NOCB_WAKE_LAZY     2
> >  #define RCU_NOCB_WAKE          3
> >  #define RCU_NOCB_WAKE_FORCE    4
> > +#define RCU_NOCB_WAKE_OFFLINE   5
> >
> >  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
> >                                         /* For jiffies_till_first_fqs and */
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 2fb803f863da..8648233e1717 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -295,6 +295,8 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >         case RCU_NOCB_WAKE_FORCE:
> >                 if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
> >                         mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
> > +               fallthrough;
> > +       case RCU_NOCB_WAKE_OFFLINE:
> >                 if (rdp_gp->nocb_defer_wakeup < waketype)
> >                         WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> >                 break;
> > @@ -562,8 +564,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >         lazy_len = READ_ONCE(rdp->lazy_len);
> >         if (was_alldone) {
> >                 rdp->qlen_last_fqs_check = len;
> > -               // Only lazy CBs in bypass list
> > -               if (lazy_len && bypass_len == lazy_len) {
> > +               if (cpu_is_offline(rdp->cpu)) {
> > +                       /*
> > +                        * Offline CPUs can't call swake_up_one_online() from IRQs. Rely
> > +                        * on the final deferred wake-up rcutree_report_cpu_dead()
> > +                        */
> > +                       rcu_nocb_unlock(rdp);
> > +                       wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_OFFLINE,
> > +                                          TPS("WakeEmptyIsDeferredOffline"));
> > +               } else if (lazy_len && bypass_len == lazy_len) {
> 
> Since the call stack is when softirqs are disabled,  would an
> alternative fix be (pseudocode):
> 
> Change the following in the "if (was_alldone)" block:
> 
>                if (!irqs_disabled_flags(flags)) {
> 
> to:
>                if (!irqs_disabled_flags(flags) && !in_softirq())
> 
> ?
> 
> That way perhaps an additional RCU_NOCB flag is not needed.
> 
> Or does that not work for some reason?

It works but this forces the wake-up through the timer when a callback is
enqueued from softirqs. And waking up from the timer is a bit more overhead
and also added GP delay. It could be this though:

    if (!irqs_disabled_flags(flags) && cpu_online(smp_processor_id()))

Hmm?

Thanks.
> 
> thanks,
> 
>  - Joel
