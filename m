Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C3C4332F
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJPQXm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJPQXl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588AD3D5B4
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z30so5385035qkz.13
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O99Qgvv8EMn7R2VX8zNwhW7077dknEew8817iqFh+Z0=;
        b=A0iw44OIXFnSt6q7ohniyWUHk+cUylfjjbIh1F4lTWAyPpei5ZY5NInt+6TUjLZyqT
         GQbzNAYDP5YQDIpkg/1CC+ISYld8+pJRCj4CzKCHI2txJCFmFKE+xXPXb70gbpfpxqM8
         D7wxzReb589Z93lS7ZQ4saIztNiFghiEs2suw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O99Qgvv8EMn7R2VX8zNwhW7077dknEew8817iqFh+Z0=;
        b=k81aGGcIFTe2MFzyAwA3xXkEgIigv9dE3QWlVYsqedUyne3PZEnseUXsbLjwZFaK1h
         U0TugppZy+5BtM8e+8xiecs1tyOCvHJqiHGJEafAgXmX1kpoa498Of1tAsyi2yIogRyv
         9RzuQuuJg7ylb54YjOxpzUXb9uVkEtiWGD4So+2xuMC46r7sz8gGKPZkcrlq9CDkJ8Ld
         xIMpsRvYr58+g2yxMvuReIFo7LmGSvJKr5KrJLY6uNg5W/bB/EpEoFpuyRN6+O5k8W12
         sxiYkjowu5VIir9JaM+P8L3cepaWrA2Gn+JUpzwYyyt8lPlevRTXQtxi+QCvwr2YJfTM
         9IRg==
X-Gm-Message-State: ACrzQf394o+zN6FMhDrMFTGveJ8vOjptLHEeCgDb6VKxv9EJpwfhOPx6
        zcWFMzE6MuU+8TXHB13g3l5ONQS4bUG2Og==
X-Google-Smtp-Source: AMsMyM48rMeAqPyhvvqc03I7NgSbQD6HEVxx9lyonu1ZvxbY6qOShApcYXaNgcs3NNddejTreTKgYg==
X-Received: by 2002:a05:620a:191d:b0:6ee:e3cf:b2db with SMTP id bj29-20020a05620a191d00b006eee3cfb2dbmr1245456qkb.633.1665937417334;
        Sun, 16 Oct 2022 09:23:37 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org, Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v9 04/13] rcu: shrinker for lazy rcu
Date:   Sun, 16 Oct 2022 16:22:56 +0000
Message-Id: <20221016162305.2489629-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
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
index 717c0591c037..dc014a0b97b7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1312,6 +1312,55 @@ int rcu_nocb_cpu_offload(int cpu)
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
@@ -1342,6 +1391,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.38.0.413.g74048e4d9e-goog

