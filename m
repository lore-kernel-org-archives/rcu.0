Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E7C433F5
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJKSCv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJKSCf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910AF6DF9D
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g11so4119212qts.1
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed18G+CW3RyPlXV+dC0y1CBcUrLSvT0k/M+hDUcZxHc=;
        b=aqkfH/cDI6clYIekxRPX9iOLhIrAvYX8Xg2stIVy0P6Dc1dJMi6/rlnj+cT/s0+mtl
         78XgiYvj/UDI1HnH3GJJG1TpB15m0Pd0mi4RHpG+rwjDss52jqubRUDjdaJGhkqG+gSI
         MUu2BCIjWk55ShLCeoB4R9hnDvWiuqVu3B92c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed18G+CW3RyPlXV+dC0y1CBcUrLSvT0k/M+hDUcZxHc=;
        b=DvzfsprZF7+g9IIuojYxPOLrehUMCS8dZZBluOix0KxHy3kYYoSotJq4eSPoyChDOM
         MkQxeq37AQvMoMJVI1b6AoXW1tiks5O2lLyEbwnJAeZyfe3+vKX38pVDYpnbBNQOljul
         Gv7ck06aPKoripO7hgQr8AWtSdVXtc8XZRXCVA5j8tysrqBIyLqsQpFX6T825aW2iN/n
         KSV/54+RMbz3wotRs/osb5FBy7/BWdSMUPZh3W4+35yRakxjpZQFpaZ3E+5SH8fJWYmC
         QHlZqVyg6kqlt0+wcEpvWgNG8lQLv5OW6LB2kL+/v9j+HHz1b0HGGX5yYBS4krE+6nJ3
         biDA==
X-Gm-Message-State: ACrzQf1tHt9eKQ7uRE/Jk2SJcv9Lu5kEKruBysTPvMeJHF6yVcIV8G30
        AwSp6jGPio/FcOGWmucEbTUVVNRqtnoc/w==
X-Google-Smtp-Source: AMsMyM6qGNyN13NrEofrpXC6/Dr49/RebsHHQFAWml7QuzB/OO63ebSxC0Y6rmnB4WTr7mL66/DZtQ==
X-Received: by 2002:a05:622a:1652:b0:35b:a2dd:f0ad with SMTP id y18-20020a05622a165200b0035ba2ddf0admr20470352qtj.302.1665511339455;
        Tue, 11 Oct 2022 11:02:19 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 13/13] rcu/debug: Add wake-up debugging for lazy callbacks
Date:   Tue, 11 Oct 2022 18:01:42 +0000
Message-Id: <20221011180142.2742289-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch adds initial debugging for lazy callback: whether the
callback does a wake up or not. We see that callbacks doing wake ups are
usually associated with synchronous use cases (SCSI, rcu_sync,
synchronize_rcu() etc).

The code is not very intrusive as almost all the logic is in
'lazy-debug.h' with just a few calls from tree.c

In the future, we will add more functionality such as ensuring
callbacks execute in bounded time.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/Kconfig      |   7 ++
 kernel/rcu/lazy-debug.h | 154 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.c       |   9 +++
 3 files changed, 170 insertions(+)
 create mode 100644 kernel/rcu/lazy-debug.h

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index edd632e68497..08c06f739187 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -322,4 +322,11 @@ config RCU_LAZY
 	  To save power, batch RCU callbacks and flush after delay, memory
 	  pressure or callback list growing too big.
 
