Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745B1DDC28
	for <rcu@vger.kernel.org>; Mon, 18 May 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110012; cv=none; b=sVPZmkvd97OMevhuXVai9PqLW7uR+VGM7ssqGHdos1PMLfaj90vq5Lkw970phJrc9sDQjrVKvYc5P7hdmbMfZSKtfr6UqeDGXfPmUBc6qCJ62194K5fQ3pL5tddtDUwxeyB8RhEbBjSa0VzEhC7T8U97On80cTxqXaN0e+3R6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110012; c=relaxed/simple;
	bh=gfn4n8kLvSvmBLrFa7nK9KJ0o4ezPxYyfGoVBhhjmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGIMcqKzDR0QbCoYw1fBbs2oG7pVHruLO5iRdPWXYjuLrjNB0kYVA15ul2pGQze75G/C87/a8R696EtpOu8c6QXkBZeiLGfWUBuNOo8UqFfoon2T2cLkIgV7p9STBiZKPeHypY67HtZG0cwSeNpFPFMh5vIa+qfvoYm8JEKXFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTXFhURF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTXFhURF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so1069366a91.1
        for <rcu@vger.kernel.org>; Mon, 18 May 2026 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110010; x=1779714810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=WTXFhURFD47w1ZjUJ2hsaBJbPciwpSc1xgwigdalmVQWgsaHo0slie/ZLPNU08NZxm
         SlL2xO47AecBRiXrzcqUz5pxZewRQwycLvGKwi/xm6tA3ozLPbj7/yMDUtxSzYzxTFNc
         NEI5KpYGayMewQ8G1SI+HpQaAlYKfPKXwXVwgz/SYOac73KCChCnmHh7qQRtpwZlh0o2
         98YZeURfkzppkIGDV7UPb+VSudXmAdrCqGeJhkK+Uv721QzfZPx56sXKqBdGUWrU3tIs
         wyNoJtvMyzselEZr/odYMfd7EwAbxamVMLhziRnUR8eP14XivUlciBuFBbxTv4iPLah8
         TxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110010; x=1779714810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=jQj3rpqhn14MZfUj2h4HHlmid/lWA4pbRMqgHru5D6aVXQpve+khxFUhYl9F1tRz/t
         fHH7UQtDhpeQoLGWvqIBgT0NMydshKH9lGK30CMCwgoPEzMhNEUmnK16iWC3u+5HWQ5v
         UZksQRlHE11TWfSbRRQhoy+jCB/d9GgguWSsj2yO/TozcjQkxm1c27P8n6wjDfCih96/
         xDgP3dOKwE6IINwmCz2k3c5qDKdszHMjrlqOMAmj6F0xlWjAUO6KxYK5BIs4OnDySd9I
         bzBlXq+tUpH+I0hB5XFIq8pZS1CqTtca4tfZ/NP4FCLuwU+Tm2MGuSZI1ODCE8rwtFLG
         xukQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Tly3kUOBFB0Bpf9ezGC2ptFNHGUMondRs6mhhWAS0k0b0JT6Kg0joTFOvzzlNnaJCjH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCDNQqaIxe6XLv6pa6m95vcpFjS2oBOOK91jifnn4/DuERYl/
	YCG3Yf6/aJ+IDlEof1Otqllu/Mn+02DUoR4RTT29J+EX9xxh7uZgCsmq
X-Gm-Gg: Acq92OGqWr8eD1zm46vhG0MTbP7MahMZb9FxTjgP6y/q1ZinrL7J6kkWZyDXzOcI7L1
	A0E1cIbAxMGKnySqkT0oPNhKvUrNrn6QHW2lvc6MR+TEW9LSnMyfYG8zTm4It8bLSSqrb8GO8aS
	8UW6YAfN5caBQjTL6YExF+Ws3MEE3Toqg8s3eG1iHtcffdFUtiHOE/AOmTs3oGfos0MPf5fBE8Z
	CB6J0OyqOiC489kSREiY4KSqI0X+2idbmdbjQLhES5VcJiw2jnip3BOnDD0b3grBH/fgX/XVRKb
	1Rl3CWX4sUJiPh5TiuPSRYOlrut8heiTU4gwfrQW6dd7izzMCciG28jGxGPHFXlqIG+JfPo9zGJ
	A+FLNAw8ieK3kyWgFx9UQXudITbmCMtYId5neMBDpRgvsmVYr0KV1iNbmRMCKkYuYZZ4B+KQ/6j
	5dEiIxs2crWf75nn4FeYyETevu9k7XYczQYg85IWw4g/XGRDEIA3aC
X-Received: by 2002:a17:90b:1d83:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-36951889fe9mr13316303a91.1.1779110010242;
        Mon, 18 May 2026 06:13:30 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c31b:5187:c514:ac40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm11241781a91.4.2026.05.18.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:29 -0700 (PDT)
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
Subject: [PATCH v3 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Mon, 18 May 2026 21:11:48 +0800
Message-ID: <20260518131311.1170786-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518131311.1170786-1-yphbchou0911@gmail.com>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
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

