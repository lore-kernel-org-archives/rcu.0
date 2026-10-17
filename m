Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007B3CCFB2
	for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244251; cv=none; b=e+ykBszGAT6S4FcUIfZrJqXRFOaSiIEXCUDEDT8YDMg+8E3nZLgKnEaUoJDQFiAss+qBq6Aw39dtnHedFXDZiRNvhaOmdvxbqarZL3TX60Zrp9j3wuzoeNHB+2cVJXnErvJTVgNO1112RfRtC+MEhFh8jlRXYbiSuW5mL+XqYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244251; c=relaxed/simple;
	bh=VJSutq2Y0velJ0zr0d61tLtveDKtPDeckCcKO2hJCjI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=YepMXpaJAKpJFtZE/2PSyQ+fIZCo947VYY5TflWFBhQpVSnwHirZiGMS2bd67h0JiJQ8qkphbu06S+bc7FVWcMR4LGYOU4zlWDw3U41bC7NMbaoclbUfQmVrqNH+ESV5GVmNZDnuBlVTl98I6YALBNXaGue9NihPZ9XBg4rNPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H3E/z9nh; arc=none smtp.client-ip=91.218.175.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H3E/z9nh"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VJSutq2Y0velJ0zr0d61tLtveDKtPDeckCcKO2hJCjI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792244244; v=1; x=1792849044;
 b=H3E/z9nhXWdkwfLKIIhSXS8JDuAQyJaWUNo3yaN/HSMzyc74ZkuLyOfEB06dOhxgBPtxuF1n
 iFKaeTYYHDrYrhJhBIVstiyvVohb5NJgl5zLu5yPv+RKjMBEPBInXwOy9BkX0fZOALKf5mMjxns
 Qyenw6jNSBCVWpFxjmFKrYOA=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 64034d4cb3b5a32b;
	Sat, 17 Oct 2026 13:37:24 +0000
X-Mizu-Trace-ID: 64034d4cb3b5a32b
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 13:37:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <d43b5294512c51f62dd80f1b1bf6856f44d90cbe@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
To: "Bradley Morgan" <brads@mainlining.org>
Cc: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
In-Reply-To: <AB14D6F5-9882-4527-82E6-BB33C1C7D3DE@mainlining.org>
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org>
 <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev>
 <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org>
 <aa11c41ba0458bda078c6cdff9e2b155bee1a59b@linux.dev>
 <C2E20E85-17A3-458C-9279-50022D30F5C8@mainlining.org>
 <AB14D6F5-9882-4527-82E6-BB33C1C7D3DE@mainlining.org>

