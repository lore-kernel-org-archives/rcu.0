Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7440C4361B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 20:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC8C23CD1
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgLIU3E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgLIU2y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 15:28:54 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00511C0613CF;
        Wed,  9 Dec 2020 12:28:12 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id h19so4879374lfc.12;
        Wed, 09 Dec 2020 12:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXHApmwQ+fq8Jp06pnCwt/jV0z0jBnK6zmB/zPM4HUU=;
        b=OwrMYAxzb0KK9VLPA8HYeEp9vJaMwn7644V3jGCqIYfhgbUPVVW0PZspMW42lQ4wfI
         Dk8RlaU4lqoP4D9qye6hMrcMFUHKUSsUepsp828sWVZV3Q/UP86kJjKiarbjuxX3yUtb
         hf5HLw4jTDsNzgZv9CG41xw7TkSCk/ki6MjXK+R5yMCAF5MdXRmHQBy1SKcO4U1NDN8I
         c1KH6oIVK3VC5FBbykpdGg/1A+503qzrh5TJvMaGeRlQlJ0UgDqacbF3vuPyLnl3MXJn
         T1L0zbetpZCAqewsCq4ESDPlMDvBPdp2nW6WzPQwu3JZacu5pcAJ+9DlvAlahTW5ZnSh
         Wy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXHApmwQ+fq8Jp06pnCwt/jV0z0jBnK6zmB/zPM4HUU=;
        b=eq3bJHhhF7dlptU929G7xp0BzeKandcwyYt5E30dgL2Cf1LzY+FKXK8rXeFHfce/ea
         CCqm0Rek8rwAtuxj3TcdkLtyeZPjdlvkvuHQCtm2XXty6odaQOXGlU6z2AKC84fJuQQI
         QYyEM5uijZ6k9NO6uMjlmpe+t7X9xNAd/IO3iv7S9yD1tLgUpnYfDa9yRZUWQavhdwhF
         RJp1HduH0Ne75wUNJ7YdG8K/pCeoWRGZgHV5fhpUBLJBlbIXv4U+oiXdV49XnzDLpKCt
         +8DykYa8eR73jIQJOqFKnm2sCrCI6bpgf8KipsYhDeZs6OdMylQ9PT99PZOVCKQpE9rg
         iEAA==
X-Gm-Message-State: AOAM531HC9bglVleeN8vCaHvI5AHAxyNHCztxzV1FR/zxNPjz8CIVCvI
        4pTFwKGMIVRIxX8M+dth+BUfdbYJpjlGog==
X-Google-Smtp-Source: ABdhPJxCmvMOim88E44iydtUCV9FXMnqagJIZhJke1s4leRsjN6BnZAT7dw1VWoMwTg74r3E+SdDVg==
X-Received: by 2002:a19:5510:: with SMTP id n16mr1526250lfe.135.1607545691434;
        Wed, 09 Dec 2020 12:28:11 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z26sm17323lja.125.2020.12.09.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:28:10 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of core_initcall()
Date:   Wed,  9 Dec 2020 21:27:31 +0100
Message-Id: <20201209202732.5896-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Initialize the RCU-tasks earlier, before *_initcall() callbacks are
invoked. Do it after the workqueue subsytem is up and running. That
gives us a possibility to make use of synchronize_rcu_tasks*() wait
API in early_initcall() callbacks.

Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h |  6 ++++++
 init/main.c              |  1 +
 kernel/rcu/tasks.h       | 26 ++++++++++++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3c3efa4d6ab5..340c7d5344a4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -88,6 +88,12 @@ void rcu_sched_clock_irq(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
+void rcu_init_tasks_generic(void);
+#else
+static inline void rcu_init_tasks_generic(void) { }
+#endif
+
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
 void rcu_sysrq_end(void);
diff --git a/init/main.c b/init/main.c
index 130376ec10ba..e253e87bdf58 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1502,6 +1502,7 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
+	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
 	lockup_detector_init();
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 35bdcfd84d42..67a162949763 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -241,7 +241,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	}
 }
 
-/* Spawn RCU-tasks grace-period kthread, e.g., at core_initcall() time. */
+/* Spawn RCU-tasks grace-period kthread. */
 static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
 	struct task_struct *t;
@@ -564,7 +564,6 @@ static int __init rcu_spawn_tasks_kthread(void)
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
 	return 0;
 }
-core_initcall(rcu_spawn_tasks_kthread);
 
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_classic_gp_kthread(void)
@@ -692,7 +691,6 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
 }
-core_initcall(rcu_spawn_tasks_rude_kthread);
 
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_rude_gp_kthread(void)
@@ -968,6 +966,12 @@ static void rcu_tasks_trace_pregp_step(void)
 static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
+	// During early boot when there is only one boot-CPU,
+	// an idle_task is not set for other CPUs. In this case
+	// just revert.
+	if (unlikely(t == NULL))
+		return;
+
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_checked, false);
 	t->trc_ipi_to_cpu = -1;
@@ -1193,7 +1197,6 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
 	return 0;
 }
-core_initcall(rcu_spawn_tasks_trace_kthread);
 
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_trace_gp_kthread(void)
@@ -1222,6 +1225,21 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+void __init rcu_init_tasks_generic(void)
+{
+#ifdef CONFIG_TASKS_RCU
+	rcu_spawn_tasks_kthread();
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	rcu_spawn_tasks_rude_kthread();
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	rcu_spawn_tasks_trace_kthread();
+#endif
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
 void show_rcu_tasks_gp_kthreads(void) {}
-- 
2.20.1