+config RCU_LAZY_DEBUG
+	bool "RCU callback lazy invocation debugging"
+	depends on RCU_LAZY
+	default n
+	help
+	  Debugging to catch issues caused by delayed RCU callbacks.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/lazy-debug.h b/kernel/rcu/lazy-debug.h
new file mode 100644
index 000000000000..b8399b51d06a
--- /dev/null
+++ b/kernel/rcu/lazy-debug.h
@@ -0,0 +1,154 @@
+#include <linux/string.h>
+#include <linux/spinlock.h>
+
+#ifdef CONFIG_RCU_LAZY_DEBUG
+#include <linux/preempt.h>
+#include <trace/events/sched.h>
+
+static DEFINE_PER_CPU(bool, rcu_lazy_cb_exec) = false;
+static DEFINE_PER_CPU(void *, rcu_lazy_ip) = NULL;
+
+static DEFINE_RAW_SPINLOCK(lazy_funcs_lock);
+
+#define FUNC_SIZE 1024
+static unsigned long lazy_funcs[FUNC_SIZE];
+static int nr_funcs;
+
+static void __find_func(unsigned long ip, int *B, int *E, int *N)
+{
+	unsigned long *p;
+	int b, e, n;
+
+	b = n = 0;
+	e = nr_funcs - 1;
+
+	while (b <= e) {
+		n = (b + e) / 2;
+		p = &lazy_funcs[n];
+		if (ip > *p) {
+			b = n + 1;
+		} else if (ip < *p) {
+			e = n - 1;
+		} else
+			break;
+	}
+
+	*B = b;
+	*E = e;
+	*N = n;
+
+	return;
+}
+
+static bool lazy_func_exists(void* ip_ptr)
+{
+	int b, e, n;
+	unsigned long flags;
+	unsigned long ip = (unsigned long)ip_ptr;
+
+	raw_spin_lock_irqsave(&lazy_funcs_lock, flags);
+	__find_func(ip, &b, &e, &n);
+	raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
+
+	return b <= e;
+}
+
+static int lazy_func_add(void* ip_ptr)
+{
+	int b, e, n;
+	unsigned long flags;
+	unsigned long ip = (unsigned long)ip_ptr;
+
+	raw_spin_lock_irqsave(&lazy_funcs_lock, flags);
+	if (nr_funcs >= FUNC_SIZE) {
+		raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
+		return -1;
+	}
+
+	__find_func(ip, &b, &e, &n);
+
+	if (b > e) {
+		if (n != nr_funcs)
+			memmove(&lazy_funcs[n+1], &lazy_funcs[n],
+				(sizeof(*lazy_funcs) * (nr_funcs - n)));
+
+		lazy_funcs[n] = ip;
+		nr_funcs++;
+	}
+
+	raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
+	return 0;
+}
+
+static void rcu_set_lazy_context(void *ip_ptr)
+{
+	bool *flag = this_cpu_ptr(&rcu_lazy_cb_exec);
+	*flag = lazy_func_exists(ip_ptr);
+
+	if (*flag) {
+		*this_cpu_ptr(&rcu_lazy_ip) = ip_ptr;
+	} else {
+		*this_cpu_ptr(&rcu_lazy_ip) = NULL;
+	}
+}
+
+static void rcu_reset_lazy_context(void)
+{
+	bool *flag = this_cpu_ptr(&rcu_lazy_cb_exec);
+	*flag = false;
+}
+
+static bool rcu_is_lazy_context(void)
+{
+	return *(this_cpu_ptr(&rcu_lazy_cb_exec));
+}
+
+static void
+probe_waking(void *ignore, struct task_struct *p)
+{
+	// kworker wake ups don't appear to cause performance issues.
+	// Ignore for now.
+	if (!strncmp(p->comm, "kworker", 7))
+		return;
+
+	if (WARN_ON(!in_nmi() && !in_hardirq() && rcu_is_lazy_context())) {
+		pr_err("*****************************************************\n");
+		pr_err("RCU: A wake up has been detected from a lazy callback!\n");
+		pr_err("The callback name is: %ps\n", *this_cpu_ptr(&rcu_lazy_ip));
+		pr_err("The task it woke up is: %s (%d)\n", p->comm, p->pid);
+		pr_err("This could cause performance issues! Check the stack.\n");
+		pr_err("*****************************************************\n");
+	}
+}
+
+static void rcu_lazy_debug_init(void)
+{
+	int ret;
+	pr_info("RCU Lazy CB debugging is turned on, system may be slow.\n");
+
+	ret = register_trace_sched_waking(probe_waking, NULL);
+	if (ret)
+		pr_info("RCU: Lazy debug ched_waking probe could not be registered.");
+}
+
+#else
+
+static int lazy_func_add(void* ip_ptr)
+{
+	return -1;
+}
+
+
+static void rcu_set_lazy_context(void *ip_ptr)
+{
+}
+
+static void rcu_reset_lazy_context(void)
+{
+}
+
+static void rcu_lazy_debug_init(void)
+{
+}
+
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 37fe6ebc113a..ac34e1ed3ab2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -67,6 +67,7 @@
 
 #include "tree.h"
 #include "rcu.h"
+#include "lazy-debug.h"
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
@@ -2245,7 +2246,10 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		f = rhp->func;
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+
+		rcu_set_lazy_context(f);
 		f(rhp);
+		rcu_reset_lazy_context();
 
 		rcu_lock_release(&rcu_callback_map);
 
@@ -2770,6 +2774,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	}
 
 	check_cb_ovld(rdp);
+
+	if (lazy)
+		lazy_func_add(func);
+
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
@@ -4800,6 +4808,7 @@ void __init rcu_init(void)
 	rcu_early_boot_tests();
 
 	kfree_rcu_batch_init();
+	rcu_lazy_debug_init();
 	rcu_bootup_announce();
 	sanitize_kthread_prio();
 	rcu_init_geometry();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

