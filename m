Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAC2609CC
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765699777; cv=none; b=sg2knxpRdx4x9Sup7wxYdwQfy/i0j3DmeR6Ne7nn/i7U5IxkXWIvkfilOqIWlNHTBmcRLS2VdZgmZlZjSH1PDqbMfc3wcVuFYLWBPPvAp3OXQtqELNeVc0y1/gvgWx88qoKiWoa0ovN6DPDnkaMuSSMcGMT+XdPQoEe0b1IZoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765699777; c=relaxed/simple;
	bh=M2FGEwwT4zXcGkt9j5/ja6BrOplqjQa45cHgmqVFi2c=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gWJcRvB+Wr8olufEreeVlfv65YHprr07A9Cb9WYPoHRBDrCD5yi1FBesQY9pzIwRQsm3jDkyOB+jJOZ0nmFvD5TS94zF2So6FT8yRPPdQiDAhAu6FZScym7hgMlie2OGl6cc351CASi47ZXgHKU8woDf+ljyH17Lh2t2pzu3bMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZUEfUf1N; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZUEfUf1N"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765699768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71K4+QjiNI/4PIBCHDWzQQSXlzpWyuqXts7FvsKWdeo=;
	b=ZUEfUf1NCOzv2Gao1caXixOtSciWRItUocHBz0eUF7UsheeQSwY14AVBTl+SigpchPEUTU
	bzrW1TytZyhCk3AtgoVM4z/QoaHIYDDKLa+iA1L+96fAiJDaLtwYTaRGZLQB0FBzeKC+3A
	dE2YOdZEaes8QrR9Cw9nBRr6UUiHwJA=
Date: Sun, 14 Dec 2025 08:09:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <37b5095a7c5014a5bcc9874b8433a043c8b94819@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Use suitable gfp_flags for the
 init_srcu_struct_nodes()
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <811D4BC0-A080-47C5-84AA-24EDE1C4EF6F@nvidia.com>
References: <20251213135518.109887-1-qiang.zhang@linux.dev>
 <2D296DB9-2F60-47B2-A48A-D490A291A0EB@nvidia.com>
 <e4030c94bbc55d1e78f0d26039561f583ff0cadf@linux.dev>
 <811D4BC0-A080-47C5-84AA-24EDE1C4EF6F@nvidia.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20>=20
>=20> On Dec 14, 2025, at 12:28 PM, Zqiang <qiang.zhang@linux.dev> wrote:
> >=20=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> >=20
>=20> >=20
>=20>=20=20
>=20>  On Dec 13, 2025, at 10:56 PM, Zqiang <qiang.zhang@linux.dev> wrote=
:
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
> >=20=20
>=20>=20
>=20> >=20
>=20> > Nit: please avoid double negatives, becomes a bit harder to read:
> > >=20=20
>=20> >  Instead,
> > >  is_static ? GFP_ATOMIC : GFP_KERNEL
> > >=20
>=20>=20=20
>=20>  Ok, will do that.
> >=20=20
>=20>=20
>=20> >=20
>=20> > Is it also worthwhile adding a might_sleep() here for additional =
robustness?
> > >=20
>=20>=20=20
>=20>  Would it be more appropriate to add might_sleep() before
> >  allocating ssp->srcu_sup ?
> >=20
>=20Actually this is probably not needed because the slab allocator alrea=
dy does that for sleepable allocations.

Yes, I also find the might_alloc() already exists in the slub allocator.=
=20

Thanks
Zqiang

>=20
>=20So feel free to ignore the suggestion.;-)
>=20
>=20The one reason to do it might just be for documentation.
>=20
>=20Thanks.
>
