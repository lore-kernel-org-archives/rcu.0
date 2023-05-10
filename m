Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D6EC77B7D
	for <rcu@archiver.kernel.org>; Wed, 10 May 2023 17:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbjEJRG1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 May 2023 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjEJRGX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 May 2023 13:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A70A8;
        Wed, 10 May 2023 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 352D163F2F;
        Wed, 10 May 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A69C433D2;
        Wed, 10 May 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738370;
        bh=XH5sB07f3Ey9Nxv2UrTDaQPS9YGvRkyAeAe39j1qiZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwaz01RxSf5T8D6+ZZpqvWlINKfEHlDRz/ABaTt1G1sGGGfhJx4n2w29hOaNxWGIm
         Jxtfn5KGGnL/LOS+HDItbHCrRKnfeJpQAYDOTvkHG+6/dayMtQjv2B/scYCtI5HmPC
         0GJ2bTDErbVBuQlPk3Z/iS7mnNZEOekQcqlkG+CFhfVKmLzEE/xjDH48uPeS4yPSvj
         nBT8tj+IOKOo+RiYSCgw4dprENveCuFMsC1M73Bo+tYJiUXwyQsj5lwh9DteNLkGWa
         eS7hpqr2yLr12VOFpv4EVvCm4jUWBexqcMNj35teRBAfM5S4ptaYZGQPya7zUqiJvj
         HD2FrfZQyHzJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F6C4CE1279; Wed, 10 May 2023 10:06:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] rcu/nocb: Fix shrinker race against callback enqueuer
Date:   Wed, 10 May 2023 10:06:05 -0700
Message-Id: <20230510170607.2187978-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
References: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The shrinker resets the lazy callbacks counter in order to trigger the
pending lazy queue flush though the rcuog kthread. The counter reset is
protected by the ->nocb_lock against concurrent accesses...except
for one of them. Here is a list of existing synchronized readers/writer:

1) The first lazy enqueuer (incrementing ->lazy_len to 1) does so under
   ->nocb_lock and ->nocb_bypass_lock.

2) The further lazy enqueuers (incrementing ->lazy_len above 1) do so
   under ->nocb_bypass_lock _only_.

3) The lazy flush checks and resets to 0 under ->nocb_lock and
	->nocb_bypass_lock.

The shrinker protects its ->lazy_len reset against cases 1) and 3) but
not against 2). As such, setting ->lazy_len to 0 under the ->nocb_lock
may be cancelled right away by an overwrite from an enqueuer, leading
rcuog to ignore the flush.

To avoid that, use the proper bypass flush API which takes care of all
those details.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1a86883902ce..c321fce2af8e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1364,7 +1364,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			continue;
 
 		rcu_nocb_lock_irqsave(rdp, flags);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.40.1

