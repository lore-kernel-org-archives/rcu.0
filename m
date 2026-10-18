Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86F34D397
	for <rcu@vger.kernel.org>; Sun, 18 Oct 2026 02:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291884; cv=none; b=c+AhvEwAKbfF4hSlggr8qbmKKu8OhMtXQFuLA5necVnmvxaXUK50mI1Zr+sSJGHm334b76fCKdy+G7mspKWvDMz7KKXeAYWiv+mNbBqRidaVYiHDJLzuzImzOf2GCEbNKVemwmGefVuYSiSAyTLUz8pM9Fgdfc8NEoQ4Tgjgolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291884; c=relaxed/simple;
	bh=wA3bzBzkubJAzxoEJdPOpOYuFRmZFkX99276xQziAVA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=miUwLz2xAdMyaR9a0f7znIeqGMUj69/n1DsF6R7ZjxtpLTjxHegTpkL8C0+xxDwshedLdqN1c9WrZLvkSaJ16WXzAQijgkF3wO5LOqg/sfUr/BBsagG0zwo18UHjaNTAAXlssnVeW6qR7M5Ej1muCBYVrJmmrP1vMcTWITfKkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MnU3EdKy; arc=none smtp.client-ip=95.215.58.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MnU3EdKy"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wA3bzBzkubJAzxoEJdPOpOYuFRmZFkX99276xQziAVA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792291880; v=1; x=1792896680;
 b=MnU3EdKyeVTIpC3+eQ988IJXNZMz/Jm0PREQ+rp4JZffONKoIWu55eM+hF+NpqM5PgA6yC0L
 HcOP2hfurGFT03LCUeXMDBnwjcvOydo4RTITN7UVVvlJYtkWj+msy0Cafaf9cNIh85JaBCzrW1n
 Lzh2NHbfcX5HcAYJuXTHCVzg=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dd522225debb44ed;
	Sun, 18 Oct 2026 02:51:20 +0000
X-Mizu-Trace-ID: dd522225debb44ed
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 Oct 2026 02:51:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <0c9fd241b8bdef73b3fe83683a238ad7df13bf65@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <970F52C9-3198-4BD1-B1A9-6A4B24F550AA@nvidia.com>
References: <20261015094619.8773-1-qiang.zhang@linux.dev>
 <970F52C9-3198-4BD1-B1A9-6A4B24F550AA@nvidia.com>

>=20
>=20>=20
>=20> On Oct 15, 2026, at 5:46 AM, Zqiang <qiang.zhang@linux.dev> wrote:
> >=20=20
>=20>  The RCU Tasks Rude grace period is implemented by invoking the
> >  schedule_on_each_cpu() with an empty work function, which forces
> >  a context switch on every online CPU and guarantees that all
> >  rude-tasks read-side critical sections have completed. However,
> >  schedule_on_each_cpu() can fail (via alloc_percpu() returning
> >  -ENOMEM) and returns immediately, in which case those context
> >  switches never happen, too-short grace period happen.
> >=20=20
>=20>  This commit therefore wraps the schedule_on_each_cpu() call in
> >  WARN_ONCE() so that this failure is reported as a "Too-short
> >  grace period" warning.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >  kernel/rcu/tasks.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index fcac7361ec51..91c25717402e 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct work_stru=
ct *work)
> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >  {
> >  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> >  - schedule_on_each_cpu(rcu_tasks_be_rude);
> >  + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
> >  + "%s: Too-short grace period, OOM is now expected behavior!!!\n", r=
tp->name);
> >=20
>=20Is that the best error message? OOM is expected when grace periods do=
 not conclude.
>=20

Hi,=20Joel

I will resend v2, use DEFINE_PER_CPU() to replace alloc_percpu() to alloc=
ate work_struct objects.

Thanks
Zqiang

> Thanks.
>=20
>=20>=20
>=20> }
> >=20=20
>=20>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback=
_t func);
> >  --
> >  2.17.1
> >
>
