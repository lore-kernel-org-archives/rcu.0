Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76783CD2;
	Fri, 16 Aug 2024 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787576; cv=none; b=IyQDF2elIQ+YvVR66bGowZMMg2bqo8Q0qJTUFgSy7lPIzdCchWwoPHIvK52m/tp3fGrkm4enm97EZ/+UvCqliRDQjHnFU++8IbkgXSFRt/vu+dt55+2966OeFx2BhYf2BCtWZdOlPISMsKuMR1pR4ucaA2Vo10+BW/Yir7xU0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787576; c=relaxed/simple;
	bh=MdDex2Mg/EaOY+pvJ40G35klWOJmYSRzCllFxjKzbBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKbIYFfUGpeEJNQQsF06AnMSHeejpCKkGVtRx4+1xtxcT/CWsFmTg0Wim/cIuG/MbmDr0SqgNckui07pD54q22hGHWF99Tp42llMo8z7RL2tiyxVwTtNx1mQcoQi+TtuAp0BhVuKGg1QgnUDpTd1UcCtsM6dZT3CPLYQZJ9y+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6uaJbL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6uaJbL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24562C4AF0E;
	Fri, 16 Aug 2024 05:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787576;
	bh=MdDex2Mg/EaOY+pvJ40G35klWOJmYSRzCllFxjKzbBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6uaJbL/xpmtwLHW5BjYSg3op872r1NVTORQBFizkKjTGyhnv5c7anrd1k8Dd2vlk
	 KzULpg93zcDTLtj5Wmrq8u42H3sr6BGVsHU7GKBoUccGJbneOOj71cezVpY+CITL8q
	 ElW8JcUScBHwIrhx/pNnfrj/0dj/3mmNNA1T3RfJQJvK7mpYF9yIMotAUxSBlTSpAx
	 LEJwyz+NeR/bzsKGg9y4Spim53wEu3Wp7tFtrU7UUerZxU2aykQjvUk0TIl2Wt3E9J
	 gd4aa/DzlnLFd15cIeSi90xpQZnKtx3hMd5IWevCVrDQURAIf7sDLAR40Tdqw2Jv/l
	 78E8MQB8dY5IA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 1/8] rcutorture: Remove redundant rcu_torture_ops get_gp_completed fields
Date: Fri, 16 Aug 2024 11:21:56 +0530
Message-Id: <20240816055203.43784-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_torture_ops structure's ->get_gp_completed and
->get_gp_completed_full fields are redundant with its ->get_comp_state
and ->get_comp_state_full fields.  This commit therefore removes the
former in favor of the latter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08bf7c669dd3..836e27250a8b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -366,8 +366,6 @@ struct rcu_torture_ops {
 	bool (*same_gp_state_full)(struct rcu_gp_oldstate *rgosp1, struct rcu_gp_oldstate *rgosp2);
 	unsigned long (*get_gp_state)(void);
 	void (*get_gp_state_full)(struct rcu_gp_oldstate *rgosp);
-	unsigned long (*get_gp_completed)(void);
-	void (*get_gp_completed_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*start_gp_poll)(void);
 	void (*start_gp_poll_full)(struct rcu_gp_oldstate *rgosp);
 	bool (*poll_gp_state)(unsigned long oldstate);
@@ -553,8 +551,6 @@ static struct rcu_torture_ops rcu_ops = {
 	.get_comp_state_full	= get_completed_synchronize_rcu_full,
 	.get_gp_state		= get_state_synchronize_rcu,
 	.get_gp_state_full	= get_state_synchronize_rcu_full,
-	.get_gp_completed	= get_completed_synchronize_rcu,
-	.get_gp_completed_full	= get_completed_synchronize_rcu_full,
 	.start_gp_poll		= start_poll_synchronize_rcu,
 	.start_gp_poll_full	= start_poll_synchronize_rcu_full,
 	.poll_gp_state		= poll_state_synchronize_rcu,
@@ -1437,8 +1433,8 @@ rcu_torture_writer(void *arg)
 					  rcu_torture_writer_state_getname(),
 					  rcu_torture_writer_state,
 					  cookie, cur_ops->get_gp_state());
-				if (cur_ops->get_gp_completed) {
-					cookie = cur_ops->get_gp_completed();
+				if (cur_ops->get_comp_state) {
+					cookie = cur_ops->get_comp_state();
 					WARN_ON_ONCE(!cur_ops->poll_gp_state(cookie));
 				}
 				cur_ops->readunlock(idx);
@@ -1452,8 +1448,8 @@ rcu_torture_writer(void *arg)
 					  rcu_torture_writer_state_getname(),
 					  rcu_torture_writer_state,
 					  cpumask_pr_args(cpu_online_mask));
-				if (cur_ops->get_gp_completed_full) {
-					cur_ops->get_gp_completed_full(&cookie_full);
+				if (cur_ops->get_comp_state_full) {
+					cur_ops->get_comp_state_full(&cookie_full);
 					WARN_ON_ONCE(!cur_ops->poll_gp_state_full(&cookie_full));
 				}
 				cur_ops->readunlock(idx);
-- 
2.40.1

