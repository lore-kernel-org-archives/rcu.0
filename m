Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298D37204E
	for <rcu@vger.kernel.org>; Thu, 21 May 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380212; cv=none; b=e1u7O6bGEgumGxmsNdMHQRsPp98xxAw2Cg9zQOA65jnqpLWKLoTVis4SRx8pBNQ/ewt1M2D1c0bF0Ad1O8qgh2eEKU7+YigSyxDoAUWgHo+SwX/FbN2h48/bLyxje8eZfYgo2vYplLJJ19LLKLeJCJBuiTdXrBbj5oi6NmHe5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380212; c=relaxed/simple;
	bh=gfn4n8kLvSvmBLrFa7nK9KJ0o4ezPxYyfGoVBhhjmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAV4a2E8ODw3iMfYB1exZapuoCeT2/5MD90SxMdgJtkKC8+/YsnpFpq/Q2KbKBkvUIoT4jRMb9MmelFC3aM5hmpdvv+eziSTJPfNunetZ9L6IO8MyD/mseNAxjKX1SHYUXHzWT8b/fMMVH1QXDQM/0aHSwNSDS8BIbVDVmcrlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfVOUFax; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfVOUFax"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-838d0b7c950so4520744b3a.3
        for <rcu@vger.kernel.org>; Thu, 21 May 2026 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779380211; x=1779985011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=TfVOUFaxpgYJTSWwh++oh3WZxwlTI0H/Ju/UUOEsNkT25jWp6PuXzAhxSKKaX0Lq6q
         XNSwG5j0mTOACIPYVgYak0ZApmvEwWEVb82cNJVKe34paxKPIHpcetyl1KFrc0l2DS4b
         w1OJw8atJxfNhoMENuuY43yd8GQYIa33dlDZ+H+ouQDB/G6wpgC/sgBFF1FcQjZddJDf
         AFhi/LO3qaW26AlrlNuAXFTh0xTqQMTioyJqxH1uP9KLQ1evcDxApNfhWCckgmY3J9Zh
         it/QqNdf7r2DLckdVJYPbp1wx0pp379BfIuhOZ6zMOxipfZqloXJkz5n6NZ+l6MJEMBp
         R5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380211; x=1779985011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=PxTBaERVWJLDnPlHveI8W3StTLsMKbOQ/zl0JoUrDyA1Hx0ta6258GJ4goFmZb1rcA
         28kzAyRQZ7McZqie0XZJCEXF3M+8LJvItABXML8v7iE7ROMzJjAUUTZNU8DAWtgUlRwx
         23wNM6sQQdqU9dTDbox5Klg9yBiG2eSCxgkBA1ZxohYLVuVR8tBcIVddctPQmDVsbUSc
         EKPu287gigS6d3P6rFnDP3CZSpd53YxfaPDn7TSSo2U7DDuYOfcb0/Vvm3CrDjQB4hSi
         A5/X7jYmqT7PabQz7dFaJDnVsdH4d3dcT4evf1UclauAz7RoXAvbn0+1QpYuR1a/Ohvy
         g//w==
X-Forwarded-Encrypted: i=1; AFNElJ/i+ulOXyUkbXihgHbHB0GqfDK9gmW83f0EZf/+raueNAgCiw2fxo2aeEaD0rCCMgzssYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc49z32gq9KObMB5Pcl0UJ6AB+yAYCkCKZ+zRi0DsirovmQFj8
	6+IRRrYXuIcnu+UgluuMFilMjtewEeSRrTIaDDZ4MY/6/35ovbRODjhLlSPT5Q==
X-Gm-Gg: Acq92OFo3Lq3fYYALvJcmRvob7Lw4bw5VXiiWEM+v8dV+DZ5AeqYsrJCHofM3REsvzI
	P6Aivqeykw4ppwJLLZ7iHiGORNLPB0ABivDtdDYmCLdylOsZkPGxWVKNZCTwx9VafDCVybZOcy4
	0LLQQUm1MfI5yU4DZk9bhvpIQFH1fgpSZ1n99re2H7BIOuAkJTlP9njTMhnw2V49dCjBUgqYk5/
	w9/MIpLcb+u8XfAPXdgnONMCsf6zu7DDLLH1z5Q89fHftqSfJsSlKo+ft3lIH6lbthdbXbWymHb
	2o7r+dU2SSOixjsTC4B+2u2dKtGTzhwuGa3Ky979vQZfpEM44VKnBz/6JMOSWkuLASAtd9HuSW0
	M5x23bZgFUz5mF8nPdt4C7jcXrQ0PYNO1ImP2ZMHCLZOYSR7bqcTuWCHhtAtXwTZmhwJz4ibT8g
	neWPwUL0Yrd1fdt4ljMvD6zykeKmUI4fKg3RMuaDo45YC/IeXyv1IC
X-Received: by 2002:a05:6a00:430d:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-8415f0e87ebmr18418b3a.10.1779380210713;
        Thu, 21 May 2026 09:16:50 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:431c:aecf:2272:9090])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549c4806sm1729493b3a.6.2026.05.21.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:16:50 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Fri, 22 May 2026 00:16:09 +0800
Message-ID: <20260521161636.1893894-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260521161636.1893894-1-yphbchou0911@gmail.com>
References: <20260521161636.1893894-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
for two paths:

- scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
  irq_work may run elsewhere. Pass the local cpu explicitly.
- scx_rcu_cpu_stall() records the detector CPU rather than the stalled
  one. Pass -1 for now. The next patch fixes this properly.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c          | 12 +++++++-----
 kernel/sched/ext_internal.h |  2 --
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9c458552d14f..22b1356aa4eb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5141,6 +5141,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 
 /**
  * handle_lockup - sched_ext common lockup handler
+ * @exit_cpu: CPU to record in exit_info. Pass the stalled/hung CPU, not current.
  * @fmt: format string
  *
  * Called on system stall or lockup condition and initiates abort of sched_ext
@@ -5150,7 +5151,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
  * resolve the lockup. %false if sched_ext is not enabled or abort was already
  * initiated by someone else.
  */
-static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
+static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
@@ -5166,7 +5167,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		ret = scx_verror(sch, fmt, args);
+		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
 		va_end(args);
 		return ret;
 	default:
@@ -5188,7 +5189,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  */
 bool scx_rcu_cpu_stall(void)
 {
-	return handle_lockup("RCU CPU stall detected!");
+	return handle_lockup(-1, "RCU CPU stall detected!");
 }
 
 /**
@@ -5203,7 +5204,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+			   smp_processor_id(), dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
@@ -5222,7 +5224,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 7258aea94b9f..3ccfea06cba0 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1490,8 +1490,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.48.1

