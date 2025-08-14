Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143325B1D5
	for <rcu@vger.kernel.org>; Thu, 14 Aug 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177088; cv=none; b=NYJYL/9YHNuKQhSL1FlZhuTV3Zc4yV361Si+iRa/rfOR+OIUyuEb4bzJqPcx9Je4uEY8FZvlpAiWWcKcCB3Iz4q0dGg4pgxZmUs+evb8cvzdnF/Hw20bLFj37gutVEfGAiB8A4LT5xgHHe3v2p0kPUf0xQu75mWQfSDGRuCp3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177088; c=relaxed/simple;
	bh=upflz7LSDXjvhs6at+PKE/rkrM7wKCJB/DI7ONrqE4o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bZeJan+ax3B8hqby/Cir3ulcQ6uLdvHgbqaz1WWnws38jmA3lDfgU0sviHsdQcrUI3HGIn7I7MhHnb7mBK314Nfs9lFeTnHHJMb3xXQmMj7o3dzQX1Vlorra+J/6je4i6SHkAWxwgQDYbBO1Dt6hNRtN+jARQFAVWzij/82yuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=By+Eokl4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="By+Eokl4"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755177084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zR9ZMOwbJIL+UAyfDp6d5JbsqZ8vG/TNYQ3zSwJbRgI=;
	b=By+Eokl4nSrDadH53DwfuI9Jn9v14cTKBna4M1OhOHldZNnj8YljFO5cbRxCDBOLM6NvPK
	9ij8uVCRf+e/v4vK8e1oeVRz6aUGh1hQvRV+37SRvn4iPSyDBFvBU1vPQKTpO4wFkVCNLW
	fu8iTmeLX1TdZxk+O86Al6dzYAh6yhA=
Date: Thu, 14 Aug 2025 13:11:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <a05dca3ce29244c4bd9a9977546c91a096068310@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] rcu: Remove local_irq_save/restore() in
 rcu_preempt_deferred_qs_handler()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
In-Reply-To: <ca6d0ea1-9f67-4c8a-bfcc-357ffb9496d7@paulmck-laptop>
References: <20250813133002.331879-1-qiang.zhang@linux.dev>
 <ca6d0ea1-9f67-4c8a-bfcc-357ffb9496d7@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, Aug 13, 2025 at 09:30:02PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> Currently, the per-cpu rcu_data structure's->defer_qs_iw is initial=
ized by
> >  IRQ_WORK_INIT_HARD(), this means the rcu_preempt_deferred_qs_handler=
()
> >  always be executed in the hardirq context of irq-disabled.
> >  This commit therefore remove local_irq_save/restore() operations in
> >  rcu_preempt_deferred_qs_handler() and add lockdep_assert_irqs_disabl=
ed()
> >  check, if someone mistakenly invokes this function in hardirq enable=
d
> >  context will splat.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Queued for further review and testing. With luck, this will make the
> v6.18 merge window. I could not resist editing the commit log, so could
> you please check whether I messed something up?

No problem, thanks for editing the commit log :) .

Thanks
Zqiang

>=20
>=20 Thanx, Paul
>=20
>=20---------------------------------------------------------------------=
---
>=20
>=20commit 523e71ba3007f8f7c260b9c2baf69c9461a84f55
> Author: Zqiang <qiang.zhang@linux.dev>
> Date: Wed Aug 13 21:30:02 2025 +0800
>=20
>=20 rcu: Remove local_irq_save/restore() in rcu_preempt_deferred_qs_hand=
ler()
>=20=20
>=20 The per-CPU rcu_data structure's ->defer_qs_iw field is initialized
>  by IRQ_WORK_INIT_HARD(), which means that the subsequent invocation of
>  rcu_preempt_deferred_qs_handler() will always be executed with interru=
pts
>  disabled. This commit therefore removes the local_irq_save/restore()
>  operations from rcu_preempt_deferred_qs_handler() and adds a call to
>  lockdep_assert_irqs_disabled() in order to enable lockdep to diagnose
>  mistaken invocations of this function from interrupts-enabled code.
>=20=20
>=20 Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>  Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
>=20diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index fc14adf15cbb34..57e2ae51c0b2cb 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -626,11 +626,10 @@ notrace void rcu_preempt_deferred_qs(struct task_=
struct *t)
>  */
>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  {
> - unsigned long flags;
>  struct rcu_data *rdp;
>=20=20
>=20+ lockdep_assert_irqs_disabled();
>  rdp =3D container_of(iwp, struct rcu_data, defer_qs_iw);
> - local_irq_save(flags);
>=20=20
>=20 /*
>  * If the IRQ work handler happens to run in the middle of RCU read-sid=
e
> @@ -647,8 +646,6 @@ static void rcu_preempt_deferred_qs_handler(struct =
irq_work *iwp)
>  */
>  if (rcu_preempt_depth() > 0)
>  WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> -
> - local_irq_restore(flags);
>  }
>=20=20
>=20 /*
>
