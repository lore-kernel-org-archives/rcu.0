Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876AD4A23
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211092; cv=none; b=BdNHJERwRaIa9sKUaNimWOXe4vAtiG/yWju+cpzTzuBGIhdDd3lj6nxg+5DotkpEsZYhcmCMXGL3bInp/6oCdwlJesE3U8gmlBFh2Umpjs6bx+ts29RBzqfody+GJLSz8R5YGg9pdzn4T/2GsFHEZ+w5XiRLPppC5h0G+B7ECeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211092; c=relaxed/simple;
	bh=gfn4n8kLvSvmBLrFa7nK9KJ0o4ezPxYyfGoVBhhjmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1w17cM8QbOD7KG9xxFdxd2jMQpUfbb7caSPUNLD9PQIurW957VK09NhdAviuh7AbkTRG6pxM+5mkzfrTLCHa7u6sPdRdr5opVqpmIltH/qDkBK3KmyOhIMC/ilkKZNEcnfUUQMUj9cLcECUA8COCbZsNcxS4RSfTBuk1rfP2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly8U2tFW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly8U2tFW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so3529696a91.0
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211090; x=1779815890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=ly8U2tFWl0f3pvi0i5VYef34jD6AYC/z/DayAV2HzEJTKoIaf59WqmEheRPrfi6BuI
         PtZclOT6uTiJRpBG6oS3NgkcNowaAmEN8WZ1dVYY6mNdjFqD/1TJuIFKFL2dOGc8GxKa
         PQPVPnea/5ZVwZnDH6YVWtLLifh3V0dNAV0SY9rDjeJ7apUUOZ8TPykeFsTGgpPgZQgv
         x83u9V47n3c9J8MxKEV84ZzBeLBJEAksGJ7o1E9x9+vLiVmP1JQu4KBCc8vP1DFQycNC
         sUITQVkLeS5EcapBEnbNV31xWaSh3Vhr9yl+o1QBaul1r3mKzL1fSSUXVkJFoH6QXbrr
         kBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211090; x=1779815890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=R0y9/cMx/Y1zjxiSyrA/lswXNVlOsl9qHZ+1ghalKYefOYPZWK+M0iCqc8mmSsHWhM
         qAx+gcR9MAPTCwoZsrTWoauUfWOvpvYRuS/q5AgYRB0S5RJ2qlycpfByYlQAZG0Q+yal
         OWZu/4I9S0a8/UcyqNMPLLE0D8ppmptp/Sb9VXZpco8j6jJ7qJCMKNTpedz3nfrjyTzU
         ZEPV2A/YlLdFZu6t+peh7lLBWyj4ANkvAh1w518at3pqARCbyeNTkOC80CMFDUbY0XVs
         wRJTz8WwMrJlqTGwXibhK1LyOg0bbHNESfWvcckUbGSy/rjJ3f/DJZL6XkZNypaX0f74
         BTdA==
X-Forwarded-Encrypted: i=1; AFNElJ+RAXOlUfoD+f/cTDnpoOldvfBpYhLU/HkSRdydD8aqUo5pB6o2i9pkDujY4yt++vMU+a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYCUM+UZi25mQN6Q9LD8gT04mvw/7i3MiSlWifE0JgR9fuAMqJ
	jwPuO8ORvzbtN4ZELQ4mgnf/zU3aXp0DMLR5jJ3WL2pATCyz1iRR5T0X
X-Gm-Gg: Acq92OHdO9eVz6P6aFoaYpgfBOymSey4fBP8CF/hpttqOy9cC3nYxUWYBEK7GtQNDW+
	8I6zjILdWnMuchNSVFUuL2insI+K6n7EVnNN7V4EKgMGPlnkCrG/8dyeXOdAs6PJEGYJkRoKa3q
	fM6Z5NrJERd8+fB+R+sdpz9+r2Ej0Lc91Ezo8eWbmdhMGG6pbGCROPrXfoNb5fftA/IVk+mejoB
	nblUX5NkcxrY94Bzo8G+IlWhprM7kc3jhbDArKK0r7U1SAzMDKyDbR7ZJ5fglUeJysqfmQ1tav2
	5AKN7AylH2UtxZZJ98YaXaKGsvzTEXUxMOSCQmNmtsb0zU9dJ2bGzLJ6pOYE96RzdcnrIAIKND3
	3feMSAi8XZMcC3LNBS3P3AjsVJsn77D5AuKweO4fIELe2ZJYV+Ixh3XLYMi8s/zHaCKPUV524Hl
	wuGyxT3s33BVb0n2QypvK6wgqNgdFPp2U7o056A68TQCtDu86sCA==
X-Received: by 2002:a17:90a:d446:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-369519af686mr16956900a91.1.1779211089467;
        Tue, 19 May 2026 10:18:09 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:46ec:2327:9655:89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm14370012a91.0.2026.05.19.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:18:09 -0700 (PDT)
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
Date: Wed, 20 May 2026 01:17:30 +0800
Message-ID: <20260519171745.1551340-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260519171745.1551340-1-yphbchou0911@gmail.com>
References: <20260519171745.1551340-1-yphbchou0911@gmail.com>
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

