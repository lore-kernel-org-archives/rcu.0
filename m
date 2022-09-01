Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DFFC54EE9
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiIAWSF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiIAWSD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C955809B
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l5so143253qvs.13
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5Y5kbAl2ZL0hvyMP3+b8/GM5tIuNKa2oHKBHOOJke14=;
        b=DLk0B/+Kjl2sEDnaJ5HNoOkF5QFsAHl3d/WO0kQdWt7MwUX6E9cr00jSheEW6r0ohh
         eKqnQ2mBJFjJ3kK0CphbuerOCVjht107mlZlGLAxmmWEJQT3dq2Zm0nFUcX0KPUZ68Qt
         UbZiWOQ9CWe4p662dEMWk9EB4AQrJh0Qr8MdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5Y5kbAl2ZL0hvyMP3+b8/GM5tIuNKa2oHKBHOOJke14=;
        b=QdrS3njLdULSc0ep+td3HuyhS/qF20BbN6acPC4uFvaekvOZ8nlfC2d9fFHzGEuRrQ
         f6s6eep1iom4LgHyxx15+zcYYIiXrLKvtedMc9c6kOZo46V0okodoX3ckEtUtHD6py35
         nbDDhPJyVloUI7Xdk/jhpy24Wf19fD/YTddz8hYIWWbVQHqNzXXUTALouN+PKxuZQbDv
         83A+9MtGjDuSgOfK4X5yecGI/URuqiCPZ17/8OQdpETRhOT529ScdWs+afafKd1fRPlO
         kN5PIMDb+1bz+KtHNNKhC/vUp1SUy9BXCN5NaXeV8gVtDnOcVsAY5e7zpGECCntF6fTO
         2kQw==
X-Gm-Message-State: ACgBeo0khpQm64A9P8iwzLuougRb+tbiDC7/NWX0pB9mOqcLMCriRGAQ
        jIqM/x4KA+X276jeaYyCeQzKnxLPGJNiow==
X-Google-Smtp-Source: AA6agR5SVRH/RM5xAYfxYhk8E1h0qVAjY9FUK/2Tu/dAn793HN5Tons0Nj46w1jA+Idc8q2jHDCtow==
X-Received: by 2002:ad4:5bc2:0:b0:499:2c2c:1b0b with SMTP id t2-20020ad45bc2000000b004992c2c1b0bmr4677172qvt.115.1662070682335;
        Thu, 01 Sep 2022 15:18:02 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v5 07/18] rcu: shrinker for lazy rcu
Date:   Thu,  1 Sep 2022 22:17:09 +0000
Message-Id: <20220901221720.1105021-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Vineeth Pillai <vineeth@bitbyteword.org>

The shrinker is used to speed up the free'ing of memory potentially held
by RCU lazy callbacks. RCU kernel module test cases show this to be
effective. Test is introduced in a later patch.

Signed-off-by: Vineeth Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 7e97a7b6e046..560ba87911c5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1333,6 +1333,55 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+static unsigned long
+lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		count +=  READ_ONCE(rdp->lazy_len);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		int _count = READ_ONCE(rdp->lazy_len);
+
+		if (_count == 0)
+			continue;
+		rcu_nocb_lock_irqsave(rdp, flags);
+		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		wake_nocb_gp(rdp, false);
+		sc->nr_to_scan -= _count;
+		count += _count;
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+	return count ? count : SHRINK_STOP;
+}
+
+static struct shrinker lazy_rcu_shrinker = {
+	.count_objects = lazy_rcu_shrink_count,
+	.scan_objects = lazy_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1367,6 +1416,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-- 
2.37.2.789.g6183377224-goog

