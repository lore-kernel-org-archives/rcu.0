Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A839FD6;
	Mon, 21 Oct 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508477; cv=none; b=kmpZslBL+PVp2nQsxjDmEXcf3ThMK9nWjl4dHrMJHI+1ZSlgJj47M5jVNUogEg4X5dMn8MgYSh9j6Yf8LMcK+0Xuhjv0PlYeShyBS1RIpjLj1ldU5PdHf4zaIRzSQ5VWQhPIahYL17Wt6ZzcdIPUD7N47miZxNTZqUrPZfiIzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508477; c=relaxed/simple;
	bh=6XLiaMEZxQ4QwTwbir/0YL+IYqC7fls+fsVVw28BR/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNcAohoSesD44wBZo2xbtHLYchNVFgYfb9Youp0mT2T/JCfU7IMicB9uo0Ewq//6hi6QAAxPBwVRUPU8TuRPHxsOZsonXs0j5AL3wXYkC9B8mHFM8XcG73ucA+T0tNmqWsAwNM/nQ7pQnRWY7xqRm/3bINIujtv9/zl4qybWmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyaVkmww; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyaVkmww"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e7086c231so3248567b3a.0;
        Mon, 21 Oct 2024 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729508474; x=1730113274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gMXRUymTCoH8sNI9EK0eOcy2+50NJoHHIVwvhU2Czg=;
        b=UyaVkmwwE4obR/hF+5sfXFcd+8eDyuwuHu85ubNFgoe0h8A+VWq/pYAgAAPdHyL3k7
         T3qe3g7cj9tS9O1l+a7hnANcMXb6eZ3t8MsudHixcTnzc1yXbUrVpaUni7pxwIEeNab2
         l4QWHcT3KuAINXMQrvR9TH8A6G03SA5JvZNuxa9vMu3LzmGKoZYWrWlVOk4k/eYq0l3w
         WFGxcww9fq+Xui58++OFvUEyLAMh1v0Flo7A7XLG0wjMzTS0zT1mWPsvo/QhPHzAiuqx
         ZoaLsQD18zZPaau1jgX544uCPl4Y3oxoapMwGlQXLDpxLI9C8N53c9vSjWjbwKAAH61w
         YVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508474; x=1730113274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gMXRUymTCoH8sNI9EK0eOcy2+50NJoHHIVwvhU2Czg=;
        b=N1hQ5Aj4jf4mZpR3Z/TirQs+IeTW1/0yAIsxTr+xjGk4wA4zgVdpRR4AVG11ES2iu+
         PBjLGIsIU1sqMeHAIggjOkC2Not0uFdsVdAcM3vEkg/A3AClW35lE0+JTRhC+678mmSJ
         QncAaQm7sQDnmE+nVCv1pFOb69yNhYNuuxDY5eUfxazPjRpiMHxGhIhcBRydcLN8O+z7
         t+vGlS1aIEMtcipaxHFg9yOXsfLv8XOBXMHFs5je5MZECvusIJPTZ7mSFACq03OUyQlu
         QSDPJuZbi3AP3Dq5pOmpPukJGo+j7TdPa3eMNk/HjjCrXdWc5C/ARwwzJ92vMcfL/huf
         Pkbw==
X-Forwarded-Encrypted: i=1; AJvYcCUAG+NCLOeP1ldLro0siQ4sEKL4sY7hZG1ez41E2X3kYMles3T0it56ez/CvgFnr4o9JZHFIf78MpmX9R8=@vger.kernel.org, AJvYcCWVscPCAvz5Amy1vaYiw/I9hxDYNMYAtdWxd3MXwNK927XkNHcTzy4kNPQvn5cSz9fPBahq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79BXVc4B1p2dRpaWORTSs9eAqEQR8LQRWdtB/NzqsgX5zgver
	4xq05aOkPZzoJ5GWQNbyzHfTuT+PpkUzIhg9gCeTdKuNOwN2Vz0STrSeZ5d+g8ypVokZYY0d4t/
	J2PlslcfvpKwYMIGieO1H6AihRsn5IMYK
X-Google-Smtp-Source: AGHT+IEb/3p4D00oVX/AqH0go9qA8LLY374WlFXQij8i/IHeFxnXb8NHtpTShdMfcaiSPeISBmND6n65bWeAB3qTlA8=
X-Received: by 2002:a05:6a00:140c:b0:71e:6122:5919 with SMTP id
 d2e1a72fcca58-71ea332adfemr14464143b3a.20.1729508474030; Mon, 21 Oct 2024
 04:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020125119.14751-1-qiang.zhang1211@gmail.com>
 <ZxWO6BmRutOC0RnZ@pavilion.home> <CALm+0cW=1PAVhjHKM+aXLHHzsD0+7pbVDvmm+kxvff7r=Di2tA@mail.gmail.com>
