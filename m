Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B07E0E9;
	Fri, 16 Aug 2024 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784220; cv=none; b=TgICRBhScg0qB+k7r3bAYEm2QSXms7BQd10g3iq+UFlgXsfgQIUBDWRNMMOu6VT7wRFz1KjN7pmgs8FVkuvwr5ANoqx13dbds1MwOim2CAkDmk7CYTek/Y0V3exyLxuhgA1wk5TBZrg1HEhMBiBQtaDukgGc1Ha2pMoJ7xkjfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784220; c=relaxed/simple;
	bh=AyDX/E65dFVaQqud/LFIM54rkLe+yBgstvy7o5q4JdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnMkpb01QUP7Ts4kVCU+q1KXJP+sSU/ZDYWHkhVIkXE836p4rxWy1aYUiPrrBmRWThaTIe/TpxBUV9bCNQ7oOkLgueYXYgpjxUIq5tUk7GLRwXQ3ljNzkCcoBvv9jNKuL2FBHG1ez9POEI2ZP7eB61GymMgJVztDb1ZInEJyedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL8imxRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL8imxRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8360C4AF09;
	Fri, 16 Aug 2024 04:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784219;
	bh=AyDX/E65dFVaQqud/LFIM54rkLe+yBgstvy7o5q4JdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KL8imxRySTNiltq8IW7qpMYmP3qX2uAa4JAxDZMD/YYnUtvUyrXmQaqapLL3Qzek/
	 mCSJElxETD8uz6vyp+lTZEuRV86hf8BSrUenQHF+Ym8SUy70shBohrQZzd2/bftBl4
	 ygW2OLrRPj776qwUewLtI+0tvxPnRQ5n/zhxo/FFwV6a/Uc45phra3dY8nI2iYJ1ek
	 9/quW1QukoxoL5NKn8BRjmoIaenQTrJl8AxmIxnUhkB4W9M0bWoLn5Zh3cOXEI8Cl6
	 2u90NmX96MTU+zD7IuV7f3fM5APv3OiiNzeq7UnumSPFTO5ZjHQO2i2k1uoSffbkES
	 xGQOcbYkch72A==
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
Subject: [PATCH rcu 02/11] rcu/nocb: Move nocb field at the end of state struct
Date: Fri, 16 Aug 2024 10:25:59 +0530
Message-Id: <20240816045608.30564-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

nocb_is_setup is a rarely used field, mostly on boot and CPU hotplug.
It shouldn't occupy the middle of the rcu state hot fields cacheline.

Move it to the end and build it conditionally while at it. More cold
NOCB fields are to come.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fcf2b4aa3441..a297dc89a09c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -411,7 +411,6 @@ struct rcu_state {
 	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
-	int nocb_is_setup;			/* nocb is setup from boot */
 
 	/* synchronize_rcu() part. */
 	struct llist_head srs_next;	/* request a GP users. */
@@ -420,6 +419,10 @@ struct rcu_state {
 	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 	struct work_struct srs_cleanup_work;
 	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
+
+#ifdef CONFIG_RCU_NOCB_CPU
+	int nocb_is_setup;			/* nocb is setup from boot */
+#endif
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.40.1

