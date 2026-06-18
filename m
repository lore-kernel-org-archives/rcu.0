Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169A33ADBF
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752346; cv=none; b=i3CuEKlVq0ADkzHX9AF5zrsd3Ddv4UmM0KEMbRDbyUa71FGa/hotKkD36DtV4biYMV6uDr6xh2a0dzciZw3mOSMPjG/YuxQqQhPBoJtInnG5LC2ZI70CCB9SxBRClSylPcKJD85peyICcKVLiL+iqJ39gRj9a8oJ1q15+eTP6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752346; c=relaxed/simple;
	bh=SZOR3Po26I5px5IWl3qao5Q198zBGy4no+Y9jQCKPSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vja/C2uLFTjofLegEv78caYa1WBiTrxkCxT/ORE75j2tACgknS6OIexoyD5havjJMmulqKGErt5U7x66F46ObazJ9ePAzK9ezeeCJ7lEmQ5b+dO01RFQ6R/NYUJ1XAIoF60mFv1owKewyRaypGopsM2b1hymqszshQK3tCXxonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHAmH5IP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHAmH5IP"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so173531a12.2
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 20:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752342; x=1782357142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTFQPj89QbzgFs0dMZHtOVwajXrW91e6WK1jm8uL+Eg=;
        b=PHAmH5IPLrZV/EG6wS1qTEkI8DsVC2qRHijBIoPG3bGf1q3aI6OaG8IstQ5gFY71XG
         12fAD4RRLw00mD/USJ0d/0FKlgopsQ1jjimgtHGVHW9GugaUGexPgRn0+OnXlEgCQpjM
         Mc4K8w9N79gZTqi0th0g4YJ9lLFmWuSv03IeKxSmZHHmeIfKJNcoH7kfsDp8jdureFKM
         pQT0KP1oL17uD3r0omav7WTSTnxzVfC3w3LsYpY3uvEmuFbcNnj+Co9FEPlEpNhzLtJA
         C/W0QhGHNrDB67BAbRYD4wXkhS5aovYwUpBeAadRGLCO6nEdUFmZNtJjnjj+c6kXiDg3
         YVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752342; x=1782357142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GTFQPj89QbzgFs0dMZHtOVwajXrW91e6WK1jm8uL+Eg=;
        b=P3XfaDTePSKHgc3xCKqzZYj1YS0mbz0kTaq0TjfvWErsn0vOkF5c+vLBokbNRQwgPO
         QgbwXS7+hekloOzr64Bv3oUczW3dQNUgu+yqGzMj9ap+4MIVdCzQFXuncmQCtwIFO0EO
         uC0boQIvA22DIaG0xtoHHOu5fUaGyNS7J7Fg3MiugJnpYiHMO4v5w//Umrzpo/4VGaBJ
         cU9d9nX/zUNY/9XvTUw5iqgVkMtkxICQxQF7GpM++WK0CvX1Ok9nM2vglGgxoIxWm/gE
         E7HMHyPJJQ2SsXR/jK+JHBm3gKtJ76ZickXqCTjW0mHXr90W+95YDXtdxuM5H98z/KbR
         0v+g==
X-Forwarded-Encrypted: i=1; AFNElJ90xQ9I8EqzWHLIoRnGJ6TvhTdOOIUf4b4ZuImTp7V8vhH/usGYHC4nQkZduj0aCMFjDU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyainOVZ+j938kM8Y6lQH7YripF9t0I4ZO/vmuxHv2CXTosl8qf
	OnN6TiwROmyh0/ecUFpQ7+2FnA9U5ayqsBYwUi8MiakPVaQY6WKYVEeU
X-Gm-Gg: AfdE7cnH35L/3LGtp565fRGCbj3cUmL+JmDamMNrj5z2ddqBC0agmh7sWny83xFnBep
	5KeD1aLNGRWrVY3vH2mqjbTU67HPv0aW4+yqvPQSiBUcy1kCd1eTr/kxoiH7u+7fSk7ZDi0oH6T
	3Axt9wGucfTO4sr9DOW+2bcdUwz5HRgcEuZ1Ik4msvzKdZzAGpyeJOV+3KHIB64AVijMlkNAViA
	EiHW5cotX/jD8Aj1AJ8B03ppct78LY/mFxEh+mKcccOsYSGmSp6XFo5IMj5g19I11iJPmSJ9SqN
	3grOQID+LNHIL/84CvmQ/SWrQscBY2XXX+jPm+Kcf3qp6qKh1lsQAFsO7kTT+ZtQBLd2MpQb3Ar
	79ZBzBmEJDXpwOyEEHpla0Mx5OwDM7hP9BXKCIEgGa1tzsTNIWcTFJ4SMSJ2QaP4ZEL4CBI6MPS
	uTGOmpWgIjCi0=
