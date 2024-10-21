Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF901FDD;
	Mon, 21 Oct 2024 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729471179; cv=none; b=B/v0ruG3V3mmudo6XKucRmyDSU5i/B79+b7VTFJ+5AzIniHGbtIaAexsqMET7MkK/kB1A40taou9MWwxakqphZEKnTugNa04EGckIxQzOEGbxmvcB+nu3HrgPnAGWvjhWrYkmWoiTR+1ga811XFztOPmPRrlr7zL7CUQF1r6yKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729471179; c=relaxed/simple;
	bh=L6ST1QJasl3mtJ4houSLt1c+e9IqlVPIqwr3tSn6irI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLeXzmoUFnQ2ztTyarYafKHjlHViZ6XxpXU+AUqsHwrAv4FiAE3ya5kdlYXVvGJPS9HSt1ietejT0xjWe13ob2pd5GTNHz9Geh+T8RYsiQ7OkcepuIgeru2QjntxH6pgAIqbl/2JCsCfbs48SKpmKWFHT1CmGWnbdIEATl3Av/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3365fCb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3365fCb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e983487a1so2718791b3a.2;
        Sun, 20 Oct 2024 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729471177; x=1730075977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANyKrgYNgnyauX32Pt4wK4DRXcpk6uScKLfjJ4dSe4c=;
        b=L3365fCbdXz+hv3ziCmrcX03FFAIv3NmZWB/VmfwR1bgICvWKkCbfUE6lZ0eY/D8zP
         HGfMw9JUdt40QbLrEDIy12EDrWhaI+Sv4Utb8nkbaOIZhP9gkcFmYPyRmrXFgdfJWOEs
         D7QQRbF2U5440OKt334OOwdeYah3bQuXDuN92h98SVKMsMcvNtJpHVkS2UWizTT2ZqgD
         hCTxOFd5zuh39JyVTJ2LroJ+JQHmRsH3gn9xHuI9wP/tPbhoY03OI0172o2XoT7olpQY
         f0WCgEuVmZdGf46xSD7nijdhQSMktNuGyxstsThp5dn+88cjS/JEV83qbu2NHnRJmdVy
         oFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729471177; x=1730075977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANyKrgYNgnyauX32Pt4wK4DRXcpk6uScKLfjJ4dSe4c=;
        b=o1IzvUQ15boQcdO1O6HC3M8RmiFRlb7xN4Lrz/lY2KFr802BHgiu+yDF/DyGdxHME9
         BkRaLfzPkC9Is93bby3oyBRka0hOz119pPu7AFAwUz8UhQwH8GTgwpTq9qaXIEk5Bq1h
         EET4E2AkOVHeGPEDcDIvwqUcldBe8mHZkGMpHZqj/GszjuzoIb9kO7gCxnrWsmg9PrGc
         fxf+TzoqhgO02OSSBDgtSyB3PdReEH8nLlrPSHKBzXbzLYeplhquDnxg8t0kmBZKCT0V
         Mt1U7vlwe8qmKzw2Pnw0icbLfW41JUPUWPHucqSWw8kH+rx4IRvLWJ37pqv/0CKKkQbK
         Zy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAktLbv4o8BDLHOBJ8FicTrKPH4p432JJB/IRBi0yneYZQp+YN8vHGcSXlmfKTadY89z8hCs4OsyRfuCE=@vger.kernel.org, AJvYcCVngf5sIsp7spxy1G7a9TGzDdudGcop69iNv4qbWX/xlEAph608UsuBuMkjKcVzCOnKJV3C@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3g6oJOxqK+1X03b3x3ShdbrFpDslSjbcD7beOpEHRrNp7Gsa
	3Chg+djavFfwQV1CkEA+GZGnezdoEsIezOO/kCHArY/PBhYSSwDNRwDq7Lj7eKOMO7lXHIeHRRr
	0m/lo30z+Ut/VIj0ywnPIYnOxzhg=
X-Google-Smtp-Source: AGHT+IF02fpeRCAfdflN0uMgWfoX/IQlvyaz7kAhF7WaR7s8HnCe0eDc0Hm59uenuc76hvenr3Pr6VU8HFUJ/hjN/g0=
X-Received: by 2002:a05:6a00:b48:b0:71e:82b4:6e6e with SMTP id
 d2e1a72fcca58-71ea31d3056mr14318470b3a.4.1729471176585; Sun, 20 Oct 2024
 17:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020125119.14751-1-qiang.zhang1211@gmail.com> <ZxWO6BmRutOC0RnZ@pavilion.home>
