Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BE1C433F5
	for <rcu@archiver.kernel.org>; Thu,  7 Apr 2022 21:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiDGVJz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiDGVJy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 17:09:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD303179B30
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 14:07:53 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f3so5989110qvz.10
        for <rcu@vger.kernel.org>; Thu, 07 Apr 2022 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxKxY+DBpoByF0mtjo+UB7bPjCEPBSOvES4J4XomWfw=;
        b=jwQg9dQrHOSiG8lPloLqQ/bp8O7sK5UOZyz9D/aVa4j2kiHcO2my5h+zwWBcJxgOC0
         z6UbFO8G2TDI4B9chEJiAFxEa79J08iPbDo3ggVSuH2+rR9uPX++uhbY28MqAULtWQvO
         JoiusccmH4T9pSjjUbI19eDJ4crl6IHyUGXQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxKxY+DBpoByF0mtjo+UB7bPjCEPBSOvES4J4XomWfw=;
        b=zrJYZY/i+krdPXjPRhd5Bkwl6ERT0yHIh91YuiVDtmm/7wlKnIImYHb8cS+z0b9rBX
         vBFo8zac6b6BrB4K1kqzlam5gKndL8klvSi8fOEdyzH8RvKSEp3cYnQ9q0p9voaCJVWZ
         h61W3VsnWdWr7rOWpl5DALnv+Av9pMzfSDSuGFS4k+1mgrZbJH/+NN0hcxhd5VT+5yI5
         LG5Pzwyc9l0eWZub/tH2tNXR0hMn3QF3d91Ea6djVyxKsntjBxkcig060oYxpv/A/vLY
         1GznYcMORPAk0APfZYTf7+44NqU7UB9uS7Vt8Pka0Dk4KIE63kpurxlsaINnXOtQ4jHQ
         f/Vg==
X-Gm-Message-State: AOAM533NxXPsEmJIrYw4XaP3uJKdZRX70FQf4JDZXa1VUTWvRtcCm5L5
        BmAyM0x1a6PSj34tgc6uhl2Mzw==
X-Google-Smtp-Source: ABdhPJzwtvpZaHmk9lriKJMPmnSalngNgvvJoX3cZ2JPuR2Hll7aVpCqu3lWkR/jk381xr2DKPRpGA==
X-Received: by 2002:a05:6214:4017:b0:443:e335:efd3 with SMTP id kd23-20020a056214401700b00443e335efd3mr14132649qvb.131.1649365672835;
        Thu, 07 Apr 2022 14:07:52 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d3-20020a05622a15c300b002eb9af4c945sm18230376qty.3.2022.04.07.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 14:07:52 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
Date:   Thu,  7 Apr 2022 21:07:33 +0000
Message-Id: <20220407210734.2548973-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
which ends up not offloading any CPU. This patch removes yet another
dependency from the bootloader having to know about RCU, about how many
CPUs the system has, and about how to provide the mask. Basically, I
think we should stop pretending that the user knows what they are doing :).
In other words, if NO_CB_CPU is enabled, lets make use of it.

My goal is to make RCU as zero-config as possible with sane defaults. If
user wants to provide rcu_nocbs= or nohz_full= options, then those will
take precedence and this patch will have no effect.

I tested providing rcu_nocbs= option, ensuring that is preferred over this.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a0..607fbf843467 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1165,12 +1165,25 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
+	bool need_rcu_nocb_mask = false, set_nocb_mask_all = false;
 	struct rcu_data *rdp;
 
+	/*
+	 * In case rcu_nocbs= was not passed on the kernel command line,
+	 * provide a sane default by offloading all CPUs. This provides a
+	 * sane default for rcu_nocbs and prevents users overlooking these
+	 * details.
+	 */
+	if (!rcu_nocb_is_setup) {
+		need_rcu_nocb_mask = true;
+		set_nocb_mask_all = true;
+	}
+
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
+	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask)) {
 		need_rcu_nocb_mask = true;
+		set_nocb_mask_all = false; /* NO_HZ_FULL provides its own mask. */
+	}
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (need_rcu_nocb_mask) {
@@ -1191,6 +1204,9 @@ void __init rcu_init_nohz(void)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
+	if (set_nocb_mask_all)
+		cpumask_setall(rcu_nocb_mask);
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.35.1.1178.g4f1659d476-goog

