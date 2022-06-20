Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D50C43334
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 22:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbiFTWyk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344395AbiFTWyR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33329C2E;
        Mon, 20 Jun 2022 15:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A38FE61386;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6C0C341D2;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=wpgebg/KhIEpkSESZZFctc0JpJDXRZO9CeIYbmOEtGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/3AB2fFxL9ZuNPOU1ii68zbJjIoBzF09yiY2qphU0eEMxaEdXZXsskyVmia06Zw3
         oVakqF2+MQNkbF6fqajlGrLwv/CzC3ik1BIqqtFo4DzhP7TY0rlw96mruAVgj+hsL0
         LJK7PvuzyX7GS5eEzSlqWVxiV3bnHPI8FB1cp15f3rhKhrgdMUwMYtM38o/utIjVeQ
         2wGEsQcexkyrwr0XJUMFnO4fKfzc71OoaPK5XV0w8VHTYjmydbxoDc039mDNwFCBmY
         7L4bLiXAJcEHspcB6ry6Wf5TPI2NxE74sjxzWJx3ZYnvvSoPeyfpycN1WdgU+PKiSy
         1YxNj2uiGuQAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 384FF5C0D1B; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 09/32] rcu-tasks: Handle idle tasks for recently offlined CPUs
Date:   Mon, 20 Jun 2022 15:53:48 -0700
Message-Id: <20220620225411.3842519-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit identifies idle tasks for recently offlined CPUs as residing
in a quiescent state.  This is safe only because CPU-hotplug operations
are excluded during these checks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ec68bfe98c958..414861d651964 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1318,27 +1318,26 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 	int nesting;
 	bool ofl = cpu_is_offline(cpu);
 
-	if (task_curr(t)) {
-		WARN_ON_ONCE(ofl && !is_idle_task(t));
-
+	if (task_curr(t) && !ofl) {
 		// If no chance of heavyweight readers, do it the hard way.
-		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 			return -EINVAL;
 
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
 		// However, we cannot safely change its state.
 		n_heavy_reader_attempts++;
-		if (!ofl && // Check for "running" idle tasks on offline CPUs.
-		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		// Check for "running" idle tasks on offline CPUs.
+		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
-		if (ofl)
-			n_heavy_reader_ofl_updates++;
 		nesting = 0;
 	} else {
 		// The task is not running, so C-language access is safe.
 		nesting = t->trc_reader_nesting;
+		WARN_ON_ONCE(ofl && task_curr(t) && !is_idle_task(t));
+		if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && ofl)
+			n_heavy_reader_ofl_updates++;
 	}
 
 	// If not exiting a read-side critical section, mark as checked
-- 
2.31.1.189.g2e36527f23