In-Reply-To: <ZxWO6BmRutOC0RnZ@pavilion.home>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 21 Oct 2024 08:39:24 +0800
Message-ID: <CALm+0cW=1PAVhjHKM+aXLHHzsD0+7pbVDvmm+kxvff7r=Di2tA@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Fix the WARN_ON_ONCE() in rcu_nocb_rdp_deoffload()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Le Sun, Oct 20, 2024 at 08:51:19PM +0800, Zqiang a =C3=A9crit :
> > Currently, running rcutorture test with torture_type=3Drcu fwd_progress=
=3D8
> > n_barrier_cbs=3D8 nocbs_nthreads=3D8 nocbs_toggle=3D100 onoff_interval=
=3D60
> > test_boost=3D2, will trigger the following warning:
> >
> > WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_d=
eoffload+0x292/0x2a0
> > RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
> > [18839.537322] Call Trace:
> > [18839.538006]  <TASK>
> > [18839.538596]  ? __warn+0x7e/0x120
> > [18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> > [18839.540757]  ? report_bug+0x18e/0x1a0
> > [18839.541805]  ? handle_bug+0x3d/0x70
> > [18839.542837]  ? exc_invalid_op+0x18/0x70
> > [18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
> > [18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> > [18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
> > [18839.547814]  rcu_nocb_toggle+0x136/0x1c0
> > [18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
> > [18839.550073]  kthread+0xd1/0x100
> > [18839.550958]  ? __pfx_kthread+0x10/0x10
> > [18839.552008]  ret_from_fork+0x2f/0x50
> > [18839.553002]  ? __pfx_kthread+0x10/0x10
> > [18839.553968]  ret_from_fork_asm+0x1a/0x30
> > [18839.555038]  </TASK>
> >
> > CPU0                               CPU2                          CPU3
> > //rcu_nocb_toggle             //nocb_cb_wait                   //rcutor=
ture
> >
> > // deoffload CPU1             // process CPU1's rdp
> > rcu_barrier()
> >     rcu_segcblist_entrain()
> >         rcu_segcblist_add_len(1);
> >         // len =3D=3D 2
> >         // enqueue barrier
> >         // callback to CPU1's
> >         // rdp->cblist
> >                              rcu_do_batch()
> >                                  // invoke CPU1's rdp->cblist
> >                                  // callback
> >                                  rcu_barrier_callback()
> >                                                              rcu_barrie=
r()
> >                                                                mutex_lo=
ck(&rcu_state.barrier_mutex);
> >                                                                // still=
 see len =3D=3D 2
> >                                                                // enque=
ue barrier callback
> >                                                                // to CP=
U1's rdp->cblist
> >                                                                rcu_segc=
blist_entrain()
> >                                                                    rcu_=
segcblist_add_len(1);
> >                                                                    // l=
en =3D=3D 3
> >                                  // decrement len
> >                                  rcu_segcblist_add_len(-2);
> >                              kthread_parkme()
> >
> > // CPU1's rdp->cblist len =3D=3D 1
> > // Warn because there is
> > // still a pending barrier
> > // trigger warning
> > WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> > cpus_read_unlock();
> >
> >                                                                 // wait=
 CPU1 comes online
> >                                                                 // invo=
ke barrier callback on
> >                                                                 // CPU1=
 rdp's->cblist
> >                                                                 wait_fo=
r_completion(&rcu_state.barrier_completion);
> > // deoffload CPU4
> > cpus_read_lock()
> >   rcu_barrier()
> >     mutex_lock(&rcu_state.barrier_mutex);
> >     // block on barrier_mutex
> >     // wait rcu_barrier() on
> >     // CPU3 to unlock barrier_mutex
> >     // but CPU3 unlock barrier_mutex
> >     // need to wait CPU1 comes online
> >     // when CPU1 going online will block on cpus_write_lock
> >
> > The above scenario will not only trigger WARN_ON_ONCE(), but also
> > trigger deadlock, this commit therefore check rdp->cblist length
> > before invoke kthread_parkme(), and the kthread_parkme() is not
> > invoke until length reaches zero.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 8648233e1717..a2b0ebdefee3 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -893,6 +893,12 @@ static inline bool nocb_cb_wait_cond(struct rcu_da=
ta *rdp)
> >       return !READ_ONCE(rdp->nocb_cb_sleep) || kthread_should_park();
> >  }
> >
> > +static inline bool nocb_cblist_empty(struct rcu_data *rdp)
> > +{
> > +     return !(rcu_rdp_is_offloaded(rdp) &&
>
> But the rdp has to be offloaded when nocb_cb_wait() is running, and that
> include the times when it is parking and when it is unparking.
>
> > +             WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)));
>
> And like your scenario above shows, it's possible to reach here with
> callbacks. So this check shouldn't be a warning at that point?

Yes, the WARN_ON_ONCE() should be removed.

>
> > +}
> > +
> >  /*
> >   * Invoke any ready callbacks from the corresponding no-CBs CPU,
> >   * then, if there are no more, wait for more to appear.
> > @@ -907,7 +913,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> >
> >       swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> >                                           nocb_cb_wait_cond(rdp));
> > -     if (kthread_should_park()) {
> > +     if (kthread_should_park() && nocb_cblist_empty(rdp)) {
>
> What about this instead? If the second barrier is queued before
> the final check to rcu_segcblist_ready_cbs() in nocb_cb_wait(), this
> will be noticed and ->nocb_cb_sleep will remain false. If otherwise rcu_b=
arrier()
> is called after that final rcu_segcblist_ready_cbs() check, it will obser=
ve
> the final decrement to zero and won't entrain the callback.
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 16865475120b..0de07d44646c 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -891,7 +891,19 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>         swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
>                                             nocb_cb_wait_cond(rdp));
>         if (kthread_should_park()) {
> -               kthread_parkme();
> +               /*
> +                * kthread_park() must be preceded by an rcu_barrier().
> +                * But yet another rcu_barrier() might have sneaked in be=
tween
> +                * the barrier callback execution and the callbacks count=
er
> +                * decrement.
> +                */
> +               if (rdp->nocb_cb_sleep) {

For the non-nocb cpus set during boot, the corresponding
rcuop kthread, we should park directly, otherwise
WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)) will be triggered.

Should the conditions be like this?
if(!rcu_rdp_is_offloaded(rdp) || rdp->nocb_cb_sleep)


Thanks
Zqiang

> +                       rcu_nocb_lock_irqsave(rdp, flags);
> +                       WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> +                       rcu_nocb_unlock_irqrestore(rdp, flags);
> +
> +                       kthread_parkme();
> +               }
>         } else if (READ_ONCE(rdp->nocb_cb_sleep)) {
>                 WARN_ON(signal_pending(current));
>                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEm=
pty"));
