Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90B47CC92
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467774; cv=none; b=TMdQP/s9WhipeIw+CqingcUwXUPPVYSXGZaStPWOh4bEtR9tC10Q+LWewtKmcvWaNBBG4Ru7ZrmE1qZfnKeuJItjyOZp+P4Wg/zJ0zLiLY9Ibz/zhdAJVw9uBtjMM9hIoV9m1WHn1VYi8+hITjbbiaLSDurHWQ2fcl+pLBsYtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467774; c=relaxed/simple;
	bh=QbAqr1i8wGfwpG93RfEhC6hvvYA++56HMkSO3WogBC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+8d2XS9/V4RWU7uWiVn/BVBaORjQdKiqW0YQ5yv2Zpo9fXoRq7ZaVgViqjy91Bl/bLN8zGpym8xkghPzNVN1fuja3K4ZR0xSU78pfFjPvru2Zs/ye2pE9LYbFUlmkJlSzHqdkmgWMbuuRRePorjD0e4YxQsgwC9VWw7p6CWTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4dfcPKZ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4dfcPKZ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so81681a91.3
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467771; x=1790072571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wc2tYgFRuQ1d5FQeVHhp84yw7j2VmRwEE2Rf/RiEYBs=;
        b=d4dfcPKZ34BFcM9IYBZRPRyFAGaRokuEcvbc3o8TXXaYx8p/C3kVNHMgAZdyA76X5u
         ihjsmFOAPF0mnP06N9vEmO7KFHxM+j8KJLnU3OkHbpjf+XX/4AEVxN+3yNeOthwXEkFt
         YSJ8GkFuuMWXCVAT47Lu2E2v85AO01R3ealWBDf7JD44yq/0hq3aDPOSmKD38Km/hKZj
         380kD8zU4ns55BSccQLRJoo5nx8lca6MNg04YgGVBD/K5LKBhu89AyPzdsntzshV8+S9
         142o2e5MTaniZHJ9AvAoZAbYgRJoR8I95mPxPUyT+af53QjhSCN5paRCFSduC3BQT5Tl
         AH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467771; x=1790072571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wc2tYgFRuQ1d5FQeVHhp84yw7j2VmRwEE2Rf/RiEYBs=;
        b=QTQgAYdtFw2a6E2G3RxhmO0I31AuJ3/h9T9Vf9/AR1Zze3RoG7Ug/9DeVMabfzcJsF
         5wTRYCU0CjY4LlygHKbN9Zvs6DYAGMqxpWmEFDumxDhPVw+GGTCjrOXcImBBb6Jhsn5K
         Vd8hfQ3OGICy+BSru4NgUvgVdEp6WAMHzXGbbee3E46ELHNHtviraGsZP7odGCwk0ak1
         kfzab3wX7jSG1m8Vr/S1y4YSJHkQ7a/p0kJnxQUx+I6lhJsWMRUIhnte3XsyeXpdQpjh
         mZ+qan77BZPHysDc/we/XS85YIcUEqBr8ADLZKWTI1niRqvvPC3T5Ztgp+oZ45n2lmyY
         aLcg==
X-Forwarded-Encrypted: i=1; AKwUvByEArpkJRNXdaHSIEflfdwk3i7seUXfLyfgGegJUVpQQYg8nou+W4ETnW7OMP7O5lnCW3U=@vger.kernel.org
X-Gm-Message-State: AFuF++lY+NTJEpTaxizS90UrZtU8DRYn4snlFaafcTo4RAXbnmosSFwU
	WXrmUJAjQc2BX8EG8L/GuIy7cL813SWtRoIgdnrKk6heoJB0gIhh/zGP
X-Gm-Gg: AYBFou2tw7rJlaslNyHldusBR3nWiaYbL5JxPxGcHNhRjOxHetBFZQKSgKTXgweT9tn
	MUg5rH7kblz4oIkwCVya7Sc1m7hC5NjqiJbShHN/nA9eub+O5ogrrhx0mZ/OD5rnQZj1tSq+Pk6
	8o9qN7qVXjU6Ze4BP08XWF0DxcE7kwwThSU3ttfMYORtc8NkbvEBksd3GZY7Xy+o9CoQy7cWrIZ
	M9HdzBK+sFVNe99qhpRhzBFWBm/xEa9Xy+rP6eaff7WdLzEJnWsSaYNEHzXD9SkgRmaX/Lz0GI+
	AKQ2wkKU0zAu3/1VTrfgJd3vxg/KaJbfZO+ghT4ON134FDUTD0zQ2NjN3rnB5Q+EybCqQqMgN/i
	iC7WE06SOZwopMebL6r1dX5s8Kc3yAd2pbkt7XJMpkmx3kIdauKmvKjd2Ct0ANHzuHOFFPrtHql
	snajOmqiU4vT2rYMiGQ0RWeLASxEah/A3t9D8zBNuJG+ZIvUKEluDKdp4YrdWAgqeW+ZxbsbHv+
	uf/p/iN377q4xF4l7qCN+wRbg7FrdAiKzY4jLBSK4lODnH5/NMc
