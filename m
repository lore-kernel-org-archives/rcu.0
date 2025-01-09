Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F113D246;
	Thu,  9 Jan 2025 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390823; cv=none; b=tmlAbLFTHkd0XlP2E4Ef1Vf3hKrYrJ14XkXf56s81USpAwyMA89Ve7T6xlm7mOTrWp/FmmVasyiddeZXeqDDTtwaFAGfbALqXir/pybB2haLQMucIxTdrhsv2ze2hT/kdrW1QBHpQLnGFo62RrDfVsnh7SSdc7Fjq1aANq8CYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390823; c=relaxed/simple;
	bh=JFKG2kSueeZuNsi9VrBl/iGF8RrkGoBWpcsNDrs5Fys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aY6zlJvkl9bp/nXG+w5rAF/2kx4vavLyLWTNeImYkWfKdFV85wwA153D18/gkIRE/m8RnFGEcgchQCYN+OzbTlF4bOe/ZTiewjpjR9HRCgNt7w8mUz9EwOgBiwNoPyCg8M4r+xCjJ+vHFGzgpQ2OUOyfG1mkYQXi/cZf2BqNECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oza5DoCU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oza5DoCU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so6228005ad.0;
        Wed, 08 Jan 2025 18:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736390821; x=1736995621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDqkd4G4QOhBsB9NgeIRhQI3aJ8Toz/jY2c4WkCox5k=;
        b=Oza5DoCU39AIBQYjVnP8MLHy8Ey6WzHSKFnYh/n2FJkOrThKh+faq8GsL/+HNlzbvE
         QOQhm3lGjM4RQG4ee9lkKtMcKtQR6JbFNQiEO1BGnRe97Jkv+3Wsj+dV2mgg4PDq3nOM
         lgNH+juZEZArcPthbxAzuru83z6Vvb6Xr6/CfWdfHdj2ZseWk6LluMvsJciVv41u06sT
         mUUrfJD8dJ4HmgX9An9uYzl036W2zwuLxYITTQIKFZXXOyqmB65GzeVRdnS8pYTpjyQZ
         V8rckLAMe5CaNLa+1z8cYm5o1oGTVmmQMqBoORfPPAL/PXSFKatTd5HNNByVUXXQNL1D
         GXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390821; x=1736995621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDqkd4G4QOhBsB9NgeIRhQI3aJ8Toz/jY2c4WkCox5k=;
        b=Zu2IMNhgabL/gFH6SBrdEHcZixklNcadk0ceomQeWURrW/eNGnIQtgsefCs3cr/m2o
         pntPYNOs+hdIwSt5jqDwtqKoE78SSQ+bNdc0G7m3Vx4CUUSWPewkAWVbsnMTjmeRvZ4D
         w3+EOYzx0xd4tczagNjv5LPcFF9K+sWI01l+Usv7aTUdOAjJTiIGX+AyGlzXELsBjzN5
         COjVVItCM0+Kq7QfEYHmNli/W/aXXnoaJq6kkdS1MCUC5dU3A7AvIfsHrZp6tK39JyzQ
         W/nsEzG5vzM5pGffMFHJlBu56ODrMLOLKijIhdShfmJL/QqeF8e34Vrt2B659qg5ldrx
         wWUg==
X-Forwarded-Encrypted: i=1; AJvYcCVPoR/NgJnlSohvTCzLUXEJBxsHI+RBpV4mNOobFCX1PNRmnOE8asoK0V6Iwcz89RGMQHZo/S8uihEMpls=@vger.kernel.org, AJvYcCW/768rhrb89KYK9/Hs5eYGUzUhOSvg+8eKHlYv/8GxahFJpYaMTqNRM0MUchP5PmYowyW1@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3wiXWRbLyZ4et9RIPwhkyS1CFyRICsmx4T7jTl6iuV9OBlD2
	oLr5jsDzm6rD39CLvY57+T0hAhNEVds3Shm0XlE5VkIzSvUY8io6
X-Gm-Gg: ASbGncv3hTyQ79lh9EwQLoTMCfv60IaQZ9lcxq4K5SClpRDSn0rYF9u8GR4OHdx+lWU
	SN3aoTh4jRQzqWWM5tp3JPPUvMIGt1XchjomRYq6UnZ9VjSVmG7s1gPSqY9j9YMRNYf/45Cq8m2
	3DB+KszqL8hymmmeclOQZ2jWB6zu3mR+eMaqhVcUs/8LRU7usgrAkHHLJX9PVrD0CYvw8Jd2bn6
	VzelEuBzmc4P6HEWrZxnh6Gd673dehgSLxibRgkIFB0ND8PGa54prjIL0b3j1k/ozk3TSKLzL66
	blyi6F2hRLtCijapy3ooiuzG7yc=
X-Google-Smtp-Source: AGHT+IH0/mCWnElNXMjHoHOflPue3yMKEszfgdFTi/EgbEYD8hbVTS81CcmhA/EVUOngunReCHVYuw==
X-Received: by 2002:a17:902:ecd1:b0:20c:9821:69af with SMTP id d9443c01a7336-21a83fd90f1mr65988385ad.45.1736390820856;
        Wed, 08 Jan 2025 18:47:00 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bebfsm1528225ad.6.2025.01.08.18.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:47:00 -0800 (PST)
From: Yongliang Gao <leonylgao@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	thunder.leizhen@huawei.com
Cc: frankjpliu@tencent.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture
Date: Thu,  9 Jan 2025 10:46:52 +0800
Message-Id: <20250109024652.1342595-1-leonylgao@gmail.com>
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

---
Changes from v1:
- Fix compilation error when using arm64-allnoconfig/riscv-randconfig. [kernel test robot]
- Link to v1: https://lore.kernel.org/r/20250108065716.2888148-1-leonylgao%40gmail.com
---

Fixes: be42f00b73a0 ("rcu: Add RCU stall diagnosis information")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp@intel.com/
Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
---
 kernel/rcu/tree.c       | 10 +++++++---
 kernel/rcu/tree.h       |  2 +-
 kernel/rcu/tree_stall.h |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa5..cef8859857fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -802,6 +802,10 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
 	return 0;
 }
 
+#ifndef arch_irq_stat_cpu
+#define arch_irq_stat_cpu(cpu) 0
+#endif
+
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
@@ -937,9 +941,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
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

