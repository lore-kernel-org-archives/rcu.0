Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFD43DA3A
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522095; cv=none; b=TJzwileod3vADBX081ez5KsOzgtdMXpmUPo6qf+1zjxplNSp355SQv3y1BvtLxz8E90TgyF6tAoGmURQvSJFOS+F2V7NlNGsvBiInFaNhr8/zc88Ep2eRpzX1JULgpHi5qasQyCQBKFdtewgrfAfa5WnGqd/FSsjhsfEyevEGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522095; c=relaxed/simple;
	bh=nf3d6Th/qqcFPA3j+0FA/cKyNhD0kVORFLgt2PalDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRsCozUFDqa8gPa60+E9SKf9u6+3b+i+f1/9Z2BXlqBq11HDzWx5vVBMAjdXk7k8kMmQ45zJSNlQSJnNY11soVE8xYj00bzTpNiTNEAwU1vF+MF2eJdWLHvXyHk+s6Pc0pE8hX2vO/tKulNjs+sgDjs/2EFxyQOLu40rc5AmYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVpeUdue; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVpeUdue"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38e7d983f91so43915301fa.2
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522092; x=1779126892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8n4g8DtMbilWmfrS0Iblc6XB8Z+tIb+ktHpUGgo0p4=;
        b=pVpeUdueFnnPECTMz//oiyPwZ7dcW/oxkzJmPjU+g3CXQ2JXXg3nrTJ3fmBu1MXNHg
         rwPU8ByopHGqqC39WK6ODyGKDjIQx3PcU9ItlwMRioCObdG64FO2fvCZLvHK/6GV9lM0
         jPkyqNUDTYrNQQoHZWj4cPEwaTzsrUhiO5+hvDk8i8PB6xNPD8GTcurSHZEHdVVJIWdZ
         vdcNEhP3g/3sqfKWYh9xlkQ76xQz+I+39J4XwvXWhQJmTnYRXXr+Nl92ZZ2N/2s1XMF1
         RfVPXve6zbGjrAjE/bs2W8+u517U29wpjyyQWMBLeUrp0YhuDri/aGAgcEatseO8lTUN
         jj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522092; x=1779126892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8n4g8DtMbilWmfrS0Iblc6XB8Z+tIb+ktHpUGgo0p4=;
        b=EijdpA75CGHONGywAxrQPqIg6d9X6D+33uOjia1GUQLRUqCqTzlm0FcBcuPTAxMrUV
         0216juMIvzbKX2EsUCLSklKjOgxk1nv6UZF+1qQOvtvSwNE1KBm5CIIcUHsTPp9ZVPMI
         Ji0rAqlVhjg+Iz1BXVoq7y8Tir04JZszM8nmO6M8h6Ax9HebDRQGCDYUEKvqPtr9c0po
         VS/bqMlRVLPpFU7qbduw5McpJa3oLW9+Q16tPtTcU0R685pLuQAoyaCzLXaZhosOBTvN
         UezVB3nhdKFb144p8zYuB+oWj+9yG2TFKs3jTln8EarAx46UWHd/wP/ljxGcGkKpUgoz
         lrTw==
X-Gm-Message-State: AOJu0YwgS7vzQ1Eg0DL8aVij87cYVhd4mm4NUppAvKk8kKol4n9R7SWf
	OtPRsA81/4g1jJ+f/CIfafJT2lUL8KRzAoJvakjWJduBFKuRiRvMnD1M
X-Gm-Gg: Acq92OH108o0SX6M/FXEhnSqdFazJl//DINoE5pkexIvImmuQqUeV6lesYYHPVeFNEe
	rsGx0tg3NA6xoeFhPOHce/47LIUYaDhAN7RsgFET8ePDiRxqRqSbi3BAfMhYgHzqh7MBoIrNgB0
	bv2witg5ylD8mcRAHP2IZWeWJD2AKLLpWtPoZEVP7rfsMRx5L9l3CXLra3GvDxbv+vfUYav1yM2
	zLOvyLDJLpjWZkMO5cR7wLl6ChUcVQHXBmHV2P9UNW4RSyWF+bONtMZWDWkOPfqv4byTNzySVSP
	+zpsLi4TzNi/b6QlttXTNh+R7R8fTUOtOLrPj3e7Cg8DqVLGjmSAsm82MZBksTBSO3Hpa017K/O
	Aen8tI3HC3Jgprk9oimHFUv78BhefMjxiPwicCghPPwDJ7Mir3OSI/jFNIpCM99DQ1hq+VyKBGi
	juXX6w0OXiQMbnBZs=
X-Received: by 2002:a2e:b554:0:b0:393:d562:d51b with SMTP id 38308e7fff4ca-393d562d88dmr49585891fa.9.1778522091997;
        Mon, 11 May 2026 10:54:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:51 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 02/12] torture: Add torture_sched_set_normal() for user-specified nice values
Date: Mon, 11 May 2026 19:54:38 +0200
Message-ID: <20260511175448.153326-3-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This new torture_sched_set_normal() function clamps the nice value at
the MIN_NICE..MAX_NICE limits, splatting it these limits are exceeded.
It then invokes sched_set_normal() to set the new value.  This prevents
more difficult-to-debug failures within the scheduler.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/torture.h |  1 +
 kernel/torture.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 1b59056c3b18..c9b47d138302 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -129,6 +129,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #else
 #define torture_preempt_schedule()	do { } while (0)
 #endif
+void torture_sched_set_normal(struct task_struct *t, int nice);
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST) || IS_ENABLED(CONFIG_LOCK_TORTURE_TEST) || IS_MODULE(CONFIG_LOCK_TORTURE_TEST)
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
diff --git a/kernel/torture.c b/kernel/torture.c
index 62c1ac777694..77cb3589b19f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -972,3 +972,19 @@ void _torture_stop_kthread(char *m, struct task_struct **tp)
 	*tp = NULL;
 }
 EXPORT_SYMBOL_GPL(_torture_stop_kthread);
+
+/*
+ * Set the specified task's niceness value, saturating at limits.
+ * Saturating noisily, but saturating.
+ */
+void torture_sched_set_normal(struct task_struct *t, int nice)
+{
+	int realnice = nice;
+
+	if (WARN_ON_ONCE(realnice > MAX_NICE))
+		realnice = MAX_NICE;
+	if (WARN_ON_ONCE(realnice < MIN_NICE))
+		realnice = MIN_NICE;
+	sched_set_normal(t, realnice);
+}
+EXPORT_SYMBOL_GPL(torture_sched_set_normal);
-- 
2.47.3

