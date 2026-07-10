Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB5366DC1
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654169; cv=none; b=Or/QF1CuDWfh5hrl+V+a8ivOeGnTrgEt+ne14OPkqDZwCoRgmX6MCn0W0+Mt+WcNdI740+jMdTanis8D5eV+esN4xSancIH7bOHC2jxURNcvJl4vevZ5D+RRAdgy1Krjg4oFadYsrH5V10DGJ+e8iBFVMiDzSP5WKEo1fmwEm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654169; c=relaxed/simple;
	bh=Gwt0vIVRdUfUurXNz0U9um8/c6hFVw+sQjNLaLm168U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQ7xR6ip1SJMJa0B+G1pZiEQQyENoPFv/4yws5tGyzRdmv6Pa3fqsix3gVAr3lACg3p/uL3oZI1qTEdXdLlR/n6wa0Q7OjUES5aFH7K4KtoEQvdFYtdpym2HapTEpXI6A6+tICZ218lH5RRzkgTas9OOKugBmlPbJhkHpBt2B68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfRS0gus; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfRS0gus"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so21464425ad.1
        for <rcu@vger.kernel.org>; Thu, 09 Jul 2026 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654168; x=1784258968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HyVQ93m8I4DnhXDv5rSatBwFHcjRnR8kBcgkmMTv+c=;
        b=jfRS0gusrHnEQMRd1dhgGrBgdfHybLeQ9ECOlV9GUjmEr3cT0oYfIiX3gea9Wmf2Uy
         U7pHaSzygXfxwMA6JX/+Mp2DF3Yat95RQu4rTarDlE0EK1twr6zceJfVlxYP0uTJ3BkS
         SiHdPXVaYYEiNN4bMvZVAie3epJWEdtHrUeQyOQBhS1VAn2dYrKlniXvb92s62idar3y
         NaUCEvTYX4Exl0JQ0NMe8FyrHge9eGJ97kfDoHmbQf4Vxe7wzgs0O69fEqwSVDXtzwYx
         c0/2doFPj7ukUyNyPBYqzLiamn4Qi37xwr1FRlVN+SE6QEfeei6IP2wcvIqmVYFSIti8
         hXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654168; x=1784258968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HyVQ93m8I4DnhXDv5rSatBwFHcjRnR8kBcgkmMTv+c=;
        b=mDggDwyVi8U51HOuoOiWMBWpwHvkb8Q25Mr6S6HRVthKJ0eC3I3B8ksrXBPZ05ar10
         jGUeuov5RTvh0uVpA/a9oRwFyW+/+1r4XslO7iC5NLvEC+GTMM0rvagmY0bSwT1u2zfB
         fdnrt1D7kQ4ymQ0hkhHx5ny8sABsnSizb82BtwOcRHfcSmuPVplB9dZZGDEh+rOh6sJO
         lCc2l5Ki8mSuZoboucqgR9YRcEuozOVp9S02LHBajaD9QN0+hhvJakiAPDV9dhtMKijb
         PAWjGTP9Foan39iOLiyUIHHMoyCUbA4FT+S917jYbG/YwXtGVE+aeTJSjQfFitkkYrD2
         iM5w==
X-Forwarded-Encrypted: i=1; AHgh+Rr15Z28PfRtiY6hBrfEEI+1hVDlqEIeFhp9Nyxs9YswKdtz9wSDgD7vlo8siWxSeApVjIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvtwUi3xK4ETpIhp3VXtCeREYgK773tvvVLZpjjjCMOZM5fWX
	+nfg8MAgG2jdWYMlVTPoMVA2/JNfFr4CVh09HPOAtPXM14iikdTozUuK
X-Gm-Gg: AfdE7cnSfgj31rjqoYn9uTiiKwiJtRSe1IBbOpxhnZg/YgFyxzkUY7B2VGQ01jz33pj
	Q7qoEJM7Cqtq8bRFr0EQsLhQlmhmz+5qn4qLWB4W8moH8EyfgBS68IwWYPRtb0Xgrjoj3m1QJXP
	URQM0uFkefBfszqcmYG1CetQKmai1cI9BooHBmhyXa1yg5Sy6D6F1Eqoq/+/yHmi9DO43DpgxLl
	xVDNSh/qONkww2OnUyvnngS55EEuqEehhrQ7ifkJ0a9zSaB4ngY73h/MWGcMr9wSJDBQT3K+X43
	TicUKn2i0wBz4fNBX981rCK+RCDhpPPXhZKINSM40gmq7/mxggunRvF6FVpGXOyFqz8M9uiPpx4
	X7aNzfLVN/PiRi9hgRVX/z/mu2cSxHihrPPVN1fbiZyd1Ukh9PymaSvsVpjHeuTgKQuXRTeJSWM
	0D87g1zovHQnY=
