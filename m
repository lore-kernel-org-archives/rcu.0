Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FB3BE646;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173040; cv=none; b=pmxtHLVXeNpFh4kTwPE/6hR9/uKKBDAHKuD61Hflx5Qo+CA1fOCP3w19kHg4bCE/UB2C9Iv3NFdHF6yIc9YPHP17PgDuDceRjUoIf/AJsRDXXtViWKQVjk7Xo7N0N3H8PVEHKZS2mfKJR3JccJOyRmp7Vy6UpCqXZ2O/DkGTjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173040; c=relaxed/simple;
	bh=o01rY3rWnKQ7CHvOkgj1UhEYkg00BbUol75ELLzG4A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQw23NGl5WBu6iZM4QV37DOxBbxnrKZxu9TRpcvuHW24oOkou1MpkDypPzZ9E0N069vlgi1bfd9z4H4NNk29bhdt06biWNjiNskKoZS8eKhpu/PMhpCvbcDKyGVpWaPlUDipSyTmcIPHvVkb1O6tVKIHYPICEHDonoTxsQDRN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoRsdG6c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoRsdG6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02195C2BCC9;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173040;
	bh=o01rY3rWnKQ7CHvOkgj1UhEYkg00BbUol75ELLzG4A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoRsdG6cSiOzz6V7WNqOUfnUz+ky3TY5lKtDRKh3CH4syjf/uVU6u7kIRp27krxlU
	 H0lpiIlXiziwYESNwas9Jtpsd0/FQTT57229ZVXq8A6f07SMIy/ikUeSIW9jDYYSc3
	 FP1wkr4npDhcEfP+Zdnx+R9NVspH4RKgJ3WJQY5bZC+wQzxXxl15hoU3OuU81kTYVu
	 +KI7PFuDN/EB4dFfx6t+GWQodmSn1QMJ8UeCuNDiVzOyQ5QjWGsaVdTxXV3l6B4q1s
	 tgMBTF11/U3iwbRPUDwnKo22mzdrG9/QeKbPcl7ckvDrOC7LsMYHZzsNCCS5rtnzmy
	 CaPfxGtDzX+Bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2821CE0A36; Thu,  7 May 2026 09:57:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/6] torture: Add torture_sched_set_normal() for user-specified nice values
Date: Thu,  7 May 2026 09:57:16 -0700
Message-Id: <20260507165718.2039781-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
References: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new torture_sched_set_normal() function clamps the nice value at
the MIN_NICE..MAX_NICE limits, splatting it these limits are exceeded.
It then invokes sched_set_normal() to set the new value.  This prevents
more difficult-to-debug failures within the scheduler.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  1 +
 kernel/torture.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index d80f24ff69e3e1..66d2d444428aef 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -129,6 +129,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #else
 #define torture_preempt_schedule()	do { } while (0)
 #endif
+void torture_sched_set_normal(struct task_struct *t, int nice);
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_ENABLED(CONFIG_LOCK_TORTURE_TEST) || IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
diff --git a/kernel/torture.c b/kernel/torture.c
index 62c1ac77769424..77cb3589b19f9c 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -972,3 +972,19 @@ void _torture_stop_kthread(char *m, struct task_struct **tp)
 	*tp = NULL;
 }
 EXPORT_SYMBOL_GPL(_torture_stop_kthread);
+
+/*
+ * Set the specified task's niceness value, saturating at limits.
+ * Saturating noisily, but saturating.
+ */
+void torture_sched_set_normal(struct task_struct *t, int nice)
+{
+	int realnice = nice;
+
+	if (WARN_ON_ONCE(realnice > MAX_NICE))
+		realnice = MAX_NICE;
+	if (WARN_ON_ONCE(realnice < MIN_NICE))
+		realnice = MIN_NICE;
+	sched_set_normal(t, realnice);
+}
+EXPORT_SYMBOL_GPL(torture_sched_set_normal);
-- 
2.40.1

