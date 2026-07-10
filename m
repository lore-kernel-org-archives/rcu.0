Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E43672B3
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654141; cv=none; b=YjCIhPw/GSDwp/IuxRGi3reD4RYt7j+U6+crike3MKmu5QDmxeZjd25aczDxsX9ez/rt9aiELNv+wdpq0ZPOV+piB/uRS/oI4eqyynxgNYEIMbIDgRqyR2PcJQ3J0laRF0dRDcadsaEAPUSMGEnSNQ1wbBAJBtEdqLKUG8yX66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654141; c=relaxed/simple;
	bh=/7g5rPjTXZCVa2/uRZYg9xonGTIXf23dBk7iXIO7Ns0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wym8fHKf8iCNOp8wCNatq+OmBJ+mj4QgX5P366eA8x82GJXoMe2VzJ3wFYjCiob1R8MtJ2zlq2C8S0BJ9RhY4U03GQEZJcviKKW3kehf/X5mGmTatDQwrs1+COxzmCYnWJpqC2Y7mfqfX5ownjZ225U0ql+O7SOhpfwWUyzi/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctctuR/1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctctuR/1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad8076b01so4999435ad.2
        for <rcu@vger.kernel.org>; Thu, 09 Jul 2026 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654140; x=1784258940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdWcLivIGaN7u5tA3Cryx3dVQvByPYpqsiikxpuxuiQ=;
        b=ctctuR/1r3DuO1xZ+F+26ZuVuh9k62emAj6nfw8tg4tNihn5UI3STRkKRb7pJEHgKO
         gTg8x9kqXW+KRyQ7hLsgTCUsuxyHRHJ1qz2/ibVxZFUgRqxU98LpMP7OVP9mtfG8WCJu
         Kwf8nz/PZ7JkWKLwoDFxFWzgTG6mq/V3ofvtzsQ9TUT61VYhBXSaDN55rZSWLYdfxsE/
         9hG6mKhIQuie5XEYE7PcILmUD/t7gytXx8qzqrxLF4li2f8zcCSdJxFJX6sBDNdSqAVU
         z6IEDwN9h8XvV1ZXOPqPtTprZDy/g+52goUjSwKSI4dP24HyBdIxgU/DqWx4/MKdsFi9
         tVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654140; x=1784258940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CdWcLivIGaN7u5tA3Cryx3dVQvByPYpqsiikxpuxuiQ=;
        b=aBTzB4/Zus3yr2ph5PIH5rapCvdUM87hzfEDdSQS6IPki2OQgNawUHUEJ2lDwTTnxp
         VYAX2WmrXhr4IPpD3ayvJF4rpKgsxq1R1BJf4wl8/3LqPc3oP/sZ0/XneAv/D36phGjN
         WlHFwQyqUYi+XWz5u3TPuIH++HRn3GR1topWneJrV3kp2sYDS/7km820sOzn3t5fsytg
         QJqPTxNAyMHQ/CiMVp9JkDmGwHcl3DCnmdYM2TDH6/G2Ok47x/B1168hpP1CMHgExyOV
         O231LveT4OW1iZovffkKVAqUrvtgmOL5jBkH4XPHtmkHyBUNzeOpWBQrJBat/8DCKJwk
         0QpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr49jIhDGcygEqkK06rHaQXurE0t7C4WpgxTaSk+JLD4WdtCg3UhHIqoq6DXOutkO0y9j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUPowLzIMogQIAu3FT7WYwe92Q1dkMKHjkV+NoGhYQ9WiuZwQ
	3ft62NaTJTdPMtW0LHw2VWP14cGpHaTbmpgZTcWKdT9T35GsuwtOzXe+
