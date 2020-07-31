Return-Path: <SRS0=65p9=BK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB91C433DF
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4ED208E4
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4VSCVtK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8P7v+5Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgGaJ0g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbgGaJXT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA62C061756;
        Fri, 31 Jul 2020 02:23:19 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HZWh39Uk1L/X4wpTGFztx5DG+DzEB+s/H5b6WbGsrXo=;
        b=o4VSCVtKtrK1aQzyIlF0dXpytiTJemrqD1bRwysO8g4lcNNpCPJ8LSRSbqTEI0UHhp8UyA
        YMyMFKZvdtnGoPUTqhNyrwNQ196NiQaRIHzFjc/FVmnjlB2JHzeQrypGmelk7ksy7Hmin2
        DVGEd2QTu79CBckDy2jB/7vb/8ZlRyqTHtG7SkpcorFb1DAK6fYzJLbRHfdjnM1j3lfCbk
        /N9G+syQTvOxFWkyi5XLleX4korA5iVnGvEt9Lo1jh0omnJbUJoE0r4/+/NVBEn3jZVLlY
        YFpGLlvMe2mWAo25Mc7NxjSUbEwXoF3hnmA6B2AwU90dLgmw1r+MuifSo+2ITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HZWh39Uk1L/X4wpTGFztx5DG+DzEB+s/H5b6WbGsrXo=;
        b=8P7v+5UfA379eVyTnrnSfRyqGuuYwONqINTexgeO98Ue516TQTIixg8esz09CpBXisb6xC
        njws5q6tujGIIICw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm/list_lru.c: Rename kvfree_rcu() to local variant
Cc:     linux-mm@kvack.org, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739718.4006.7426500496143396787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e0feed08ab41df0fedc38d35938891ef5715c1d3
Gitweb:        https://git.kernel.org/tip/e0feed08ab41df0fedc38d35938891ef5715c1d3
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:56 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

mm/list_lru.c: Rename kvfree_rcu() to local variant

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 9222910..e825804 100644
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
 
