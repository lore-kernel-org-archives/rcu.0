Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42530339863
	for <rcu@vger.kernel.org>; Wed, 10 Jun 2026 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105261; cv=none; b=u8Qp6yaY7i4KnZPtvCyXAPlr85TQwPpVcWTxicvr7nriImlIuYbGKYEOPRf4QUdCUIrnkdXcsSbh8/bENguzSqAq3+xhUOpdXoPVBjsRw5nK1WVE6hd+wFL/tW/9ROYhDPJI2aUdAWkpOkqOz4DmaoChdvjDx45ultYpqji1n3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105261; c=relaxed/simple;
	bh=Y7Sgz/nq2ViACapjh7GV0aYqHtnpgNTDFxg/Xs8lRDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNv/FQG6zZ2FkGIGKzaHoJWyqz+k2vGk2fljzYhpGiPRSXd/sJsputi6+n7qglRCGvYt5VB+1RHwjkvtqTvXAiJ8Dtb1n7O6TOp/avJpB2nf2zYYdDrVgMZp4MAbLktsbOMwxCfuo9Ykg4VeOJXXBC+RUeY6WHovaiHNTNNrEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDebazOg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDebazOg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so42343745ad.1
        for <rcu@vger.kernel.org>; Wed, 10 Jun 2026 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105260; x=1781710060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KwLbbL/2J/oqKV1VGplian3GK8W402eH0sQ7ZlH2PE=;
        b=EDebazOg4ti09xQVklYvy0kqH7UC0vPaYe+u/hWTUJkJRdmlLykqvzEpQQD1+luL/e
         xxuQBa2Q1Etnzq8k0laL4NiwBhWQHmhSeDKH/9nUdjo4UIgatzh1Qxm0ZhV7TYA0k2ab
         KPFVmzbDgIG5eHJhoupdm6VDOixN/FGjA20oSIq3CLEnNJxjP+735cMGqt3yNLnBfFYu
         Siizd//Dezbv2/+yZTryJlwvAhWbZxHTkIcKyYphVI2Lx9j7NJyzw3AVho4d22DNufTd
         t7zGQodrLxA3ULiA/CBbMsgVOKKDi1X1DxGDLueB2jknCjF7dkCmJHOtVQC5AeMM1ZJl
         d+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105260; x=1781710060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KwLbbL/2J/oqKV1VGplian3GK8W402eH0sQ7ZlH2PE=;
        b=EchBXITGWBV/NpAlB1EhwwkvXUsaPOG82/aZ0EdZ4RBtyDv7/FNsyHvMs1OHqqmnze
         BY1FQd7i9XZyA1GrNrfdMDvqxn+voW4foU16kZST0mk10MTbtMA4oGLbVU0VotaXwuSV
         iYCrKVOqXM1/evOi1C5fLiGROsDmcZtcC0iTW4X2dh8T7taMjTzJ+UotF5W28bGTmAhI
         IANC/ib22tVmfFkdif9li+E1QDhD9PnAocXEbfpRvl2cRSZpvu7M8Uh7iLkjnFiCFhVa
         PIW8tz1QIG0XmPXU9AAdyMbiJxoJ7eHNmS6KtYgBHWjA9xzRCONJNMK3Ynf+2NTZCA9G
         fxyA==
X-Forwarded-Encrypted: i=1; AFNElJ+mlHpGq329ZRPFWpVztAI9OWt1xVz9vZHsS6PO1q66zLE8U1EYq1m4DmQ9fCL2PNR24S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICd3dUMyE4aDtbRgwu+UcRL0Zu7D80DNuTqpKJTwvF2yXrnmX
	012ukpkAT040s1xXKDb+UQi7rjucFbdX2dVIJXe6pyxYcVSJ97bdY329
X-Gm-Gg: Acq92OG24snHfA+F9fA2jl4W4KRC2Lgf3/lcOmBOgi8W8EYhqeeElLZ1f8joBKXHcOP
	pL00zJ3pVjpBILmBfDC5VNPQeneeKMB0joYPr9H70/5ZRq/WyQyKMQeJ73UbCYrFrcK0iuMv8FV
	+edJFzAq8v1kkJH8MCgilgaVWFHmW/+nlpxKnUMo0uiINePhB4wq9M+7XDcXJa+bzoaSuU5HDSk
	sH6uzAlm7eui3f23iMG48RgdwaC0HAqSCEg7puQ9vxPwNH17V1SRaxwbJnsl4zcjFNdkc8s719w
	4oUHh7WUUlETeq0A4VG/wII1oIhaXZWuhepztOZFwzB4N84PHqm5bOKg3fizA7EbYOVwA6ggbe+
	6N2iCAqw9cbZtZKQAoBSqNXbRlLpFjCUiJgXmA4+eojtooIdRzT6Bhau5X7jwU20KSMkSkx4rGX
	9DsuTdhy3Qfhy6oL/ePI4Ee2dB7mUoDa8M8KIIxDiDAtzG6LV7xlPd/j5P1cPv8eEpVOPRgNqwh
	HF2qpbmUKommqVgTCur0ERAIHI=
X-Received: by 2002:a17:903:1209:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2c1ec80a4eamr201655695ad.10.1781105259460;
        Wed, 10 Jun 2026 08:27:39 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-226-225-196.dynamic-ip.hinet.net. [36.226.225.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm253335795ad.47.2026.06.10.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:27:39 -0700 (PDT)
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
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Wed, 10 Jun 2026 23:26:55 +0800
Message-ID: <20260610152717.15905-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610152717.15905-1-yphbchou0911@gmail.com>
References: <20260610152717.15905-1-yphbchou0911@gmail.com>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          | 15 +++++++++------
 kernel/sched/ext_internal.h |  2 --
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8f82407330ae..161a7a2ca80f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5205,6 +5205,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 
 /**
  * handle_lockup - sched_ext common lockup handler
+ * @exit_cpu: CPU to record in exit_info. Pass the stalled/hung CPU, not current.
  * @fmt: format string
  *
  * Called on system stall or lockup condition and initiates abort of sched_ext
@@ -5214,7 +5215,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
  * resolve the lockup. %false if sched_ext is not enabled or abort was already
  * initiated by someone else.
  */
-static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
+static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
@@ -5230,7 +5231,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		ret = scx_verror(sch, fmt, args);
+		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
 		va_end(args);
 		return ret;
 	default:
@@ -5252,7 +5253,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  */
 bool scx_rcu_cpu_stall(void)
 {
-	return handle_lockup("RCU CPU stall detected!");
+	return handle_lockup(-1, "RCU CPU stall detected!");
 }
 
 /**
@@ -5267,11 +5268,13 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	int cpu = smp_processor_id();
+
+	if (!handle_lockup(cpu, "soft lockup - CPU %d stuck for %us", cpu, dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
-			smp_processor_id(), dur_s);
+			cpu, dur_s);
 }
 
 /*
@@ -5286,7 +5289,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b04701190b23..bddfa59f1b75 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1535,8 +1535,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.43.0

