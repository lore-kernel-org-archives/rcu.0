Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627439;
	b=GVuMPoxtagYoc+LgKcO4M6109tkkqQo204JPLvmQ0RNonbugbAiEbZwVdvye8HYC9ZKm
	 ea96fxqfjE2WgWvjI+14JF1hCyt9lpS6ku8/+Hzo84pFL+Hej82g2zJH1imHSGGnrIObg
	 zOmdNreJyQQucUkt5w5p4WbB5j+E1olxcpQE2F8bOdQlcDw5onqmYouwKO6jl2pgdMMeg
	 oP39f4WjSnpMCx33rolDscna3gpu45zlC4P0LM6NIFhCAUfF7Erm3vJEVNZyUVo+vVer7
	 2EWcfJ4QCSU21g8YEEWpEVVb8eVrLtPTVzdziz/O+AYClWE1j92CB348Zd+AYZVEA8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627439;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=8meHEOpZpex7a+m8qpfj00KhkKtCPdGHF054UBWCRs4=;
	b=pMh003hUmUJ3jdFcifjgtQm8SRiPR/nDtjCDqE93SUuLccphx6lIyx8MqqhfQKeNJdcu
	 I8X8HKW5ELjnnLDi9MtHUIYkyEUYwT1dbXC1yOnSb0341EhcFSDsnJItKP1e/8W7klTjj
	 xCWvR2yGOo48aBUv9YjN6+6yNUA2cZakl/b+LnhL97FdpJFKymnQfBhsPMg3dReNGvQxg
	 bFtYz2fwZOPjV0NoV6bFQOsvC3MFwhTMpx0iMPzCEkJKCr+9rm3JfIsP+z70Ryy75IGcB
	 HiBbB/TT0TO9hM+Wv7SWNuRmN6HfJi5Fzooq5i2ZyAUJ4hU37VY6ac/BlULscUWvD7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=deqWApB+;
	arc=none smtp.remote-ip=95.215.58.125
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2813606A33C
	for <rcu@vger.kernel.org>; Mon,  2 Nov 2026 13:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2813606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=deqWApB+
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RB61Oyd6TaDgmIcXFReBRiPX33wW2YoBNo1nIWnrj1c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793627435; v=1; x=1794232235;
 b=deqWApB+XKofM2IiEUK8KvDIRt2a3QLXbYAYUaj05+sXDfmRov9cmB/EKQKVPrtLIgq4IqI0
 jS+Vj7zr2ct4RQFCUmOhV9Zx7GUcD0blaU3cQcGwQScueKYOhHPTX1Sv78vJtYdi9qejJlIsIpk
 m6JunUfc4VJziXGNNjYC1EAo=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 05c097b2d1638e62;
	Mon, 02 Nov 2026 13:50:18 +0000
X-Mizu-Trace-ID: 05c097b2d1638e62
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
Date: Mon, 02 Nov 2026 13:50:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <2b7d3fd6bc409170cb5207d74eb9ded4a5874b53@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] rcutorture: Avoid create fwd_prog_tasks for
 tasks-rude and srcu-atomic
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ACA82057-9E74-41CD-8EEE-1D59E98D2D41@nvidia.com>
References: <ACA82057-9E74-41CD-8EEE-1D59E98D2D41@nvidia.com>

>=20
>=20>=20
>=20> On Oct 30, 2026, at 8:14 AM, Zqiang <qiang.zhang@linux.dev> wrote:
> >=20=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>  On Fri, Oct 23, 2026 at 05:37:16PM +0800, Zqiang wrote:
> >=20=20
>=20>=20=20
>=20>  When running the tasks-rude and srcu-atomic tests, the fwd_prog_ta=
sks
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
>=20>  Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20=20
>=20>=20
>=20> >=20
>=20> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > >=20=20
>=20> >  It would nevertheless be good to run tests demonstrating that
> > >  forward-progress testing happens and does not happen on the same
> > >  rcu_torture_ops structures as before. Just in case I lost my
> > >  way through that boolean expression. ;-)
> > >=20
>=20>=20=20
>=20>  Ok, I see. thanks Paul ;-) .
> >=20
>=20So let me know Zqiang once you are confident on the testing from and =
I will apply it for 7.5.


