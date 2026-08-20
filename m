Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0C3E765A
	for <rcu@vger.kernel.org>; Thu, 20 Aug 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223612; cv=none; b=utgHcHShzlMoqlobZzyrLBOGYFsTnhZD40V8MaH5WQibfR7uMSwTJFhbzdNYkV5MH98ymXuvr3f2WkYImE9DPRyebCEwVEwzQncfarIjAt7zAorCn37IPktjRcqjBBHpg9u9q7SKKBAfLw6m+bKCTbfW5h9hXr1aWIwTy1YMDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223612; c=relaxed/simple;
	bh=/Fn9Rea31k33ypxcXtym56JhlxpamcNJOrexPG1H8nA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rOa8J2xZU2LI0wxlcgeSjoaX+YsDZFPD+IRUTawyOTEgnmlVMcm6J1VF4pngd+x+ayvGd7OwR3I58EYwdGtlaqHt/ZOlR9qua7whc6Wo0X3jtTKkbmr/BRkQoTPpgbAz42RvAMry9OZzViAGXChYfBXD6W0bTZieJDy/V4+DjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YqNOw8VN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8lDfKnp9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YqNOw8VN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8lDfKnp9"
Date: Thu, 20 Aug 2026 13:00:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787223609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46fb85SzbBYwdhZzyDR3m5ikX0tpEPzXCIFysJFakDQ=;
	b=YqNOw8VN9G1mWyrFrSzeBUaO5P4Ax+iLx5oyphRelI2R9eSObPJTawRfU1gorcXy4YgbuU
	4Txg8JgDQEfzY+8ydNxc1i5oK/usdSyiabWIy26zbzK/6dgcgQDlXonrvAQh35b3utcdx5
	Q/trMdP1Y25PZL1/CjOEKAYGvVB3z0SA+xHjEGuMbLkIRu9DC2q04Zxe+WE7vnSMUkKwdw
	p1yGXD/55CAh+UiI3TFJferlWw7OaVBbI8m9LtxklonIaF65V99dTF8puiP0GmgUUieS7z
	pupqH5wTgIY1TBp057vqPcFGMRRkEHk06ofaPJLm29FclFbKmOpy8rc2RGYsbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787223609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46fb85SzbBYwdhZzyDR3m5ikX0tpEPzXCIFysJFakDQ=;
	b=8lDfKnp9AufJmay+Lwomv66YEVaWV6+/uJJSSHj34Rx5z9eqf8pPNxhSTM/iggYH/Ci6Nf
	3wU/FMlsXpDVABCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260820110008.v2Tlr0_H@linutronix.de>
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
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7a..b703233d4a63f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *=
ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
-	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
+	ssp->srcu_sup->irq_work =3D IRQ_WORK_INIT_HARD(srcu_irq_work);
 	ssp->srcu_sup->sda_is_static =3D is_static;
 	if (!is_static) {
 		ssp->sda =3D alloc_percpu(struct srcu_data);
--=20
2.55.0