X-Received: by 2002:a17:902:e54b:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2c6e484a87fmr17591495ad.11.1781752342087;
        Wed, 17 Jun 2026 20:12:22 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:21 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:20 +0800
Subject: [PATCH v3 09/13] watchdog/lockup_detector: Register housekeeping
 callback for kernel-noise
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-9-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

Initialize watchdog_cpumask from HK_TYPE_KERNEL_NOISE rather than
HK_TYPE_TIMER at boot, so the initial mask already reflects any CPUs
excluded by nohz_full= on the kernel command line.

Register a housekeeping_cbs so watchdog_cpumask stays in sync with
HK_TYPE_KERNEL_NOISE when isolation boundaries change at runtime via
cpuset isolated partitions.  The apply() callback copies the new
housekeeping mask into watchdog_cpumask and triggers
__lockup_detector_reconfigure() to restart watchdog threads on the
updated CPU set.

When nohz_full= is absent at boot, tick_nohz_full_running remains
false and DHM isolated partitions do not activate tick suppression.
In that case watchdog_hk_apply() is a no-op: there is no need to
reconfigure the watchdog CPU set because the full nohz_full
infrastructure was never initialized.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/watchdog.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968d..998ad94da4cb9 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1389,7 +1389,7 @@ void __init lockup_detector_init(void)
 		pr_info("Disabling watchdog on nohz_full cores by default\n");
 
 	cpumask_copy(&watchdog_cpumask,
-		     housekeeping_cpumask(HK_TYPE_TIMER));
+		     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 
 	if (!watchdog_hardlockup_probe())
 		watchdog_hardlockup_available = true;
@@ -1398,3 +1398,57 @@ void __init lockup_detector_init(void)
 
 	lockup_detector_setup();
 }
+
+/*
+ * Watchdog housekeeping callback: resync watchdog_cpumask with
+ * HK_TYPE_KERNEL_NOISE when isolation boundaries change at runtime.
+ */
+#ifdef CONFIG_CPU_ISOLATION
+static void watchdog_hk_apply(enum hk_type type)
+{
+	const struct cpumask *hk;
+
+	/*
+	 * When nohz_full= was not given at boot, tick_nohz_full_running
+	 * remains false and the full nohz_full infrastructure was never
+	 * initialised.  DHM isolated partitions do not activate tick
+	 * suppression in that case, so there is no need to reconfigure the
+	 * watchdog CPU set.
+	 */
+#ifdef CONFIG_NO_HZ_FULL
+	if (!READ_ONCE(tick_nohz_full_running))
+		return;
+#endif
+
+	hk = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
+	if (mutex_trylock(&watchdog_mutex)) {
+		cpumask_copy(&watchdog_cpumask, hk);
+		__lockup_detector_reconfigure(false);
+		mutex_unlock(&watchdog_mutex);
+	}
+}
+
+static int watchdog_hk_validate(enum hk_type type,
+				const struct cpumask *cur_mask,
+				const struct cpumask *new_mask)
+{
+	return 0;
+}
+
+static struct housekeeping_cbs watchdog_hk_cbs = {
+	.name		= "watchdog",
+	.pre_validate	= watchdog_hk_validate,
+	.apply		= watchdog_hk_apply,
+};
+
+static int __init watchdog_hk_init(void)
+{
+	int ret;
+
+	ret = housekeeping_register_cbs(HK_TYPE_KERNEL_NOISE, &watchdog_hk_cbs);
+	if (ret)
+		pr_debug("watchdog: hk callback registration skipped (%d)\n", ret);
+	return 0;
+}
+late_initcall(watchdog_hk_init);
+#endif

-- 
2.43.0

