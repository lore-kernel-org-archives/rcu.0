Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101803672AC
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654160; cv=none; b=OQhII5oJG+QhjqkH/IZ9sIHmutfJ/CYit28nMHWwotbzb87vrdY1eE34SK6AO5+l/BR8NcyWMwD0nZYW8wRhjnDcHCKUe6Hi588ACdWWhe1hlu3gqmizClHVrJDMnGE7vkMa75wYoVfqi2jRzJad1gkW4WSjzFiScnHvenCJtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654160; c=relaxed/simple;
	bh=XLXzIgc0ems38hTXhytSCLWNSTJ6/lnczDaOsWqzk80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEbRTJA2ONfoIJ3gXDTwUgyhkmiSRjavBS1A2ftbXKeolQQtxVXjyttyTDpO8LZukmCBIrMTzyBjSErWLXgApPsSf7JrsOkpDx2OLHErFIMLiP8JOki7TxGopv1TXXiFYr8zcKVIRO00DPMGKmleDco33MLCj5G/5dM2QGPmkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAwlXME/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAwlXME/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so3686735ad.1
        for <rcu@vger.kernel.org>; Thu, 09 Jul 2026 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654158; x=1784258958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foKf2OzW/IJk9qSRNXtj3QHT8NO8zJPjssJk6y4CFnQ=;
        b=FAwlXME/ZU8CIggt766MxOWFrtD1DEAq+1QJV89HtJ/4qNAdyqlrf/mhagoGSGEkRn
         simFefKR9u1kk0tTchJvpGxeImcfcMQ+B3g9eTnnkDEH9XXJLiKeNBiBoFJhpiNoTROV
         JPfNXiOvjRdsXCNgbxO6KYKDP20enDacVWXEzfyJzG3eTFqBg1o+IgDB+qgBK4SpH1bV
         yjUrAOOQSD0c67wB5qVWQYidOMm3XPFPFvlrZxewjKtLcSQg5kZIti0sNZqwA4jlgV1T
         5fy1b02DQ9S97U8n8/oJN3AhnVlmiLR1Dx9eL1uSHP/O9VPhJb8mU8FiWzuxGLj7+ByE
         oXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654158; x=1784258958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foKf2OzW/IJk9qSRNXtj3QHT8NO8zJPjssJk6y4CFnQ=;
        b=aQfeMPymhcBAMI6Hu+Nqdz2tvORPhqTXt0VYtDEN+AGUY9V6Nra7n1ejX/ZfoT7VIH
         dkc4IjUNyaPwba/uXPY2qcRg08F94k6GQluIWnp9SOC1uza1FfSk4iID6UqMk0UxyrK0
         DaQWFzTU43bBr1T+3xRZOECr9PxzYnTr368TGeE8FC689DxnlZxWnABnDuw2Ltclp4dz
         H1XYy55LFKP2pvZ7NhKwA1MRwSBL9CasrfTSdX7bo0WtMHERuIJlYx2W6pow5Ri5SPNG
         +tpknIBV6NCH8c5fGrwIwurO0rMs/vu2tuGvIRbKwvees0zGbo2aBgvbhpk6mp51GIZi
         NUjA==
X-Forwarded-Encrypted: i=1; AHgh+Ro60viJF3m3N+nKBxdfoRENFzNeJc9dvVPHypPZd9YaISNJU8Dnf5KYsrsmSB/dDZ5EtMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1pguzCipJmI9GmIvUAz3wELjLj4R1rnHpTk5w3jN4ieM8MN3
	7SCtisLVeaf5MIqFLhnYCWvZCjnkmmrLgDeGz00uf2c2PVI5TPBX5FGS
