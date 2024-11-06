Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFA20402B;
	Wed,  6 Nov 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905170; cv=none; b=Izfq3nRx6tON2ErMI5+VIZyZxdQKy3NpQr1S9bB8L9TaLljV6rICqrHG0kzyMwulZL/mYoznJm0VtDAXeVqKu4AJTcOdnhn1P5K+1PdArjtqFxde4kpQ54iRHzpeURvqHSXjqIz+ajJ2+rfUeBnyMaFJ4exXIhZyClL4J+g/c6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905170; c=relaxed/simple;
	bh=KfEzAK0yWwsc73/eBMwT2Rzo8Q/O9jbmqLzgwx89IvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoGXYYPJecIkrwrMu1r1aXmp0ReXN8k96BXk7jASgQWzmtaedrYw7Fc/erLpENq1lBaIpQbbVhsYHq9nZRR6XfCGYAE+LWR3UCGsE7MmG42urB66YvT3dFaa33ocEiTVZcfySyi2cFZCDt2oqD9ziiiD5hEeN1GwYKt9siT/TF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXqcBxcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXqcBxcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9551C4CED4;
	Wed,  6 Nov 2024 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905169;
	bh=KfEzAK0yWwsc73/eBMwT2Rzo8Q/O9jbmqLzgwx89IvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXqcBxcXkyn27Puwj3HRxr8vRWOX/LJt+EyevkZ32fB6o36U9w6tYd+y7fwA60i0f
	 ixoUOvFQ+uoQyFHSUQL1iFoZgNrB/GkZZd1TzuE0TJ3n/Ip/k8zK00j00WYwF/17cB
	 rY3438l1WpUAJ2zmUjr3uOxMv45pPBI2aYXp7IaIGDRI0ouPQOeI00bYmtVGGWMzhD
	 /AV6nJfaIXqFYOOHDK7sLacADfIpCUA/CwNq7+CuWFmnwE2BqlM2BLfEGLPrtMD+0S
	 aGIcsGyd85CgGqhjqOOZXoEFGoHHtXGbHdU6ZWVmcG3/7zDbZUF7NSWChlRUUr3cfI
	 klYFlwEqLh3PA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 4/8] rcutorture: Test start-poll primitives with interrupts disabled
Date: Wed,  6 Nov 2024 15:59:07 +0100
Message-ID: <20241106145911.35503-5-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit tests the ->start_poll() and ->start_poll_full() functions
with interrupts disabled, but only for RCU variants setting the
->start_poll_irqsoff flag.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800..b4cb7623a8bf 100644
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
2.46.0

