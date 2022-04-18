Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2240C433EF
	for <rcu@archiver.kernel.org>; Mon, 18 Apr 2022 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiDRR45 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiDRR45 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 13:56:57 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C03134BA3
        for <rcu@vger.kernel.org>; Mon, 18 Apr 2022 10:54:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a11so10531756qtb.12
        for <rcu@vger.kernel.org>; Mon, 18 Apr 2022 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/3BcuTzSL75+vMpG3I84IOJFAf0o/XYXX55kXrSgsA=;
        b=oCrYPa0Ue6shF2cDjwduw7VSc0g8tDjaEIi3UcpJlQXQmxiYX1ZKxX0uLXsDq+RSpK
         aRvW5EYbPlv0EN+F9owmIJZH2+7Q21kE2qOz5VJz0d/xgLAtRcdrrnoVaZXyrd+kUKc2
         9Jel7y8OezFrIonMhIerVWGdJE9vsS25e5HyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/3BcuTzSL75+vMpG3I84IOJFAf0o/XYXX55kXrSgsA=;
        b=uKciEFHd6mA4xqjmBexBKviC+NYUWlZyZ7G8CyVmLzkI5NWfSXGmWp4opRbUfmKa6Z
         cfzyj9CmYMPefvys/PXi9kR197COR43sZhSe9yc0gkIWdk01IsnymNBdl+KuRj86QOgq
         Bf2VG4uEIDokCKr1BGKzeUgJU7JQ7pMq++shWPcb2lID3R8g2g5cTFiFccgJYpo02rES
         PvzLygCLVcAQEAVLT/OEYX8SoN19IDfwaKc53XShcHKL96ERiDlrTYhfuSiN+6t88keT
         eyCi4QsAvRi0kbX0A1JqIZ6aMvW6BEV/j3wFKFYp4LuH92ufUldlVLULZC7vaWcCmf4e
         F0lQ==
X-Gm-Message-State: AOAM530XD37S8VdD6/onzx0mNw6D7Qa1gCtXJuw8vq+3OXzZCYs+smmr
        3hdCt0RN8n0k6lyX0Yl1oEyH+g==
X-Google-Smtp-Source: ABdhPJwoUHqFe2AP1ZSUvAqOZkicUs2BfMutZZiDRiMFhS1StWPKpd8/WPR+hk0zFvUY5FW0saTGfQ==
X-Received: by 2002:ac8:5c42:0:b0:2f1:e7f8:3e62 with SMTP id j2-20020ac85c42000000b002f1e7f83e62mr7955509qtj.41.1650304456715;
        Mon, 18 Apr 2022 10:54:16 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id u12-20020ac858cc000000b002ef01d55d2asm8461531qta.78.2022.04.18.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:54:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: [PATCH v4] rcu/nocb: Add an option to offload all CPUs on boot
Date:   Mon, 18 Apr 2022 17:54:03 +0000
Message-Id: <20220418175403.2553842-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
which ends up not offloading any CPU. This patch removes a dependency
from the bootloader having to know about RCU and about how to provide
the mask.

With the new option enabled, all CPUs will be offloaded on boot unless
rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
v4: mostly style related fixes.
v3 is back to v1 but with a config option defaulting to 'n'.
v2 was forcing the option to override no_cbs=

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 kernel/rcu/Kconfig                              | 13 +++++++++++++
 kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..4beb15ccac1a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3506,6 +3506,9 @@
 			just as if they had also been called out in the
 			rcu_nocbs= boot parameter.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	noiotrap	[SH] Disables trapped I/O port accesses.
 
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
@@ -4398,6 +4401,9 @@
 			no-callback mode from boot but the mode may be
 			toggled at runtime via cpusets.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bf8e341e75b4..746a668bf81d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -223,6 +223,19 @@ config RCU_NOCB_CPU
 	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_DEFAULT_ALL
+	bool "Offload RCU callback processing from all CPUs by default"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  Use this option to offload callback processing from all CPUs
+	  by default, in the absence of the rcu_nocbs or nohz_full boot
+	  parameter. This also avoids the need to use any boot parameters
+	  to achieve the effect of offloading all CPUs on boot.
+
+	  Say Y here if you want offload all CPUs by default on boot.
+	  Say N here if you are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a0..f648f773600a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1166,11 +1166,21 @@ void __init rcu_init_nohz(void)
 {
 	int cpu;
 	bool need_rcu_nocb_mask = false;
+	bool offload_all = false;
 	struct rcu_data *rdp;
 
+#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
+	if (!rcu_nocb_is_setup) {
+		need_rcu_nocb_mask = true;
+		offload_all = true;
+	}
+#endif
+
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
+	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask)) {
 		need_rcu_nocb_mask = true;
+		offload_all = false; /* NO_HZ_FULL has its own mask. */
+	}
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (need_rcu_nocb_mask) {
@@ -1191,6 +1201,9 @@ void __init rcu_init_nohz(void)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
+	if (offload_all)
+		cpumask_setall(rcu_nocb_mask);
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.36.0.rc0.470.gd361397f0d-goog

