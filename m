Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BA22576E;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161423; cv=none; b=gbrdCpnEbDjlujIDVuDg77NZAQLnvypaNkxu1BDUeGKduqACXx+Vw+IsGX709YiHLuC0GQuPFhMKGrq4UsUOMphwPNifRJa/6n0M1TODmopLcOmXDr3+uvdDTYZtZVL0WE4tMKUR3nMwIrAhYzLrc2BRh0F+gpT9efsDE+YdCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161423; c=relaxed/simple;
	bh=x1v3NISCPTvmugF4LUUhLDczxEsZx2rv5fgRjpex4OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raOcTgjXxOfJrdFvUgmqAgDvcaTgmJ9PiF13ADIOljnjF1zrxZV/nbZ/din9ZfMMnezK1xd6wlXUCj1jJLSYKoXr2N4pD02xRis8MglptcrtWgL9D2efWJFlOtNl/p2B4VLot6Lx8zZflCOcuU/7AFAXvGD436q8gPlJz9OqYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnsbSawu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnsbSawu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6CD1F00ACA;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=5awFt3rVsUFRv61tL7C01iSjH3iLbouNiQclS/ingoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnsbSawu9F0heo1ZthYiVUryFLXv/RTBRT1qdz3IzFlMoKs2n7PVEeHFFEMLA96jN
	 orVT+gevjPJGpbyUSPh3l1tB0tT+Jt5TT8mGkgVRMqFs6cQ2sOPXQImFqzEelY29wA
	 i5DBr9alyhEafeE+24z7ed04QYj+BAvq1nS/lWbHeDOPWWxQMgwssKFSEfgJyxbbjf
	 G7eR4DFZX5ys7C0Gzxt6XvEbP6KkWnpLNPJVQ9AY4rT6V69JhLRL498sl17RTr3bjp
	 822JMjfBQKSpmb+h+criO89l2iKIJIeapzem61J0MXc6soPJTHyVJ8FjEz56Djc8M+
	 pVDYBXBlGx+Lg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F22F0CE0C57; Wed, 15 Jul 2026 17:23:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 05/10] rcu-tasks: Remove unused struct rcu_tasks's->n_ipis_fails variables
Date: Wed, 15 Jul 2026 17:23:34 -0700
Message-Id: <20260716002339.11717-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The RCU tasks trace has been reimplemented by 'commit c27cea4416a3
("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
rcu_tasks structure's->n_ipis_fails is no longer used, this commit
therefore remove it.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f4da5fad70f516..7f7d1e6362178a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -67,7 +67,6 @@ struct rcu_tasks_percpu {
  * @gp_start: Most recent grace-period start in jiffies.
  * @tasks_gp_seq: Number of grace periods completed since boot in upper bits.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
- * @n_ipis_fails: Number of IPI-send failures.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @lazy_jiffies: Number of jiffies to allow callbacks to be lazy.
  * @pregp_func: This flavor's pre-grace-period function (optional).
@@ -102,7 +101,6 @@ struct rcu_tasks {
 	unsigned long gp_start;
 	unsigned long tasks_gp_seq;
 	unsigned long n_ipis;
-	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
 	unsigned long lazy_jiffies;
 	rcu_tasks_gp_func_t gp_func;
@@ -735,12 +733,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		if (havecbs && haveurgent && haveurgentcbs)
 			break;
 	}
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c%c%c l:%lu %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
 		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
-		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
+		data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[havecbs],
 		".u"[haveurgent],
-- 
2.40.1