X-Gm-Gg: AfdE7cnoUDgQ+RDTRwAMslP0wPGn+QX7yenlraEv4cyibLMo8UXMEFtA1ump5qUc19P
	cRWQSf0fVmgEnK4VcV8pfuqauKIuqW8TfaJS9DK3uNEiSmeLwViRYAWddDMPuqdiCj3ouWaADi9
	VuxFxDkEGZh6xaet/O2l1+yxJxdtjm/tnYStw9kkykpvc1TPfDBEgq1GRfaWWTwJxRdD4jtkNxU
	64goLQdKvUPWvjTY0MuPnXWJbHI77X4m1H5+ZzzgB/1Iz4275XmGXtW9//Bzc2ar2QggrEJ4xFe
	DS+aQrDZKRYT6FCOPjQMMtax9oThU3plfEK8guP+RspGS9YXqet6awtHlPbKBxJvr6/5sIZbb38
	+IvBjuxg1VbmGh/edkUaHyNjpgE71q7I0zyECjl9wFGr7B/iS6siZzc+wCl7Jo+6qJx88/dKvEV
	4KShUpjoBgRgk=
X-Received: by 2002:a17:903:22c1:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2ccea37ace4mr104298875ad.15.1783654139660;
        Thu, 09 Jul 2026 20:28:59 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:28:59 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:15 +0800
Subject: [PATCH v4 04/11] context_tracking: allow runtime per-CPU user
 tracking enable/disable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-4-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
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
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

ct_cpu_track_user() and the context_tracking_key static key are currently
restricted to boot-time use: the key is __ro_after_init and the function
is __init with __initdata state.  This prevents enabling nohz_full context
tracking for CPUs isolated at runtime via cpuset partitions.

Split ct_cpu_track_user() into three functions:

  ct_cpu_track_user(cpu)      - sets per_cpu(context_tracking.active) and
                                increments context_tracking_key; callable
                                at runtime with the CPU offline.

  ct_cpu_untrack_user(cpu)    - reverses the above; for de-isolation.

  ct_cpu_track_user_init(cpu) - __init wrapper; calls ct_cpu_track_user()
                                and handles TIF_NOHZ / tasklist setup.

Change context_tracking_key from DEFINE_STATIC_KEY_FALSE_RO to
DEFINE_STATIC_KEY_FALSE so that static_branch_inc/dec() can be called
after the __ro_after_init window closes.

Update tick_nohz_init() to call ct_cpu_track_user_init() so boot
behaviour is unchanged.

This is a prerequisite for DHM (Dynamic Housekeeping Management) runtime
CPU noise isolation without boot parameters.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/context_tracking.h |  2 ++
 kernel/context_tracking.c        | 38 ++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c         |  2 +-
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..735d353d87560 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
+extern void __init ct_cpu_track_user_init(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c00..a81d9f8b85eed 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
@@ -674,14 +674,44 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+/**
+ * ct_cpu_track_user - enable context tracking for a CPU
+ * @cpu: target CPU (must be offline when called at runtime)
+ *
+ * Marks @cpu as actively tracking user/kernel transitions and increments
+ * the context_tracking_key refcount.  Safe to call at runtime provided
+ * the CPU is offline so no context-tracking readers are active on it.
+ */
+void ct_cpu_track_user(int cpu)
 {
-	static __initdata bool initialized = false;
-
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
 		static_branch_inc(&context_tracking_key);
 	}
+}
+EXPORT_SYMBOL_GPL(ct_cpu_track_user);
+
+/**
+ * ct_cpu_untrack_user - disable context tracking for a CPU
+ * @cpu: target CPU (must be offline when called)
+ *
+ * Reverses ct_cpu_track_user().  The CPU must be offline so that no
+ * context-tracking readers are active on it.
+ */
+void ct_cpu_untrack_user(int cpu)
+{
+	if (per_cpu(context_tracking.active, cpu)) {
+		per_cpu(context_tracking.active, cpu) = false;
+		static_branch_dec(&context_tracking_key);
+	}
+}
+EXPORT_SYMBOL_GPL(ct_cpu_untrack_user);
+
+void __init ct_cpu_track_user_init(int cpu)
+{
+	static __initdata bool initialized = false;
+
+	ct_cpu_track_user(cpu);
 
 	if (initialized)
 		return;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7c..ba7adc671c580 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -677,7 +677,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		ct_cpu_track_user(cpu);
+		ct_cpu_track_user_init(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,

-- 
2.43.0

