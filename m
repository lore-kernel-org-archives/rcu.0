Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676C33509B
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429791; cv=none; b=SADyMIGtaEiIte6KUItkEBc2j/gaSgTceyhIfufq7kKNAmkUVg1IvElnIp0zJW1KaVEHMDmNd19a6zt5XbiQp4myrV9lY9qGGNDjpwhisKFedAApkSslCtYUfy33DQYo8nbfSbwWGeKEYid/1spuU5IrYRBu/m4FlSZcbgYXWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429791; c=relaxed/simple;
	bh=orBqlTSU08SBfpvoR+5o8LS2QT5TANQSy6dJ/409s5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5gQt8P5hkE81D9Rjk9pUgQkrygodsRM7g0FORn2HI5NLF7/uTsgIEEyCTFWD/xmK9cMXHoTrFLWBTegGnrlmzO2IQMG7Leidd41itJ0G9PJkOyVEOGt3qZe0FP9SS1iNvSq4xrDlyIXxQFGiiaJtlKEDPmujFpDZeNl4bGp3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAg/TD4l; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAg/TD4l"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so2390631c88.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429789; x=1775034589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWZZ6ePUrfQHB8Z/JVxCsE1F+0gZz3S/duMH4Wpbiuk=;
        b=pAg/TD4lr5ll1e/tBegxTmkuPrYjZUZCks4h3KvkokORLdnGGO1Q1/PqC5/rIoohXK
         WAK9SY/cI9oGhCvMRqmlj99eAFIjWpk9Jbyie/msj2Xu20jKh7fRGXfNuc+CnHzPm0U/
         n3fiAiG34Z+FP5gPt+OWPWd/f3XYMMlwCFW6R7VH7l9TfhcPa2OdXvBz8hDw7sctJkO3
         FMaGIY9IkMwLsCIWwd09WvbDBxIg167aSSctaTgz0WYwKHChlJCpZ6oXf7TsoFlcf4G+
         MgEK72ZZFfOe9T1NhmBufvCvYfhzJBTCLbsRaDpQ3BrZjaNMJ0P/2dOLaTZIlW5OpFTw
         PFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429789; x=1775034589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWZZ6ePUrfQHB8Z/JVxCsE1F+0gZz3S/duMH4Wpbiuk=;
        b=JZ3uf1Wcxz7oABtiaKE3K79E1yr60+/5VaxN4F8YMLFlaLpaJ1n5mR5e+Zt+Pdlepd
         TFJPX/Yy/jOkQzJ51G2b6fTdtymjkGPQQp4cLvgoKt33RPfb9TjG0RgOk1eWgoDEXlX6
         bcjxjUn+XFLk2WQL+VVzbItl5E8mhmfqSDrVGIs49z0yhL6b5dTT85FUZGhLJ0Q7zp/o
         qWtzkHrY26rzk3LTIf6sAj3LeszjcGhDTMn4hVk1TI/3aOFBQVfS9JZNJ/Tl+bTIs7pZ
         LqDINyN83d9xWRrY9aPiFh/wmNmCoeZk+uGoUD7vAy3YDfKD4c3vFBrJekYNyX8+FS4i
         /sLA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/c3oGeaYomPkjngpvWjJU53XyG6mIqBA6RLmC4NDWpaXlDKxb/GLdHI6URhmMyW4fN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Qox8E/9MRwWiquRnFwW/3fYGVtPBXfO7LIYD4HpPGYYWrPIv
	yDJxxyI3TahI1lMHON3MObuchjfXB0OJ+ie3gL+rK6PIcWTBwmuwyQjs
X-Gm-Gg: ATEYQzzvHGeDxesOC2qDAWBJ3jA/tniJpFNWn1ARz3teTOFYbe+iGquKKPcPtZ/ycBX
	HE3tfvwxlEObSQPQEO7g4Z8PY98RAahUWrNvakVHF5/MvQ2QwS7aT+2o1nAylthReaOZW3b03x2
	oYxJiX4yjdZe57Eg3GHnLLZ7ILE/QyHh7LbDbvGUxopURNd4X8FlCwhf8NCdbITNpNw47TboRV7
	AgLQQHMUYB+DoBxC5E5T6+oPtnMNNWM5qaiRZclZJ+5BJgmlOKcpuKW7eQPtl0mnwxwe03IoObI
	nvKkrh64ODIXnSaRMnptpx14sDvcreQZ2cXxwwBYMgF/tIQBvZbtZHiIU+T9wfqFHKZof+/o1ej
	/h91KR0l9c0vOwcEgPHr9/Jz+O0IXH13t7pDKgUXMbKiaunriYWht0UipopDn6ntTkKwUvsidbr
	vi9HxezoYD3wAoypZe
X-Received: by 2002:a05:7300:b505:b0:2ba:a60a:15e6 with SMTP id 5a478bee46e88-2c15d3db165mr1328179eec.16.1774429789468;
        Wed, 25 Mar 2026 02:09:49 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:09:49 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:32 +0800
Subject: [PATCH 01/15] sched/isolation: Support dynamic allocation for
 housekeeping masks
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-1-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
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
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

The existing housekeeping infrastructure uses a single static cpumask
for all isolation types. This prevents independent runtime
reconfiguration of different services (like RCU vs. timers).

Introduce dynamic allocation for housekeeping masks to support DHEI.

This allows subsequent patches to manage service-specific masks
independently at runtime.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/sched/isolation.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3ad0d6df6a0a2..67a5ff273ea08 100644
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
 
@@ -105,8 +107,14 @@ void __init housekeeping_init(void)
 static void __init housekeeping_setup_type(enum hk_type type,
 					   cpumask_var_t housekeeping_staging)
 {
+	unsigned int gfp = GFP_KERNEL;
+
+	if (!slab_is_available())
+		gfp = GFP_NOWAIT;
+
+	if (!housekeeping.cpumasks[type])
+		alloc_cpumask_var(&housekeeping.cpumasks[type], gfp);
 
-	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
 	cpumask_copy(housekeeping.cpumasks[type],
 		     housekeeping_staging);
 }
@@ -116,6 +124,10 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 	unsigned int first_cpu;
 	int err = 0;
+	unsigned int gfp = GFP_KERNEL;
+
+	if (!slab_is_available())
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
2.43.0

