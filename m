Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566823446CB
	for <rcu@vger.kernel.org>; Sun, 31 May 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241278; cv=none; b=PEpKe/aR+ZIVDiWrkOoHqARAtyBLoKDDRbMM9Uv9cJ/7ZAfwmE9UqFgj5OLvm0nhnfgNaKX3KfwTc3wTQF7dfPz7ZnKo28SOl5X6WP+4QsNFNxltT5HoEP3+iz6qtSf29RxYfYm964cPOnFAf29zeYOzUdjlbQQ/Pqp8xOaJUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241278; c=relaxed/simple;
	bh=OnyzdsPvb2VVK+jblskJN4wpnGwAr20TCywLCNXdBg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghxbKHf5N4JeDp+fzD4xLVilc+MGKDOQHWvGR8jZirXwaMguCOjoKz+iXtlF8WEl3Q6qo9gUmdmics4RObwg3Md0pPdmwVvOB+MMrFifBnuoKZkABUJ/0l85tSRs37U2CeOOrFjQuoU/o/GoMy5eYB7SPsJO+NONP6GA6Yx0bps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj+mNFBP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj+mNFBP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf125989f2so20475545ad.3
        for <rcu@vger.kernel.org>; Sun, 31 May 2026 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780241276; x=1780846076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dRI8XaV8GqMcpPiucNvllomgPC9XiBTTrB9N8R+RrM=;
        b=fj+mNFBPDV/RgNwfWKwUmL1ceEtrp+yuGIVlMmoIdcWrPkgVfVgy3wZJroLqOHn08c
         E3ibfNnoT8lH4lpHah5k424KmRPlPx7bdq4I3xYSjd82HAlrcJig5wIkfTZS+qw6jxve
         12kVdjhUfnQrW8aMRawAYAmAh/IPN4Y6uDUi2+3YtQCnawCoE3fdzPAMOcB9cKEhcVqe
         9NMwMsuJa+i9F3+OaBjTRwDyyeRwcGsBDeCjzBZkzvnjZFzHjcMHMaWxYed/8/9Ldy39
         WKswFf/15RwRG9XrNU9QQDsUn2jpxwYJtzesSlD+E2MUBXkpGauPY3REqxZTIEpK20Eb
         RhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241276; x=1780846076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dRI8XaV8GqMcpPiucNvllomgPC9XiBTTrB9N8R+RrM=;
        b=Guh+nwNhf2lQu7Ll59/XzSdmw1ZNnqcO9YbKTxOzdfBde5bDNFFdCWWpl0esBH4d1a
         mPNQUtifn1XSb8QHxtpC5/WsY/t1y7R6A39LzMxbyAXh1xHj2HfC+gAqfN1Ou/IvoLwL
         mtNh037XoQufCx1JEMZiEBWVqxP0qOwaIhygoFuxoimHQfMOvULTYblvPYAeUzEuJdXP
         K793zuDaEj0FSqBIdQPhzQXDe7k1cf14Nl9eZkZlyQYi/3b5RRZWXowWIYmpelGa7rBY
         3Ft5XfHmLSrWswMzZQAHh6mlX9DqbrSLLDrpXd5bnXsjmRcGbgCqBBJpIp8KMKt6cpSe
         aWsg==
X-Forwarded-Encrypted: i=1; AFNElJ9xdjUW+C/SzsDCiMvFiecVvRoaLPz41lFI/aSIdNRMQWXD1L8cO91eA6fmExVFeS0Kpmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWONypztCAGEI4eNXWtVIJVxEybI9if3PL1fkUX00qzp3/AwnU
	ka1bVMV2NcDXT43gtiYXApEcnNHKJpPLwvmRniY9MiCs4x9Ad1XQhqDM
X-Gm-Gg: Acq92OHixdPSn/8gQvWBXgK6Ej75PYWPC1vb7UvcCVNSg7MLsiDo38NyugejzQvYpM1
	lNWIqqRwvx7IiKMHMhlf07bQ/D2dvGvNeHngxjlkCPNDIzLDKb42b0KytR9aFuBCRZe4U4A6NbJ
	GLKr4wt8wRqkBBbVFd2AhBLMWzzGXN4UDAuZZzR/Yv1vCAQz0HdnMFnyMoNcjaXeEiZcnI37TdX
	vojTStIol6DPJ6Xi+/1eGFhelSD1NKs5W94vX6lpE46rYgJkGX6IKpE/hiF/edx94HywY1eQcPe
	jFC2coW9+LFIeP85EOJ7+uiEkRVlvwUdCTXSnUxghGN3r3i6Cq9EtSrQ4Sjm0jYMN1ykhR8MgC1
	LTK9VU5qQmXk+5Sv/HLWHuGmF3CTYTJA7My7S7JCybHC6XzdQ+oxmlxH4vjl30ayeKMO5hJMUMT
	EqVLb60nwe5iZZVUEQSQuzP9cxQeyG/Dq6y6VSJPTq24T6mqjb4KS6MbBjK6E05DnK7oixDwanp
	A==
X-Received: by 2002:a17:903:41c9:b0:2c0:c0fa:1659 with SMTP id d9443c01a7336-2c0c0fa18a9mr37485775ad.33.1780241276439;
        Sun, 31 May 2026 08:27:56 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1fc8:a0da:7205:7281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00c13sm83921845ad.28.2026.05.31.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:27:55 -0700 (PDT)
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
Date: Sun, 31 May 2026 23:25:26 +0800
Message-ID: <20260531152646.1206799-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260531152646.1206799-1-yphbchou0911@gmail.com>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
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
index ffad1a90196f..0c37b5fd58b0 100644
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
@@ -5267,7 +5268,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+			   smp_processor_id(), dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
@@ -5286,7 +5288,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 9bb65367f510..2f15a4d3c534 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1509,8 +1509,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.48.1