X-Gm-Gg: AfdE7cm/DD5Mj1bakZ5rQXUGZi7v2cENub8Om15h6ePy9tZEbdJh7t2XeHH/wtMkvXA
	y7EwnblvXgXfJZIZogAe/5y4uIVuZ6i43Oj6JkLq+m9lMFXjt1UIOtmyOGOlisnxdxx4HRAJ1UO
	Gowt3QWKtYjpHUYu29byAkgLALBInzKtVHwjEUhsLVTYSeP/lkRWHwYz/jZMCLzhiFeNQrdNxW3
	h8GSoFFuDZCzG99d0kym9zXCYfZ/oLXJra8q4mxZBl0rm0HjMczNUmUX+OajMzFOwDl6zGEik6C
	WL6jPH0w5719ZCaReySzv7aDSJrX0uV+1QAXr29nYDiTp4lqSuqAT4xBMCWb8x0xutHu/tIVYCK
	SA/O1iF71MdQNzit/kpb24AQpSWO2PpcDzdyQ2nBhdzazoUeQYjPo2y/y09tcC+7nElOaOtpW0T
	eRGGZELMOKzjM=
X-Received: by 2002:a17:902:f78b:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2ce6d4a5c71mr56853935ad.38.1783654158257;
        Thu, 09 Jul 2026 20:29:18 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:17 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:17 +0800
Subject: [PATCH v4 06/11] watchdog: sync watchdog_cpumask with
 HK_TYPE_KERNEL_NOISE on isolation
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-6-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

The watchdog is initialized at boot to run on all housekeeping CPUs
(HK_TYPE_KERNEL_NOISE). When a cpuset isolated partition removes CPUs
from that mask at runtime, watchdog continues running on those CPUs
because nothing updates watchdog_cpumask.

Save the boot-time watchdog_cpumask as watchdog_cpumask_boot, which
captures the user's intended coverage (possibly narrowed via kernel
parameter or sysctl) before any runtime isolation. Introduce
lockup_detector_hk_update() which intersects this boot snapshot with
the current HK_TYPE_KERNEL_NOISE mask and reconfigures the detector.
This ensures that isolated CPUs are excluded while honoring any
manual narrowing the admin applied at or after boot.

lockup_detector_hk_update() snapshots the RCU-protected housekeeping
mask under rcu_read_lock(), then updates watchdog_cpumask and calls
__lockup_detector_reconfigure() under watchdog_mutex, matching the
same locking discipline used by proc_watchdog_cpumask().

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index bc1162895f355..0bbe562de67b7 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -37,6 +37,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
+static inline void lockup_detector_hk_update(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -120,6 +121,7 @@ void watchdog_hardlockup_enable(unsigned int cpu);
 void watchdog_hardlockup_disable(unsigned int cpu);
 
 void lockup_detector_reconfigure(void);
+void lockup_detector_hk_update(void);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
 void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index c18c3e9781d7b..26463f6d3a39d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -53,6 +53,8 @@ static int __read_mostly watchdog_hardlockup_available;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
+/* Boot snapshot: user's intended watchdog mask before any runtime isolation. */
+static struct cpumask watchdog_cpumask_boot __ro_after_init;
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 
@@ -1348,6 +1350,27 @@ static void __init lockup_detector_delay_init(struct work_struct *work)
 	lockup_detector_setup();
 }
 
+void lockup_detector_hk_update(void)
+{
+	cpumask_var_t new_mask;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return;
+
+	rcu_read_lock();
+	cpumask_and(new_mask, &watchdog_cpumask_boot,
+		    housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE));
+	rcu_read_unlock();
+
+	mutex_lock(&watchdog_mutex);
+	cpumask_copy(&watchdog_cpumask, new_mask);
+	__lockup_detector_reconfigure(false);
+	mutex_unlock(&watchdog_mutex);
+
+	free_cpumask_var(new_mask);
+}
+EXPORT_SYMBOL_GPL(lockup_detector_hk_update);
+
 /*
  * lockup_detector_retry_init - retry init lockup detector if possible.
  *
@@ -1390,6 +1413,7 @@ void __init lockup_detector_init(void)
 
 	cpumask_copy(&watchdog_cpumask,
 		     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	cpumask_copy(&watchdog_cpumask_boot, &watchdog_cpumask);
 
 	if (!watchdog_hardlockup_probe())
 		watchdog_hardlockup_available = true;

-- 
2.43.0

