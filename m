Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F69218594;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=A5asaFOz89XwEOSmBJbQcRMX70MA8Ieg7sKhykcU+EJRBK6kuPKbLRO/N8mhNL/vk+laQOeeCi1awGfT/qIH1uNaI6yYNCAMLKRT5Nt+qFpBbgMDUXasuNmKN00HKSQvQ+XvAv1Wy3reeOAggVecPpS0FwGaXCNlFlriuMff/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=mpb3OxMibi00zoaHZEYpEWb6uy4/muJlU71GYLvWf90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhPZKeabIZRVj+5iBNtdxH1yazGl0r43thu+wX8cCUZP0uWH7MO9WR8KHQNffAbdiwaHs2Uhv3v4Dc1wRKreIqW8y55EcQPy/2VqS8daKw7bqC3Y1KBSFzzhEoNXQanx5xCMPTY4LxhtY6UAZ2jF8PvhyDE4Jev1GN9GRmwyqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2+AgoRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2+AgoRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E2CC4CEDE;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028777;
	bh=mpb3OxMibi00zoaHZEYpEWb6uy4/muJlU71GYLvWf90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2+AgoRZPL1+tZg7Sq2m8jE9SsJU4i3fW7CMWAtR1ObgdYFEYwrMRvzzgB6Yp96gt
	 MigzXYBS8Zgfypl2bNKJmMRZ9sds1er91iEkgOWUR2gC0wis4mw+xRftF+5T4ZNQkm
	 u1wOCgbtELJcC0j54+NYzGSAm5FHgHTfd/riZiy0K4xeBuNZM1tnUfdGS+zwqsAf0R
	 GPZA3HyPL86NdOH4HZkag0Eny5kRrLDjEBsGqdg9F7D+lHiA1iO33tz5ecofWJBq6s
	 F6j0TBXYKuOOr1fdqpcZ1MJiBk2nkW3Q8P2P5CnrVGXfEcHkvyoLqa3bs2q8uhRoJX
	 6je32rKyTJ1HQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43CAFCE0FA5; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 4/8] rcu: Replace open-coded rcu_exp_need_qs() from rcu_exp_handler() with call
Date: Thu, 12 Dec 2024 10:39:32 -0800
Message-Id: <20241212183936.1936196-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the preemptible implementation of rcu_exp_handler()
almost open-codes rcu_exp_need_qs().  A call to that function would be
shorter and would improve expediting in cases where rcu_exp_handler()
interrupted a preemption-disabled or bh-disabled region of code.
This commit therefore moves rcu_exp_need_qs() out of the non-preemptible
leg of the enclosing #ifdef and replaces the open coding in preemptible
rcu_exp_handler() with a call to rcu_exp_need_qs().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 5c4ea66cc00dd..f3884393b9477 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -718,6 +718,16 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 	rcu_exp_wait_wake(s);
 }
 
+/* Request an expedited quiescent state. */
+static void rcu_exp_need_qs(void)
+{
+	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
+	/* Store .exp before .rcu_urgent_qs. */
+	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
+}
+
 #ifdef CONFIG_PREEMPT_RCU
 
 /*
@@ -742,13 +752,10 @@ static void rcu_exp_handler(void *unused)
 	 */
 	if (!depth) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-		    rcu_is_cpu_rrupt_from_idle()) {
+		    rcu_is_cpu_rrupt_from_idle())
 			rcu_report_exp_rdp(rdp);
-		} else {
-			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
-			set_tsk_need_resched(t);
-			set_preempt_need_resched();
-		}
+		else
+			rcu_exp_need_qs();
 		return;
 	}
 
@@ -841,16 +848,6 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
-/* Request an expedited quiescent state. */
-static void rcu_exp_need_qs(void)
-{
-	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
-	/* Store .exp before .rcu_urgent_qs. */
-	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
-}
-
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
 static void rcu_exp_handler(void *unused)
 {
-- 
2.40.1

