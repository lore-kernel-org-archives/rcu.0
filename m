Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A17191F88;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=Gz7z830G46phJrudffMHU45jbzSNZAy7Tg74eakcCAr6z7rd3TfUGZP8LxCQmxSFZvzBUhPDFd8792PCuMe0DGPp8H/xHyA61hlerzchieWIgByi43wjs01tz8oWO2Orrsw8S9bvNxV0tANENUPJkQmbHdr5Y5AB2I2Klm46N5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=/4kMmBV/Oc3c3Mh65406MccJTTAR/9unXOzgDbbf4Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgyw9XZhP/aGmWWg8XFlJH5Cl7HVLKSn7mzoHVTlh9zSTrR1FR/mMsXKXUp/vH732qVRr3Pn2C6PkXPxDKnCBjwsx5Uly+nzPpgPV3oYvoGIB4uQlVZkQuiUDKb+W3uulhkmG5z7N6+6FxDpyJCCC00ylwB7A8eImzD1Kf8o8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuvtWLCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuvtWLCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA71C4CEE3;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=/4kMmBV/Oc3c3Mh65406MccJTTAR/9unXOzgDbbf4Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuvtWLCkmwzUn/8LGB6sluGMEmYoTP9olB2riKZWcLKFQbnONZbPmDhI4zKDblKST
	 oJPM6hRBGOLUuBHmMxJF92qk6aLb20yu1nex+0GtUYHbCpH9YQ0+0RYv2fdT5nvvQd
	 rVZdEVvvRbLs89/TpxoUMo3WuwKaf23Ig70AqkXCbG/qXXYN86wxr2bgDrlU+zs/rH
	 /qvWXe7z0CJ5i0LvEevB1pQFBFzC6zWoy9h6M4LFybXdVcJqi2+BELZ54hL5RPyZ/f
	 CX28DYp0lyT+btgRI7izVtmflau+MKOPvkC6iRbSS6xH/griTR1zyqaV7UITyY7eeR
	 Ucirqwz1S2/+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5052CE0FF3; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 07/18] rcutorture: Check preemption for failing reader
Date: Thu, 12 Dec 2024 10:49:46 -0800
Message-Id: <20241212184957.2127441-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit checks to see if the RCU reader has been preempted within
its read-side critical section for RCU flavors supporting this notion
(currently only preemptible RCU).  If such a preemption occurred, then
this is printed at the end of the "Failure/close-call rcutorture reader
segments" list at the end of the rcutorture run.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
---
 include/linux/rcupdate_wait.h | 11 +++++++++++
 kernel/rcu/rcutorture.c       | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 303ab9bee1552..f9bed3d3f78d9 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -65,4 +65,15 @@ static inline void cond_resched_rcu(void)
 #endif
 }
 
+// Has the current task blocked within its current RCU read-side
+// critical section?
+static inline bool has_rcu_reader_blocked(void)
+{
+#ifdef CONFIG_PREEMPT_RCU
+	return !list_empty(&current->rcu_node_entry);
+#else
+	return false;
+#endif
+}
+
 #endif /* _LINUX_SCHED_RCUPDATE_WAIT_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 658ac46581d81..9b81e21c75d18 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -267,6 +267,7 @@ struct rt_read_seg {
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
 static int rt_read_nsegs;
+static int rt_read_preempted;
 
 static const char *rcu_torture_writer_state_getname(void)
 {
@@ -394,6 +395,7 @@ struct rcu_torture_ops {
 	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
 	void (*gp_slow_register)(atomic_t *rgssp);
 	void (*gp_slow_unregister)(atomic_t *rgssp);
+	bool (*reader_blocked)(void);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -587,6 +589,9 @@ static struct rcu_torture_ops rcu_ops = {
 	.get_gp_data		= rcutorture_get_gp_data,
 	.gp_slow_register	= rcu_gp_slow_register,
 	.gp_slow_unregister	= rcu_gp_slow_unregister,
+	.reader_blocked		= IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)
+				  ? has_rcu_reader_blocked
+				  : NULL,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2035,6 +2040,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	int newstate;
 	struct rcu_torture *p;
 	int pipe_count;
+	bool preempted = false;
 	int readstate = 0;
 	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS] = { { 0 } };
 	struct rt_read_seg *rtrsp = &rtseg[0];
@@ -2100,6 +2106,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 				  rcu_torture_writer_state,
 				  cpumask_pr_args(cpu_online_mask));
 	}
+	if (cur_ops->reader_blocked)
+		preempted = cur_ops->reader_blocked();
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
@@ -2112,6 +2120,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		for (rtrsp1 = &rtseg[0]; rtrsp1 < rtrsp; rtrsp1++)
 			err_segs[i++] = *rtrsp1;
 		rt_read_nsegs = i;
+		rt_read_preempted = preempted;
 	}
 
 	return true;
@@ -3569,6 +3578,8 @@ rcu_torture_cleanup(void)
 			pr_cont("\n");
 
 		}
+		if (rt_read_preempted)
+			pr_alert("\tReader was preempted.\n");
 	}
 	if (atomic_read(&n_rcu_torture_error) || n_rcu_torture_barrier_error)
 		rcu_torture_print_module_parms(cur_ops, "End of test: FAILURE");
-- 
2.40.1

