Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828738D407
	for <rcu@vger.kernel.org>; Fri, 21 Aug 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337495; cv=none; b=O+G2mWq5pu3Xhhzn2gaX1QFGrL2lWqJskztsj1+f4tRpgnUB8w+fqnZ5d9ATv1bGsemcGX8V2nyoRvCTz757J4N/fHcBrYZbzj4Yy9ItNSuXK/R+gYxkmsK4jx9qrSpqlNXUlh6cbYIcyW6Y0J3o17UV+NVoGfjXiSVqQiO13UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337495; c=relaxed/simple;
	bh=i0iM4CMeClX0wBoi7QQYpmlCBlrZQciscnIIH5l/RlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B679sSiuK7dkP6xIG/QgEM2F81oyn+Nf0im7mgT+/51ioHiORfz/a9epE+NFTcwO1QAL4GDRfBGjm6fR5OhBVXAQ0+TJtuPYWxqm1kQVFl9P41IlJnbkVI86DjlXH2lmcUwP390vhALPfLQhxgG/Rmu84xDUjt2f+jYq2Hr/9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fa77s66/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAb5sP2w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fa77s66/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAb5sP2w"
Date: Fri, 21 Aug 2026 20:38:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787337490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V7r0kaJtZqeCjXcFe8bOxkN+Hlq44U6zZusNWwnFLJ8=;
	b=fa77s66//a96ctpHY0SyxFebbBlLvzsZSY/LrOD4N3OJWDwlU4tWgoPlgUR1XS4GsuTXJQ
	qKLttEeY1VQV9Srf5CKZLI9ZjcJ10C0iWYT2661TgpcuIBzCB7Z2Lg50rldd1TjfHQK0l7
	jKe/3OWeEmNIJaC3dGjQ/4A5LlOT/n6u2RTDb3mH0pbeZOED49rStMLz3p8Ws++e30jStw
	ClUr/lrcg9U6GQTvjydAiqMe5Vp7Mcz9Tdti55BzakqsLlryPgn3f9eUADempek6Wc5/fa
	wkQveMUD6+hFv5iA3Gl9tq78I62GZ0M1vLDgA41CHRYIe9qMfrCvf76XGHu8Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787337490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V7r0kaJtZqeCjXcFe8bOxkN+Hlq44U6zZusNWwnFLJ8=;
	b=sAb5sP2wTWkgHQP46c0Qwm0GQp9gA0Ppo4/A0LxWeX15oQXsDjpW0w7Pno6WxB7livOB4N
	rvrVhthY5d3/yzAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: [PATCH v2] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260821183809.-kRAXbZs@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The irq_work in srcu is used to schedule a delayed work. The work item
is not scheduled directly because it is not always possible wake a
thread directly.

On PREEMPT_RT the default irq_work is initialized with IRQ_WORK_LAZY and
is delayed to the irq_work thread. A system booted with the command line
"trace_event=3D=E2=80=A6" will freeze during boot because the irq_work thre=
ad is
not yet deployed (and tracing uses synchronize_srcu() in
tp_rcu_cond_sync()).

The irq_work performs just a wakeup a thread, there is nothing wrong
with doing this from hardirq context on PREEMPT_RT.

Use IRQ_WORK_INIT_HARD for srcu's irq_work.

Fixes: 7c405fb3279b3 ("rcu: Use an intermediate irq_work to start process_s=
rcu()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: https://lore.kernel.org/all/20260820110008.v2Tlr0_H@linutron=
ix.de/
- Add a comment as suggested by Steven.

 kernel/rcu/srcutree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7a..af9fe0165a800 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -218,7 +218,12 @@ static int init_srcu_struct_fields(struct srcu_struct =
*ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
-	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
+	/*
+	 * trace events started on the command line require SRCU before
+	 * the irq_work kthread starts. Since all it does is a simple
+	 * wakeup, having it as a hard irq, even on PREEMPT_RT is fine.
+	 */
+	ssp->srcu_sup->irq_work =3D IRQ_WORK_INIT_HARD(srcu_irq_work);
 	ssp->srcu_sup->sda_is_static =3D is_static;
 	if (!is_static) {
 		ssp->sda =3D alloc_percpu(struct srcu_data);
--=20
2.55.0