In-Reply-To: <CALm+0cW=1PAVhjHKM+aXLHHzsD0+7pbVDvmm+kxvff7r=Di2tA@mail.gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 21 Oct 2024 19:01:02 +0800
Message-ID: <CALm+0cV-s+gYDXKQV9dYWEr-ui6aJ6DZzvyNhW6H2T39WtPjWw@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Fix the WARN_ON_ONCE() in rcu_nocb_rdp_deoffload()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> >
> > Le Sun, Oct 20, 2024 at 08:51:19PM +0800, Zqiang a =C3=A9crit :
> > > Currently, running rcutorture test with torture_type=3Drcu fwd_progre=
ss=3D8
> > > n_barrier_cbs=3D8 nocbs_nthreads=3D8 nocbs_toggle=3D100 onoff_interva=
l=3D60
> > > test_boost=3D2, will trigger the following warning:
> > >
> > > WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp=
_deoffload+0x292/0x2a0
> > > RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
> > > [18839.537322] Call Trace:
> > > [18839.538006]  <TASK>
> > > [18839.538596]  ? __warn+0x7e/0x120
> > > [18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> > > [18839.540757]  ? report_bug+0x18e/0x1a0
> > > [18839.541805]  ? handle_bug+0x3d/0x70
> > > [18839.542837]  ? exc_invalid_op+0x18/0x70
> > > [18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
> > > [18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> > > [18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
> > > [18839.547814]  rcu_nocb_toggle+0x136/0x1c0
> > > [18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
> > > [18839.550073]  kthread+0xd1/0x100
> > > [18839.550958]  ? __pfx_kthread+0x10/0x10
> > > [18839.552008]  ret_from_fork+0x2f/0x50
> > > [18839.553002]  ? __pfx_kthread+0x10/0x10
> > > [18839.553968]  ret_from_fork_asm+0x1a/0x30
> > > [18839.555038]  </TASK>
> > >
> > > CPU0                               CPU2                          CPU3
> > > //rcu_nocb_toggle             //nocb_cb_wait                   //rcut=
orture
> > >
> > > // deoffload CPU1             // process CPU1's rdp
> > > rcu_barrier()
> > >     rcu_segcblist_entrain()
> > >         rcu_segcblist_add_len(1);
> > >         // len =3D=3D 2
> > >         // enqueue barrier
> > >         // callback to CPU1's
> > >         // rdp->cblist
> > >                              rcu_do_batch()
> > >                                  // invoke CPU1's rdp->cblist
> > >                                  // callback
> > >                                  rcu_barrier_callback()
> > >                                                              rcu_barr=
ier()
> > >                                                                mutex_=
lock(&rcu_state.barrier_mutex);
> > >                                                                // sti=
ll see len =3D=3D 2
> > >                                                                // enq=
ueue barrier callback
> > >                                                                // to =
CPU1's rdp->cblist
> > >                                                                rcu_se=
gcblist_entrain()
> > >                                                                    rc=
u_segcblist_add_len(1);
> > >                                                                    //=
 len =3D=3D 3
> > >                                  // decrement len
> > >                                  rcu_segcblist_add_len(-2);
> > >                              kthread_parkme()
> > >
> > > // CPU1's rdp->cblist len =3D=3D 1
> > > // Warn because there is
> > > // still a pending barrier
> > > // trigger warning
> > > WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> > > cpus_read_unlock();
> > >
> > >                                                                 // wa=
it CPU1 comes online
> > >                                                                 // in=
voke barrier callback on
> > >                                                                 // CP=
U1 rdp's->cblist
> > >                                                                 wait_=
for_completion(&rcu_state.barrier_completion);
> > > // deoffload CPU4
> > > cpus_read_lock()
> > >   rcu_barrier()
> > >     mutex_lock(&rcu_state.barrier_mutex);
> > >     // block on barrier_mutex
> > >     // wait rcu_barrier() on
> > >     // CPU3 to unlock barrier_mutex
> > >     // but CPU3 unlock barrier_mutex
> > >     // need to wait CPU1 comes online
> > >     // when CPU1 going online will block on cpus_write_lock
> > >
> > > The above scenario will not only trigger WARN_ON_ONCE(), but also
> > > trigger deadlock, this commit therefore check rdp->cblist length
> > > before invoke kthread_parkme(), and the kthread_parkme() is not
> > > invoke until length reaches zero.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tree_nocb.h | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 8648233e1717..a2b0ebdefee3 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -893,6 +893,12 @@ static inline bool nocb_cb_wait_cond(struct rcu_=
data *rdp)
> > >       return !READ_ONCE(rdp->nocb_cb_sleep) || kthread_should_park();
> > >  }
> > >
> > > +static inline bool nocb_cblist_empty(struct rcu_data *rdp)
> > > +{
> > > +     return !(rcu_rdp_is_offloaded(rdp) &&
> >
> > But the rdp has to be offloaded when nocb_cb_wait() is running, and tha=
t
> > include the times when it is parking and when it is unparking.
> >
> > > +             WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)));
> >
> > And like your scenario above shows, it's possible to reach here with
> > callbacks. So this check shouldn't be a warning at that point?
>
> Yes, the WARN_ON_ONCE() should be removed.
>
> >
> > > +}
> > > +
> > >  /*
> > >   * Invoke any ready callbacks from the corresponding no-CBs CPU,
> > >   * then, if there are no more, wait for more to appear.
> > > @@ -907,7 +913,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > >
> > >       swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> > >                                           nocb_cb_wait_cond(rdp));
> > > -     if (kthread_should_park()) {
> > > +     if (kthread_should_park() && nocb_cblist_empty(rdp)) {
> >
> > What about this instead? If the second barrier is queued before
> > the final check to rcu_segcblist_ready_cbs() in nocb_cb_wait(), this
> > will be noticed and ->nocb_cb_sleep will remain false. If otherwise rcu=
_barrier()
> > is called after that final rcu_segcblist_ready_cbs() check, it will obs=
erve
> > the final decrement to zero and won't entrain the callback.
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 16865475120b..0de07d44646c 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -891,7 +891,19 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> >         swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> >                                             nocb_cb_wait_cond(rdp));
> >         if (kthread_should_park()) {
> > -               kthread_parkme();
> > +               /*
> > +                * kthread_park() must be preceded by an rcu_barrier().
> > +                * But yet another rcu_barrier() might have sneaked in =
between
> > +                * the barrier callback execution and the callbacks cou=
nter
> > +                * decrement.
> > +                */
> > +               if (rdp->nocb_cb_sleep) {
>
> For the non-nocb cpus set during boot, the corresponding
> rcuop kthread, we should park directly, otherwise
> WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)) will be triggered.
>
> Should the conditions be like this?
> if(!rcu_rdp_is_offloaded(rdp) || rdp->nocb_cb_sleep)
>
>

How about this?

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8648233e1717..14b70e662c9e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -904,11 +904,27 @@ static void nocb_cb_wait(struct rcu_data *rdp)
        unsigned long flags;
        bool needwake_gp =3D false;
        struct rcu_node *rnp =3D rdp->mynode;
+       bool need_parkme =3D false;

        swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
                                            nocb_cb_wait_cond(rdp));
        if (kthread_should_park()) {
-               kthread_parkme();
+               /*
+                * kthread_park() must be preceded by an rcu_barrier().
+                * But yet another rcu_barrier() might have sneaked in betw=
een
+                * the barrier callback execution and the callbacks counter
+                * decrement.
+                */
+               if (!rcu_rdp_is_offloaded(rdp)) {
+                       need_parkme =3D true;
+               } else if (rdp->nocb_cb_sleep) {
+                       need_parkme =3D true;
+                       rcu_nocb_lock_irqsave(rdp, flags);
+                       WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+                       rcu_nocb_unlock_irqrestore(rdp, flags);
+               }
+               if (need_parkme)
+                       kthread_parkme();
        } else if (READ_ONCE(rdp->nocb_cb_sleep)) {
                WARN_ON(signal_pending(current));
                trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpt=
y"));


> Thanks
> Zqiang
>
> > +                       rcu_nocb_lock_irqsave(rdp, flags);
> > +                       WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist))=
;
> > +                       rcu_nocb_unlock_irqrestore(rdp, flags);
> > +
> > +                       kthread_parkme();
> > +               }
> >         } else if (READ_ONCE(rdp->nocb_cb_sleep)) {
> >                 WARN_ON(signal_pending(current));
> >                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Woke=
Empty"));
