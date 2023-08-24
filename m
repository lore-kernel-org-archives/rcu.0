Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99DEC71153
	for <rcu@archiver.kernel.org>; Thu, 24 Aug 2023 03:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjHXDrE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Aug 2023 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbjHXDqg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Aug 2023 23:46:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7811FD8
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 20:46:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-565b053fe58so827755a12.1
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 20:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848759; x=1693453559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slvH5erABEtW2nvv6nNGvvoe5mGFS1H1V89UwcERxi4=;
        b=cbb6YHTIFEQj4yQfjGUpRvykeBzedoRrcnJeHycSN6zpLxRKFd2K1sA1PClUDZpn4T
         KK49F+aIpE3Kw/cuZzQabHYGj+DcL5bEjWjkQ+qi7ft3Ev2JbxUbeVYCETHKaq602P+Y
         Q7oloE3/wd+SPkhUMg/xXEsiNT4bfTZky090yFESMFjiMV9iGF50YTAJEOHOG/FFlYOk
         wZOQ2hXf37apCQIv1XImuzja1cULLKP8EH8AUaPzctKv1kopSAYqQMUxWCHyKDVoFD4O
         R+sSI8aAT4VztFaIxvs+T3hnulNn+bEQZ9zTNyY0CnFLm+zjLyVeoOaFF/qATgaNLyIK
         PIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848759; x=1693453559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slvH5erABEtW2nvv6nNGvvoe5mGFS1H1V89UwcERxi4=;
        b=f7he6p1JPO3tDhFP/D9HXyouBAgWKieiT90Sh/A4JThsbe8QW/OBdd0c3wnT+K89WE
         5dXSpR78e/GIWb2FIarBngKKYtbcLtdkn5x49V5+f5/JDNmR4BnzVzs9IJyJvPQx2k0o
         lsou935g1yqHniE9DRMw/ek3k/JV0EJ84ASPLCa8S8F0BowVQer4X0Po4+hruN5ZBddq
         XJFGOs2ALIqm55Vd6dA1mZUDm6s3EUaocidiDB9sufNSicMEsWM39I8lsc/gFSYIsTz6
         vI0l3i9xTHTX/2GoghHuS0SDVE6YA7OTqwuZilozHCeJN6162VkgIetGWz91HG2Ak8C9
         1uDg==
X-Gm-Message-State: AOJu0YzQ++67V+yxFXPWISCT0bTZM+oteje/TiEV8wkIFOBIxpXbe4ay
        gvFphBY25BWoemmNhQBA+ev1bg==
X-Google-Smtp-Source: AGHT+IE20y+zxkxvqCK4atfI05RSclhW6cQ/eTGKWMSl83j87LaqFIyfEPTvaL3BQlf4vLg1/yn0UQ==
X-Received: by 2002:a05:6a00:1f89:b0:68a:33fc:a091 with SMTP id bg9-20020a056a001f8900b0068a33fca091mr13891773pfb.3.1692848758726;
        Wed, 23 Aug 2023 20:45:58 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:45:58 -0700 (PDT)
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
Subject: [PATCH v5 15/45] rcu: dynamically allocate the rcu-lazy shrinker
Date:   Thu, 24 Aug 2023 11:42:34 +0800
Message-Id: <20230824034304.37411-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
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
 kernel/rcu/tree_nocb.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..e1c59c33738a 100644
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
@@ -1436,8 +1430,16 @@ void __init rcu_init_nohz(void)
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
+		lazy_rcu_shrinker->seeks = DEFAULT_SEEKS;
+
+		shrinker_register(lazy_rcu_shrinker);
+	}
 #endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-- 
2.30.2

