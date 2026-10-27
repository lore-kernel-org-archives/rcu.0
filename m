Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119140;
	b=mEPhYa1yW/LZxbvj6DfUxAOMdeYCd6ps+cZSN1+nW/G2+mCKXk0kA7y+evbKnNQS7RbG
	 yavcqG/HNzV1MUp+tdoherEBwRVYbdtnliOzLZQy6ztXsBwNtMRaJotUaGKDIThdTmyo8
	 tKREuTkVAK9rcEzgd7wA+Qn+C5yl+Fr5DF3MtKboj7H6feXNM93mOHRHYnj6Nmfp6kyPk
	 pqw/I/8RQXHAivQ66csk9ydzo1yvqqC3QWjr4qOnbWVdq6kHpDnv4xM0rKpGfH7vsCkkT
	 oESx5PyAWYikW2fPzdgnw6AHmLhcOj/ihZEyEDqI0NlTK/5dCB3jZH0YEuHtG4it1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9uOoh9IXRFNxNkyBrfne1vGxftWSxATGplynCIne7a4=;
	b=HF4RXDwazf5UgOTiln3SYKk4lm6C2b6OwMIGUHNfS4i5h5YoF2+3TWi9wLfzI+1Y1En5
	 /Ffx2KBWegfdsjId4rCcYbs8FG90zkAdMHKdRQlpR3kFPeHJLLbhQxKdW8kk/78fJHqoX
	 9sK+wgZVhb4fIjubjwfLutjplyPTd9KolpNSeeJyFvSs74jv7O/2+LfC3BBw1UOQbGdAv
	 ZHIxUKQhWMUSJaRXeSvbn5RPLAoFJuOA8pMroMbyzuxxtQLqGCOk7Vnvcrcngr8KzggxX
	 E1DxaVfYNseJ76iupvyLtmTiXSzjA8+mkDmSYXDwkir8SFXQf1rZw8SYl9E+yX9qGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jx7qFqdq;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157F606A325
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 16:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C157F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jx7qFqdq
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so339745e9.3
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119138; x=1793723938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uOoh9IXRFNxNkyBrfne1vGxftWSxATGplynCIne7a4=;
        b=jx7qFqdqhYPNuoIM8KV8iZ9x5aEH1s3uAWqqw7VV8uWGH1JtC5Xuk4sN5w30PlYvie
         xT+kALMnLakupfcPQYg97ISDZ5mBOPq9morEzGHWHa5V2SfQvPSomp/jBtFGV6lGifWe
         GgqDu4FxoWbhomR86cYNudVZh/ssA17OhiDP/tjIodlk1k2kKI/vj9TNFRAJKGHDAhkT
         4dM4QkSNR0vnhXnl/e4awY322lvD57qlyCkpoSdcghnYFQkHkBT1GrWkMKlUKmFJu/3Z
         dkzT2R72u/XBsiV6ICsaxBAM0U5icw8xYxOUJMiiTQZb2mL1mSr7qGF8cB/mCFsaGPKC
         PjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119138; x=1793723938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uOoh9IXRFNxNkyBrfne1vGxftWSxATGplynCIne7a4=;
        b=uIyCuGy1QSqezmfvDo7bMmNJs2K3EcFwr3GDqFYaYCEfWRVX1hwh4WBRc38wLHgAOS
         kXIabULh9N3X4H4/yOKAq1MZMr1zpEgQCq/X9dh4S1t+j6AUT9qRTH89jhDW1x26ZDgM
         6RpFrCUuSVYDMH4vJjdL44VBcZ/ATpOxzaLQ/NRvBpwvIfzD93HcLc2uPsc8Y69kQ9Xq
         9TkgA486YfP228quegy2+re1KMAPt95y+LFOJean1GBiSv4NK0XCzYXKAQGMfarNC41r
         gyL6Y+moD+8RNnxvzTG+66YN/uH51DAq7WXcIRTLCekK4xP4PYenRgR9WIUMmfqHYqSL
         DooQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/1myrwpH3yvJuVUMd5AJ9wNvEN/RIqAuMyWJ30gGfqrrCur1QSqFT/tzazSsWX3fsuts=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGVhn0IlgM1x7cEJqaIGWpLmdSKTKXUE1BMbo4gjfZCUTCx+DS
	WwIJnnxCQxgT6dp0BOaiWUAPvH4SKZGtN4RlcxwRQd/U5FMgRBgf4kzI
X-Gm-Gg: AYBFou1yKsWIQp5itQhjKdRaqQlF46aq/S+imJNWeyJm5tWkf4UPauf/RowFdZAA5tJ
	9Ys3XbDCnv/OXEGWEzTc08SzMBrgL8HqM/xwEDMSb/pFXQR0uuWEbLOIwf20/GPm9E1HtnBj+bs
	+VW7ShOPwX51rqrR79+9qv3aNvTUND5wIKFKE6dqpt6EWXsQe3XthAly4EciXEZc6BQ8vQPJ3CL
	BOSTPEdxMh1EB/EV1rG6a/Ca71MjRjKRwpdPuL6CbyUBFHS/Ecf3QQRlkUFJ5FNqhwYKL/2CZeb
	2W3waTDHmrgAo2PzANB5JzpwgT0iMeNYKOMMwElurTuwXv02wUVMOLlQHJyRtNAVuMEeXmV9+Ew
	sQWjABzNaDZxYQanGpzLsrVDWWIX23+apEG5e4y8BH82bn4J0+q0xl8jDHlrelhq99J+jTpUhAb
	domdV4cgNk0+61aEmsS2VpHoSGgqtKbjKejcWAawupi4sZWEwyGC7iTf6CcBVp67qlN/Jhz3gZG
	7Aca4Ry14UG72zzti2AXi00bb9ltQXVRFDe0tFcFv3z+V7S8mi4ECk0xEWvD2QsI1Yf/QzS9tqx
	ICoGV8yaH/g1xyfeoo50JApY4hoU6LlTRJNEfW6Ms+4Ralg=
