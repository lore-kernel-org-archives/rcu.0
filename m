Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054641A760
	for <rcu@vger.kernel.org>; Thu, 16 Jul 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203764; cv=none; b=Ge57AYOEH64HUYynci9PJB7uOaMztHgTlk30H8Jxb5q3/7fCwNu4siTVN0SwCX27O0Vw2YJk2PQTn+M51nG6QVLt1f7PunEFdjES6NTAiqucWNFv/tkZQs+8mS2WHNstiTj+RQb53/i5JTxSp9ZBSNxT7+VcEfm8cjpRil7ze+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203764; c=relaxed/simple;
	bh=r2dmu2ycJGEYVHizZLl85lfiNoo1A1VJLvOUSh5JlGE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=L0YKcj6ZOJx45/mDQp1XVNCtiV1wj8d1Y11Y4JptS+JOnM7yUbfmTpAuC3kP2Y0CNgZdU/3gRUnfuOGDWtMNL1nougBW+jP+cLCvdeZZvYU7bcYtiZi/NdoHUR3t9R35/1fJ70DfoqZ5gy2teLh7CUIxJ4qQV/R2R4PMXL5vo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hh/v1Y1s; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hh/v1Y1s"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784203750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN0sRFKK3BwtvDA7sIcX0Sie8Fsea3P7aTP6Q81xsKY=;
	b=hh/v1Y1s+6+d+2apo6D+5ghFc94I5NtQdDdksfAEeWuOIm5cVJM1wyXrEDX6ilNtpTxCxn
	iILmvpwZgDGN8X/5UKZf82Z8IzExAc+DOH3F8jvDeOJhDIybKNMBaKDm66uFbeFTBfKSjJ
	jmK44lm5BAkivi7Q38O1HY6pVNJTKm0=
Date: Thu, 16 Jul 2026 12:09:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <7ac329e8d59e4dfbb8a19d127e1dff6915735872@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Update comments in call_rcu_tasks_generic()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <4f9b2c64-3d9d-4b39-af13-9ac726e21660@paulmck-laptop>
References: <20260713103126.29782-1-qiang.zhang@linux.dev>
 <4f9b2c64-3d9d-4b39-af13-9ac726e21660@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Mon, Jul 13, 2026 at 06:31:26PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> Currently, the comments: "We can't create the thread unless interru=
pts
> >  are enabled." from 'commit 4929c913bda5 ("rcu: Make call_rcu_tasks()
> >  tolerate first call with irqs disabled")', now the kthread creation
> >  has been move to core_initcall() time from 'commit c63eb17ff06d
> >  ("rcu: Create call_rcu_tasks() kthread at boot time")', and use the
> >  irq_work does deferred wakeup. this commit therefore update comments
> >  in call_rcu_tasks_generic().
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Queued and pushed both, thank you! I adjusted the comment and commit =
log,
> so please double-check them in case I messed something up.

Thank you for adjusted comment! I have been checked(including previous SR=
CU patches).

Thanks
Zqiang

>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/tasks.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index a2ca79d1dd6a..089a0d5a5cc9 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -395,7 +395,11 @@ static void call_rcu_tasks_generic(struct rcu_h=
ead *rhp, rcu_callback_t func,
> >  raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> >  }
> >  rcu_read_unlock();
> >  - /* We can't create the thread unless interrupts are enabled. */
> >  + // We can't create the kthread with interrupts disabled,
> >  + // or a spinlock might be held, the kthread creation has
> >  + // been move to core_initcall() time.
> >  + // at the same time, use the irq_work does deferred wakeup
> >  + // to avoid potential lockdep splat.
> >  if (needwake && READ_ONCE(rtp->kthread_ptr))
> >  irq_work_queue(&rtpcp->rtp_irq_work);
> >  }
> >  --=20
>=20>  2.17.1
> >
>
