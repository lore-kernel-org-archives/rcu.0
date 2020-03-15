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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F3C10DCE
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C1D20736
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyER+arR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgCOSTI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:19:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33351 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgCOSS6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 14:18:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so16080717ljp.0;
        Sun, 15 Mar 2020 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgKkTnOMX6ncghHWriOangneW0Lj1MTz7QUFlB/TBlk=;
        b=cyER+arRUN4tPHswUJyWF1Y0W1kj2Rw3H9LSCib5RMlxr17vX6RcfSoxJSGAxqBtba
         0KFI8YI3/6nf++K4bHegZ9MpwZnxCTBJJmxDWOHyX7LEmCD37SKE3lX9/YTI1B3Blvtv
         ibLL6ye2rk+vZNKAMQ2yEhaU4vqWgwtM9rQpQH06vsOs+3LfiJ5Kl4QisfK1upCMTCXR
         fmQ9Lg0LE7H4g/J2I+lUtBoFTfheMLy9SCcbzNqMuP4NdFSx2NcqzLzks4IOHT0zU4AM
         bEPR2QWgdo9c42FETz6v0S1k3GHXBDeVSz6bXTQ4/AQMjipinSWmBCo+6vx8H9VRiiTU
         apOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgKkTnOMX6ncghHWriOangneW0Lj1MTz7QUFlB/TBlk=;
        b=hV2sZQ4sxHGzvWrovml7J7L/cXsxwAt2OFToi9+aS4mRANH6+/rU4cbAnzXscdkrl0
         Cc1rZBXp6L+Tvx2oQKgOyp4KGkI7cBe8sVO8EDkAVfDPges0Kw9tvOLBJ6V4J7zGJjoo
         0a8KZfGazrVet8bNIwj1okhSMaoDr3wKNltd8fQ3WfhUVASANc50MEliTDaI82taUadn
         mV1OLnwOz1aye9Xfj0JgOaS2oXuPLMNeP0ERACDTulZ9aRiDCiWoejYPpYi6gWjsr7O7
         Fp33c71vTOlJy86OC/Rt03akkiIp7ZhOwBQ6N88fKVDTClTULBZXIxK8CsnLZb33LssL
         hhbg==
X-Gm-Message-State: ANhLgQ2+3l7b7h25c9FW6J4Z54sfMRZKgyhtEB/Fp+a9YBujLpY/1K6D
        bCLaGRQFypQadtSOJVTRZxIVLss+cEWjJw==
X-Google-Smtp-Source: ADFU+vvQJd7IaN87n6kxG1TlY5n4Bc1aAhA1WrVKj4gLfyh8vnDOdScPTXmeuGwVRSwFA070TSGXew==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr12247365ljg.144.1584296334835;
        Sun, 15 Mar 2020 11:18:54 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o15sm3040629ljj.55.2020.03.15.11.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:18:54 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 6/6] mm/list_lru.c: remove kvfree_rcu_local() function
Date:   Sun, 15 Mar 2020 19:18:40 +0100
Message-Id: <20200315181840.6966-7-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315181840.6966-1-urezki@gmail.com>
References: <20200315181840.6966-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since there is newly introduced kvfree_rcu() API,
there is no need in queuing and using call_rcu()
to kvfree() an object after the GP.

Remove kvfree_rcu_local() function and replace
call_rcu() by new kvfree_rcu() API that does
the same but in more efficient way.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/list_lru.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 386424688f80..69becdb22408 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
+#include <linux/rcupdate.h>
 #include "slab.h"
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -383,21 +384,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
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
@@ -429,7 +422,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu_local);
+	kvfree_rcu(old, rcu);
 	return 0;
 }
 
-- 
2.20.1

