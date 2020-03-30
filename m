Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77024C2D0F0
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0922083E
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rxDfrhuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgC3Cde (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33994 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgC3Cde (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id 10so13936997qtp.1
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9u1d7Nq8RT0AOHNZvylOBJ81hqFkLhdoH0L2zGb794=;
        b=rxDfrhuk8LqW6ZnmW+LnImOtpzM2Zw9S69J/P+yG2hd6Vw5mMl8yBevuQ6ntcQkpt1
         6sS/aa7qsRAXfO8SA/uVHNRUM3XnlchLsYPPO6idkXfPZNHXzbwNfmaWP7vJXU7yG8GR
         cAXpIptCUsYctVOx9/SD1kmPf6JJ5CIL5InT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9u1d7Nq8RT0AOHNZvylOBJ81hqFkLhdoH0L2zGb794=;
        b=buKaZVQ6gyqse3mTijk04xQc373gfGqpnBr8JqkGGwlkKFjqsiiLtyIOYwOvVjYBty
         M3OiFzwk9suSPR1jZhOtoNdkL/n0HG3DJ5SNViiU2nkNJe4bwBNRdhHjZIFqjGHjLQxC
         M7PzWDpeIv0C9QZkmh+I2b2nmfTcZDWl2cE/Pk4S1D8MSgaNH6yQNqMiCWfuJd5fpK1t
         05rCTU64AocxcG3If0c2fhnem7nK5Nylv6C2H2lwesez3bHMcKXUxEbxj60nrsilDfQX
         HuFpxTnBLWnwz43aPn3Nb2Q+zEOzJCqoVMdYByYrNIYP1BEQOi2M4qxvVOww/KB0BOqr
         zTZg==
X-Gm-Message-State: ANhLgQ272Qgxbw25kU8r8ejVRuNTE5Hj7yf4epFH2/4NHn9puhm1d7f0
        gke5Vmk6og0tY44i/AEVxaDcZA==
X-Google-Smtp-Source: ADFU+vtJ/nFZMvAXPR8p2akuS9nHt322wcY7VnnK+V09LMOq6oHXy/eGbZOe0mEFY2W1AiDcgsCNJg==
X-Received: by 2002:ac8:72ce:: with SMTP id o14mr10086333qtp.226.1585535612029;
        Sun, 29 Mar 2020 19:33:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 01/18] mm/list_lru.c: Rename kvfree_rcu() to local variant
Date:   Sun, 29 Mar 2020 22:32:31 -0400
Message-Id: <20200330023248.164994-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Rename kvfree_rcu() function to the kvfree_rcu_local()
one. The aim is to introduce the public API that would
conflict with this one.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f36..386424688f805 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -383,14 +383,14 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
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
 
@@ -429,7 +429,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu);
+	call_rcu(&old->rcu, kvfree_rcu_local);
 	return 0;
 }
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

