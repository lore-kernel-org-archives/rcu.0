Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170A1B424F
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429837; cv=none; b=tGiF40J9YC0gKCxnbvG0aTgzT7lhSCv7VRQKdz5Zel/HSOTQS2YA4n+MpgMCxfCtZ9Y8YJAqHXgM5vazPQVl802mcR38uRS+f1BmOWQQ3N/gqWuexD2nqJ3V0kfHfmvyHfRiZNNb4fG0tC1H5paWShnZ1T9/pD7jlBD/kk0us9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429837; c=relaxed/simple;
	bh=UeaDJZbzyb0leR7Qls8fmOy4YWD3y8kXCvRPcK0fa0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XF7EsaJC/p1jIP512B/exOLu33+hZuiaRLWbdTDdN2LzHjt+3ZfkimGlCXpnzuMXi+N7EpbAAwxS1JrWPKGtJSQG1yR5hcD187gUUcqVizsUUK+RHL7JwHpeD8XgqlsRN9vKG5zcdfVuDUUhV/8jqL/XN650UWCvybViE5fEEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ185vCt; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ185vCt"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c107ef474fso5216793eec.0
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429835; x=1775034635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B65y17E56pZOCr9RDMC9jiTFzum1CPtoQPIrPMkYTbY=;
        b=WQ185vCt9g4aPrVdOOYodFBmLSw2UbjvKLs0yxDWdlkxGUQzkeMN4bpLt9f7s6/qeA
         Z3bE7lAWlI9dvF8OJLvT01QfxSmRtU/2kGU8yyWy7pMrLX8gfQ1B60+Pq97YuttNLkm4
         FEjg/hWBnpC54q6UUKI0qRJlcmKv+a1W5iEmO2t1FICeMQFE0DEwu8nQlVduyTLQRGBh
         S870/Da9N4d0ihyV2RSkl7fRVx/eR0UXVamhu6jGp/Xg2n1/7/8E7Ed+zf0knWoV8B9M
         SeyWqGiNZL7dbUPEDMdT59NKks6M+mywDyz/rkOXVDtGpWxaVwo1AstVq9KG9Grh3teH
         IWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429835; x=1775034635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B65y17E56pZOCr9RDMC9jiTFzum1CPtoQPIrPMkYTbY=;
        b=heLJTff4lxt6PoIS1tdyW5NsPtXsxiyTEwy68NMKR4p7etPsqwNvQMzZKkwd2JjRhY
         K4ED9Sq22Z0iB0eJZosvPwTAt6DtqRQEYLmyAVu7mxn0N7+vmG1GqVtPCWYrmdf9n6ig
         QBJwaCJxw97WIyhESQ5SpYXDdtf9AVRhHwya4qH2kAcUqkWfZHNW3tNcrgHw1zBxvnaI
         dESj+sHxJ2dwFAx/eUIAMRhq1V4gdTP0lFZFEUlsWHJ8f72+09WWDawF8orDYYlXIpAg
         Mj7S9eT2efSmKdMsJzlW+FOwJNyimeDks9jdCaLRgM5OD39BwlEZb7MDWqBebOsUhdCh
         QzMA==
X-Forwarded-Encrypted: i=1; AJvYcCV5hmm26tCD4nga1fBbTuT+LJn/eE60XF0JepMhEvtqwRHzn+99Hq2QWSeBdXQJAn1B2WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDqFaDo4qVk4VpIyJyrrMrxB/utrZNGNJmAi0ogAvaPonxINv
	hQBYAwjNljhaJSBt+fKhKDWJYRvEBa2pRkMs0TMuxQqdx0OQYZzoQ2R0
X-Gm-Gg: ATEYQzxr8KbhaI4sw07X6dwDk2a5/k/O92ijEOl0sHvI6Y4ETYn+aANJkaFua2N6xrd
	rbliBODNH11lIpVQ6E6i/GdKpvGn1vRmFYqOdV9Lgeen6F6Fhh7PSrVNm1W2qtIz8O+7x+OSTbp
	15Xk7NfyJ8kdQdOPMiymCBgkT+PvVtGIY7urG1vfaUTi69EZhbCIz1xT47DxvvYI+0vbc/m6PZC
	cKV4QrJEuCCnL4JuW5bv3F8eGeExaz5MFasG4r1cs8jUOaeUyC1FcvAcMlhdtNmQiL7HhbQqE7I
	XmEM7nt1KHPmy+pmvcUFJqUcDtuMMadQpH9Gb6OKj4UGJNy9XklX8xQoxkzwbsRYxgJmLWhVcDM
	UppuuCqv1AIvbU0p+zX6N730PAnAuhKt0UjIiV1GvGHGDn40BjHmhYa3D6Juge3b3Xws68Xy0xp
	7V4+cGLoYJLML0a3xMg/4d1p7EDJo=
X-Received: by 2002:a05:7301:6592:b0:2bd:c8a2:954 with SMTP id 5a478bee46e88-2c15d41245bmr1419655eec.24.1774429835176;
        Wed, 25 Mar 2026 02:10:35 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:10:34 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:38 +0800
Subject: [PATCH 07/15] watchdog: Allow runtime toggle of lockup detector
 affinity
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-7-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
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
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

The hardlockup detector threads are affined to CPUs based on the
HK_TYPE_TIMER housekeeping mask at boot. If this mask is updated at
runtime, these threads remain on their original CPUs, potentially
running on isolated cores.

Synchronize watchdog thread affinity with HK_TYPE_TIMER updates.

This ensures that hardlockup detector threads correctly follow the
dynamic housekeeping boundaries for timers.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/watchdog.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 366122f4a0f87..ef93795729697 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -26,6 +26,7 @@
 #include <linux/sysctl.h>
 #include <linux/tick.h>
 #include <linux/sys_info.h>
+#include <linux/sched/isolation.h>
 
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -1359,6 +1360,29 @@ static int __init lockup_detector_check(void)
 }
 late_initcall_sync(lockup_detector_check);
 
+static int watchdog_housekeeping_reconfigure(struct notifier_block *nb,
+					    unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		struct housekeeping_update *upd = data;
+		unsigned int type = upd->type;
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
@@ -1373,4 +1397,5 @@ void __init lockup_detector_init(void)
 		allow_lockup_detector_init_retry = true;
 
 	lockup_detector_setup();
+	housekeeping_register_notifier(&watchdog_housekeeping_nb);
 }

-- 
2.43.0