>=20
>=20On 17 October 2026 13:20:50 BST, Bradley Morgan <brads@mainlining.org=
>
> wrote:
>=20
>=20>=20
>=20> On 17 October 2026 13:14:29 BST, Zqiang <qiang.zhang@linux.dev> wro=
te:
> >=20=20
>=20>  On 17 October 2026 00:41:00 BST, Zqiang <qiang.zhang@linux.dev> wr=
ote:
> >=20=20
>=20>  >=20
>=20>  > >=20
>=20>  > > On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev=
>
> >=20
>=20> >=20
>=20> > wrote:
> > >=20
>=20>  > >=20
>=20>  > > >=20
>=20>  > > > The RCU Tasks Rude grace period is implemented by invoking t=
he
> >  > > > schedule_on_each_cpu() with an empty work function, which forc=
es
> >  > > > a context switch on every online CPU and guarantees that all
> >  > > > rude-tasks read-side critical sections have completed. However=
,
> >  > > > schedule_on_each_cpu() can fail (via alloc_percpu() returning
> >  > > > -ENOMEM) and returns immediately, in which case those context
> >  > > > switches never happen, too-short grace period happen.
> >  > > >=20
>=20>  > > > This commit therefore wraps the schedule_on_each_cpu() call =
in
> >  > > > WARN_ONCE() so that this failure is reported as a "Too-short
> >  > > > grace period" warning.
> >  > > >=20
>=20>  > > NAK, this seems like a edge case, and potentially panicking th=
e
> >=20
>=20> >=20
>=20> > system
> > >=20
>=20>  > > with panic on oops doesn't seem right to me, because we would
> >=20
>=20> >=20
>=20> > reserve
> > >=20
>=20>  > >=20
>=20>  > that
> >  >=20
>=20>  > >=20
>=20>  > > for when something definitely goes really wrong and we need to
> >=20
>=20> >=20
>=20> > notify
> > >=20
>=20>  > > the user.
> >  > >=20
>=20>  > > I don't believe this patch should go in for this reason, it's =
a
> >=20
>=20> >=20
>=20> > heavy
> > >=20
>=20>  > >=20
>=20>  > edge
> >  >=20
>=20>  > >=20
>=20>  > > case, that doesn't *have* nessesarily need to be accounted for=
.
> >  > >=20
>=20>  > Indeed, this is a rare event, so I use WARN_ONCE() to mark it, t=
he
> >  > WARN_ONCE()
> >  > not panicking system unless you set warn_on_oops true, this can he=
lp
> >=20
>=20> >=20
>=20> > us
> > >=20
>=20>  > troubleshoot
> >  > UAF issues caused by a too short tasks-rude grace period.
> >  >=20
>=20>  > or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work=
) to
> >  > replace
> >  > alloc_percpu(struct work_struct) queue to all online CPUs.
> >  >=20
>=20>  > Anyway, Thank you for your reply. I would also like to hear the
> >=20
>=20> >=20
>=20> > opinions
> > >=20
>=20>  > of others.
> >  >=20
>=20>  Fair enough, but me and Paul done some discussions:
> >=20=20
>=20>  Here is the TL;DR
> >=20=20
>=20>  My ^W^Wai slop^W^W tool helped me with this: if the too short grac=
e
> >  happens,
> >  it falls back.
> >=20=20
>=20>  root@p10-linux-brads:~/linux# mailto:root@p10-linux-brads:~/linux#=
  mailto:root@p10-linux-brads:~/linux# git
> >=20
>=20> >=20
>=20> > diff kernel/rcu
> > >=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index 627295396cd9..65bb7d4ed632 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -1344,15 +1344,23 @@ void exit_tasks_rcu_finish(void) { }
> >  // Ordering is provided by the scheduler's context-switch code.
> >=20=20
>=20>  // Empty function to allow workqueues to force a context switch.
> >  -static void rcu_tasks_be_rude(struct work_struct *work)
> >  +static void __maybe_unused rcu_tasks_be_rude(struct work_struct *wo=
rk)
> >  {
> >  }
> >=20=20
>=20>  // Wait for one rude RCU-tasks grace period.
> >  +static void rcu_tasks_rude_ipi(void *info)
> >  +{
> >  +}
> >  +
> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >  {
> >  + int cpu;
> >  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> >  - schedule_on_each_cpu(rcu_tasks_be_rude);
> >  + cpus_read_lock();
> >  + for_each_online_cpu(cpu)
> >  + smp_call_function_single(cpu, rcu_tasks_rude_ipi, NULL, 1);
> >  + cpus_read_unlock();
> >  }
> >=20
>=20> >=20
>=20> > RCU Tasks Rude use preempt_disable/enable as the read critical se=
ction,
> > > you use smp_call_function_single() to send ipi to each online CPUs,=
=20
>=20> > it's not forces a context sched switch, and not wait the
> > > preempt_disable/enable
> > > read critical section to exit, this is the wrong mechanism. ;-(
> > >=20
>=20> > Obviously, we only need to not apply alloc_percpu dynamic allocat=
ion:
> > >=20
>=20> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index fcac7361ec51..49b629b0010b 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -1357,11 +1357,25 @@ static void rcu_tasks_be_rude(struct work_s=
truct
> > >=20
>=20> *work)
> >=20
>=20> >=20
>=20> > {
> > >  }
> > >=20
>=20> > +static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
> > > +
> > >  // Wait for one rude RCU-tasks grace period.
> > >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> > >  {
> > > + int cpu;
> > > +
> > > + guard(cpus_read_lock)();
> > >  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> > > - schedule_on_each_cpu(rcu_tasks_be_rude);
> > > +
> > > + for_each_online_cpu(cpu) {
> > > + struct work_struct *work =3D &per_cpu(tasks_rude_work,
> > >=20
>=20> cpu);
> >=20
>=20> >=20
>=20> > +
> > > + INIT_WORK(work, rcu_tasks_be_rude);
> > > + schedule_work_on(cpu, work);
> > > + }
> > > +
> > > + for_each_online_cpu(cpu)
> > > + flush_work(&per_cpu(tasks_rude_work, cpu));
> > >  }
> > >=20
>=20> >  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callba=
ck_t
> > >  func);
> > >=20
>=20> Wow!
> >=20
>=20> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> >=20
>=20Gimme a sec I'll submit the patch..=20

