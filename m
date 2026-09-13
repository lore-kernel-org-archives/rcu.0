Received: from mta0.migadu.com (out-152.mta0.migadu.com [91.218.175.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD03BFAF7
	for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789280510; cv=none; b=J3sZhhKGOUUs23Z4l+T9DZ00GnhSUTCwjfndiLabfxKjPyc8jRkQl5u38rWLsdmnJ4JalKQZInRphRzxmPKgUA0lqU52VbrAQNB43R9rvwW+dtvlIWcL7skIp7RI/KzPFdI4QNqv/lliuKnzBgnxUNrkhtYSIS+OCZN373OkN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789280510; c=relaxed/simple;
	bh=DKUbiJiE/sOu0abbPdCv3nvnAnk9qZMEAt+zFGYu3OE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=eLJayKnC3JcFollCza1qBHjQd1ZWBO6wM3voKxhu+OdRwCky8LFAEHNJxbBcaSzzYZKZRmaPO9Ymx+5NFRd3Wfd/9TR6jCEAVQP7/Z8HvNqE53hTCZVcLyBIdMPxco+eBSQd7FYceqD/3MBc2xt4yqR+R5ms86UJWlmCl0JXtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dcw8oWZF; arc=none smtp.client-ip=91.218.175.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dcw8oWZF"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DKUbiJiE/sOu0abbPdCv3nvnAnk9qZMEAt+zFGYu3OE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789280505; v=1; x=1789885305;
 b=dcw8oWZFIfrt126nsBaxlH2pWfP7vlJyOHPUpEIN5wwRhu4V7FhmfCEtyvDKZpZoklYEDAJC
 MA8Au7woDdYGewZonrtJt9+F1bnv3CxkoSKbs5+adIbWpG/VDbyXp9lvDxFtoPRp3XHin54+N1X
 nwGxlM9KaHLW5L5QVmNtjrI8=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 22ff5bd08d6f44c3;
	Sun, 13 Sep 2026 06:21:44 +0000
X-Mizu-Trace-ID: 22ff5bd08d6f44c3
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Sep 2026 06:21:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <32e952728ea1a9c25c2b56de468f43a32104b8a8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to 
 synchronize_srcu_atomic()
To: paulmck@kernel.org, "KunWu Chan" <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
 <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
 <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>

>=20
>=20On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
>=20
>=20>=20
>=20> On Sat, Sep 12, 2026 at 12:47 AM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
> >=20
>=20>  On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> >  > Add the lockdep annotation, same-type SRCU nesting warning, and
> >  > early-boot check used by __synchronize_srcu().
> >  >
> >  > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> >  > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >=20
>=20>  Queued for review and testing, thank you both!
> >=20
>=20>  Interestingly enough, it is now the case that there is a grace-per=
iod
> >  wait that can be placed in a normal RCU read-side critical section.
> >  Does this mean that we should also adjust the --do-srcu-lockdep test=
ing
> >  in tools/testing/selftests/rcutorture/bin/torture.sh?
> >=20=20
>=20>  Thanks, Paul. Good point.
> >=20=20
>=20>  I=E2=80=99ll check the current `--do-srcu-lockdep` coverage, inclu=
ding the
> >  case where `synchronize_srcu_atomic()` is called from a normal RCU
> >  read-side critical section, and follow up with the necessary torture
> >  testing changes.
> >=20
>=20Sounds good!
>=20
>=20Perhaps you and Zqiang can work together on this. Co-developed-by,
> for example.

Hi, Paul and KunWu

Should we also consider the following situations ?


idx =3D srcu_read_lock_atomic(srcu)

by interrupt run hardirq context:
   synchronize_rcu_atomic(srcu)

srcu_read_unlock_atomic(srcu, idx)


or:



           CPU0:                                                         =
         CPU1:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

idx=20=3D srcu_read_lock_atomic(srcu)

smp_call_function_single(CPU1, som_func, NULL, 1)
to send IPI to CPU1, and sync wait complete.
                                                                   hardir=
q context or ide task context:

                                                                         =
 some_func()
                                                                         =
 ->synchronize_rcu_atomic(srcu)=20=20

srcu_read_unlock_atomic(srcu,=20idx)


Add WARN_ON(irqs_disabled()) to synchronize_rcu_atomic() ?

Any thoughts?

Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> Thanks,
> >  Kunwu
> >=20=20
>=20>=20
>=20>  Thanx, Paul
> >=20
>=20>  > ---
> >  > kernel/rcu/srcutree.c | 8 ++++++++
> >  > 1 file changed, 8 insertions(+)
> >  >
> >  > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  > index 6a9c432a3bd0..6c729e805fb3 100644
> >  > --- a/kernel/rcu/srcutree.c
> >  > +++ b/kernel/rcu/srcutree.c
> >  > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_st=
ruct *ssp)
> >  > unsigned long rdm0, rdm1;
> >  > unsigned long unlocks0, unlocks1;
> >  >
> >  > + srcu_lock_sync(&ssp->dep_map);
> >  > +
> >  > + RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> >  > + "Illegal synchronize_srcu_atomic() in same-type SRCU read-side c=
ritical section");
> >  > +
> >  > + if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> >  > + return;
> >  > +
> >  > // Initialize. Either init_srcu_struct() was invoked or
> >  > // DEFINE_SRCU() or similar was used. Therefore, no allocation
> >  > // will be done here.
> >  > --
> >  > 2.43.0
> >  >
> >
>
