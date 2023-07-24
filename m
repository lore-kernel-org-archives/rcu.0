Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A67C001B0
	for <rcu@archiver.kernel.org>; Mon, 24 Jul 2023 10:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjGXKPE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Jul 2023 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjGXKOk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Jul 2023 06:14:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F4C469B
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 03:07:03 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a1e8fe2cbbso463333b6e.0
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193222; x=1690798022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IhUpcns1yxxzymDv5YqZr0WL/UQLCqdNy71sVoDGM4=;
        b=BPKemEhxYEDEF/Js9BhgLDhz6pJWUl9xalMzWVM1mWWQ+ZV8rdwCwwH4XzaKO2jw63
         UOS4sMP0IVtODZD3oFVFJ8+TMA35YuacaDfZstOmg/zMd16J98ikMFD++tLvTjwl9eVP
         QtIPUg1EDgdfe4E/I7jgQcXlEJPazlqZIoq0sdEyS4WL+/hZkTgvrkFtvWAWC1oyzkT/
         iKEny1jj3z1rfIYCi3W5flNqDmMGvpZ30hrMtadvOH/hqN53QeW4Y76qHg9rJPd6LBWo
         iEWoHnJ2R2bEw5uinyUQDj1raCF/K+jhmhJRcTmC0OlkOVUd7p5bGkKYvKZEEDoYDc3E
         h3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193222; x=1690798022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IhUpcns1yxxzymDv5YqZr0WL/UQLCqdNy71sVoDGM4=;
        b=dJKrBICIGruS+QroToNaW/pojTKYIpjYPHET0+7313Y374ErDg7/1g2Y8xg6nNwoMy
         hBdmTNQWKBIDmJSD/nOy+9indrcriiUgH51qNz+rKewx0xNL7gm9b5c/rseiCo845C3h
         UT2+vEtfp7rtWO/nIhu68udIQ/8MhQzDVlwtBK/Y2gzn8O5Rk06H8F96hlH60M9iq6ur
         W0/bUrDf05P1bbcrJnq2ACOqSoryTvjTlGSa/tbcn0YzrOld9JZTnro/JPMMavyB8Jvh
         CurH6DcAeXBAovqTkd4Oy7hggp06OspVuAB8rqBXyXVZREK4VR4E327fBUcmPRjdUopw
         v3KQ==
X-Gm-Message-State: ABy/qLaY8vRomSL59ZM7tXBMiATcD15rk+k/r0vtbJ2HXOR29eO6rXlD
        h2vJhGbDXEAxKNHbjwZY9Va2avgXCn/DoSUhkio=
X-Google-Smtp-Source: APBJJlHBx7nK5g3+kldzxnSt3u+r3r/G3QW+9x74hGsko9rk5z0xsgiAGVczPyEk+gpBI6IeMpdddg==
X-Received: by 2002:a17:902:dad1:b0:1b8:aded:524c with SMTP id q17-20020a170902dad100b001b8aded524cmr12547787plx.1.1690192373829;
        Mon, 24 Jul 2023 02:52:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:52:53 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 39/47] zsmalloc: dynamically allocate the mm-zspool shrinker
Date:   Mon, 24 Jul 2023 17:43:46 +0800
Message-Id: <20230724094354.90817-40-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the mm-zspool shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct zs_pool.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/zsmalloc.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 32f5bc4074df..bbbffe313318 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -229,7 +229,7 @@ struct zs_pool {
 	struct zs_pool_stats stats;
 
 	/* Compact classes */
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
@@ -2082,8 +2082,7 @@ static unsigned long zs_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
 	unsigned long pages_freed;
-	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
-			shrinker);
+	struct zs_pool *pool = shrinker->private_data;
 
 	/*
 	 * Compact classes and calculate compaction delta.
@@ -2101,8 +2100,7 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 	int i;
 	struct size_class *class;
 	unsigned long pages_to_free = 0;
-	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
-			shrinker);
+	struct zs_pool *pool = shrinker->private_data;
 
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
@@ -2117,18 +2115,24 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 
 static void zs_unregister_shrinker(struct zs_pool *pool)
 {
-	unregister_shrinker(&pool->shrinker);
+	shrinker_unregister(pool->shrinker);
 }
 
 static int zs_register_shrinker(struct zs_pool *pool)
 {
-	pool->shrinker.scan_objects = zs_shrinker_scan;
-	pool->shrinker.count_objects = zs_shrinker_count;
-	pool->shrinker.batch = 0;
-	pool->shrinker.seeks = DEFAULT_SEEKS;
+	pool->shrinker = shrinker_alloc(0, "mm-zspool:%s", pool->name);
+	if (!pool->shrinker)
+		return -ENOMEM;
+
+	pool->shrinker->scan_objects = zs_shrinker_scan;
+	pool->shrinker->count_objects = zs_shrinker_count;
+	pool->shrinker->batch = 0;
+	pool->shrinker->seeks = DEFAULT_SEEKS;
+	pool->shrinker->private_data = pool;
 
-	return register_shrinker(&pool->shrinker, "mm-zspool:%s",
-				 pool->name);
+	shrinker_register(pool->shrinker);
+
+	return 0;
 }
 
 static int calculate_zspage_chain_size(int class_size)
-- 
2.30.2

