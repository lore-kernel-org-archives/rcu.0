Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C818C32771
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351598AbiHSUtS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351437AbiHSUtN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E603B5A5D
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so4095082qkl.10
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lNcAKp5cSys1fGk6soAVHXz41xwD4aYJNt/yj8PSxMI=;
        b=Z5NOz5b17X7HfkZzJOmU+TrGq9k9v7VqVqcjqBeqEHaupK1YDx6isupnlPQZnlKJoi
         skTSm0cZbcoldx2512oPzJfb96Sm6Fkf1RxlhKRuXxSIirY3obUi/9OvTDhEwlG2rkKx
         olPINJzLr6/w6LKuFHLL3aqhVPRvriUt+oUZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lNcAKp5cSys1fGk6soAVHXz41xwD4aYJNt/yj8PSxMI=;
        b=WGBAjol1g/XMjSp6KVrGrbi5T2tXnpryfPUNKhK1glpPVtqO/G0QzZtrMdwXHUHmaq
         iB169UqAAY2Jtk+An7pzzRFlW3Dmv9Wj1jcS18qW+IeP9t2b+MYxgX466I0zNZysOwa3
         t99C/1hHg7J+rsmmIMY1exnd0J0t6w6hrX35wT4DMoXdb1AZ9lnkfFQbM+Jv7MnIynU6
         5FapN2LBVpmcZpj9Whj8I4Hkx2PpuFR+7YCIf8psDVghTQxs0StGpHU0zxyMcSVE2mtq
         xOG/zjMtgeif1ggH5SCwhZeWXUde1IxSZD5pDEGQ3nDrlROhKfSKtbxHTpiXgoHvAzIo
         mIsA==
X-Gm-Message-State: ACgBeo3c8xsc9IEnVbYsNox1m27yXzKk+x56XWueUPcASOSzPnTvqEWR
        wHutcf25UxmfxoQt9qw8/4JM5Q==
X-Google-Smtp-Source: AA6agR4Y+4r+MWffKODfxjuKe49rH8feKDIxdpzllu1ok0KwILGkckGGq/CDgdkru5b5f1OB/tBAUg==
X-Received: by 2002:a05:620a:290d:b0:6b5:cecc:1cab with SMTP id m13-20020a05620a290d00b006b5cecc1cabmr6185949qkp.465.1660942148400;
        Fri, 19 Aug 2022 13:49:08 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 06/14] debug: Toggle lazy at runtime and change flush jiffies
Date:   Fri, 19 Aug 2022 20:48:49 +0000
Message-Id: <20220819204857.3066329-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Enable/Disable this feature by writing 1 or 0 /proc/sys/vm/rcu_lazy.

Change value of /proc/sys/vm/rcu_lazy_jiffies to change max duration before
flush.

Do not merge, only for debug for reviewers.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched/sysctl.h |  3 +++
 kernel/rcu/tree_nocb.h       |  9 +++++++++
 kernel/sysctl.c              | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 2cd928f15df6..54610f9cd962 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -14,6 +14,9 @@ extern unsigned long sysctl_hung_task_timeout_secs;
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
+extern unsigned int sysctl_rcu_lazy;
+extern unsigned int sysctl_rcu_lazy_jiffies;
+
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index edb4e59dbf38..16621b32de46 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -266,6 +266,9 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 #define LAZY_FLUSH_JIFFIES (10 * HZ)
 unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
 
+unsigned int sysctl_rcu_lazy_jiffies = LAZY_FLUSH_JIFFIES;
+unsigned int sysctl_rcu_lazy = 1;
+
 #ifdef CONFIG_RCU_LAZY
 // To be called only from test code.
 void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
@@ -292,6 +295,9 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	unsigned long mod_jif = 0;
 
+	/* debug: not for merge */
+	rcu_lazy_set_jiffies_till_flush(sysctl_rcu_lazy_jiffies);
+
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
 	/*
@@ -697,6 +703,9 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
 	bool wasempty = false;
 
+	/* debug: not for merge */
+	rcu_lazy_set_jiffies_till_flush(sysctl_rcu_lazy_jiffies);
+
 	/*
 	 * Each pass through the following loop checks for CBs and for the
 	 * nearest grace period (if any) to wait for next.  The CB kthreads
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b00f92df0af5..bbe25d635dc0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2450,6 +2450,23 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_RCU_LAZY
+	{
+		.procname	= "rcu_lazy",
+		.data		= &sysctl_rcu_lazy,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "rcu_lazy_jiffies",
+		.data		= &sysctl_rcu_lazy_jiffies,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
+
 	{ }
 };
 
-- 
2.37.2.609.g9ff673ca1a-goog

