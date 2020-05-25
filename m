Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1169BC433E1
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75BA206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXSy4DSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389063AbgEYVsw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbgEYVs0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61F0C05BD43;
        Mon, 25 May 2020 14:48:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o14so22215850ljp.4;
        Mon, 25 May 2020 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ma6ozjce0VsxuWEnBAmau4C36oX126QKppp7v2kR4Bo=;
        b=NXSy4DSx5DHkmao9iem3wyRQf7BFcvkq9BZwo4Xn7fNoonCwaGlYttBUNSK7XZyiKk
         MvFXMOtTnUGYIiaM2GCWi6QC4BB2er3giLKzJQugD8tGOH3BD2sbvjtj+V2aKbwzKrNM
         pfrFQpL9uwJZYM0QgCNtSI/PamuNUIIdOcIGu6z8qFvWUQZ7vQI11gTVpRK5fJqKQost
         VWHqXAs4hJla7bwSnB5QWpSyt8y3wvGhKapGaJz6UPZBpbC4cD74DqwzDp+LilFb/yCH
         ZYUO0x9KmNL3FPcmKukuuHe14Jr4U2Q1xo+/C+9lzW5T1P6m/bAMyKbWJcVeQSOqGIWR
         YdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ma6ozjce0VsxuWEnBAmau4C36oX126QKppp7v2kR4Bo=;
        b=m0vWUBjxOiaaA0z5owi40OW5icLg+1j4LCtPagvWPm3drwnoSEZT+/c5TV+PnMQlIS
         lQxWMXYM/Tm/25wo/wY7MRxSdzNg6PMMKne2JeXYldlgBM76QUHyfm905d8+ciDySiBI
         xTXl5w2A4jJnHWuZkhHG58zSqmCDQSm31uTkzOYzd9ckqFM8pGFagqqd5T51vAfIb24K
         JbGAOArNcAESMb8FVi+OfgzpFsM5/C7N0qpMARtAmDJ2pl1x/NqRY1A6+extLwudZRYp
         ablIxTiO3fHRQZYwKA1JjT0VOBeU3X4iXAEki72qG9R+zC7Sh0gmSAWzysOtEqWrHgn3
         iTLw==
X-Gm-Message-State: AOAM533wrm6G89q55PH+tB1MbdXg9i/gl3sBbdtJ6Wv9eF6zWM70snY4
        mFMBlFueFKsns9hca4sCNnrBjQg4OO4WmQ==
X-Google-Smtp-Source: ABdhPJzX7B4hxYlADv9D7q19Ax/D4dz4rbE7H3yxDwhkpf8rQ+Y8wFTVlnlYRsZU/BydGVrMJi0gTg==
X-Received: by 2002:a2e:9891:: with SMTP id b17mr11934960ljj.320.1590443303981;
        Mon, 25 May 2020 14:48:23 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:23 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 12/16] mm/list_lru.c: Rename kvfree_rcu() to local variant
Date:   Mon, 25 May 2020 23:47:56 +0200
Message-Id: <20200525214800.93072-13-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename kvfree_rcu() function to the kvfree_rcu_local() one.
The purpose is to prevent a conflict of two same function
declarations. The kvfree_rcu() will be globally visible
what would lead to a build error. No functional change.

Cc: linux-mm@kvack.org
Cc: rcu@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
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

