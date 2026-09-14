Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A340855
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344784; cv=none; b=lnnWKgl2RtOiIfyi42UNirW65LaMcOvtdDARDSoBzWkcPvDiC5TVT/V9Lw373f2Hqcr0DAczHx9Rr2SckpnlIv9SdCcHvrdR1MpSDDt3VReEhTgnvoClbEqxy/KCvFZf7TAfD8vZhGVat6YI09Xc80kik0oxuHmotHrPPXFXz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344784; c=relaxed/simple;
	bh=xuV2ICgV+jOsxwu/AbswYM8qD9l0hBhTWfupUfJeuRk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=U0D5MixJutsm4mjfYqhJuU8g4Ugvhh7IcC/zkUC0x04+fjxXMorJQzDD/fYSIwWNKQ4ZK1q4+cRudW7BKh/AB+E7M91HmMXMQsEeWhN3zXOb1feX4JBrt/QpLCfDqe4vPBYsriCkIsYEKXquogrlQglyHAlVVhg18km+xQNJux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YIXqymik; arc=none smtp.client-ip=91.218.175.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YIXqymik"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xuV2ICgV+jOsxwu/AbswYM8qD9l0hBhTWfupUfJeuRk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789344777; v=1; x=1789949577;
 b=YIXqymikxTm6A/n5Hq0c7hTUdHJ2cNTd1xmZz32kDApLV9htGauaiQ8p+eTAStt8Jsb9K6HI
 BBqQDUfuAzI7LavXQRnwulUef4Yc4HEEENEoPzXpPx4KIZXuyoUzeLo6ysqPZ07/HgwllpTn4gx
 HCrJblq4ebV7PwY/SeUGmJ34=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e830eaf301b3535a;
	Mon, 14 Sep 2026 00:12:47 +0000
X-Mizu-Trace-ID: e830eaf301b3535a
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 00:12:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <ab4b7feb3d7ab68ce0de1d1d93d6272b355d7d5d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to
 synchronize_srcu_atomic()
To: "KunWu Chan" <kunwu.chan@gmail.com>, paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <CAN_Opa9v-6Kx2tUFkT4YiOVM_tgZuUVOkbwieOrC6WfbNj_=kA@mail.gmail.com>
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
 <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
 <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>
 <32e952728ea1a9c25c2b56de468f43a32104b8a8@linux.dev>
 <CAN_Opa9v-6Kx2tUFkT4YiOVM_tgZuUVOkbwieOrC6WfbNj_=kA@mail.gmail.com>

