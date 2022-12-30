Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57922C4167B
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 11:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiL3LiV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 06:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiL3LiU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 06:38:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180861AD9E
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=24uUcRmiJlphNCmOEAx52DRVZQYqhKC64tJ2z9r0Az8=; b=QpblY15fjhn+NdzGaEMuKTtjE5
        ZLbejccaMA0BT0tt6YF1kwPRNxSLUSZBgKaD8E8Phv5CHn0y1VaRWUoQ2Ir9kUh0seDcGpcsTvMvf
        AfCxdY7yxaxMS3FscH3LoYfjNhUhNM/1QBiAwbeErRj+SzzA7INpgix1vIdX6ySTha7ttYZSoNWkq
        TahSPkJlOWeXoMF75KFpHYg/wNmsz6Tp+uBv/fh5xTrvSRVE2OiOPIak9pdgF60lA9NNXK7efz/54
        gVQiWjnAweez8ZLdZKF6p5L+yTAISyHrFu0C6/A6v83XUX8VznFHojNAVXcY2rksFQu8zfxwcpycx
        I3am3AVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pBDiP-00AZzF-OD; Fri, 30 Dec 2022 11:38:21 +0000
Date:   Fri, 30 Dec 2022 11:38:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: [RFC] Catch dwmw2's deadlock
Message-ID: <Y67NrWVLaL7B/EuO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


<dwmw2> why doesn't lockdep catch us calling synchronize_srcu() with
   a lock held, and elsewhere obtaining that lock within an srcu critical
   region ("read lock") ?

Because synchronize_srcu() doesn't acquire the lock, merely checks that
it isn't held.

Would this work?  Not even compile tested.

You can put my SoB on this if it works.

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ca4b5dcec675..e9c2ab8369c0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1267,11 +1267,11 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 {
 	struct rcu_synchronize rcu;
 
-	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
-			 lock_is_held(&rcu_bh_lock_map) ||
+	rcu_lock_acquire(&ssp->dep_map);
+	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
+			 "Illegal synchronize_srcu() in RCU read-side critical section");
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
@@ -1282,6 +1282,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 	__call_srcu(ssp, &rcu.head, wakeme_after_rcu, do_norm);
 	wait_for_completion(&rcu.completion);
 	destroy_rcu_head_on_stack(&rcu.head);
+	rcu_lock_release(&ssp->dep_map);
 
 	/*
 	 * Make sure that later code is ordered after the SRCU grace
