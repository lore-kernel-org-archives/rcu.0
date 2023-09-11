Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF445CA0EC9
	for <rcu@archiver.kernel.org>; Mon, 11 Sep 2023 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbjIKV63 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjIKJrs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385D9E4A
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 02:47:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0efe0c4acso7086885ad.0
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425642; x=1695030442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO5XG1oNP6pUjS3WN2+RrRDElLAKlnsgenuSaZhp694=;
        b=CwGNapEsGEKLOP1WtNH0uwIv9Lr9oKEL35X/KtieiyH9m5IoCCEMLpq2cAk5aBg9wa
         K5Ycps6CA2+bGZuUNVF93Vjtx1PyH2OyaHPcSMsfJfZ8XxVfhcmsHf4xVMkfLfjwtKGc
         /L3HcDLGW2qEUyYkyxNjql2X8XBxk4dW6MppiV+JNYEo2AwcB+DYWtFt4wWNmz2YLKYK
         4UKN5C1e6q0tSUQxE0RQymndbGMCVN9sL4toX1mVbAht8dsRIhuFcF9IH47NvACTC/TY
         IEZxV2scnE31dCjQqTOjdN8Jk3KWmlzjeJeNyKqhUzZIf0nfDNXZEyjyc3t0XbE7GqbC
         DyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425642; x=1695030442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO5XG1oNP6pUjS3WN2+RrRDElLAKlnsgenuSaZhp694=;
        b=Mbl///ZLKliwnASR0A7WSLq7HF3f890liZqmX2QYMzns9DEs+bj9MiQbds9ngHXXjc
         6kHIP45N1BkhYa0fTqn0o7+5LefQ8rt67ql9vJeFjyE0n7Y/An0aH2MkluhxLVWMsZDz
         H95WqheKhIvJARN2F/s2+dBjZ+p0cOiad5cqfZUlAPyTNoRnQGum6DhNm6JvLn5IGx6+
         u+FZ3UNIOxDIwSo94WzNky9U4RJSJ61vLkOVqX3k71Un3FNYQNSm/UASvhYda3mkjC7R
         OEyfBl9symM2AAMOKTySmdliuL2ACJtl77Ec0ezryFzd3lVcz7a3VSDldPvogxpapPxJ
         xxKA==
X-Gm-Message-State: AOJu0Yybx4khP0legqpn0DM0WC2AJNG5XH7RWJt+Act+01jfKEwph18s
        rJrgkShp844UkOg0hkfIQIpAlg==
X-Google-Smtp-Source: AGHT+IGU0jWm5aUKgo65aoc1FmWqzP1rWPbNbFl1TEnUeGhWf2rII1K9xqSMkpAW8Vpnx3sOpXBIKg==
X-Received: by 2002:a05:6a21:a594:b0:13e:1d49:7249 with SMTP id gd20-20020a056a21a59400b0013e1d497249mr13273426pzc.2.1694425642605;
        Mon, 11 Sep 2023 02:47:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:22 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH v6 15/45] rcu: dynamically allocate the rcu-lazy shrinker
Date:   Mon, 11 Sep 2023 17:44:14 +0800
Message-Id: <20230911094444.68966-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Use new APIs to dynamically allocate the rcu-lazy shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: rcu@vger.kernel.org
---
 kernel/rcu/tree_nocb.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..4efbf7333d4e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1396,13 +1396,6 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 	return count ? count : SHRINK_STOP;
 }
-
-static struct shrinker lazy_rcu_shrinker = {
-	.count_objects = lazy_rcu_shrink_count,
-	.scan_objects = lazy_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
 #endif // #ifdef CONFIG_RCU_LAZY
 
 void __init rcu_init_nohz(void)
@@ -1410,6 +1403,7 @@ void __init rcu_init_nohz(void)
 	int cpu;
 	struct rcu_data *rdp;
 	const struct cpumask *cpumask = NULL;
+	struct shrinker * __maybe_unused lazy_rcu_shrinker;
 
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
@@ -1436,8 +1430,15 @@ void __init rcu_init_nohz(void)
 		return;
 
 #ifdef CONFIG_RCU_LAZY
-	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
-		pr_err("Failed to register lazy_rcu shrinker!\n");
+	lazy_rcu_shrinker = shrinker_alloc(0, "rcu-lazy");
+	if (!lazy_rcu_shrinker) {
+		pr_err("Failed to allocate lazy_rcu shrinker!\n");
+	} else {
+		lazy_rcu_shrinker->count_objects = lazy_rcu_shrink_count;
+		lazy_rcu_shrinker->scan_objects = lazy_rcu_shrink_scan;
+
+		shrinker_register(lazy_rcu_shrinker);
+	}
 #endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-- 
2.30.2