Hello, Joel

I have make simple testing for all rcu flavor:

rcu:

[    3.871868][  T158] rcu-torture: rcu_torture_fwd_progress task started
[    3.874347][    T1] tasks-torture: rcu_torture_fwd_prog_init: Disabled=
, unsupported by RCU flavor under test
[    3.862128][    T1] tasks-tracing-torture: Creating rcu_torture_fwd_pr=
og task
[    3.857800][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Dis=
abled, unsupported by RCU flavor under test
[    3.435733][    T1] busted-torture: rcu_torture_fwd_prog_init: Disable=
d, unsupported by RCU flavor under test

srcu:

[    3.676067][    T1] srcu-torture: srcu_torture_init normal SRCU
[    3.691425][    T1] srcu-torture: Creating rcu_torture_fwd_prog task

[    3.467289][    T1] srcu-torture: srcu_torture_init NMI-safe SRCU
[    3.482983][    T1] srcu-torture: Creating rcu_torture_fwd_prog task

[    3.457597][    T1] srcu-torture: srcu_torture_init fast SRCU
[    3.475676][    T1] srcu-torture: Creating rcu_torture_fwd_prog task

[    3.381378][    T1] srcu-torture: srcu_torture_init fast-up/down SRCU
[    3.397417][    T1] srcu-torture: Creating rcu_torture_fwd_prog task

[    3.479642][    T1] srcu-torture: srcu_torture_init atomic SRCU
[    3.488532][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled,=
 unsupported by RCU flavor under test

srcud:

[    3.898271][    T1] srcud-torture: srcud_torture_init normal SRCU
[    3.915141][    T1] srcud-torture: Creating rcu_torture_fwd_prog task

[    3.586829][    T1] srcud-torture: srcud_torture_init NMI-safe SRCU
[    3.604943][  T146] srcud-torture: rcu_torture_fwd_progress task start=
ed

[    3.617095][    T1] srcud-torture: srcud_torture_init fast SRCU
[    3.635608][    T1] srcud-torture: Creating rcu_torture_fwd_prog task

[    3.915194][    T1] srcud-torture: srcud_torture_init fast-up/down SRC=
U
[    3.933086][    T1] srcud-torture: Creating rcu_torture_fwd_prog task

[    3.866575][    T1] srcud-torture: srcud_torture_init atomic SRCU
[    3.883949][    T1] srcud-torture: rcu_torture_fwd_prog_init: Disabled=
, unsupported by RCU flavor under test

srcud-busted:

[    3.382474][    T1] busted_srcud-torture: srcu_torture_init normal SRC=
U
[    3.389525][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: D=
isabled, unsupported by RCU flavor under test

[    3.423111][    T1] busted_srcud-torture: srcu_torture_init NMI-safe S=
RCU
[    3.432941][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: D=
isabled, unsupported by RCU flavor under test

[    3.364002][    T1] busted_srcud-torture: srcu_torture_init fast SRCU
[    3.372654][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: D=
isabled, unsupported by RCU flavor under test

[    3.860358][    T1] busted_srcud-torture: srcu_torture_init fast-up/do=
wn SRCU
[    3.870796][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: D=
isabled, unsupported by RCU flavor under test

[    3.364909][    T1] busted_srcud-torture: srcu_torture_init atomic SRC=
U
[    3.372280][    T1] busted_srcud-torture: rcu_torture_fwd_prog_init: D=
isabled, unsupported by RCU flavor under test

trivial:

[    3.858080][    T1] trivial-torture: rcu_torture_fwd_prog_init: Disabl=
ed, unsupported by RCU flavor under test
[    3.689060][    T1] trivial-preempt-torture: rcu_torture_fwd_prog_init=
: Disabled, unsupported by RCU flavor under test



Thanks
Zqiang

>=20
>=20thanks,
>=20
>=20Joel Fernandes
>=20
>=20>=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>=20=20
>=20>  ---
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
> >  --
> >  2.17.1
> >=20=20
>=20>=20
>=20> >=20
>=20> >=20
>=20> >
> >
>
