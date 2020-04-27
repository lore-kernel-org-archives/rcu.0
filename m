Return-Path: <SRS0=HwWG=6L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B654C5519C
	for <rcu@archiver.kernel.org>; Mon, 27 Apr 2020 11:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8332063A
	for <rcu@archiver.kernel.org>; Mon, 27 Apr 2020 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXEYwn2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgD0LLl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0LLl (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 27 Apr 2020 07:11:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8FCC0610D5
        for <rcu@vger.kernel.org>; Mon, 27 Apr 2020 04:11:40 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so13447039lfo.8
        for <rcu@vger.kernel.org>; Mon, 27 Apr 2020 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ldgJ4636CVVH5K09ieY2CjYskH7FkK4YIkv15ewvcg=;
        b=OXEYwn2ZMuWXXCHmC9HNP3jNT4y5HIqH+Ikzlkys80/gyZ+2dAxoD6qAmgR6BjSxNk
         3IjoRoFzjzkEdS/jd77MHalB3P1bK7Z0Z5wRoDj82dBD13UvtximgEa+e6Q0kdAUncpR
         IrJPs6TYJdsu/aRrd23dReAvNds9+/lFz9CX4MrNvmlP7Iy0xzBHTFfzLnM1NUmWRZzv
         3KplJV8ZHmAqYAZXQ/gD2O/2soogtdnGhnDPBNWEa1lWNaZ2e7tHHjNQ1JWGLMZDba8x
         exCKp0ebus2G20rMEQNvj+CgqUjFp8cCsE3n2Q59ADhf1w1eOPIAYY4pv2gZNKbC7wOO
         5D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ldgJ4636CVVH5K09ieY2CjYskH7FkK4YIkv15ewvcg=;
        b=cDSfpzuxsi9KgGFNAKldDopwuKzMrcpKVlJO9aYL9A8DZsZsToO6lW4cZcdPfQkmsa
         IZ1fDpx09ot7dXPjNI6HqKYMaEHEa5+SmnNNI+PGXDbNpiqjwP98T+CO4jJHWbCnoP+l
         Rp1MvqOE8Uof2zZYHI8B33hT3IcJcgnSc/+gFBmutJx40hRlDO697i9nVxW9NAC8I4pb
         2NSWnAZ9kwxWCaL5bbuK9NYl8Q2p+gRvi+sTcSbp7FWYaO8j5/FdZZQ2GrzobBR3j5Fe
         +dAqC0NHIaAqDc3ZVxay+AWEHYYov/wnOlGrMdpg0u99/m1D38EolA2Mw9dMtMsCPeYL
         c8yw==
X-Gm-Message-State: AGi0PuYjlga+OL8cWEu8hlufq/JtOpLrX+V6z68LSEOAHfWRAgM3ZhNl
        GJByTxEonD296O8AaqT4aPE=
X-Google-Smtp-Source: APiQypIwWu1Txq59pLktC8m8z8//IexkdKjlp79unijhEdHYYu4QYyxMjlqT9kfBeuSUEA/iLjVZjg==
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr14989449lfr.189.1587985898826;
        Mon, 27 Apr 2020 04:11:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm9853867lje.19.2020.04.27.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 04:11:38 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org
Subject: [PATCH 18/24] mm/list_lru.c: Remove kvfree_rcu_local() function
Date:   Mon, 27 Apr 2020 13:11:07 +0200
Message-Id: <20200427111113.5956-18-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427111113.5956-1-urezki@gmail.com>
References: <20200427111113.5956-1-urezki@gmail.com>
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