>=20
>=20On Sun, Sep 13, 2026 at 2:21 PM Zqiang <qiang.zhang@linux.dev> wrote:
>=20
>=20>=20
>=20> On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
> >=20
>=20>  >
> >  > On Sat, Sep 12, 2026 at 12:47 AM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >  >
> >  > On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> >  > > Add the lockdep annotation, same-type SRCU nesting warning, and
> >  > > early-boot check used by __synchronize_srcu().
> >  > >
> >  > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> >  > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >  >
> >  > Queued for review and testing, thank you both!
> >  >
> >  > Interestingly enough, it is now the case that there is a grace-per=
iod
> >  > wait that can be placed in a normal RCU read-side critical section=
.
> >  > Does this mean that we should also adjust the --do-srcu-lockdep te=
sting
> >  > in tools/testing/selftests/rcutorture/bin/torture.sh?
> >  >
> >  > Thanks, Paul. Good point.
> >  >
> >  > I=E2=80=99ll check the current `--do-srcu-lockdep` coverage, inclu=
ding the
> >  > case where `synchronize_srcu_atomic()` is called from a normal RCU
> >  > read-side critical section, and follow up with the necessary tortu=
re
> >  > testing changes.
> >  >
> >  Sounds good!
> >=20
>=20>  Perhaps you and Zqiang can work together on this. Co-developed-by,
> >  for example.
> >=20
>=20>  Hi, Paul and KunWu
> >=20
>=20Hi Zqiang,
>=20
>=20Thanks for pointing out these cases.
>=20
>=20>=20
>=20> Should we also consider the following situations ?
> >=20
>=20>  idx =3D srcu_read_lock_atomic(srcu)
> >=20
>=20>  by interrupt run hardirq context:
> >  synchronize_rcu_atomic(srcu)
> >=20
>=20>  srcu_read_unlock_atomic(srcu, idx)
> >=20
>=20For the same-CPU interrupt case, the existing check in
> synchronize_srcu_atomic() already catches it:
>=20
>=20 synchronize_srcu_atomic(ssp)
>  RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
>  "Illegal synchronize_srcu_atomic() in same-type SRCU ...");
>=20
>=20lockdep_is_held() resolves to __lock_is_held() (lockdep.c:5612),
> which checks current->held_locks[]. The interrupt handler runs with
> the same current, so it sees the SRCU dep_map acquired by
> srcu_read_lock_atomic().
>=20
>=20>=20
>=20> or:
> >=20
>=20>  CPU0: CPU1:
> >=20
>=20>  idx =3D srcu_read_lock_atomic(srcu)
> >=20
>=20>  smp_call_function_single(CPU1, som_func, NULL, 1)
> >  to send IPI to CPU1, and sync wait complete.
> >  hardirq context or ide task context:
> >=20
>=20>  some_func()
> >  ->synchronize_rcu_atomic(srcu)
> >=20
>=20>  srcu_read_unlock_atomic(srcu, idx)
> >=20
>=20The cross-CPU case is different. current->held_locks[] is part of
> struct task_struct (sched.h:1302), so the existing
> __lock_is_held() check can only see the current task's held locks.
> It cannot see the SRCU read-side lock held by the task running on
> another CPU. The same limitation applies to the
> lock_is_held(&rcu_lock_map) check in synchronize_srcu() at
> srcutree.c:1665.
>=20
>=20>=20
>=20> Add WARN_ON(irqs_disabled()) to synchronize_rcu_atomic() ?
> >=20
>=20>  Any thoughts?
> >=20
>=20WARN_ON(irqs_disabled()) wouldn't help with the cross-CPU case:
> CPU1 could be running in process context with interrupts enabled, so
> the WARN would not trigger. It would also add a false positive for
> legitimate hardirq calls. synchronize_srcu_atomic() omits
> might_sleep() (compare __synchronize_srcu() at srcutree.c:1676)
> because it is designed to work in contexts where sleeping is not
> allowed, including hardirq context.

If runing in hardirq context, we should use raw_spin_lock_irqsave_rcu_nod=
e()
and raw_spin_unlock_irqrestore_rcu_node() to replace raw_spin_lock_irq_rc=
u_node()
and raw_spin_unlock_irq_rcu_node() in synchronize_srcu_atomic().

Thanks
Zqiang



>=20
>=20Whether a general cross-CPU read-side-hold check is feasible is an
> open question. It would need to account for the read-side state across
> CPUs without adding too much overhead to the SRCU read-side fast path.
>=20
>=20I'm happy to discuss and explore whether there is a reasonable way to
> handle this cross-CPU case.
>=20
>=20Thanks,
> Kunwu
>=20
>=20>=20
>=20> Thanks
> >  Zqiang
> >=20
>=20>  Thanx, Paul
> >=20
>=20>  >
> >  > Thanks,
> >  > Kunwu
> >  >
> >  >
> >  > Thanx, Paul
> >  >
> >  > > ---
> >  > > kernel/rcu/srcutree.c | 8 ++++++++
> >  > > 1 file changed, 8 insertions(+)
> >  > >
> >  > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  > > index 6a9c432a3bd0..6c729e805fb3 100644
> >  > > --- a/kernel/rcu/srcutree.c
> >  > > +++ b/kernel/rcu/srcutree.c
> >  > > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_=
struct *ssp)
> >  > > unsigned long rdm0, rdm1;
> >  > > unsigned long unlocks0, unlocks1;
> >  > >
> >  > > + srcu_lock_sync(&ssp->dep_map);
> >  > > +
> >  > > + RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> >  > > + "Illegal synchronize_srcu_atomic() in same-type SRCU read-side=
 critical section");
> >  > > +
> >  > > + if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> >  > > + return;
> >  > > +
> >  > > // Initialize. Either init_srcu_struct() was invoked or
> >  > > // DEFINE_SRCU() or similar was used. Therefore, no allocation
> >  > > // will be done here.
> >  > > --
> >  > > 2.43.0
> >  > >
> >  >
> >
>
