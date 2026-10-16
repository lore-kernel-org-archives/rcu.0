Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476029D288
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194065; cv=none; b=i20/hwXv/4z2CQSFXHjq097RFy2nf5YCVinBdVSucPlYw9W6LQVSp/7zHjKacW2tDYnlzZUREuSZYKzwV32qRII026LptXgUZuJY+nfU2oGE+whUd0j8q4OofaLPC9ytL0eL552dmFGdAqAvM7ijCN85PnC8HUY53mYyKUt83C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194065; c=relaxed/simple;
	bh=P2oJEjK48YxbmXcf07T3CDj8eQed/6ihYVaubh19t6s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LMcx9PSgRPwmychHFV+j0HNZg7ltArpDvYkVNE+xIdpHezF6W+0isMLRPIc+st00uD0U7dM0W8jIQHPZQ/V8T8znT1vE+TLeojeJcPT+wjcUqs1V+7JYIMzLENH95C/zG2oMEQYH29697whQgdyrx/ALHxabYVbP4lqwwavawvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TGHsoODJ; arc=none smtp.client-ip=91.218.175.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TGHsoODJ"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P2oJEjK48YxbmXcf07T3CDj8eQed/6ihYVaubh19t6s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792194060; v=1; x=1792798860;
 b=TGHsoODJiIEVmw947/krKdrqm7KCpfBCsj0g+NgdJtk8eJZatyn12goqPFuxSc9aIoA5zkdT
 19H966DH8piCL0D5rX1tqNube0djtjFwaAmat5wrhom2o33fDrAeLPW0DFKDEXtH/nXvA3NH2SC
 a6wxY8NKXfx0DWBz/51sjF7M=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 134b307fc00d8967;
	Fri, 16 Oct 2026 23:41:00 +0000
X-Mizu-Trace-ID: 134b307fc00d8967
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 23:41:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
To: "Bradley Morgan" <brads@mainlining.org>
Cc: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
In-Reply-To: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org>
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org>

>=20
>=20On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev> wrote=
:
>=20
>=20>=20
>=20> The RCU Tasks Rude grace period is implemented by invoking the
> > schedule_on_each_cpu() with an empty work function, which forces
> > a context switch on every online CPU and guarantees that all
> > rude-tasks read-side critical sections have completed. However,
> > schedule_on_each_cpu() can fail (via alloc_percpu() returning
> > -ENOMEM) and returns immediately, in which case those context
> > switches never happen, too-short grace period happen.
> >=20
>=20> This commit therefore wraps the schedule_on_each_cpu() call in
> > WARN_ONCE() so that this failure is reported as a "Too-short
> > grace period" warning.
> >=20
>=20NAK, this seems like a edge case, and potentially panicking the syste=
m
> with panic on oops doesn't seem right to me, because we would reserve t=
hat
> for when something definitely goes really wrong and we need to notify
> the user.
>=20
>=20I don't believe this patch should go in for this reason, it's a heavy=
 edge
> case, that doesn't *have* nessesarily need to be accounted for.

Indeed, this is a rare event, so I use WARN_ONCE() to mark it, the WARN_O=
NCE()
not panicking system unless you set warn_on_oops true, this can help us t=
roubleshoot
UAF issues caused by a too short tasks-rude grace period.

or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work) to repl=
ace
alloc_percpu(struct work_struct) queue to all online CPUs.

Anyway, Thank you for your reply. I would also like to hear the opinions =
of others.

Thanks
Zqiang


>=20
>=20Zqiang, have you reproduced this OOM on your own system, if so, could=
 you
> tell me more details, you may turn my frown into a smiley face ;)
>=20
>=20>=20
>=20> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > ---
> >  kernel/rcu/tasks.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
>=20> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index fcac7361ec51..91c25717402e 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct work_struc=
t *work)
> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >  {
> >  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> > - schedule_on_each_cpu(rcu_tasks_be_rude);
> > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
> > + "%s: Too-short grace period, OOM is now expected behavior!!!\n", rt=
p->name);
> >=20
>=20Good message, makes sense. But I don't think this is right, see above=
.
>=20
>=20>=20
>=20> }
> >=20=20
>=20>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback=
_t
> >  func);
> >=20
>=20--- Thanks!
> "I'm not a very positive person" - Linus torvalds
>
