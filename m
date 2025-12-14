Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF32E3B1C
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765682874; cv=none; b=kQxJl4z1fQtofhlFfmRLrU1IfBvKbk9mui8U/N1UhJ76tRrpFbvYFN6Ycdw0f0siAsm7LuCv1VpdhcmaMnIP/BC7rH3B+5Hy84oswD8d583ImoxMRPhpLl9vPwN7uT/Miqn5mH6nsSHOkr1+Hu+Zuv9v8iYNwrw5rvn3qlph4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765682874; c=relaxed/simple;
	bh=9eAUnOfGiJU1ZuTKjgKvNA9utX+kFraDeUyYoARH+gs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=a3EWkkLqvr1nWr+b78BOTMYPPEOgjrmOi04OpiIYo9epxwJUQO/US5U/M0a2ZbwEjW08x02VUDMRi9WrEVuTA6PhkBMVs+mYDYAP6asORZM8LcgEZRlHyP0zEaMQmEWmsNiXgbx33CFmH7ZYmRQQnSfoccSPO9rAt+EZU4Y79Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZVhAgyd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZVhAgyd"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765682866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IbxK7gVPF3ySMRskI4S5Z+sLxF8K+3g1TxLF+AfjAE=;
	b=MZVhAgydZ6T03yiouLNHhhSNyE0AlPoFBS24+LekD47o7oBZTR1UiEZt/q9Q5LCOl1yEKu
	n1Dmx/W6sRSh/s+zCjmoPUGa7SfC/9NU81PqX+3vPPz6VZ54RuHgpxuupfCa6ptG7gPxYi
	iIpfxRSG+2VnBwyO+cJDdokJ2viYaww=
Date: Sun, 14 Dec 2025 03:27:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <e4030c94bbc55d1e78f0d26039561f583ff0cadf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2D296DB9-2F60-47B2-A48A-D490A291A0EB@nvidia.com>
References: <20251213135518.109887-1-qiang.zhang@linux.dev>
 <2D296DB9-2F60-47B2-A48A-D490A291A0EB@nvidia.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20>=20
>=20> On Dec 13, 2025, at 10:56 PM, Zqiang <qiang.zhang@linux.dev> wrote:
> >=20=20
>=20>  In some kernels which is set convert_to_big to SRCU_SIZING_INIT,
> >  for use the init_srcu_struct*() to initialized srcu structure,
> >  the is_static parameters is always false, the memory allocation
> >  for srcu_sup structure's->node can use GFP_KERNEL flags.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >  kernel/rcu/srcutree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  index ea3f128de06f..e4571b569752 100644
> >  --- a/kernel/rcu/srcutree.c
> >  +++ b/kernel/rcu/srcutree.c
> >  @@ -262,7 +262,7 @@ static int init_srcu_struct_fields(struct srcu_s=
truct *ssp, bool is_static)
> >  ssp->srcu_sup->srcu_gp_seq_needed_exp =3D SRCU_GP_SEQ_INITIAL_VAL;
> >  ssp->srcu_sup->srcu_last_gp_end =3D ktime_get_mono_fast_ns();
> >  if (READ_ONCE(ssp->srcu_sup->srcu_size_state) =3D=3D SRCU_SIZE_SMALL=
 && SRCU_SIZING_IS_INIT()) {
> >  - if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> >  + if (!init_srcu_struct_nodes(ssp, !is_static ? GFP_KERNEL : GFP_ATO=
MIC))
> >=20
>=20Nit: please avoid double negatives, becomes a bit harder to read:
>=20
>=20Instead,
> is_static ? GFP_ATOMIC : GFP_KERNEL

Ok, will do that.

>=20
>=20Is it also worthwhile adding a might_sleep() here for additional robu=
stness?

Would it be more appropriate to add might_sleep() before
allocating ssp->srcu_sup ?

Thanks
Zqiang


>=20
>=20Thanks.
>=20
>=20>=20
>=20> goto err_free_sda;
> >  WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
> >  }
> >  --
> >  2.48.1
> >
>
