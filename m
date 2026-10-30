Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362487;
	b=YZE9Os8XU33MVrYIEgY9B133sPZf6bRfLFhfgX6aV+2o0OOD2bQWdtARU6FoIxVIabmb
	 BGhjKbwOWQt3aMef7ZnflOVk0/AD5ZhvMlIJlsen5j71S3O0HG5wbZ+sVX96lLoLkYnsn
	 JqObPMURWnazFuH164bLHBEgNAcrf4tZIZE4FRH4Yjn7vEc+xkA6ONt85CFCx5hQqhM8e
	 T5D8V2ME1a9lH68AT3GmCCYdVBxU2YOEzAYPm6ko+DWGDzhFRx6sP/3xIVa1xUeSXjwDj
	 5yNqnZsPUSlgdCE5GDlfKZP4HdwNnaDoAcXt+rmGBzkooZhzUsUbq4RBQfi2q8UmZWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362487;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=h2ip5SvFQXMjskOPscXy3MGP8bE0cs7x1URhQqE3CrM=;
	b=Q31fgtieO3Qh15pHXCvPnLCsP6cQWts4WGQw00UE0rrEd+900LdNkZHDQxLi8NDNEEyB
	 BC42yp0BJFjr4YclLR5/lf/2TM/ceS4lbygvVHly0CIzzDE6dUUnuK0LpuY7HUeHmznjX
	 43g/5852JU+tvkMSZII+91J8jzg35Yamxg+1oxwD0ILHChp2spW5JqPg3SRgVMvslQxGT
	 mw16Owp3yRaeqfZum0aqqg3HjM2ZpUhBTWPz17+1Frmz5SJwUJ8V0Q99MNBpzZ6xzmpI5
	 ElXbWiOF9OfXW99zKVvI4mPtbbhI67wGi6qb9GrJ6EBR+Ul9qYy4Lg5SNvyDeByyYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q98j0faV;
	arc=none smtp.remote-ip=91.218.175.52
Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85439606A326
	for <rcu@vger.kernel.org>; Fri, 30 Oct 2026 12:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85439606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q98j0faV
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HCRBN2Dk48Rcr6GaXJ+oqaIPUyAM1rumz9TPvTLc5b8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793362484; v=1; x=1793967284;
 b=q98j0faVFE3L4eZwCTVkdjEkvxFeGPMpErXgdQ/V4ut1+C47ljzXQwzS8NjA4boc9aFAH6JI
 MQPIYDCAmts/RzJwaLm+DbhxU+cSRSc4nGYfEbWl1fqAhBK0RgoIxbDBOvG9nK5GuB6VrzJEfoG
 p5HzlaW67kKbQv9P1HGFCxfQ=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7652bde6c35a393;
	Fri, 30 Oct 2026 12:14:44 +0000
X-Mizu-Trace-ID: e7652bde6c35a393
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 12:14:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <746fe313c43392e69e99e4f9e9301abda3800a28@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] rcutorture: Avoid create fwd_prog_tasks for
 tasks-rude and srcu-atomic
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <5cb8b0cb-c7ea-4f2c-a9f9-3ccbab1bddc3@paulmck-laptop>
References: <20261023093716.25717-1-qiang.zhang@linux.dev>
 <5cb8b0cb-c7ea-4f2c-a9f9-3ccbab1bddc3@paulmck-laptop>

>=20
>=20On Fri, Oct 23, 2026 at 05:37:16PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> When running the tasks-rude and srcu-atomic tests, the fwd_prog_tas=
ks
> >  kthread is created because the default value of fwd_progress is 1.
> >  however, the two RCU flavors not support ->call():
> >=20=20
>=20>  1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU =
Tasks
> >  Rude asynchronous APIs") removed .call and .cb_barrier from tasks-ru=
de,
> >  but left the .cbflood_max =3D 50000.
> >=20=20
>=20>  2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to =
NULL
> >  for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched=
.
> >=20=20
>=20>  In both cases, the non-zero ->cbflood_max fools the check above in=
to
> >  creating the fwd_prog_tasks kthreads, even though those kthreads can=
not
> >  possibly carry out any forward-progress test:
> >=20=20
>=20>  1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_op=
s->call
> >  is NULL:
> >=20=20
>=20>  [ 68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no forward-p=
rogress test 0
> >  [ 129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no forward-pr=
ogress test 0
> >  [ 190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no forward-pr=
ogress test 0
> >  [ 252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no forward-pr=
ogress test 0
> >=20=20
>=20>  2. The rcu_torture_fwd_prog_nr() is never even invoked, because it=
s caller
> >  requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
> >  provide ->stall_dur (only rcu_ops does).
> >=20=20
>=20>  Therefore, creating fwd_prog_tasks kthreads is pointless, this com=
mit adds
> >  ->call and ->cb_barrier to the forward-progress check, rejecting fla=
vors
> >  that lack the cbflood_max set and a positive ->stall_dur.
> >=20=20
>=20>  simple verification output:
> >=20=20
>=20>  [ 3.062959][ T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled=
, unsupported by RCU flavor under test
> >  [ 2.922323][ T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disa=
bled, unsupported by RCU flavor under test
> >=20=20
>=20>  Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>=20
>=20It would nevertheless be good to run tests demonstrating that
> forward-progress testing happens and does not happen on the same
> rcu_torture_ops structures as before. Just in case I lost my
> way through that boolean expression. ;-)

Ok, I see. thanks Paul ;-) .

>=20
>=20>=20
>=20> ---
> >  kernel/rcu/rcutorture.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >  index 968343be4e0d..92ff197f4789 100644
> >  --- a/kernel/rcu/rcutorture.c
> >  +++ b/kernel/rcu/rcutorture.c
> >  @@ -4007,9 +4007,8 @@ static int __init rcu_torture_fwd_prog_init(vo=
id)
> >  } else if (fwd_progress < 0) {
> >  fwd_progress =3D nr_cpu_ids;
> >  }
> >  - if ((!cur_ops->sync && !cur_ops->call) ||
> >  - (!cur_ops->cbflood_max && (!cur_ops->stall_dur || cur_ops->stall_d=
ur() <=3D 0)) ||
> >  - cur_ops =3D=3D &rcu_busted_ops) {
> >  + if (!cur_ops->sync || ((!cur_ops->call || !cur_ops->cb_barrier || =
!cur_ops->cbflood_max) &&
> >  + (!cur_ops->stall_dur || cur_ops->stall_dur() <=3D 0))) {
> >  VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsuppor=
ted by RCU flavor under test");
> >  fwd_progress =3D 0;
> >  return 0;
> >  --=20
>=20>  2.17.1
> >
>
