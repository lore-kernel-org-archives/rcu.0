Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D8198E92;
	Wed,  8 Jan 2025 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319444; cv=none; b=WBDMv3Cy3G5feDGEg7fPh5pfFVWFBLzhivsp4iXGaIERTTrC3z2vS8bqsYq256+qaRw8bZswCtrIndBDCKdZmg5UeegNQ27nW9j4V5rePE2zNPlLkzcFbOXzAdGHwNwjqixIbCfh3fQWf5oXcFzKBkbCtJer4DVpQ0ni6fG4OGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319444; c=relaxed/simple;
	bh=f7ndycysB0AapUoccIrUnUG5fEYKEIxbHkWfON7320c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=No99ChU58H1cEMNRzpDt/kx5+fBiZLujyIzrNZ6hq9bLo1NBmmte21RyBFbXIPb8S4DIzDp+pmT6DdMTpnIKn1t5ZVkX2Lbokb3WV7Ky2s20ODUw96jzS8CNjI2pcB++9j9uaDj/oC6kQRPSopRcbGOkWw85Lw04JwgbOBAgqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdaIMNhO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdaIMNhO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso46419515ad.1;
        Tue, 07 Jan 2025 22:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736319442; x=1736924242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDD6V3F9Iaaa7ir2g7dGgl4IhbjyYAhKQ6DAoWH4g0E=;
        b=LdaIMNhO8RqSU3OdKnQyAFqHnQAq7+gozSYj73T+XOfNRMr3Dt2A4IeTLXzFWBpTiK
         9NDKy7oOhCdUIbkHFyE05KZsHxVJKamYKXVHycENXE2TA3xyNVC5WZuWf6xhPRY8y0fX
         VXhgshUSwmdx9Wcq5WPy7qyReA3T6LjD6uFlP7e82n0jIu2RXEgtJjmzPLGlK7TlRU8R
         IlvL1kX9DoXSJ0LZPeZy+4+LCtM7gsOQL0ZpdacXdJFPQy4sJl/2K3zgxuHkai7HjSQi
         bCy5N3PXjO/Vv4e+V5MGi/LYKdoNDaYTUfi9Epf43/IThiz2cFE3XlXHKfVhlhPBAAqT
         IlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319442; x=1736924242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDD6V3F9Iaaa7ir2g7dGgl4IhbjyYAhKQ6DAoWH4g0E=;
        b=RCUOWKwwpyVV2b8T81KCAd473e3wIAyjT25+SPLXesVO7t6ybd2DieHfppp5XgqpmJ
         oK8jOpMtJTYNz18cyKImAE8PLWZEkeLXd7C+/tglK1Ut6hRDJAldMb3nstquUrGaV0ie
         nEkYV6hzmSw6bZ5hcb8S5vw3si9BqpvEf0cICFyht5r6mzugdCNCSkTufbZANjXaHy9w
         wcWkoxg1TMJ58FP7n0e2EQAm054U7eVj/h1kMYVtR2avmZqhVKlNGKD6pkrsujW9/kKC
         2gcDAvMruq+SeSJheaE2K/MH+lAVNKlZMl/9dCSUHnH5KmzfCwuz67S2unDvYCGs/J94
         Bd3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtez8k+HzSU4nJ4QkA5MnQPZf0/45RxhOFnDoG/F/I1qB++gpkF1LSjO2YG53TYLhy6Znp@vger.kernel.org, AJvYcCWmdXm8Kb/P39mFWpXgNdBQXR2yXzOSis7iO1+OW4fXZxlL9BfVVl2siNyze/o85qXhNxY4nuy6zGzEAJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJQe3WFo3QeZna02Z8zquK8AEsalVM7p2b3uiRMFhzpcUTwio
	yuGl4kAe7SS1+ZZl1E0jBaxnVKOU8biYoCnUbk2giLY1bvI9vCg9
