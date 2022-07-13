Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2075ECCA479
	for <rcu@archiver.kernel.org>; Wed, 13 Jul 2022 21:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiGMVdE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiGMVdC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Jul 2022 17:33:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A1357CE
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:33:00 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l2so9454694qtp.11
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnuh9DRpicbbN00vi9y+Nvgl395m8SvJRn+/VVTeXdo=;
        b=b3Tf51aLPLE0rnLyeQiWMDZ/Z5z17EjXZe+zkaIYnBzfWOeVI8vtSewi2SE4aTPF+1
         Ha9/dFYpXzObV6yccy17Vmjp8ysdiXNd/PMSQtEk/39Gszalm2VqMqwyNrEHZ6LxIxQM
         jUVJzO1R/GQ4kXUoLz8poK/uVvOkGve33fQ8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnuh9DRpicbbN00vi9y+Nvgl395m8SvJRn+/VVTeXdo=;
        b=aNyK+TiTjUPzX62uABENLg5QRj+hT7K8KOQnaKIoqP1OnOoxWRy9boNUDxb/jgcRrp
         WoleWbfarDk+rajZnAUJtutv0yrJH48FdxRarLSVkrZd9SgnbNVpGB+crJKn6w1+pkjv
         RQ2eXVdFzjcNAwfvSj6wQGlLezrCHapplFJjdDq4shB/RjUkNMyoPoW943CzFDitN6x/
         PkiGB/2keuyL1b/Bm9VhD5KUPMMLSVFHv08s2y1AiSxNrFGIZXF07VysVgbxFqcEByXw
         j5GrPljGMjTXbOlllDM1FmcODPSZqarcW+HmYByK3wRLxWeWUg9zhKcwVMN6vYT/58QC
         O8eQ==
X-Gm-Message-State: AJIora+91QOa3re1zpHrYZuSKRJrpppKSdtVqDFJoK1mQjUKtso/bL1u
        E/IMWPufqlK101+rqJ4bypWLsVTRZmZtgQ==
X-Google-Smtp-Source: AGRyM1s4Ru6/TRP5ftaqXfLBEZP8U0srddLBAWqYA/af6DTuWkwVFmEfiHtwmzD3l9E/C+divNxGLA==
X-Received: by 2002:ac8:5b90:0:b0:31d:42af:e107 with SMTP id a16-20020ac85b90000000b0031d42afe107mr5090471qta.457.1657747979421;
        Wed, 13 Jul 2022 14:32:59 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006b5988b2ca8sm6791163qkn.40.2022.07.13.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:32:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/5] rcu: shrinker for lazy rcu
Date:   Wed, 13 Jul 2022 21:32:34 +0000
Message-Id: <20220713213237.1596225-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220713213237.1596225-1-joel@joelfernandes.org>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
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
index 61b1409bd4d6..f8d7255f4f0a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1249,6 +1249,55 @@ int rcu_nocb_cpu_offload(int cpu)
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
+		count += rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
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
+		int _count = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
+
+		if (_count == 0)
+			continue;
+		rcu_nocb_lock_irqsave(rdp, flags);
+		rcu_cblist_reset_lazy_len(&rdp->nocb_bypass);
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
@@ -1286,6 +1335,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-- 
2.37.0.144.g8ac04bfd2-goog

