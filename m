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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB59C54FD0
	for <rcu@archiver.kernel.org>; Mon, 27 Apr 2020 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE89D206BF
	for <rcu@archiver.kernel.org>; Mon, 27 Apr 2020 11:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWJeL57x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgD0LLi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0LLi (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 27 Apr 2020 07:11:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F556C0610D5
        for <rcu@vger.kernel.org>; Mon, 27 Apr 2020 04:11:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so13454589lff.2
        for <rcu@vger.kernel.org>; Mon, 27 Apr 2020 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Asw9tqE4/cLTmlTUoE8ln3vIOlzdWNXgzJMQ+xZMncE=;
        b=eWJeL57xKjIdcl9oZXC1vkTlvvg9YfjDLhcu1Cd0uqlFCE1NorBR7hzN77e0N5d8Yk
         YjP1fx9C7hcCgx8/38G4XxzBWuLwHjVpCwK80WmYP6y/r9KjomfL6WRSzzEqbycBmCjK
         um7BTp5HYod5r5vom1tOJZKOwMpeGvCJi8+FpUjMdY3JDZjK68pYA2p/76iHPKFdrorh
         E6Yj7l0K1/Ho3X2TAHjIQo5CIRrBIuDwSufLkfLMF6n/NK9ueU6PHNMouAoDlf1BLZtA
         K2l9E12XdRY49nm7q2QxffzFxMdmnHfoIdkloQqPrS1kAIZRM9e3K45i8mXIw1qWIPgH
         tfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Asw9tqE4/cLTmlTUoE8ln3vIOlzdWNXgzJMQ+xZMncE=;
        b=Uxs1jTjynm3wztFbcPMp1ZHKc1nmBVGxMk1i24mn5rAEljKGDFo+lmFfq7pdQ8Reat
         slmZggg7JCbPHL1bH5DV1PzowS5RTUObER0Y5ucPUS+fZFjmDF6B9F+wxnhl+ZgfA52C
         pJ9TwJAf08AKT+e0Q2R9jUphf4+iMVHSPstCxZ90nEP51prFRomF2KVSm7VJEJ7+cYSr
         sw8L6dQLFLkQvJbzFSqn2xsEi6rcIiJJc0JLqXsEUDUwt2Q9ZVnUr5I6Dcu6VugmXEWO
         qz2Kk8HUT9vJommpYCxc5YiNHhcD5y6iK6kC+kblWCvTqZTZ8KiMxy0PF4t6aZmMjXqD
         XMCw==
X-Gm-Message-State: AGi0PubrtDy3kMYXa3XBpdy089DFLNUjlWWGuhLzQdTjKuHLL3jJ4gzR
        i0/JpNm8VbpTjmqrOtV2NHQ=
X-Google-Smtp-Source: APiQypLw8DW9AwQv3dkvfZ5hQ/5oRokvuW9JiFJXNwoehEERY+TOUoOzKfXkYpintyuLzTJpr4I3Ag==
X-Received: by 2002:ac2:4546:: with SMTP id j6mr15479058lfm.203.1587985895897;
        Mon, 27 Apr 2020 04:11:35 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm9853867lje.19.2020.04.27.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 04:11:35 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org
Subject: [PATCH 15/24] mm/list_lru.c: Rename kvfree_rcu() to local variant
Date:   Mon, 27 Apr 2020 13:11:04 +0200
Message-Id: <20200427111113.5956-15-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427111113.5956-1-urezki@gmail.com>
References: <20200427111113.5956-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename kvfree_rcu() function to the kvfree_rcu_local() one. The aim is
to introduce the public API that would conflict with this one. So we
temporarily rename it and remove it in a later commit.

Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4d5294c39bba..42c95bcb53ca 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -373,14 +373,14 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	/*
 	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu().
+	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
 	 */
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
 	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static void kvfree_rcu(struct rcu_head *head)
+static void kvfree_rcu_local(struct rcu_head *head)
 {
 	struct list_lru_memcg *mlru;
 
@@ -419,7 +419,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu);
+	call_rcu(&old->rcu, kvfree_rcu_local);
 	return 0;
 }
 
-- 
2.20.1