X-Gm-Gg: ASbGnctIxyOSjieuivZssYrICbnsXIsz5aumMZ+ufXLkHIMLM5Knl2flacxAHC+uBxr
	kh4R0WKjfAh2rnugxSgjISAGUyM2gl3+mTKsic9htbGhKAdLcUwc/Q8PL3pUNPLMgEP1Na/cx5h
	oNLqTOH/BnYVb0kq4Pcw+kQlouaPFcYLKdIz/779yRz9vcpCOirokuahV8COkEP1huiYBKikRxg
	4d3LKakvfecHfmxJKjTX+gb/zFgPa8AKpQEtqcewWuHQrlO7dkN1VgLibSFjsgTn05jX4bIknvD
	1eSHjK4XLwuodFh/EFh0itNv684=
X-Google-Smtp-Source: AGHT+IG1cal8UzALrc+e3d4bTwfLeNsCmLsgHQyHNsRTBKrG/TFvRvFZ/SlmtkZtXwDGHdccdW0j1Q==
X-Received: by 2002:a05:6a21:910c:b0:1e1:f281:8cf5 with SMTP id adf61e73a8af0-1e88cf48a57mr3241016637.0.1736319442292;
        Tue, 07 Jan 2025 22:57:22 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1c7sm35388758b3a.182.2025.01.07.22.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:57:21 -0800 (PST)
From: Yongliang Gao <leonylgao@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	thunder.leizhen@huawei.com
Cc: frankjpliu@tencent.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>
Subject: [PATCH] rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture
Date: Wed,  8 Jan 2025 14:57:16 +0800
Message-Id: <20250108065716.2888148-1-leonylgao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongliang Gao <leonylgao@tencent.com>

When counting the number of hardirqs in the x86 architecture,
it is essential to add arch_irq_stat_cpu to ensure accuracy.

For example, a CPU loop within the rcu_read_lock function.

Before:
[   70.910184] rcu: INFO: rcu_preempt self-detected stall on CPU
[   70.910436] rcu:     3-....: (4999 ticks this GP) idle=***
[   70.910711] rcu:              hardirqs   softirqs   csw/system
[   70.910870] rcu:      number:        0        657            0
[   70.911024] rcu:     cputime:        0          0         2498   ==> 2498(ms)
[   70.911278] rcu:     (t=5001 jiffies g=3677 q=29 ncpus=8)

After:
[   68.046132] rcu: INFO: rcu_preempt self-detected stall on CPU
[   68.046354] rcu:     2-....: (4999 ticks this GP) idle=***
[   68.046628] rcu:              hardirqs   softirqs   csw/system
[   68.046793] rcu:      number:     2498        663            0
[   68.046951] rcu:     cputime:        0          0         2496   ==> 2496(ms)
[   68.047244] rcu:     (t=5000 jiffies g=3825 q=4 ncpus=8)

Fixes: be42f00b73a0 ("rcu: Add RCU stall diagnosis information")
Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
---
 kernel/rcu/tree.c       | 6 +++---
 kernel/rcu/tree.h       | 2 +-
 kernel/rcu/tree_stall.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa5..69205b9fbe4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -937,9 +937,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
 			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
 			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
-			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
-			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
-			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
+			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
+			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
+			rsrp->nr_csw = nr_context_switches_cpu(cpu);
 			rsrp->jiffies = jiffies;
 			rsrp->gp_seq = rdp->gp_seq;
 		}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..1bba2225e744 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -168,7 +168,7 @@ struct rcu_snap_record {
 	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
 	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
 	u64		cputime_system; /* Accumulated cputime of kernel tasks */
-	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
+	u64		nr_hardirqs;	/* Accumulated number of hard irqs */
 	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
 	unsigned long long nr_csw;	/* Accumulated number of task switches */
 	unsigned long   jiffies;	/* Track jiffies value */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 925fcdad5dea..56b21219442b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -435,8 +435,8 @@ static void print_cpu_stat_info(int cpu)
 	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
-	pr_err("\t number: %8ld %10d %12lld\n",
-		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
+	pr_err("\t number: %8lld %10d %12lld\n",
+		kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu) - rsrp->nr_hardirqs,
 		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
 		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
 	pr_err("\tcputime: %8lld %10lld %12lld   ==> %d(ms)\n",
-- 
2.39.3

