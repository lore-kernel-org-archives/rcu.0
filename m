Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52FC83008
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB30E2072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQtUZub7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgD1VAX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726941AbgD1U7x (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FFC03C1AC;
        Tue, 28 Apr 2020 13:59:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so211368ljg.8;
        Tue, 28 Apr 2020 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ldgJ4636CVVH5K09ieY2CjYskH7FkK4YIkv15ewvcg=;
        b=CQtUZub7pmYCoM9rgBDRF8mOSsdyPuWwmd58ngg3Hlx0WWJBUPyU6nMUtnNSnjSvFi
         9PcXKfbggKYCYRv4M2BI1ivQVzjcHHOwxvfjfZv1cqmGM5J25fNWUENTN5J+ek9erpbJ
         SvkSqmrZut59DzXc+ag223V9aWC3r1f9IWUbXfRi3ACwJp5mu9xU0KxkgDSNH83xyk8x
         QLhcYVe1OvpcztTL865V1jatwBmH3vn/pkqoIJ7Jxj4NSloLaTRUzsuxaBjRsh1xXLeN
         hQVUWmQlPqcZEL4nguD8c7Vlkry1FfBNwpumcnUWV6vISLulSNYtcvhuKkiQPO6HLKG6
         S9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ldgJ4636CVVH5K09ieY2CjYskH7FkK4YIkv15ewvcg=;
        b=HAHeWZmHB0yvkOOhZK8ncaJl9FfVinbkkPdFWGf00qj48MZCNCSsZW4D8Jf4tq5Npw
         6JwXOz6dXKHwLkWZ0irhCRVfP/pBFU1I8C5mMKHvCRazLN0L0pom1JnG0SZbVZhAgBe7
         Gju7T56VuDV9czYzu/5dFbY+9GKoKdGElaUDMidJGPtskLY0bIJ/wqsQAwcTmrprThoF
         tVxmDnvpP803h1neM0DJyDNomPRK/fJ/8LCOLmvcCm22P3G4RIGmk0wEFd7z1qcv44iM
         5cWvfdBTSnDOTVRfvDOHSZXTiOjRZ5JrQBY6krTLTOirv0tY3nkApD1DPHmdUkKXVboG
         yGzQ==
X-Gm-Message-State: AGi0PuYunQHJ7vE6Ohd379UEJl7ZaHOZkbJRtTjCTca5ChuJxlyxXh/Y
        nR2ezDvIPZ25W7v4DKU7YVxm+vLEowjY8A==
X-Google-Smtp-Source: APiQypI7Q10ox7ABU0RMMw3dY9sgNyJEZcaL1fC+sRAcqhh5hwFSEZtLMIISQ2ZVDZMjGMbpQT614Q==
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr14996061ljp.57.1588107591349;
        Tue, 28 Apr 2020 13:59:51 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 18/24] mm/list_lru.c: Remove kvfree_rcu_local() function
Date:   Tue, 28 Apr 2020 22:58:57 +0200
Message-Id: <20200428205903.61704-19-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since there is newly introduced kvfree_rcu() API, there is no need in
queuing and using call_rcu() to kvfree() an object after the GP.

Remove kvfree_rcu_local() function and replace call_rcu() by new
kvfree_rcu() API that does the same but in more efficient way.

Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/list_lru.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 42c95bcb53ca..a0b08b27a9b9 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
+#include <linux/rcupdate.h>
 #include "slab.h"
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -373,21 +374,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	/*
 	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
+	 * and nobody can use it. So, there is no need to use kvfree_rcu().
 	 */
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
 	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static void kvfree_rcu_local(struct rcu_head *head)
-{
-	struct list_lru_memcg *mlru;
-
-	mlru = container_of(head, struct list_lru_memcg, rcu);
-	kvfree(mlru);
-}
-
 static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 				      int old_size, int new_size)
 {
@@ -419,7 +412,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu_local);
+	kvfree_rcu(old, rcu);
 	return 0;
 }
 
-- 
2.20.1

