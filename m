Received: from mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC21A0B0E
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194411; cv=none; b=mo1uc9Qj9in91dsnJfVc2jysxlN58BfyLO7CEZKLpvP2bg3dWgzJ3dGAFGZAb3CN1PjIkepAOAUq8fAdwJBsTT2GEvVudGvS9h3a8KRyl4r/EKYHs9sDhjsolwcLbKtSPv0bkChcGQgTGWLEDUBbwcedI/nM6qA6cyMlRjEBMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194411; c=relaxed/simple;
	bh=G1Vz29oWYSTovODRxSCg3TcRy45L95oOL4PSZ3a5lOQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XtbVdtFsQYO7efDR2J5UaVusKFj9PwRc3tIriqYWhc3abJO2b8cUINav6AwHToZlCAYQF+pnBVQMGcm5QmoggL8fx173WLP5ZAifEOp1G5XhdnVeowKUNtZkRjmMeFywv6SeVsXS5NKUwyNDC/4LY8TcvA62RYfRz9Ym6Gp8ceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w3w6KlUt; arc=none smtp.client-ip=95.215.58.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w3w6KlUt"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=G1Vz29oWYSTovODRxSCg3TcRy45L95oOL4PSZ3a5lOQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792194408; v=1; x=1792799208;
 b=w3w6KlUt/aOlliKlK1IFPOPA+SZXga7iqhcRq9413Fgb9Z6fU7s/yF8ePnwkYlK9cXReFreh
 JiLuVanTop+DjMrCsVfz7XAAHngl5bdv8tBUmceSy78nYLe82M4PEElgEX9G9B9eWOukN+H70Y7
 OnAzWQiJLISioEn5y89Q3r2A=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3dfc57db80b0a082;
	Fri, 16 Oct 2026 23:46:48 +0000
X-Mizu-Trace-ID: 3dfc57db80b0a082
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 23:46:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <a7d7a54442035f8401d8dd55546ee549f28f1c49@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcutorture: Clear cbflood_max for tasks-rude and
 srcu-atomic testing
To: "Bradley Morgan" <brads@mainlining.org>
Cc: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
In-Reply-To: <CB7858D2-103F-4EB5-8A7B-55E1A65042FA@mainlining.org>
References: <CB7858D2-103F-4EB5-8A7B-55E1A65042FA@mainlining.org>

>=20
>=20On 12 October 2026 11:41:34 BST, Zqiang <qiang.zhang@linux.dev> wrote=
:
>=20
>=20>=20
>=20> When running the tasks-rude and srcu-atomic tests, the fwd_prog_tas=
ks
> > kthread is created because the default value of fwd_progress is 1.
> > however, the two RCU flavors not support ->call():
> >=20
>=20> 1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU T=
asks
> >  Rude asynchronous APIs") removed .call and .cb_barrier from tasks-ru=
de,
> >  but left the .cbflood_max =3D 50000.
> >=20
>=20> 2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to N=
ULL
> >  for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched=
.
> >=20
>=20> In both cases, the non-zero ->cbflood_max fools the check above int=
o
> > creating the fwd_prog_tasks kthreads, even though those kthreads cann=
ot
> > possibly carry out any forward-progress test:
> >=20
>=20> 1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_ops=
->call
> >  is NULL:
> >=20
>=20> [ 68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no
> > forward-progress test 0
> > [ 129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no
> > forward-progress test 0
> > [ 190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no
> > forward-progress test 0
> > [ 252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no
> > forward-progress test 0
> >=20
>=20> 2. The rcu_torture_fwd_prog_nr() is never even invoked, because its=
 caller
> >  requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
> >  provide ->stall_dur (only rcu_ops does).
> >=20
>=20> Therefore, creating fwd_prog_tasks kthreads is pointless, this comm=
it
> > removes the .cbflood_max from tasks-rude and clears ->cbflood_max in =
the
> > srcu_torture_init_forbidden_apis().
> >=20
>=20> simple verification output:
> >=20
>=20> [ 3.062959][ T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled,
> > unsupported by RCU flavor under test
> > [ 2.922323][ T1] tasks-rude-torture: rcu_torture_fwd_prog_init:
> > Disabled, unsupported by RCU flavor under test
> >=20
>=20Fixes tag?
>=20
>=20This LGTM anyway so:
>=20
>=20Reviewed-by: Bradley Morgan <brads@mainlining.org>

Thanks for reviewed !!

Thanks
Zqiang

>=20
>=20>=20
>=20> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > ---
> >  kernel/rcu/rcutorture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 968343be4e0d..00db87256e78 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -723,6 +723,7 @@ static void srcu_torture_init_forbidden_apis(void=
)
> >  cur_ops->deferred_free =3D NULL;
> >  cur_ops->exp_current =3D NULL;
> >  cur_ops->start_gp_poll =3D NULL;
> > + cur_ops->cbflood_max =3D 0;
> >  }
> >=20=20
>=20>  static void srcu_torture_init(void)
> > @@ -1250,7 +1251,6 @@ static struct rcu_torture_ops tasks_rude_ops =
=3D {
> >  .exp_sync =3D synchronize_rcu_tasks_rude,
> >  .gp_kthread_dbg =3D show_rcu_tasks_rude_gp_kthread,
> >  .get_gp_data =3D rcu_tasks_rude_get_gp_data,
> > - .cbflood_max =3D 50000,
> >  .irq_capable =3D 1,
> >  .name =3D "tasks-rude"
> >  };
> >=20
>=20--- Thanks!
> "I'm not a very positive person" - Linus torvalds
>
