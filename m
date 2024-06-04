Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40014D440;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540595; cv=none; b=uzibc90Z+SzfgwZ6E1NVq/3hPZZOWAbEuO3HaCAyks1wWzb7IQJUevy7SaRaI3Tmgt1AVTo34yfzMlX2y+dB1feEFw5SJ/HHlsJ4xOa50VLWSXQRleTKjvov4PIA95wW84uAFbDv+DBkW/exWzYJutAbGi2uBDjbLrbU4WLD1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540595; c=relaxed/simple;
	bh=NOwZpjRsx43legxKprMX+skO8mm2ciSTty9AOru7vw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=puDTgdOI1WgZKRlAo+eM4cQkzRm7ITgUa3NlAKLRT+fT2oBw91obpHIdzE+oCK71SrelXaaN8XWJsj/0t9J6XfKfwIaoJUCfLW1UDtpE0CNugu7SIega62K58zZeXjqZNBW4Pv3Ha0L9heAf22PBfUAEYWiqm59vyB87nVp6Jxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1uw6ulO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1uw6ulO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C4C3277B;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540595;
	bh=NOwZpjRsx43legxKprMX+skO8mm2ciSTty9AOru7vw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1uw6ulO7sCy1JuR5MRlxujDrk8+CRxHBHaowvKRKyIR4bXUA45nRTsjKYOo3j2U5
	 dxHbueXjjIKGRRh6BhlLbocAhdwxQb7ZE3Rp7oLrDQoc0mvaOc3dJ4TY3r31h1OGxn
	 qH2Boa/Wwnz0lawxZMnDUy2oBVUptGesJpLZ3lVKsy2EEfvvXcEwgj8wNN6xa8suOd
	 i/KvwPoDe0C375lPrUDmi17jhDuw4mBsmYXwi2oDROU4wbV5qDg0+ZBnw1qpZ+nRKY
	 FfzLVpD8Z+/kraRzNGf6FHnIKowco4uVi36V7dpgwxn/UMYMmBIR3vPjjU8CbgZrMo
	 dcwey5ulTbEpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5E50CE3ED6; Tue,  4 Jun 2024 15:36:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang1211@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] rcutorture: Make rcutorture support srcu double call test
Date: Tue,  4 Jun 2024 15:36:30 -0700
Message-Id: <20240604223633.2371664-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

This commit allows rcutorture to test double-call_srcu() when the
CONFIG_DEBUG_OBJECTS_RCU_HEAD Kconfig option is enabled.  The non-raw
sdp structure's ->spinlock will be acquired in call_srcu(), hence this
commit also removes the current IRQ and preemption disabling so as to
avoid lockdep complaints.

Link: https://lore.kernel.org/all/20240407112714.24460-1-qiang.zhang1211@gmail.com/

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 46 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 807fbf6123a77..44cc455e1b615 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -390,6 +390,7 @@ struct rcu_torture_ops {
 	int extendables;
 	int slow_gps;
 	int no_pi_lock;
+	int debug_objects;
 	const char *name;
 };
 
@@ -577,6 +578,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.debug_objects		= 1,
 	.name			= "rcu"
 };
 
@@ -747,6 +749,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
+	.debug_objects	= 1,
 	.name		= "srcu"
 };
 
@@ -786,6 +789,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
+	.debug_objects	= 1,
 	.name		= "srcud"
 };
 
@@ -3455,7 +3459,6 @@ rcu_torture_cleanup(void)
 		cur_ops->gp_slow_unregister(NULL);
 }
 
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
 {
 }
@@ -3473,7 +3476,6 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
 	 */
 	pr_alert("%s: duplicated callback was invoked.\n", KBUILD_MODNAME);
 }
-#endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
 /*
  * Verify that double-free causes debug-objects to complain, but only
@@ -3482,39 +3484,43 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
  */
 static void rcu_test_debug_objects(void)
 {
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	struct rcu_head rh1;
 	struct rcu_head rh2;
+	int idx;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
+		pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n",
+					KBUILD_MODNAME, cur_ops->name);
+		return;
+	}
+
+	if (WARN_ON_ONCE(cur_ops->debug_objects &&
+			(!cur_ops->call || !cur_ops->cb_barrier)))
+		return;
+
 	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
-	pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
+	pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
 
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
-	preempt_disable(); /* Prevent preemption from interrupting test. */
-	rcu_read_lock(); /* Make it impossible to finish a grace period. */
-	call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
-	local_irq_disable(); /* Make it harder to start a new grace period. */
-	call_rcu_hurry(&rh2, rcu_torture_leak_cb);
-	call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
+	cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
+	cur_ops->call(&rh2, rcu_torture_leak_cb);
+	cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
 	if (rhp) {
-		call_rcu_hurry(rhp, rcu_torture_leak_cb);
-		call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+		cur_ops->call(rhp, rcu_torture_leak_cb);
+		cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
 	}
-	local_irq_enable();
-	rcu_read_unlock();
-	preempt_enable();
+	cur_ops->readunlock(idx);
 
 	/* Wait for them all to get done so we can safely return. */
-	rcu_barrier();
-	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
+	cur_ops->cb_barrier();
+	pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
 	kfree(rhp);
-#else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
-#endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 }
 
 static void rcutorture_sync(void)
-- 
2.40.1

