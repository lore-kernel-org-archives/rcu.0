Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24F369965
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219931; cv=none; b=cEJK8OLTVLLEtt04RY9CqAOMinVEbFiA/Pe7el8skDT4wBgpPgK8Ltg2YQlFpQ1d+zE1N4/KEyUluf2lofffAdHyxieR0VupJPMx/kxVvRy+3B/NMVH/k3ldYwkIGp3/TWHTHKfxWsEqG9S9HSB0bC+O/TqXfnp3uOfwgPZ2re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219931; c=relaxed/simple;
	bh=nf3d6Th/qqcFPA3j+0FA/cKyNhD0kVORFLgt2PalDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee2HR71rTMqPmO6u7km2ASbu8o6ZEvW+6hLJghkwthXXV49mmDpx75gn10FmGw+g/to63h1y3DwIx1fneBUeb+vllr+SwcSvu3BUgXxXEFr9F24DoChjFaW2xFXhiEY7ultDHnmeNHHwebdzmSF8HMq4D71lbw9ryrVHrUH2Qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB+bjYb8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB+bjYb8"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-393a44854d2so39094361fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219928; x=1779824728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8n4g8DtMbilWmfrS0Iblc6XB8Z+tIb+ktHpUGgo0p4=;
        b=iB+bjYb8vH7qT64UYpyBHdkiBxhsBeR2vVmkqMoCz9D3IHkpnd4Q+XvSNl0Wc1u63s
         i9Qj+VYYuB/QQEb2Z8qFQgmcsSxvWmvzC3vJYbfZ4dKRV1n5AdvpAWOQ7foBsCuk/Fjv
         my7STpRyWTfXLSitSMC1LfLaHJOLGM5sCahIjtaKihG9bd3X+v263MNiHEuIMRVZLhfb
         CFv9W07mk9vb4tpRyG3rmO/9rd8Zsg/660aL9vZn/u1atRrL90JETRIbOywDTbJv+sc/
         n/OZHjVBQ7HVpyFQE3Uphi4chRYeBzu8y6nbFXTlogqLxtb+wLd9lxoA2lHZqlYbQ2kj
         6jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219928; x=1779824728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8n4g8DtMbilWmfrS0Iblc6XB8Z+tIb+ktHpUGgo0p4=;
        b=sWECD/oLfEmye1K0OJKFaBXdAiuSnYaAi7Yf4Sly83ySoXWerlDSa1+ED8VPLSO6JQ
         Ctr0nKdgeQOwpOCaRi9707YoUPFQXZPNAsCyixpEUfihXCWRekXYVgIfpZ3ZeUy5pGSG
         tMeLAl9SjCr7wQb9aQYL/DrB5bfjwbTBobnXlOkDrdGjcuwo8l++yVVMp2pvvXvjcw+w
         +z1p/Ivn104pgZXPlvaWbS7wzdw5+zc8deRfuf/aDy1Scq0AoJioS2NCEC1I0aozGPD8
         FgNXBDgG3TapskBNKRZUSfqRQrMKwGHU07PejkTT4ptjiAUIBuCRUN9F5u4GSl+IkNp8
         MrTg==
X-Gm-Message-State: AOJu0Yziw7Fu9c+PurEzrMykLmphkTI/AeQaJQLUrB0ZT90s/2SopsZK
	1eCjprNb69etQBIMUy0vm0BRQD+qiWrom8EV+TPfAAlVyhAg86gQZR0C
X-Gm-Gg: Acq92OGNF3SNxXkrY6QjdIBuIxhGKbhuY/1QGnK1spFvwftDL7I7Bk0OI0VRLebzQpj
	pMoYvWKbGkmQsjN8TKrAntmlhpoH3D6k5dKMuw5zCNwgYv2naJjioyXd/lrO3Tsyp6jZ67qNkvA
	CHYymm6ci0vfsBU1z9gCp0DCxinuh8GachIMA0O/G8ic/PpHSNWp1MyfjQQI8XhaB9xyVlvdETL
	4LhZk/Ux/2fkcA+zThjb/AFYZDItMZkoV384vo38Pjr5L3GZttQURQQxp2RTVGLKGpAgazpLRCY
	q1Wv93wlh2GOGukD8EWB54XpfASnU6fqBNBT785+c6JBjykBaIoudMqQwwNQX6dUTVExTjAPDGC
	vW0i6P/8GXOEGdNM0s/lwBE97kTb3/WHP8jR2wKIA4ZVL23vhJOnKxuuEjwA32AFLSvK2UFs0/3
	SErS+lkt7lF9rOlo7USxYSIJtFMA==
X-Received: by 2002:a2e:9059:0:b0:38e:58c7:cd1 with SMTP id 38308e7fff4ca-39561dc13c1mr44953141fa.21.1779219927559;
        Tue, 19 May 2026 12:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:27 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 02/11] torture: Add torture_sched_set_normal() for user-specified nice values
Date: Tue, 19 May 2026 21:45:15 +0200
Message-ID: <20260519194524.158515-3-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
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

