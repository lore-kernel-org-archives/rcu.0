Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D264594A
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878254; cv=pass; b=HyBIWymDi5W2XC2TE68U/4DsUUjdBqHBGNkmtJC+6k34lUavaTFpPXVOWo5DaiVaE1tq0a4Vn07wD8hJS4rWhaim5kQXvrZuwhU3H31PUEkrofIvPiouXtaUaiccIZm6laYFaDCuprgIrTm8TGzQ2wgqBofUB+NkEhxBJOnQJes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878254; c=relaxed/simple;
	bh=KopPrSzmkQxHbzfCHKwvDH8jOXTZub16xKm+FF2xFfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+4rypBnp7OLhGZGZ0mVIsxHl2lxdDQBCJ/stQyjKjcqtQnPog8TJuedb18VptmwGewTl0KVUa/GmHj5KO1HVqJ2z7Kt1ETZRItkfyYv5k4Q74Wo8n8slHWyUy0FjthCNbFmaGgAczqkHH70kgcfKp/q2rq+mjlHsRGx5gz1uH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkzyK6lj; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkzyK6lj"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43b4915161fso285936f8f.2
        for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 16:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773878251; cv=none;
        d=google.com; s=arc-20240605;
        b=F+j1rl02ud7VGTSoC7juNcQEBU2cEZTVV8Rc7G/4piSokLAfdfBBsOt+BV54uQaDJJ
         5kgTySgNkOc+pDonp7XRMjoE3iHhNhTWG1FRdGQZAOa5DRgqP5pLoFo7alHWYesZGzOr
         bH3uZo0HJK+ZOEr5xJw6IADoQ27D5k7fA7g4/K8gJEQvxhzDhoxwi1CSxk9pknH2/tse
         lHQ/6NmJIfilrIgHJx9ELcklAwe+YKQ9EbFZHJ7E8tL7OxshQwrgWTU0kSmihnF34Ljq
         wF6E/u9y+f9rVxWOJc6nHKfyq0x93zIo8kuObNtYMq/F4/TpVoPCynWTXypCMgSvPFlO
         ABgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LB/0U6OIxbhSOKMOnJDlz+V5XIRWWEvd68hu1TipwzI=;
        fh=60IR+kpNdcvDXcaioDVYuc11jFvViy9mdUIqe2WIsWs=;
        b=f55zdBUHHHI2K876BmzXxDwFQPzE7Edj9/AO0OWCc+I6CgeRI3W/iPqcljB/QLPHVa
         rodsUFvWoPeafciWe+TCyHHJe/eY3ccUXAIjzSQQg/jbzzalew3vmmktfXhJqxUafMbP
         SJMvsGRkSfjEIkn4dW9z+lJBuBJmRJY9EpT3YCZCFcbjz3KjtsKbmG9cm9VfeH5TRTkl
         58s9E+ELBa0kMUxShJzRZAYyEoQ5QpRAftSAwgaYugyPAMC3kaJkZg3ulp1f2h1QSnFe
         rVISszAMUGwk0RgHLcdCB8rBWrqr3LNdqPLS3p8OHkHQYPEByoyTu2fzZqY3RaROgHUi
         gKoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773878251; x=1774483051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LB/0U6OIxbhSOKMOnJDlz+V5XIRWWEvd68hu1TipwzI=;
        b=SkzyK6ljESAiqmFHKLjKvjhsqI35dJ9j4a7GBkypj9/EN2kp1DBNP0HLLK2sXsPpXh
         JTY7U1YS+FiNicuBU2BrOvz43ZAZbc+voNSljTOVNDP9zv4lTiX1HF9to7Pnh4owrj51
         8RxLukXOQ9TaJ5+ZYhnnMCh/+zK8I9F5necNBwA8ypBbCPFAeLDO0G54IRc32LbcHFp5
         GJdBvYJfb6OWl609dmcmMDjTkjz76MqwOII2wiauUCTtp1q1TI7NLLRro/KccN6KuTbB
         /xwPxIETBGdRUeDaeMpRxGgMATsbZhsHgaUsKM8L8YTEQICgga5vR6pZgvIp2s/k4Ke4
         lkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878251; x=1774483051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB/0U6OIxbhSOKMOnJDlz+V5XIRWWEvd68hu1TipwzI=;
        b=bVhTg728GQ8FvoJglpnPxrmyehDzWjs0CkFME4+f3s3uS7h71tYZMOyv1YHNAnG4Yl
         TM++NQxVJpwgTQBXH18TOQXz1Y/OAJ8h820Q9pv7Q30DNBsiKfBLYiPXCcFErG/q7mUV
         k/rxeQxnpZtBm9BS+K4WQdgH5se5lpjH+8HUQZ3ooSuAPrxnZScpmfNbEo0Qzg7c6zTw
         lVjXIsvHrp6R9X2tH0NoDcwSY11l6K608lI/F2qD0/HQMOtP6kreebabnstwafU/sgtr
         QhFPF3JuJOUqNJ2P2jlZb45maGBSFaT1sEfTAOos+G7ofMbrj3mLA8Zzz4T94PRocd1h
         d02A==
X-Forwarded-Encrypted: i=1; AJvYcCW11bZ4hgSkR/9v9ACopAr7+3ixzO6kiDTVYthqR0whtsyuSWI7qubTsc8Kd96+oN4krNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAbo1diMbr/vwJB3lngn2d4JEQNQg5inagyNKomDavWqBC0IT
	1p/1d3D/pVk02bgpCu8LhzPUBSvdyIQnEEhvK4vwLyTA3UZ7iWJO0oP5flfX1UWUIQAJcO7xG1W
	CxB21haKmj+Jw7a06cJ2fapf6lHiOElE=
