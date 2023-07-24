Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A9DC41513
	for <rcu@archiver.kernel.org>; Mon, 24 Jul 2023 09:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGXJrn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGXJrV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Jul 2023 05:47:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5591BD7
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 02:46:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb85ed352bso2229725ad.0
        for <rcu@vger.kernel.org>; Mon, 24 Jul 2023 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690191978; x=1690796778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ34aDXYlHmjcWHNnO8BUtZL0Yf5ZszuCt3/FkcxObI=;
        b=dPg8Z+s3aha2IvphpVKs8g7PSY6piop3d9NgPI5ubIDitgffw9A2UJF008ettaOzL2
         E1tyNH7CPDs7txXWOfoA23V8TkeR2HnX04I7DoxtzP6sL4XEnTxiiEMAs0kV9Z/otM2W
         0kOcjwbHjS6iULnGuX+LKfjLBZnKtzDuWFv8l1d9/Rkqg83rJ36ocDx6bY7GsC2wtJpk
         Mw6apkZAnLMNttQVQifEE+ksvX6HBpvA7k/G1tddocZPzT2wZK5koTXpHocOk7zUb799
         2LPg0QZl2ME3q58o3tQeyyaY1BlYV7m8Ier04lnGoxRFxPK9Wx4EcovR5xvgXGZWDCe6
         9eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191978; x=1690796778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ34aDXYlHmjcWHNnO8BUtZL0Yf5ZszuCt3/FkcxObI=;
        b=d/LtCxn8zkPBdQlXdDKagqgpoaAoK8bACY/eMe54ZEStEPS1LhsyXiNGmajvjSw2tD
         8tnj1JzSzN+b8G8asXoeXbkOQl+QRs+dhE4G5SinEiL4MovYWmOp+nE9OWk0BZIXzMZI
         HjCsO+COHezmQioyKW9KA6sP/dk1Jmlv9gSFdmqEq52943iNBTh+1R0eQaDXHPzlrJUF
         FOSLkKML8ciTr6yz8KKuhYwInRo44vblNiCVpkJpOt8MoH0kbNkWZVDL4e4eQTKtHVEG
         rkjyEtiz7iBV2QaG3ujN7X5lD47Wl4s+BJlr/MQmjvD93K3MNduDnUHf6WFGNfaCRaPB
         Hg/Q==
X-Gm-Message-State: ABy/qLarsMmF4eDfHeidZp/RA9haPA/WQWavK7Fn58BICtu7VwL1xZQs
        OSFDwPvKYOoChGE/KTyGfLNw4A==
X-Google-Smtp-Source: APBJJlGS+SYk55mAAJOUNGx8fxUIn0OJAQvX8pDu/8/ugt1o28j6t6h3zVeppHUSF07Rw5MgS0vxBA==
X-Received: by 2002:a17:902:d484:b0:1b8:a27d:f591 with SMTP id c4-20020a170902d48400b001b8a27df591mr12255719plg.5.1690191978640;
        Mon, 24 Jul 2023 02:46:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:46:18 -0700 (PDT)
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
Subject: [PATCH v2 06/47] drm/ttm: dynamically allocate the drm-ttm_pool shrinker
Date:   Mon, 24 Jul 2023 17:43:13 +0800
Message-Id: <20230724094354.90817-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Use new APIs to dynamically allocate the drm-ttm_pool shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cddb9151d20f..e1eb73d0b72a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -73,7 +73,7 @@ static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
 
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
-static struct shrinker mm_shrinker;
+static struct shrinker *mm_shrinker;
 
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
@@ -734,8 +734,8 @@ static int ttm_pool_debugfs_shrink_show(struct seq_file *m, void *data)
 	struct shrink_control sc = { .gfp_mask = GFP_NOFS };
 
 	fs_reclaim_acquire(GFP_KERNEL);
-	seq_printf(m, "%lu/%lu\n", ttm_pool_shrinker_count(&mm_shrinker, &sc),
-		   ttm_pool_shrinker_scan(&mm_shrinker, &sc));
+	seq_printf(m, "%lu/%lu\n", ttm_pool_shrinker_count(mm_shrinker, &sc),
+		   ttm_pool_shrinker_scan(mm_shrinker, &sc));
 	fs_reclaim_release(GFP_KERNEL);
 
 	return 0;
@@ -779,10 +779,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 			    &ttm_pool_debugfs_shrink_fops);
 #endif
 
-	mm_shrinker.count_objects = ttm_pool_shrinker_count;
-	mm_shrinker.scan_objects = ttm_pool_shrinker_scan;
-	mm_shrinker.seeks = 1;
-	return register_shrinker(&mm_shrinker, "drm-ttm_pool");
+	mm_shrinker = shrinker_alloc(0, "drm-ttm_pool");
+	if (!mm_shrinker)
+		return -ENOMEM;
+
+	mm_shrinker->count_objects = ttm_pool_shrinker_count;
+	mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
+	mm_shrinker->seeks = 1;
+
+	shrinker_register(mm_shrinker);
+
+	return 0;
 }
 
 /**
@@ -802,6 +809,6 @@ void ttm_pool_mgr_fini(void)
 		ttm_pool_type_fini(&global_dma32_uncached[i]);
 	}
 
-	unregister_shrinker(&mm_shrinker);
+	shrinker_unregister(mm_shrinker);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.30.2

