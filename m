Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611E306B08
	for <rcu@vger.kernel.org>; Mon,  8 Sep 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337590; cv=none; b=r67mOhXnyxaxAOtkS8wJeT1PT59ZYhNIUk672iKdewoCR922TBq+XwAq1nm+9AtMAy1ih8I7rUbB6n2MQtUeeetEYGdRIH+vA6i3xYCpN3zCrauImkeiwPaXbL7/A4smoX4HKwfTpIogvsbxvSeDzI3kaB6FNYb6e2h6oV0yBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337590; c=relaxed/simple;
	bh=CMkxjovtdluJdrhTykccaf/DPBkVzKytqf4GBlWPI+w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=q+H3urGr+P2rYeTDHDa+Vapz4H5MJFmEHGB/pIqbLoBRFjaRC5bDLB0BG4/XBSlaOPUVqpUVDrLVix1l2AbptaM5jSLWalQjZg+Lp9x/JmTi9+oJdcyOikbWTznIG2yrdL6dvSvH0MCCIhddDzQe5/CGTgTyeYxKayd3R2isVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hwUlUdSJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwUlUdSJ"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757337586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvWF9oiEuQKrAaQ99dbpu/iFnJzrE3J1N28AGILDc+8=;
	b=hwUlUdSJC2YGXLwGISplUSfwmRM+Si9gNwupQ9M7EO+TwovGGPNGmYm8MD6h5tWgwYJWsF
	ez6zY0pwEQ1A/n2jXe09ZXF1ECvsZJiibzcc9+Ys3x/pP8v8OtaTvQJ9EG+uk4Y6ukZC8+
	sl+CNhrDUJkVtWmlGSRwO/zurrW2OA8=
Date: Mon, 08 Sep 2025 13:19:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <63d537e65b7f4b6f77a16112a871103d07a248d2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <9dfa7d4f-6e3f-4084-a14f-beb1db06f817@paulmck-laptop>
References: <20250908003155.557070-1-qiang.zhang@linux.dev>
 <9dfa7d4f-6e3f-4084-a14f-beb1db06f817@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Mon, Sep 08, 2025 at 08:31:55AM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> Currently, the srcu_gp_start_if_needed() is always be invoked in
> >  preempt disable's critical section, this commit therefore remove
> >  redundant preempt_disable/enable() in srcu_gp_start_if_needed().
> >=20=20
>=20>  Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable pree=
mption")
> >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Looks good, but what would be a good way to make this code defend its=
elf
> against being invoked from someplace else that did have preemption
> enabled? Especially given that the Tree SRCU version of this function
> does get invoked with preemption enabled?

ok, maybe we can add lockdep_assert_preemption_disabled() in
the srcu_gp_start_if_needed() ?

Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/srcutiny.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >  index b52ec45698e8..417bd0e4457c 100644
> >  --- a/kernel/rcu/srcutiny.c
> >  +++ b/kernel/rcu/srcutiny.c
> >  @@ -181,10 +181,8 @@ static void srcu_gp_start_if_needed(struct srcu=
_struct *ssp)
> >  {
> >  unsigned long cookie;
> >=20=20
>=20>  - preempt_disable(); // Needed for PREEMPT_LAZY
> >  cookie =3D get_state_synchronize_srcu(ssp);
> >  if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> >  - preempt_enable();
> >  return;
> >  }
> >  WRITE_ONCE(ssp->srcu_idx_max, cookie);
> >  @@ -194,7 +192,6 @@ static void srcu_gp_start_if_needed(struct srcu_=
struct *ssp)
> >  else if (list_empty(&ssp->srcu_work.entry))
> >  list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> >  }
> >  - preempt_enable();
> >  }
> >=20=20
>=20>  /*
> >  --=20
>=20>  2.48.1
> >
>