X-Received: by 2002:a17:902:d98b:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2ce8285abefmr20003265ad.6.1783654167651;
        Thu, 09 Jul 2026 20:29:27 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:27 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:18 +0800
Subject: [PATCH v4 07/11] tick/nohz: add runtime tick_nohz_full_mask update
 for CPU isolation
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-7-2e912e5d9645@gmail.com>
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

When kernel-noise isolation is requested for a CPU at runtime via a
cpuset isolated partition, tick suppression must be activated on the
affected CPU without requiring nohz_full= at boot.

tick_nohz_full_mask and tick_nohz_full_running are currently set only
during boot by tick_nohz_full_setup(). There is no runtime path to add
or remove CPUs from the full-dynticks set.

Add tick_nohz_cpu_isolate() and tick_nohz_cpu_deisolate(), both called
with the target CPU offline (between remove_cpu and add_cpu in the
hotplug cycling path):

  tick_nohz_cpu_isolate(cpu) - lazily allocates tick_nohz_full_mask
    if it was never set up at boot, sets the CPU's bit in the mask,
    sets tick_nohz_full_running, and calls ct_cpu_track_user() to
    activate per-CPU context tracking so kernel/user transitions
    suppress the scheduler tick.

  tick_nohz_cpu_deisolate(cpu) - reverses the above: deactivates
    context tracking via ct_cpu_untrack_user(), clears the CPU's bit,
    and clears tick_nohz_full_running when the mask becomes empty.

A per-function mutex guards the lazy allocation and running flag
updates against concurrent isolation requests.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/tick.h     |  4 ++++
 kernel/time/tick-sched.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577f..c4038e62533ba 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -210,6 +210,8 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
 extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
+extern int tick_nohz_cpu_isolate(int cpu);
+extern void tick_nohz_cpu_deisolate(int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -281,6 +283,8 @@ static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
+static inline int tick_nohz_cpu_isolate(int cpu) { return -EINVAL; }
+static inline void tick_nohz_cpu_deisolate(int cpu) { }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ba7adc671c580..1bc01e2ab525b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -621,6 +621,51 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+static DEFINE_MUTEX(tick_nohz_cpu_isolate_mutex);
+
+/*
+ * tick_nohz_cpu_isolate - Add a CPU to the full-dynticks set at runtime.
+ * @cpu: the CPU to isolate; must be offline.
+ *
+ * Lazily allocates tick_nohz_full_mask on the first call so that no
+ * nohz_full= boot parameter is required.  Activates per-CPU context
+ * tracking so that kernel/user transitions suppress the scheduler tick.
+ */
+int tick_nohz_cpu_isolate(int cpu)
+{
+	mutex_lock(&tick_nohz_cpu_isolate_mutex);
+	if (!cpumask_available(tick_nohz_full_mask)) {
+		if (!zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL)) {
+			mutex_unlock(&tick_nohz_cpu_isolate_mutex);
+			return -ENOMEM;
+		}
+	}
+	cpumask_set_cpu(cpu, tick_nohz_full_mask);
+	if (!tick_nohz_full_running)
+		tick_nohz_full_running = true;
+	mutex_unlock(&tick_nohz_cpu_isolate_mutex);
+
+	ct_cpu_track_user(cpu);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tick_nohz_cpu_isolate);
+
+/*
+ * tick_nohz_cpu_deisolate - Remove a CPU from the full-dynticks set.
+ * @cpu: the CPU to de-isolate; must be offline.
+ */
+void tick_nohz_cpu_deisolate(int cpu)
+{
+	ct_cpu_untrack_user(cpu);
+
+	mutex_lock(&tick_nohz_cpu_isolate_mutex);
+	cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+	if (cpumask_empty(tick_nohz_full_mask))
+		tick_nohz_full_running = false;
+	mutex_unlock(&tick_nohz_cpu_isolate_mutex);
+}
+EXPORT_SYMBOL_GPL(tick_nohz_cpu_deisolate);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {

-- 
2.43.0

