Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E672E1722
	for <rcu@vger.kernel.org>; Wed, 31 Dec 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167717; cv=none; b=o/t+No33uTVu3lPdbkUXxsp/Lp7tWa/T+z9x6AjLm0tS3pEbAX0NrTEQL5o02C2l8vFXTfdd2vxtUg7uDD1i0TPVmfdCcXBIrd/wUzB/smc7H/CtjmpoUvSb8bFv6gOc3j82f0y/39B+kZAP3X2TYePQ4197n6rUOY/+ayGL58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167717; c=relaxed/simple;
	bh=rWOszggxjJjpncGJmiFkk4N4MH9eYsYtfbMMHhWRgJY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CjarWlsGw/ruXZi4ie5HZnvKW1JWBMyD/7SuXaU4d1Dokm8wf4gxHaSDO3CFR/zSHu/GUPYJOWmCSzxAH07Kk1gj2VnGYbtNl0fnzzALDx5XBPq+AvKJNfqLes8mVOfv+28nOjiqMaybNS1kOnE4WQ7irEdXf3WSJosEXnoLvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qy7Gcw2W; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qy7Gcw2W"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767167703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzuMiu6c93+7tR3MBDwHo6wwFpJ1ILdR+zPuQ7Q2CTU=;
	b=qy7Gcw2WRtjhA6649YMOoE7gPU3elTajFGr5Xl6XEq9fnrG0CkTT6MP4tBmZNZpZKFKrqS
	ZkhByUuJlkpG9U+LbCksfRxatTlp4mIotRha3hkZ6XxCQL/9eVy91Dm3iNQfQzL2OTJ75n
	vvRWoillalyJGT+1AJAkHCFqjg124+Y=
Date: Wed, 31 Dec 2025 07:55:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <9254e0cfc06f9820d77113a4be5d3f6d6edd28cd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary smp_store operations in
 the cblist_init_generic()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b8cae37a-65c9-4380-9290-8494c854373e@paulmck-laptop>
References: <20251214024904.121128-1-qiang.zhang@linux.dev>
 <b8cae37a-65c9-4380-9290-8494c854373e@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Sun, Dec 14, 2025 at 10:49:04AM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> The cblist_init_generic() is executed during the CPU early boot
> >  phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
> >  lists at rcu_init() time"), at this time, only one boot CPU is
> >  online. this commit therefore use WRITE_ONCE() to replace the
> >  smp_store_release() to assigning rtp->percpu_enqueue_lim in the
> >  cblist_init_generic().
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Good eyes, thank you!
>=20
>=20But in that case, we are running on a single CPU with interrupts disa=
bles,
> so do we even need WRITE_ONCE()?

I missed the interrupts disabled, It seems like there are no need use WRI=
TE_ONCE()
and include above, I will update and resend.

Thanks
Zqiang




>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index 76f952196a29..f763f60d5e50 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -292,7 +292,7 @@ static void cblist_init_generic(struct rcu_tasks=
 *rtp)
> >  shift++;
> >  WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> >  WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> >  - smp_store_release(&rtp->percpu_enqueue_lim, lim);
> >  + WRITE_ONCE(rtp->percpu_enqueue_lim, lim);
> >=20=20
>=20>  pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=
=3D%d rcu_task_cpu_ids=3D%d.\n",
> >  rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->perc=
pu_enqueue_lim),
> >  --=20
>=20>  2.48.1
> >
>
