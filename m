Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511430BB8A
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361511; cv=none; b=pUPdJiHqQUeKsaiIbCEZxDf47dDv6TMCXtUsaAKV7D1QXmSbkowhq+qrwrttcIyBFnVrQj/W5Mo5HyshrWx35FMcW+RUVwiiIdm/m6pRUq2zR8j8WUQlbtGohHYP91sBX8mgwQKx6DTb+ok9d1hdST28DOSKWZM57gdW1ediqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361511; c=relaxed/simple;
	bh=cs6CcPjBf3Hhxwg3I/aO+r+GIKGiE678uAuhi86HGrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHBIT3O22aE0ILHDwO38Mgztw677ukXOezfvkqC+BFfJslexZPqSJYfVFpxdiOtnEtVfxpCYBaMuJrXSbX1K72QePFLU2GnlBfJZEX24Du/LTsE/dzGuMAGIZa28/1173X+WCUOhifTj8fsyVSYZtVS50FtuCbsNtCZR/acMMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGOQDkS6; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGOQDkS6"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124a635476fso2705773c88.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361510; x=1770966310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3v4q+lvsBn1hE6xrawKSqo/X3eavnWHmOAy67YUdOo=;
        b=fGOQDkS6ebAdRHYBru5yx5CLGYxpirwFiN9HztTPGh+TPh6jG2pYJCnVqWt+XMUXmL
         n+qCheDLkCaFRgMQYRvfjY/NqcQt6dO3RjP6itEUh1PLxrcmM5Fv68CYTpnklLmJiqBU
         MDi5k1ElF0qwvoGyXin3yxF2FmQXK66sR0X9ejrC9hfHsSPowsXmpCTVXi3894YdHUxD
         jXjqAMTJzP3ZI8/QYBcMnsSJ1f9noEp4EnA1ZCf3w2txkxTsvePeP85tSk0xDsXKzQxl
         ZLOxK8fuqA7rh2830tIQnx/bBvD+bqiNoc2+EZR2bOe6kIDtWASjLwNsYa2vg8GQa4Mh
         RDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361510; x=1770966310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q3v4q+lvsBn1hE6xrawKSqo/X3eavnWHmOAy67YUdOo=;
        b=LWzAjJsKknynmBDk/q8pnGNQIwxZa7DP9e8p4MAIzdxEnfI9/5Tlvxxt+n6tSLkyYG
         hMXPCrgxtNodbV+MKap2RBuB7A3v9sKwS6Ww48VjFqzIUbwQmCKB74yOdrBnh/9v8xly
         5AqK0U7EvMbyti/6VSveIWSENsyd+oYqpbMHILy8C9+NVSg9U8zDwwqVXNzSDrJcjG74
         Fd2Pk2Mv/MGBaYqM/OSeS+rFUfn9syQMwPPUThQ/P9+T+7LXWndD72TsGGSlSHQpM0bd
         7ue8JrEBqIq8JPTwq5rIpyb/Lax45SQ6W3df/12cq/MNeNXH8p3w39n38YdRSRlc9TyN
         c2zw==
X-Forwarded-Encrypted: i=1; AJvYcCWVsiSrRWiWzi5z01Z4scYbNg9liHSdPaMAmcx5DPfavMrX+cIPLArNd2SdGKe45Nn7isA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqGUt4NBc5jJL1BO10rOxLossDELWknMa7VZP+SajYOWPXhkW
	MFffgtreDDq37CfBywx8Z6XOFPMkTrZ+XRbSZNgjJjSgEqM11iI2xQ/b
X-Gm-Gg: AZuq6aLP5qebxaIawybMZDUvR5G5knJ2hEbsRSJD7Twk33Akdolw+3Wx7ldt+w78/Rt
	nP04wcxkrQqDhBaNkXSNIXkqmBHTWIlYr+y7ytOSlpApc09aD+Iiw474FTLmbvMSBX0aCe8dPAJ
	Fy+NATqF7Il5QYNdP121Vh7y0HvCUeK9m2X+zkn21ETTcCy/DD8qPZfOOn0Psd7o6ZtT3cr0bJ0
	LMOZEynl0HLGU80On9mWylHvd3cHy19So3NQkGRAWdOuOZ2ZUOpAI3NJZ401DdSFTUnxSAQpZ57
	VvTyxNpxj+NeIwmkkS6GctCjJSRKZ7kyt6bkBaXLZ/DKBt1rACmXwF3d5iuC7ac+3Xs6ZbuKerm
	FGQxsjw6PyUTfitop5bYxnyOGY876xlPiTtycgYV0HCF2sVFHZMyxgkrLOW7/bfQ2wioHMnxh/c
	3Pc+bbL5KhQYgqaj8rDZBV