X-Received: by 2002:a05:600c:c0c8:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4a4de702b8bmr139023805e9.22.1793119137915;
        Tue, 27 Oct 2026 09:38:57 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92c21df84sm2358195e9.15.2026.10.27.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:38:57 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH -rcu/dev 4/4] hazptrtorture: Nest a second hazard pointer in readers
Date: Tue, 27 Oct 2026 17:38:06 +0100
Message-ID: <20261027163811.2470569-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027163811.2470569-1-parri.andrea@gmail.com>
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hazptrtorture rarely exercises the race fixed by "hazptr: Record per-CPU
slot owner after claiming the slot": an interrupt handler acquiring a
hazard pointer after the interrupted task chooses a slot in
__hazptr_acquire() and before it claims it.  Readers get there only when
their pointer is NULL or changes under them.

This commit therefore adds the nest_acquire module parameter, which
makes a reader acquire and release a second hazard pointer while holding
the first, once per the specified number of acquisitions on average
(default two, zero disables).  While the outer hazard pointer is in
slot 0 of the reader's CPU, the nested acquisition finds that slot in
use and goes to __hazptr_acquire(), where hazptr_torture_acquire()
handlers from other readers can interrupt it.

Without that fix, and with the checks added by "hazptr: Check per-CPU
slot owner with CONFIG_HAZPTR_DEBUG", the PREEMPT and NOPREEMPT
scenarios at default parameters report the race 6.3 and 6.0 seconds
after boot, and NOPREEMPT oopses 1.3 seconds later.  With
nest_acquire=0, both run 10 minutes without a report.

With the fix, 30-minute runs of both scenarios pass, as does a 10-minute
PREEMPT run with irq_acquire=100 and nest_acquire=1.

The nesting costs about a third of the outer reader iterations, as seen
in the IPI acquisitions, which readers send once per irq_acquire
iterations.  PREEMPT counts acqirq: 270645 in 10 minutes without nesting
and acqirq: 544976 in 30 minutes with it.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++
 kernel/rcu/hazptrtorture.c                    | 27 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e3c5a6b68fc34..63bb7719457dd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1992,6 +1992,12 @@ Kernel parameters
 			is equal to zero, in which case it instead
 			defaults to zero (disabled).
 
+	hazptrtorture.nest_acquire= [KNL]
+			Acquire a second, nested hazard pointer on
+			average one out of the specified number of
+			reader acquisitions.  Zero disables.  Defaults
+			to two.
+
 	hazptrtorture.nreaders= [KNL]
 			Number of hazard-pointer reader kthreads, each
 			of which repeatedly acquires and releases hazard
diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index c46083a8af093..4373bc5fe11e5 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -37,6 +37,8 @@ torture_param(int, irq_release, -1,
 	      "Release hazard pointers from irq handlers once per specified #, zero to disable");
 torture_param(int, kthread_do_pending_ms, -1,
 	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
+torture_param(int, nest_acquire, 2,
+	      "Nest a second hazard pointer once per specified # of reader acquires, zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
 torture_param(bool, nwriters, 1, "Number of hazard-pointer writer threads, 0 or 1");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
@@ -449,6 +451,22 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
 	atomic_long_inc(per_cpu_ptr(&hazptr_torture_releases_defer, raw_smp_processor_id()));
 }
 
+/*
+ * Acquire and release a second hazard pointer while the caller holds one.
+ * If the caller's hazard pointer is in this CPU's slot 0, this acquisition
+ * takes the slow path, which first tries another per-CPU slot and can race
+ * there with hazptr_torture_acquire() handlers.
+ */
+static void hazptr_torture_nested_reader(struct torture_random_state *trsp)
+{
+	struct hazptr_pending hpp;
+
+	hpp.hpp_htp = cur_ops->readlock(&hpp.hpp_hc);
+	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires, raw_smp_processor_id()));
+	if (hpp.hpp_htp)
+		hazptr_torture_reader_tail(&hpp, trsp);
+}
+
 /*
  * Hazard-pointer torture reader kthread.  Repeatedly dereferences
  * hazptr_torture_current, incrementing the corresponding element of the
@@ -497,6 +515,8 @@ static int hazptr_torture_reader(void *arg)
 			schedule_timeout_interruptible(HZ / 10);
 			continue;
 		}
+		if (nest_acquire && !(torture_random(&rand) % nest_acquire))
+			hazptr_torture_nested_reader(&rand);
 		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
@@ -721,6 +741,7 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 	pr_alert("%s" TORTURE_FLAG
 		 "--- %s: nreaders=%d nwriters=%d "
 		 "defer_modulus=%d irq_acquire=%d irq_release=%d kthread_do_pending_ms=%d "
+		 "nest_acquire=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
@@ -728,6 +749,7 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders, nwriters,
 		 defer_modulus, irq_acquire, irq_release, kthread_do_pending_ms,
+		 nest_acquire,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
 		 reader_sleep_us,
@@ -891,6 +913,11 @@ static int __init hazptr_torture_init(void)
 		WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
 		irq_release = 0;
 	}
+	if (nest_acquire < 0) {
+		pr_alert("Cannot have negative nest_acquire (%d), disabling.\n", nest_acquire);
+		WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
+		nest_acquire = 0;
+	}
 	reader_tasks = kzalloc_objs(reader_tasks[0], nrealreaders);
 	for (i = 0; i < nrealreaders; i++) {
 		firsterr = torture_create_kthread(hazptr_torture_reader, (void *)i,
-- 
2.53.0

