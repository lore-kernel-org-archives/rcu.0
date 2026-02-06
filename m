Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85041302756
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361565; cv=none; b=HCvTuRhDRGQFHCkG3sZI2kivRNonhhKSpWxHEaK9wD7hXcTk5uFh7IJKNXw8yK0tzJ2+Xbw+Zj+63OhC3yPwMXFTJaIRIJnaej1jIBw43J7urq4LLLOgPR5uIMLc7jqHLiQnGsWY2T9Cu1ALpk21BfX4nl4hfL4Btu+9duFv/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361565; c=relaxed/simple;
	bh=tKwD7qZPuORYanqCCrKMgXQf9MbzZVnLfxvUTl58kmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iD+4cv+BVq+jMRnYg5wt2o7OXXnlwm1QEATDKNLeQGQNu3IiLO2gGml0aj7za6GBF44iFvEaRkQlN60tavSCobKAW06OIegZclEcWj5S1/ChuoBS6U3aEljx9cM2xL7RrlxnJgCqatnACl1iNS61ooYVawb+RTZWvWCj6AVKDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkkVhdfk; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkkVhdfk"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11f1fb91996so722196c88.1
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361565; x=1770966365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX9sMLwwZBpxhdeadTLxD2L+ATZYvXDyrtJH+GXz33A=;
        b=PkkVhdfkETCDWRf5XDCJsQLAHWp7ttHONZsKz90x1XM12xlxSYsRKEEReePcfqV7WV
         1X8/t0eJ8bmIJaDm3yGFjjc2lyLveetZM43z0qufNerLPhH07gf46ZCyuuWqlcd4wWxv
         cisMFoOsoHeBtPlj72Z2HiLfWX6wZ2kd7NwpInWR2MyKqA8T8Ejrdplro7l1KAbt6ti+
         yS3l/uiOhTyIIc+k+V1Hew9PixsbfWGiO/NY+3mKH1spStzp586c+u8hReHrWeAFnGf+
         uS2T1cfWgZ6G0JZXcJukgqDRwmfEIb0fS9z/31B/KVB+J2qCObvS3Fbdyorjm4unCloP
         lZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361565; x=1770966365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BX9sMLwwZBpxhdeadTLxD2L+ATZYvXDyrtJH+GXz33A=;
        b=vhH8ROxyzfkqVdnTvJUUEiYujXHHeFeKgPNkREJ9x1MZ1Ox3wAjDVXL39EeO4asWOr
         c+md5KtLbspgFsa0lW8sg/cjmE/BW5erLBp38EHUowM7HWkcS5QLDNLiNaF8ZJeSwDRe
         dFjio9DToG13KoLOlhZHMM/8W6ewmk1rCO4dOpY/OR4IaY7ytEPsaswGfiMUc/fRIzZG
         s1bXIsEFlAG/vSxm6zE0ZPrgmYTh0zszMla3WOQ5E/OzDxbF+BI1FZYK8xL7rXGfWoq5
         vTwg9QSxIhfg6eZf7FKyZ6xqD3vtf/UpRHyGSDSDbNYsdsj5N9HUkF7yvssCzCm82W4L
         Z11w==
X-Forwarded-Encrypted: i=1; AJvYcCXERhR9s5m4O5XeNIVB7TFjxSbVDAvCXAPs4DPRSvANiro9W05gHal+jJGvE2egzsDfyss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7R8uWXFKCyaC1jOKZjvDILfQOVcZ1iSkvvZVurFF3GYxB3Ye8
	K/PjAn9DLvrQIp/jQRcKnlz1XXQE8pFm5jIIY5pqgCVa5FcwloAs4NXw
X-Gm-Gg: AZuq6aIrcEUWBOJguhYGf3m55bpJSsKhPTe+bn3dhXRVQsnMsKJwMimGLE3dM35Vo73
	Dx3n2fPCKBPDGJpgkOjB/U5eC/TpORjqu+Vc6eTW46B4r9aa/N8QPuizIe1fTYtJC+nY+NC0cEn
	LEn773Cg/p5j4ox0HtHl/SFXWIPf4K80jDoYChdHWE4regfCp8BPSCYDhmZSrjWAXdz22zgDj8T
	12CW0xU1EW1DffDfz6n/gCA8PUVws59MdN5UC2hFRtdIGiCrASYyBlL259wW63YxnbrMbtuALp7
	aGuO37ORq4eT4oE0fhB1JusUiJeTu5HKCrucUyld244gcrxsWOMCyBxTjfUcZiYZmWFDunD1Idg
	IXq/syc/qE/ztx/ApP3htG0w4XRz/3mIJ63l4y1sV1Y+gNKnh6vA6gigd+aMiZ1p5RkVJkzDWGP
	GzMppMf4nVGg==
X-Received: by 2002:a05:7022:619e:b0:11d:f890:6751 with SMTP id a92af1059eb24-12703fd8b47mr1055311c88.10.1770361564656;
        Thu, 05 Feb 2026 23:06:04 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:04 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:27 -0500
Subject: [PATCH RFC 06/12] watchdog: Allow runtime toggle of hardlockup
 detector on CPUs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-6-00a711eb0c74@gmail.com>
References: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
In-Reply-To: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 Qiliang Yuan <realwujing@gmail.com>, Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.14.3

The lockup detector (watchdog) affinity is initially set based on the
HK_TYPE_TIMER housekeeping mask. However, if this mask is updated at
runtime, the watchdog threads remain on their original CPUs.

Register a housekeeping notifier to update watchdog_cpumask and trigger
a reconfiguration via proc_watchdog_update() when the HK_TYPE_TIMER
housekeeping mask changes. This ensures that watchdog threads are
synchronized with the new isolation boundaries.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/watchdog.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 366122f4a0f8..2922d7f93d61 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -26,6 +26,7 @@
 #include <linux/sysctl.h>
 #include <linux/tick.h>
 #include <linux/sys_info.h>
+#include <linux/sched/isolation.h>
 
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -1359,6 +1360,28 @@ static int __init lockup_detector_check(void)
 }
 late_initcall_sync(lockup_detector_check);
 
+static int watchdog_housekeeping_reconfigure(struct notifier_block *nb,
+					    unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		unsigned int type = (unsigned long)data;
+
+		if (type == HK_TYPE_TIMER) {
+			mutex_lock(&watchdog_mutex);
+			cpumask_copy(&watchdog_cpumask,
+				     housekeeping_cpumask(HK_TYPE_TIMER));
+			proc_watchdog_update(false);
+			mutex_unlock(&watchdog_mutex);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block watchdog_housekeeping_nb = {
+	.notifier_call = watchdog_housekeeping_reconfigure,
+};
+
 void __init lockup_detector_init(void)
 {
 	if (tick_nohz_full_enabled())
@@ -1373,4 +1396,5 @@ void __init lockup_detector_init(void)
 		allow_lockup_detector_init_retry = true;
 
 	lockup_detector_setup();
+	housekeeping_register_notifier(&watchdog_housekeeping_nb);
 }

-- 
2.51.0