X-Received: by 2002:a05:7022:4a4:b0:11b:9386:a38b with SMTP id a92af1059eb24-127040981efmr964389c88.46.1770361510084;
        Thu, 05 Feb 2026 23:05:10 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:05:09 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:22 -0500
Subject: [PATCH RFC 01/12] sched/isolation: Remove __init restriction from
 housekeeping cores
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-1-00a711eb0c74@gmail.com>
References: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
In-Reply-To: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 Qiliang Yuan <realwujing@gmail.com>, Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.14.3

The current housekeeping management logic in kernel/sched/isolation.c is
heavily tied to the boot process. Functions like housekeeping_setup()
and housekeeping_init() are marked with __init, and they use
alloc_bootmem_cpumask_var() for memory allocation. This prevents any
runtime reconfiguration of housekeeping masks.

Refactor the infrastructure to support dynamic updates:
1. Remove __init markers from core functions to keep them available
   after boot.
2. Replace bootmem allocation with runtime-safe alloc_cpumask_var()
   using appropriate GFP flags (GFP_NOWAIT during early boot,
   GFP_KERNEL at runtime).
3. Introduce housekeeping_mutex to protect the global state during
   concurrent updates.
4. Update include/linux/sched/isolation.h to reflect function
   signature changes.

This lays the foundation for runtime isolation reconfiguration without
requiring a system reboot.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/sched/isolation.h |  2 +-
 kernel/sched/isolation.c        | 32 ++++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b5..cecb80b09120 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -31,7 +31,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
-extern void __init housekeeping_init(void);
+extern void housekeeping_init(void);
 
 #else
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3ad0d6df6a0a..811bf6cbe68d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,7 @@
  *
  */
 #include <linux/sched/isolation.h>
+#include <linux/mutex.h>
 #include "sched.h"
 
 enum hk_flags {
@@ -16,6 +17,7 @@ enum hk_flags {
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
+static DEFINE_MUTEX(housekeeping_mutex);
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 
@@ -84,7 +86,7 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
-void __init housekeeping_init(void)
+void housekeeping_init(void)
 {
 	enum hk_type type;
 
@@ -102,20 +104,30 @@ void __init housekeeping_init(void)
 	}
 }
 
-static void __init housekeeping_setup_type(enum hk_type type,
+static void housekeeping_setup_type(enum hk_type type,
 					   cpumask_var_t housekeeping_staging)
 {
+	unsigned int gfp = GFP_KERNEL;
+
+	if (system_state < SYSTEM_RUNNING)
+		gfp = GFP_NOWAIT;
+
+	if (!housekeeping.cpumasks[type])
+		alloc_cpumask_var(&housekeeping.cpumasks[type], gfp);
 
-	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
 	cpumask_copy(housekeeping.cpumasks[type],
 		     housekeeping_staging);
 }
 
-static int __init housekeeping_setup(char *str, unsigned long flags)
+static int housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 	unsigned int first_cpu;
 	int err = 0;
+	unsigned int gfp = GFP_KERNEL;
+
+	if (system_state < SYSTEM_RUNNING)
+		gfp = GFP_NOWAIT;
 
 	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
@@ -125,13 +137,17 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		}
 	}
 
-	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
+	if (!alloc_cpumask_var(&non_housekeeping_mask, gfp))
+		return 0;
+
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		goto free_non_housekeeping_mask;
 	}
 
-	alloc_bootmem_cpumask_var(&housekeeping_staging);
+	if (!alloc_cpumask_var(&housekeeping_staging, gfp))
+		goto free_non_housekeeping_mask;
+
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
@@ -203,9 +219,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	err = 1;
 
 free_housekeeping_staging:
-	free_bootmem_cpumask_var(housekeeping_staging);
+	free_cpumask_var(housekeeping_staging);
 free_non_housekeeping_mask:
-	free_bootmem_cpumask_var(non_housekeeping_mask);
+	free_cpumask_var(non_housekeeping_mask);
 
 	return err;
 }

-- 
2.51.0

