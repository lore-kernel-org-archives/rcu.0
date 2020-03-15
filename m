Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D37C10F29
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4791F206B1
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smhWEmtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgCOSSv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:18:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33322 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgCOSSv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so16080472ljp.0;
        Sun, 15 Mar 2020 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJ7uIuL9CjPfFt/IudeOvEqyUqvr+fcEsYDbZzUmAIE=;
        b=smhWEmtBdx6x8ei8WPFJ9ijTXpEcDhEVQTQHer2FRWqQOWGsdutl9D2aaL2XS7uNDr
         UoSkx1c4ivkC9zMc86acjh6wbKpVkyXnPziB7d6P+xg3ux58fdHaaw/Ktmh1rhrxC8uh
         Ht//n/i8pmbc5vqVHenUISn6M7DjF6omL2na/ApARgAR8/JyP1ofwhAZu5VyPJHlvzas
         spUxxUHVYqrz04+jjBv8tnzhPWgee4lU2govDYlvzfAj/Ahzbx4iw1XdDNMTyXY/EuRZ
         JUNyGbLXdDBE688nJOyRRuxXRXGGvHV+HzM1sRkRm+d02Mhrn+ecAyAER4JPwAbybhBj
         f2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJ7uIuL9CjPfFt/IudeOvEqyUqvr+fcEsYDbZzUmAIE=;
        b=N8lHG1oulm+9NjHGoQF8w7QSQJD4IDjWnB/hKE+jtzJ5xdRdIozza9XDgNU8FieF4e
         dG69qnLoUgjQbmwl0dM0SZI8wGW2d7HfT3KDbyq8WjPOjDbyDqNZe9i1R6Kxc1e+qBuP
         t1QbR6koNtlOKdDV3xT9LllUux2j7pYfXt4jdFSpY1RczyGageNQ99LlMw3PG5uGeX3G
         PPITxKSv+7yvxwtI67Ej1/hOkoyDc8jfw/zMXim9ku+Rn2fJEy2B0AeJjVmaM3Nz2ZUM
         n7bDW+LVk+WUWguPUiin2yAdZIsJ5KY6T6aqqB5gUI970hU+MoSD9SvLaauojkpraCMT
         f15A==
X-Gm-Message-State: ANhLgQ2Kd2zDiD8XZEHuG2bh5J4v/vkx2xdRpEPyF+HNUIwG55fZMWJW
        2b8US3ITv8qGwTW+I7OjET6MKr7H9HLo5Q==
X-Google-Smtp-Source: ADFU+vtgI9ZpY5AaKJSijXVCf7AAHMBgs7EYJv8PIGQcUVGJ9kq5rHtNa3uYxqU7mJbhIZbeD7fGcw==
X-Received: by 2002:a2e:9dda:: with SMTP id x26mr7555268ljj.199.1584296329680;
        Sun, 15 Mar 2020 11:18:49 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:49 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 1/6] mm/list_lru.c: rename kvfree_rcu() to local variant
Date:   Sun, 15 Mar 2020 19:18:35 +0100
Message-Id: <20200315181840.6966-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315181840.6966-1-urezki@gmail.com>
References: <20200315181840.6966-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename kvfree_rcu() function to the kvfree_rcu_local()
one. The aim is to introduce the public API that would
conflict with this one.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f3..386424688f80 100644
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
2.20.1