X-Gm-Gg: ATEYQzzwoKZ0Ct6uLYLjgB+32rNxe+zR7kcVeMZIqRhr6xYVlhfa6M1BQKLqMOT4JyH
	YOlZHHhfGEY58I2jrh2zVVPv7u2Kawz7vTNomBuA4nolGh5EB6e9Ie/+jtuwUuBWuY7SzRc9ZoF
	w7y1K7j7dLp6q84zoTPrqOjO2QY7F+BCGSdp9wOfYUIfR3wocgeCljHl+wboAlrbOJGNDnf75/0
	F05hUQ3gJPSCNkVNPGoVhR8nRxCdUjNrz8C/4thRiE9JM4eJVqwAHGQwYsJpDczXH0NMRlxNEtF
	ClnFVb/uYb4aE9pq2u7M2BDcGWKvpFh9TsRsubAYD6J1hwZeUZp7UpKZaobqd76cy3oerw==
X-Received: by 2002:a5d:64c3:0:b0:439:ac6b:dd56 with SMTP id
 ffacd0b85a97d-43b527ccb44mr9123436f8f.53.1773878251125; Wed, 18 Mar 2026
 16:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de> <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de> <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop> <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local> <absfZGD3en9TUA1U@tardis.local> <absj6rZbyLZY8PPz@tardis.local>
In-Reply-To: <absj6rZbyLZY8PPz@tardis.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 00:56:55 +0100
X-Gm-Features: AaiRm5067gadFbg82GaID6MhICTXVr00nLo5NZXaU9TozzZYtLbbtqPn67LUFic
Message-ID: <CAP01T76Ud2yBWwXFyzNaLLOq6yjKbHRAXFsg=TMc7LYkZH_Opg@mail.gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace + PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, neeraj.iitr10@gmail.com, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 23:15, Boqun Feng <boqun@kernel.org> wrote:
>
> On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
> > On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
> > [...]
> > > > Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> > > > different issue, from the NMI issue? It is more of an issue of calling
> > > > call_srcu  API with scheduler locks held.
> > > >
> > > > Something like below I think:
> > > >
> > > >   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
> > > >   ----------------------------         ------------------------------------
> > > >   [1] holds  &rq->__lock
> > > >                                         [2]
> > > >                                         -> call_srcu
> > > >                                         -> srcu_gp_start_if_needed
> > > >                                         -> srcu_funnel_gp_start
> > > >                                         -> spin_lock_irqsave_ssp_content...
> > > >                                     -> holds srcu locks
> > > >
> > > >   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
> > > >                                                  -> queue_delayed_work
> > > >           -> call_srcu()                         -> __queue_work()
> > > >           -> srcu_gp_start_if_needed()           -> wake_up_worker()
> > > >           -> srcu_funnel_gp_start()              -> try_to_wake_up()
> > > >           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
> > > >           -> WANTS srcu locks
> > >
> > > I see, we can also have a self deadlock even without CPU B, when CPU A
> > > is going to try_to_wake_up() the a worker on the same CPU.
> > >
> > > An interesting observation is that the deadlock can be avoided in
> > > queue_delayed_work() uses a non-zero delay, that means a timer will be
> > > armed instead of acquiring the rq lock.
> > >
>
> If my observation is correct, then this can probably fix the deadlock
> issue with runqueue lock (untested though), but it won't work if BPF
> tracepoint can happen with timer base lock held.

Unfortunately it can be, there is at least one tracepoint that is
invoked with hrtimer base lock held.
Alexei ended up fixing this in the recent past [0]. So I think this
would cause trouble too.

hrtimer_start_range_ns() -> __hrtimer_start_range_ns() ->
remove_timer() -> __remove_hrtimer() -> debug_deactivate() ->
trace_hrtimer_cancel().
BPF can attach to such a tracepoint.

  [0]: https://lore.kernel.org/bpf/20260204040834.22263-2-alexei.starovoitov@gmail.com


>
> Regards,
> Boqun
>
> ------>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2328827f8775..a5d67264acb5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>         struct srcu_node *snp_leaf;
>         unsigned long snp_seq;
>         struct srcu_usage *sup = ssp->srcu_sup;
> +       bool irqs_were_disabled;
>
>         /* Ensure that snp node tree is fully initialized before traversing it */
>         if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> @@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>
>         /* Top of tree, must ensure the grace period will be started. */
>         raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
> +       irqs_were_disabled = irqs_disabled_flags(flags);
>         if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
>                 /*
>                  * Record need for grace period s.  Pair with load
> @@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>                 // it isn't.  And it does not have to be.  After all, it
>                 // can only be executed during early boot when there is only
>                 // the one boot CPU running with interrupts still disabled.
> +               //
> +               // If irq was disabled when call_srcu() is called, then we
> +               // could be in the scheduler path with a runqueue lock held,
> +               // delay the process_srcu() work 1 more jiffies so we don't go
> +               // through the kick_pool() -> wake_up_process() path below, and
> +               // we could avoid deadlock with runqueue lock.
>                 if (likely(srcu_init_done))
>                         queue_delayed_work(rcu_gp_wq, &sup->work,
> -                                          !!srcu_get_delay(ssp));
> +                                          !!srcu_get_delay(ssp) +
> +                                          !!irqs_were_disabled);
>                 else if (list_empty(&sup->work.work.entry))
>                         list_add(&sup->work.work.entry, &srcu_boot_list);
>         }
