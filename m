Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C958524F;
	Sat, 16 Aug 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302511; cv=none; b=OauXevomas49Ua5V3tsrHHL/TTNo3vp3BkDz7yQ+SWWKophNTAghaI4SanFkxSP8C9vOjSVmkhYBW4vsjmRLc3eLAtOCJDgYqWxiAtfh3lfyBXWknJvCkmX56yQlmwqz3Kiy1CbZxraW1dH8FTY2E98ATPMltFbIlhYeC04laoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302511; c=relaxed/simple;
	bh=rq+Ub4PUmYMUmVVmwp0dloL83Muh245hgWWFkowVhoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddNiplkY8JzkbppRKzypeJUzMc5eVGgW0DLmXP0AWcx5LaV6Nr9HvNxua83nBMP9PpiObNI57r67ZrpmeqxwKSxmIsmp0glacIwGJDhXMy9A7Bydv9oYT0MUPAhrM82zPGo52qIgjoq9tIz6mix+3pCKO/UW/9yLYYy9PCB+Tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ1BjZpu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ1BjZpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB61C4CEF4;
	Sat, 16 Aug 2025 00:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302511;
	bh=rq+Ub4PUmYMUmVVmwp0dloL83Muh245hgWWFkowVhoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQ1BjZpur1oDlXcx+nf9J1Qt1ISdObHQ/YL6VAC3WGp56UtVLzLefibMBC6G+67uK
	 SJxQGV8NtYOxAbGlhN7zROHkTRDV2m5O9N056JQRZrkhNkazAZmYB02vHYL1udz6Wu
	 XF/X/aFpN/N559lymsW5RedGoOLqLwWJa2vD44TA9QhrPhQad31Hb1iirNuWdmG2PF
	 uPZhgmkGW0lScxvc3T0C612hTHCS5z1E2oAQnS/6EPpHpPb/Su5N6RoLiZBp4LM5i6
	 odEUCyikyO8sqnSoYotzraFCJYFOV6akVHlOTaiyYareNlCaGpnxuAhoCzRwK3+AzS
	 qnHbm/9BdcUuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5064BCE0B30; Fri, 15 Aug 2025 17:01:50 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] rcu: Remove local_irq_save/restore() in rcu_preempt_deferred_qs_handler()
Date: Fri, 15 Aug 2025 17:01:48 -0700
Message-Id: <20250816000149.2622447-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
References: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The per-CPU rcu_data structure's ->defer_qs_iw field is initialized
by IRQ_WORK_INIT_HARD(), which means that the subsequent invocation of
rcu_preempt_deferred_qs_handler() will always be executed with interrupts
disabled.  This commit therefore removes the local_irq_save/restore()
operations from rcu_preempt_deferred_qs_handler() and adds a call to
lockdep_assert_irqs_disabled() in order to enable lockdep to diagnose
mistaken invocations of this function from interrupts-enabled code.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4cd170b2d6551d..d85763336b3c0f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -626,11 +626,10 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
-	unsigned long flags;
 	struct rcu_data *rdp;
 
+	lockdep_assert_irqs_disabled();
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
-	local_irq_save(flags);
 
 	/*
 	 * If the IRQ work handler happens to run in the middle of RCU read-side
@@ -647,8 +646,6 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 */
 	if (rcu_preempt_depth() > 0)
 		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
-
-	local_irq_restore(flags);
 }
 
 /*
-- 
2.40.1