Actually,=20I don't mind you send this fix directly, due to you use an in=
correct IPI
mechanism to implement it, I would like to know wether you truly understa=
nd the tasks-rude
and how schedule_on_each_cpu() ensures memory order.


>=20
>=20>=20
>=20> >=20
>=20> > Thanks
> > > Zqiang
> > >=20
>=20>=20=20
>=20>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback=
_t
> >=20
>=20> >=20
>=20> > func);
> > >=20
>=20>  root@p10-linux-brads:~/linux# mailto:root@p10-linux-brads:~/linux#=
  mailto:root@p10-linux-brads:~/linux#=20
>=20>=20=20
>=20>  On POWERPC, this passes 12 hours of rcutorture on the RUDE01 confi=
g.
> >=20=20
>=20>  If you plan on submitting this into a patch, please add my authors=
hip,
> >=20
>=20> >=20
>=20> > or
> > >=20
>=20>  my c-d-b.=20
>=20>=20=20
>=20>  Feel free to rcutorture test it ;d
> >=20=20
>=20>  BTW: have you reproduced this on your own system?
> >=20=20
>=20>  >=20
>=20>  > Thanks
> >  > Zqiang
> >  >=20
>=20>  > >=20
>=20>  > > Zqiang, have you reproduced this OOM on your own system, if so=
,
> >=20
>=20> >=20
>=20> > could
> > >=20
>=20>  > >=20
>=20>  > you
> >  >=20
>=20>  > >=20
>=20>  > > tell me more details, you may turn my frown into a smiley face=
 ;)
> >  > >=20
>=20>  > > >=20
>=20>  > > > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  > > > ---
> >  > > > kernel/rcu/tasks.h | 3 ++-
> >  > > > 1 file changed, 2 insertions(+), 1 deletion(-)
> >  > > >=20
>=20>  > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  > > > index fcac7361ec51..91c25717402e 100644
> >  > > > --- a/kernel/rcu/tasks.h
> >  > > > +++ b/kernel/rcu/tasks.h
> >  > > > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct
> >=20
>=20> >=20
>=20> > work_struct
> > >=20
>=20>  > >=20
>=20>  > *work)
> >  >=20
>=20>  > >=20
>=20>  > > > static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >  > > > {
> >  > > > rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> >  > > > - schedule_on_each_cpu(rcu_tasks_be_rude);
> >  > > > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
> >  > > > + "%s: Too-short grace period, OOM is now expected
> >=20
>=20> >=20
>=20> > behavior!!!\n",
> > >=20
>=20>  > >=20
>=20>  > rtp->name);
> >  >=20
>=20>  > >=20
>=20>  > > >=20
>=20>  > > Good message, makes sense. But I don't think this is right, se=
e
> >=20
>=20> >=20
>=20> > above.
> > >=20
>=20>  > >=20
>=20>  > > >=20
>=20>  > > > }
> >  > > >=20
>=20>  > > > static void call_rcu_tasks_rude(struct rcu_head *rhp,
> >=20
>=20> >=20
>=20> > rcu_callback_t
> > >=20
>=20>  > > > func);
> >  > > >=20
>=20>  > > --- Thanks!
> >  > > "I'm not a very positive person" - Linus torvalds
> >  > >
> >  >=20
>=20>  --- Thanks!
> >  "I'm not a very positive person" - Linus torvalds
> >=20
>=20> --- Thanks!
> > "I'm not a very positive person" - Linus torvalds
> >=20
>=20--- Thanks!
>=20"I'm not a very positive person" - Linus torvalds
>