X-Received: by 2002:a17:90b:17c8:b0:39d:fced:6fb2 with SMTP id 98e67ed59e1d1-39e10c425c9mr475072a91.5.1789467770864;
        Tue, 15 Sep 2026 03:22:50 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdacba6bsm4448413a91.14.2026.09.15.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:22:50 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH] rcu: Guard deferred QS on kernel exit behind need_deferred_qs() check
Date: Tue, 15 Sep 2026 15:52:41 +0530
Message-ID: <20260915102241.1344738-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ct_kernel_exit() unconditionally calls rcu_preempt_deferred_qs(current)
on every return to userspace.  On the common fast path nothing is
actually deferred, so this is a needless write to
current->rcu_read_unlock_special -- a word that lives on the task_struct
and is therefore subject to cross-CPU cache-line traffic.

On weakly-ordered architectures such as ppc64le, rcu_read_lock() and
rcu_read_unlock() already issue lwsync/isync barriers and touch that
same cache line in the syscall body.  Bouncing it again at syscall exit
adds measurable overhead, particularly on workloads with a high syscall
rate (e.g. SELinux-heavy workloads where every AVC check issues a
system call).

Introduce rcu_ct_kernel_exit_qs() which wraps the deferred-QS call with
a rcu_preempt_need_deferred_qs() guard, matching the pattern already
used in rcu_flavor_sched_clock_irq():

  notrace void rcu_ct_kernel_exit_qs(void)
  {
          if (rcu_preempt_need_deferred_qs(current))
                  rcu_preempt_deferred_qs(current);
  }

The declaration is added to <linux/rcutree.h> and a stub no-op is added
to <linux/rcutiny.h> so that TINY_RCU builds are unaffected.

ct_kernel_exit() is updated to call rcu_ct_kernel_exit_qs() in place of
the direct rcu_preempt_deferred_qs() call.  Semantics are identical when
a deferred QS is actually pending; only the unnecessary write on the
fast path is eliminated.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 include/linux/rcutiny.h   |  1 +
 include/linux/rcutree.h   |  1 +
 kernel/context_tracking.c |  2 +-
 kernel/rcu/tree.c         | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index e56ded733b1b..dcad641eb2c2 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -120,6 +120,7 @@ static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 	return false;
 }
 static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
+static inline void rcu_ct_kernel_exit_qs(void) { }
 void rcu_scheduler_starting(void);
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 16a04202888b..d623f2a7d3fc 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -87,6 +87,7 @@ static inline void rcu_irq_exit_check_preempt(void) { }
 
 struct task_struct;
 void rcu_preempt_deferred_qs(struct task_struct *t);
+void rcu_ct_kernel_exit_qs(void);
 
 void exit_rcu(void);
 
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c0..011018214c6d 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -118,7 +118,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	lockdep_assert_irqs_disabled();
 	trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	rcu_preempt_deferred_qs(current);
+	rcu_ct_kernel_exit_qs();
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b..c23478f70c17 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -368,6 +368,25 @@ notrace void rcu_momentary_eqs(void)
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
 
+/**
+ * rcu_ct_kernel_exit_qs - report deferred QS on syscall/exception exit if needed
+ *
+ * Called from ct_kernel_exit() on every return to userspace.  Guards the
+ * rcu_preempt_deferred_qs() call with rcu_preempt_need_deferred_qs() so that
+ * on the common fast path -- where nothing is deferred -- we avoid the
+ * cache-line traffic on current->rcu_read_unlock_special that the unconditional
+ * call causes.  This is particularly significant on weakly-ordered architectures
+ * (e.g. ppc64le) where rcu_read_lock/unlock issue lwsync/isync barriers and
+ * already touch that cache line in the syscall body.
+ *
+ * Follows the same pattern used by rcu_flavor_sched_clock_irq().
+ */
+notrace void rcu_ct_kernel_exit_qs(void)
+{
+	if (rcu_preempt_need_deferred_qs(current))
+		rcu_preempt_deferred_qs(current);
+}
+
 /**
  * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
  *
-- 
2.55.0

