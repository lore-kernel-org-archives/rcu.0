Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057494;
	b=Ou8xlfLXh4yb9HlZqhfoN8P5hPvYNcUN0LEAh3HALBrjPEx0hClDUevbOK00zgJvIluV
	 pApKvegq1lnPRZa9GEphY1E8URyBzienPU1BQNzbq3bkFpKEPy8caWqy5zPenprBFySd6
	 5AtYlQxc+I/yooeHH6rYcxxXfacTtcCNHDTzvGIf1HOwsqZ1ubwpzZZZJt7AwSqs5/YkJ
	 xul9h8onT0aXINojgU0YnMEQlxLWABSnBULDx2c/p78xmkeT4SufGXmIJjKZ3pF8FSbBn
	 jwTX18E1QZwF2mCwsXYnfceIgCgEsN2UsxD/SocXlW+QtUxOLfle9ibGEtyqhC2Grrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057494;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=MvmshXKsgvlL7yA7pYzz7rQMYWGPWsd1FbsLikdog2M=;
	b=yCytJBfX9/Qq36JIGvXbjDYT2ay+8s08zK+DfV4sTJlvvq1mj6dloEzuHKR0mcBDrfva
	 wuW2u3kBExr/ytz2nDrTVgrFiDqKxjvXTazYAwQvr91V9Y+9GKX1hzJigKx881nW62ZiK
	 2lc9YoWa5MGUvuPtEWmNGe9BrGjxY5iX+Uyq2okjVe77cwrPoRZiVo79VKmgsjzFMPo83
	 33e4vJnlgVr4HeYByBdtyKFXs+32fhXNqzNWjMlZ/cnbFWd+I1aOUH7KfxJTi98WYR6ap
	 rlosR+QbevB9FGCvJnQXp/H6dIIM2r9/duiU++5hwd/wk9sHFtTZ4qPXIcUaKO7Wt3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDSLj8Yf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA3606A31E;
	Mon, 26 Oct 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDSLj8Yf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C501F01828;
	Mon, 26 Oct 2026 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057493;
	bh=MvmshXKsgvlL7yA7pYzz7rQMYWGPWsd1FbsLikdog2M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ZDSLj8Yf+Ge+XCP/KMRmBx6M8o0oZuPjSB/2+1unK6AeHelFmU2kMvWnLveQ202UL
	 ANqzxZ6hKwMExJsiv8YSXsZ6UxjC6Col7lK8ZNj1jkvSaJCiNVTBLkCGsM+Jy1qKZc
	 I1EIM/QVGiTcpPj63M1ehXEnOowwGfs0z2gp9ENeh7RYb4ZPri4+OGd+9QEwMf8TrX
	 7TGWsoOtU4FCUIrq9CPmFF0yOSD2VYCiDpNj/qzGYIDI7gq3lj7QTDfPD11vIcffy2
	 WAnrl67T47k6PL8Od6wEOmeF79sQNfBxzP9sa4MHSbKG+aIB3kyp33f7yJ2UAyfDlD
	 RhSTmZmcpGaZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87CCACE0C35; Mon, 26 Oct 2026 16:31:33 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:31:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 9/9] rcu-tasks: Detect duplicate callback enqueue
Message-ID: <004be859-71a2-42f9-af3d-958ad70f38f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-10-kunwu.chan@gmail.com>
 <cdd3f35d-9e9a-4b87-bea7-59ff3e1a7390@paulmck-laptop>
 <CAN_Opa_eWF27jfz_HfXjUEw_raQb-j8Q1TMHLr9cx0P=N2-s6Q@mail.gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa_eWF27jfz_HfXjUEw_raQb-j8Q1TMHLr9cx0P=N2-s6Q@mail.gmail.com>

On Mon, Oct 26, 2026 at 10:36:02AM +0800, KunWu Chan wrote:
> On Sat, Oct 24, 2026 at 3:31 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Oct 23, 2026 at 06:18:41PM +0800, Kunwu Chan wrote:
> > > Detect duplicate callback enqueue attempts in the generic
> > > RCU Tasks callback registration path.
> > >
> > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> >
> > And the same questions for this patch as well.  ;-)
> 
> Same changes applied: pr_err_ratelimited() and dump_stack.

Very good, thank you!

							Thanx, Paul

> Thanks,
> Kunwu
> 
> >
> >                                                         Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/tasks.h | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 5d7f234795b4..49b716feb31d 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -6,6 +6,7 @@
> > >   */
> > >
> > >  #ifdef CONFIG_TASKS_RCU_GENERIC
> > > +#include <linux/mm.h>
> > >  #include "rcu_segcblist.h"
> > >
> > >  ////////////////////////////////////////////////////////////////////////
> > > @@ -339,9 +340,12 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
> > >  }
> > >
> > >  // Enqueue a callback for the specified flavor of Tasks RCU.
> > > +static void rcu_tasks_leak_callback(struct rcu_head *rhp) { }
> > > +
> > >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >                                  struct rcu_tasks *rtp)
> > >  {
> > > +     static atomic_t doublefrees;
> > >       int chosen_cpu;
> > >       unsigned long flags;
> > >       bool havekthread = smp_load_acquire(&rtp->kthread_ptr);
> > > @@ -358,6 +362,16 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >       if (WARN_ON_ONCE(!func))
> > >               return;
> > >
> > > +     if (debug_rcu_head_queue(rhp)) {
> > > +             if (atomic_inc_return(&doublefrees) < 4) {
> > > +                     pr_err("%s(): Duplicate call_rcu_%s() CB %p->%pS()\n",
> > > +                            __func__, rtp->name, rhp, rhp->func);
> > > +                     mem_dump_obj(rhp);
> > > +             }
> > > +             WRITE_ONCE(rhp->func, rcu_tasks_leak_callback);
> > > +             return;
> > > +     }
> > > +
> > >       rhp->next = NULL;
> > >       rhp->func = func;
> > >       local_irq_save(flags);
> > > @@ -586,6 +600,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
> > >       raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > >       len = rcl.len;
> > >       for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> > > +             debug_rcu_head_unqueue(rhp);
> > >               debug_rcu_head_callback(rhp);
> > >               local_bh_disable();
> > >               rhp->func(rhp);
> > > --
> > > 2.43.0
> > >
