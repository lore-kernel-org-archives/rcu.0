Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53086247280
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572831; cv=none; b=DTbFHkxaoDoizX//ij9bkOKypX4yeVL29xyU1iDlHtoOYmU4F+9lMYvP0KO1fGegpJ8tnd9J9QmU/5+ld/eeHerY1FFGW1BbR5ZSVyjcrOXFFVfcbzOwQbGO6h6dfJUMCzOL2CbB92ULbSxedEXP7Hn+I9Jkz15fMD7pxepW3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572831; c=relaxed/simple;
	bh=o5A2JDmc2TaaPyIwFTjbHiAdUQ1p2BngZub+pHyh1c0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Jrcj+RbHzzCgNmnO9cd39hSedmAsLsR9FQ152dKVsqHiqq5JFngikRDABqNIdeXsSvcpgD+b1KN0YXC1efHMZtZxxDByiLCSopdV34V+PYEibwhSZkKdZXtM8qIw8L2dN5SbP8ruzmOTQQfqkdpjNKGfUk5zDKDQGmJxg3AhiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eXk1iysf; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eXk1iysf"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767572816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/foYnzrGmcXx1MWIBMjcYndMwgxhMsludhrjSZdsgNk=;
	b=eXk1iysf+Q6IX5x+/D5CuyrOqCyA0v04K8dyv5hQhEWOE52eYmOD4iUZrPaf6BAxfShuV1
	pQjZ/8ZGO8c6Q9QrJ8jXt6dRRkZTuwhRlt+Y6NFyPYqpjcoD3SRC2yND4/inTkTiLbQRMi
	tGr3Iq39eayFRt4P8OKEpxfV7ShQ/pU=
Date: Mon, 05 Jan 2026 00:26:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <3188cbf5bcbe5799c77a6cc870ad0ee85b58d255@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu: Align stall warning 'idle=' output with
 documentation
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Donglin Peng"
 <dolinux.peng@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 rostedt@goodmis.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Donglin Peng" <pengdonglin@xiaomi.com>
In-Reply-To: <20260104194534.GA2247470@joelbox2>
References: <20260104081027.189234-1-dolinux.peng@gmail.com>
 <20260104194534.GA2247470@joelbox2>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Sun, Jan 04, 2026 at 04:10:27PM +0800, Donglin Peng wrote:
>=20
>=20>=20
>=20> From: Donglin Peng <pengdonglin@xiaomi.com>
> >=20=20
>=20>  The RCU stall warning message includes an "idle=3D" field to indic=
ate
> >  the dyntick-idle state of a CPU. According to Documentation/RCU/stal=
lwarn.rst,
> >  the hexadecimal number before the first '/' represents the low-order=
 16
> >  bits of the dynticks counter. An even value denotes that the CPU is =
in
> >  dyntick-idle mode, while an odd value indicates otherwise.
> >=20=20
>=20>  This was accurate until commit 171476775d32 ("context_tracking: Co=
nvert state to atomic_t"),
> >  which merged the context tracking state and the dynticks counter int=
o a
> >  single atomic value. Consequently, the value printed in the stall wa=
rning
> >  no longer directly corresponds to the documented dynticks counter bi=
ts.
> >=20=20
>=20>  To restore consistency between the code's output and the documenta=
tion,
> >  right-shift the merged atomic state value to extract and display the
> >  correct low-order bits of the dynticks counter.
> >=20=20
>=20>  Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t"=
)
> >  Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> >=20
>=20Looks good to me! Also nice use of ilog2() which resolves to a single=
 shift
> right instruction per my testing (shift right of 2).
>=20
>=20Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>=20
>=20thanks,
>=20
>=20 - Joel
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/tree_stall.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >  index b67532cb8770..d25cc826d77a 100644
> >  --- a/kernel/rcu/tree_stall.h
> >  +++ b/kernel/rcu/tree_stall.h
> >  @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
> >  rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
> >  "!."[!delta],
> >  ticks_value, ticks_title,
> >  - ct_rcu_watching_cpu(cpu) & 0xffff,
> >  + (ct_rcu_watching_cpu(cpu) >> ilog2(CT_RCU_WATCHING)) & 0xffff,



May be also use CT_RCU_WATCHING_START to
replace ilog2(CT_RCU_WATCHING) operations? (I didn't actually test it)

Thanks
Zqiang


> >  ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
> >  rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
> >  data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> >  --=20
>=20>  2.34.1
> >
>
