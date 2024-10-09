Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DC1E102C;
	Wed,  9 Oct 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496848; cv=none; b=jzQrcsB+/ZdCDOjTX+yDIi2Fbh0POt8TixGZ4/Nb0MMvx9uNydoUCR9sF4rSGPgm2x/8g/pGqIOPQrv6f0YXRSSLOgtKFaFzPjwn+nYTo3vEw9g4f7nbVqDbfetoB6Rw/fk/o9hDcyLDuPSH1ByJrPrBNyT0EQm41ttnCc7RlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496848; c=relaxed/simple;
	bh=eJja4NpVituNDp/ZVRfcYxyH6Blp+5M5FRFnEJOlmjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sa+mmQNZ1NkygrnkmvUMH9iD6sSuHsIP7DKTXpS4ebY9uvVSqhoUzaLaTMyF+Z1TQAuswQFQEXzKkBequ1WluXqK3/x+TFtL+VfiDXkBTpDw3zWwBitR5tfqB7GEzSuc17hvIj1qZw/GgRrNwXueHxEn9w/PgysEWzr/ubm8QEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1WfJE70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1WfJE70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD19BC4CED3;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496847;
	bh=eJja4NpVituNDp/ZVRfcYxyH6Blp+5M5FRFnEJOlmjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1WfJE70RVlPaVlV1CFLPIvs5Zzg+sYaPi6qPaOT8QFEos1+hhdyZt98jERFCK9PW
	 bjCl1GsE3PFRfj48lcdPOzEsYKolsKs0jjpMn21S7siY+QAgspgVkwPxKt5WVR3Fwc
	 FwBVIWuxvZJMWwM4cEv2pZfk9EhwUr6SOguez4hSypfA8U+RyvaDhrGPr+ahJK1zg5
	 hADEL/XPwaZo+3KJGTJ4Q/mEns1sQwr0VEOG/giFKG/bQhcwwai7iuDlyYeer/4tgC
	 JnSq9pD0y8yqw+g5STk+as5wattygG1+uiM3jvISPcgD44afZjfZAYRvRKNo7VJhFw
	 6yrd2zPh8t2ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73B16CE0E61; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] rcutorture: Test start-poll primitives with interrupts disabled
Date: Wed,  9 Oct 2024 11:00:43 -0700
Message-Id: <20241009180045.777721-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit tests the ->start_poll() and ->start_poll_full() functions
with interrupts disabled, but only for RCU variants setting the
->start_poll_irqsoff flag.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800c..b4cb7623a8bfc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -393,6 +393,7 @@ struct rcu_torture_ops {
 	int slow_gps;
 	int no_pi_lock;
 	int debug_objects;
+	int start_poll_irqsoff;
 	const char *name;
 };
 
@@ -581,6 +582,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
 	.debug_objects		= 1,
+	.start_poll_irqsoff	= 1,
 	.name			= "rcu"
 };
 
@@ -1695,14 +1697,22 @@ rcu_torture_fakewriter(void *arg)
 				cur_ops->cond_sync_exp_full(&gp_snap_full);
 				break;
 			case RTWS_POLL_GET:
+				if (cur_ops->start_poll_irqsoff)
+					local_irq_disable();
 				gp_snap = cur_ops->start_gp_poll();
+				if (cur_ops->start_poll_irqsoff)
+					local_irq_enable();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
 					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
 								  &rand);
 				}
 				break;
 			case RTWS_POLL_GET_FULL:
+				if (cur_ops->start_poll_irqsoff)
+					local_irq_disable();
 				cur_ops->start_gp_poll_full(&gp_snap_full);
+				if (cur_ops->start_poll_irqsoff)
+					local_irq_enable();
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
 					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
 								  &rand);
-- 
2.40.1

