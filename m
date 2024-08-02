Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B204168DA;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=G6qZMS6glDeu726f2cFydYspwpVTvXRNzn6yBDcqB59uOwYk8Aid7PNz9maLzVpa94hj0JAnQyAld+RjFM0dyCkKkGNYCzNemeX0epvknWWXOzzaA8mB3ssCQ5IBIRahu3Vl5Bk2gLjsVwlWYxVJR6DEAUosfcPGuQEIXb9XoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=WaiDAqrc+b+wo00YSTTvMD3HfVQ61YAzmXrAlI6Fp8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hit9AtoigyCAQ4yC3G+KJB5Jq0xioz2gH4PvzggrJpIv5G92H1Roh4TEtBNGFoOBmLRk5eCAe641N5Yv1kfLRJSTkfytJH4KH99jHVO8pe7vP0xLRWQFx8iRhPU2Va7gPNi0wqvuC2LdToO/h44r0kCsPB9Ppal6uopERtSiGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVshaJlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVshaJlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2654EC4AF0A;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=WaiDAqrc+b+wo00YSTTvMD3HfVQ61YAzmXrAlI6Fp8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVshaJlXSvLX1piW3D/+90Q478VYOhywWGiWIUa9J/IUpvm5nUj27eZX+8bK2Gmvb
	 ri1GSJKNY6qYKhZKPwA7nV+KP/5N0aCnKTkZmHFD6fQh/cQmmuAKPv2Scaxej7vqtG
	 LoROBImkBtO4Sr3+id86NtvXfEQEAAjIbaZl+imBeF2g8oDaRdtxoE2N7WuhRr1okX
	 XK9CTJyD+TwnIr+8HNoR41zzARzHbBEN50tP3Tc+eN0ICAlscfs6j06GIT7nfnMjD8
	 Q/TN+aCWiW1GE2m+qhqaRgDEHC2y5MUIbYQLvqzSHwsFHFIk/InOxRRimQBY9E4qXb
	 Ag9sYKhzQCXFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3624CE0BC3; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/11] rcuscale: Dump grace-period statistics when rcu_scale_writer() stalls
Date: Thu,  1 Aug 2024 17:43:00 -0700
Message-Id: <20240802004308.4134731-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a .stats function pointer to the rcu_scale_ops structure,
and if this is non-NULL, it is invoked after stack traces are dumped in
response to a rcu_scale_writer() stall.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index c34a8e64edc30..ddfb96e5a4e1e 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -145,6 +145,7 @@ struct rcu_scale_ops {
 	void (*sync)(void);
 	void (*exp_sync)(void);
 	struct task_struct *(*rso_gp_kthread)(void);
+	void (*stats)(void);
 	const char *name;
 };
 
@@ -226,6 +227,11 @@ static void srcu_scale_synchronize(void)
 	synchronize_srcu(srcu_ctlp);
 }
 
+static void srcu_scale_stats(void)
+{
+	srcu_torture_stats_print(srcu_ctlp, scale_type, SCALE_FLAG);
+}
+
 static void srcu_scale_synchronize_expedited(void)
 {
 	synchronize_srcu_expedited(srcu_ctlp);
@@ -243,6 +249,7 @@ static struct rcu_scale_ops srcu_ops = {
 	.gp_barrier	= srcu_rcu_barrier,
 	.sync		= srcu_scale_synchronize,
 	.exp_sync	= srcu_scale_synchronize_expedited,
+	.stats		= srcu_scale_stats,
 	.name		= "srcu"
 };
 
@@ -272,6 +279,7 @@ static struct rcu_scale_ops srcud_ops = {
 	.gp_barrier	= srcu_rcu_barrier,
 	.sync		= srcu_scale_synchronize,
 	.exp_sync	= srcu_scale_synchronize_expedited,
+	.stats		= srcu_scale_stats,
 	.name		= "srcud"
 };
 
@@ -563,6 +571,8 @@ rcu_scale_writer(void *arg)
 					pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
 					sched_show_task(writer_tasks[i]);
 				}
+				if (cur_ops->stats)
+					cur_ops->stats();
 			}
 		}
 		if (started && !alldone && i < MAX_MEAS - 1)
-- 
2.40.1

