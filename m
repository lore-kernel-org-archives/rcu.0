Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158330AACF
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361547; cv=none; b=uMQlnQ1WNvRlUlZdd27RFe9VnMPtSLDUYYcv1Ddt+jLvtRe507Tq6UArlRrz3aA7fgiroKTFhr6HSROb7MbQMXgLzoMJvztpu7maGJD+maKZCdfK+kIMr7PEmYM8Tw70ab/ODFZqX7iCC/eU//DMgPzXnWftdpxLAqUUFSw3sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361547; c=relaxed/simple;
	bh=dJwZORxnoofLuqT7+FiHTuSwB9Z/aRfTx02GaGOnLfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrTELLzzZUta/lJJ+Vwws5d3vyZgkprFXbNfGQgBDgdDE54pGPl/FERge4wW8WtnwlFIdxs5BaJa607piqQB4r9FB0CyAqXzMMw+iuHP6mzfp3zbon/lYLu/BMft5YLppUcqlXBMrvSxJ/zTqOd4i0l8/r1ocyqpvh1DLyCHZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbkp29re; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbkp29re"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1248d27f2b9so2079808c88.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361547; x=1770966347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PaHf4BGcLmB1AiF1WHcrlMYrEJBUdJoTjVBNhvu80E=;
        b=Sbkp29reTtdTko619Uhh9jv6UqZKQPIrLaZbRsi584JKtHTbMobAn0+OPV98nqN7ZA
         vbexgNMJKxGte+YgVZs7mnFtQ5ty9T4WYC1++dmL2btCO92aCsyveH5S1VClkcjnc3Hs
         JsaTBRlYpCQ1IxCj86282YJ3HckFWBUFVFEiMZx5g7mh3Zb+Rh+++loWkk76Q/Ac+//T
         Oraz2Cete6yFRh2kgwDsshlaY+c7c7n0Ano8CHLj0k0YyUr/G3FZv3VVKPuMMUbTycfC
         tcxsm3hWU9CwQjH+Pm91nUdSp6+JaqkuLt4KMQxexFlmtl/otdev3iQk+eJ3QbGTf8CO
         PKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361547; x=1770966347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PaHf4BGcLmB1AiF1WHcrlMYrEJBUdJoTjVBNhvu80E=;
        b=M3neZY+iz8wl7agDa1G9+J8eNY0iMFtLKAK0F9mAAPp1GVl0bqQ7UhnPlGIA/l5j43
         wIwIRd72crpmicgOdaAB/FQfol00ScW7jwlxL0lrMcWuwgDIwpSBzJEQXZyUsrI4KPW8
         RjBzzwKhiNb6f5vcjA1iE9kSPPPFkk0OZFnR87ghTTCwsKAtOvTE425mh6K7Nxc6HpUK
         RD3hUW0kZ4WkmhFEFnM7qpHWJkWmA5pSaQuvYr/7mNSW+35eupjgJfHquo8Nvm+JdNmg
         uUxTQKWAn/fuJTAF+R3ExwzHkFDrNAx7wywXryC+E4jw3C7jNcX/1mW/+uVVrljqSpOs
         JaGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmC3tebOMBsVy9SEtdIYpDywfLUU31MCKPu8xAzUAGbT4mRmxtkUmQW1EPnHTwv+jDBtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNe/Vpc7/airA1RrBBSosKfpTEpkzYxo8a6p7JNzP5kvMoMHAs
	bXg3FHkVdLYqAUm3yU3iMrGlJWdtF7PrLJxWItBJgL1YiEhhpLFvDJtK
X-Gm-Gg: AZuq6aKw4Ao5lASD1sZR/J3Wk5RyPFbk+uP7gHPOnpxw6HBp8oxGhPCtMqAvyo4JdOE
	uLA4McPDrDzz+bQ5ji6jx59cG3yEfzyskJMwmeoyyG74azxMHg5jt2U749giWatR/UE4mdIJwtK
	yLqSz4+O5UE/pUIdyh9mymfwGLzlzBsPtivgW3pki2Bg/2jHadcYcA1qzVNCLUuV1X19hALQvAo
	pb4oxt7SzGol55rAADkLG6hieM0tpBJQST49yYgj78iQNnGeJwAcsDXX/sxAVpPa6CN30GsVugs
	LNJ/t+Ot8f340Cp5jKwFpAZ54gndMlNOP2TWy1OlsqEXm0Zua99ucKOut8kbLxWciI+CZwvXTG6
	hKlvKuDxI4mYeJpFwwtRCRG0Y9Wzsp8Mp7DM9hLUzLUhxH6YuUxXx81J0RjGxcWBfjNm9PSNLzI
	ugOd+7Wcze4Q==
X-Received: by 2002:a05:7022:222a:b0:11b:9386:a380 with SMTP id a92af1059eb24-12704030436mr735238c88.47.1770361546880;
        Thu, 05 Feb 2026 23:05:46 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:05:46 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:25 -0500
Subject: [PATCH RFC 04/12] rcu: Sync RCU housekeeping mask on notification
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-4-00a711eb0c74@gmail.com>
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

When the housekeeping CPU mask for RCU is updated at runtime, RCU
grace-period kthreads and tasks-RCU kthreads should be migrated to the
newly designated housekeeping CPUs.

1. Implement rcu_housekeeping_reconfigure() to handle HK_UPDATE_MASK
   events for HK_TYPE_RCU.
2. Update the affinity of rcu_state.gp_kthread when the mask changes.
3. Register the RCU housekeeping notifier during late initialization.

This ensures RCU kthreads honor dynamic isolation settings without
requiring a system reboot.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/rcu/tree.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..ec496e4bd24f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -48,6 +48,7 @@
 #include <linux/delay.h>
 #include <linux/random.h>
 #include <linux/trace_events.h>
+#include <linux/sched/isolation.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/tick.h>
@@ -4913,7 +4914,49 @@ void __init rcu_init(void)
 	tasks_cblist_init_generic();
 }
 
+#ifdef CONFIG_SMP
+static int rcu_housekeeping_reconfigure(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	struct task_struct *t;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_RCU)
+		return NOTIFY_OK;
+
+	t = READ_ONCE(rcu_state.gp_kthread);
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+
+#ifdef CONFIG_TASKS_RCU
+	t = get_rcu_tasks_gp_kthread();
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	t = get_rcu_tasks_rude_gp_kthread();
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+#endif
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rcu_housekeeping_nb = {
+	.notifier_call = rcu_housekeeping_reconfigure,
+};
+
+static int __init rcu_init_housekeeping_notifier(void)
+{
+	housekeeping_register_notifier(&rcu_housekeeping_nb);
+	return 0;
+}
+late_initcall(rcu_init_housekeeping_notifier);
+#endif
+
 #include "tree_stall.h"
 #include "tree_exp.h"
 #include "tree_nocb.h"
 #include "tree_plugin.h"
+

-- 
2.51.0

