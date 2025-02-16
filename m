Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B43156F54;
	Sun, 16 Feb 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695321; cv=none; b=eAx2JIvEebx1gOxcKpS8b97DxhlkYuAQFfKy1CgaGDVCb9V2wqYa8wfmBJlWU8tSdSRS/CwnScvw7b5NgX03HeCk9E7S9M7Ok/HkZTguwngc6s/hXSjTms8k9N0DpSwA0WAVxu33zSceXEl44WaP3rV8ogqjNY/xbnk560Mq4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695321; c=relaxed/simple;
	bh=Vskc2wwVqA5Ms7gkLQLcg3MEV8RCfdMgVZ3QWgJZO90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6fQNz7cIc1mcModLLxn6yFBbCP0dmrFe+1Owiarp6VwQp3F7eBPKd+GZsB8sxvECt5IkbaUQBFZVItK5h/MXMZJirCsi9xz1HpRpxQmBkcy3gT72LXeG4N1eco2gecyfAiGVyXpb8ETHp4+MHQIAd3dsztrm6cq5Cvo8czTRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4TwHDBp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4TwHDBp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d39a5627so49610245ad.1;
        Sun, 16 Feb 2025 00:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739695320; x=1740300120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uo8I2VTpZsm/M0eSKbaSlNCrIf12xCPXDdrqy9nBvo=;
        b=P4TwHDBpeh6M7610/9FzvPiOeoeLOR3PgXmVV1tPALgZrMvLancGcIp8hPyVB/o29W
         uDc/nngDkJX7EDbYMiIRyCf4WVg29QaqLDprmD4IA3OOfFE8FO4Y7F7jB30hSM50D+hp
         OiBGNLhC1TtSEvVyUGuyPwdt9TqF/lw6riG6Wzh5BdkgYuOyQjRyBxWUJ/+tZqPrQJa1
         CJOutdmi7uMHQmSi3L8DdtJcVWDWTfH5kY/iB+YkjfdPkEIoORlhagWlVLhAMcnz+nAa
         GTEek2t06T8xKWrk0X9OSIOjwbuOz3rkAPwnVIQ9wzIJzStFiwkOF9dGl8g0Eg8YrZ/L
         gLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739695320; x=1740300120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Uo8I2VTpZsm/M0eSKbaSlNCrIf12xCPXDdrqy9nBvo=;
        b=Poxe4B31jRopDecnkIQkqljbPC1DMsCrfahT2T/VfflBwwvjFWwB7lptq0Y/4R9qvD
         oN+eJ3jVN/B5RikuVdO/u7lcBZZn7dNAMdAJWOsJkb0wqce1fnQQMnOxzk6FJVqg6K6s
         5ASBbkDgxrXYycL3u5xUGJVg4VSGATYwWW436thqQQHXLnbYYgc/T5+FeYzKkOI3XmZt
         IxxN8FmSzOAlx1iKEeexJFHlAdc53lKpgJB+t/2YHd7I5vKL8iTD2K+F55E4RZKJMI69
         XUpUvp0wycf+IE/XgIQsZ5lYBvVFIJjCp34dKpysPAVbPjYbjE7nYwxxu+4fl+qmXNqK
         7SVw==
X-Forwarded-Encrypted: i=1; AJvYcCVizOdCUhDK68JpDKOzK7e8b7jMOAGONhmR6BQFIwM4qrUPkqpPheDICWWkrQ+6TG4FBORt@vger.kernel.org, AJvYcCWVA8+rKcnz7MzHukU6et8B3aZlSWM/hwqWB3Cm+2MhbG0u2gxy7AYUMrXmIGkpstgOLvxkgT4rdFRJoJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWu0w+Bo4Fx4jEO1k4Sa8HwrJRHgKBq/v4X+LmRfx1YTa5YoQF
	uFojMRwemKy+hjtWZqFQCZS1TCLBJBcOSvVO3zMpcCmD9KtkMSQxSBhz9cC0
X-Gm-Gg: ASbGncsi64Vq0gAmEhJPifIjbrYnxT4jlhOL1+ot7ixcqQE8+YGWtL/HT3/HgBEFC53
	l1RCHuTT1VZTGrLaxokbKA3hhNcCVORQLM5qlrRmkIUAHvc9RH6mvNJFk1C54zLnxtw1+ryMQhv
	DsFlJYsi9RG+pLZRfcJyckFq0rZAxVvFUIdlZ877WeJ9OVd+AMbHZWaGJYbAqoWgymnBpbGxe7K
	ty0bsm5KDOyantG5h6iA//L6wHwN0tdxQp5hJOmAqEiqji/m+rkplirtfUJlN/7HXMh3bd9pvh0
	q1gj7ynoaIk1nlfFw88WPczHQrJsDN83X1vyduk1qGbmPXx7Zv7NGhv4fyr0Hw==
X-Google-Smtp-Source: AGHT+IFWSv7o5UfJZsr45iFaTsnSGgjOJ/QEPD95j0N9PVTAsh9E6EiQ4ySP/8hifcKlUKOW3csoJg==
X-Received: by 2002:a17:902:d4cd:b0:221:2f4:5446 with SMTP id d9443c01a7336-22104048145mr89810585ad.25.1739695319630;
        Sun, 16 Feb 2025 00:41:59 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349634sm52681805ad.31.2025.02.16.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 00:41:59 -0800 (PST)
From: Yongliang Gao <leonylgao@gmail.com>
To: Neeraj.Upadhyay@amd.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	thunder.leizhen@huawei.com
Cc: frankjpliu@tencent.com,
	kernelxing@tencent.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture
Date: Sun, 16 Feb 2025 16:41:09 +0800
Message-Id: <20250216084109.3109837-1-leonylgao@gmail.com>
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp@intel.com/
Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

---
Changes from v2:
- Add Reviewed-by 'Neeraj Upadhyay' information
- Link to v2: https://lore.kernel.org/all/20250109024652.1342595-1-leonylgao@gmail.com
Changes from v1:
- Fix compilation error when using arm64-allnoconfig/riscv-randconfig. [kernel test robot]
- Link to v1: https://lore.kernel.org/r/20250108065716.2888148-1-leonylgao%40gmail.com
---
---
 kernel/rcu/tree.c       | 10 +++++++---
 kernel/rcu/tree.h       |  2 +-
 kernel/rcu/tree_stall.h |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed14..a0dab5923d03 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -781,6 +781,10 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
 	return 0;
 }
 
+#ifndef arch_irq_stat_cpu
+#define arch_irq_stat_cpu(cpu) 0
+#endif
+
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
@@ -916,9 +920,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
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

