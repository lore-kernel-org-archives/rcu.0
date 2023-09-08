Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019BEEB570
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 20:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbjIHUg3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344135AbjIHUg1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E3C4;
        Fri,  8 Sep 2023 13:36:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18509C433B9;
        Fri,  8 Sep 2023 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205383;
        bh=GUT92MKTD1zv1ELbTZztdEp1nZcVqJTBRlzdjoDETLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCmajFEMvoh8fTOLErYAwt+nF4hfVHNs6QQNNM/2Y8GtU1lnueDle9kgxUkMdxyby
         DOv1MXqFeu+ZgrAlsLMXbEGswqAyH9ONebKnlQ7L48/FEeGD5EctI+M7bZsHCWRPXy
         RRuE5dO1nT0G/fxa4WuI2+XtD1nMAWDglSuzgODLlxHwQ7p6eCQA1J9WQ1pZfz4ZUq
         vh1loZHLvNHYNxGyO8d1W4S7G0Z+GKq21flczenkRJZyt0obo0vypJ2mL6wtMRAYBx
         /sSjXr+DxA0M9ffpOqnb70Tuj01OKYMRPqqJw8j1dACnMf+MIF4fhnVttQVqFemWqP
         X+Y93EB2Ad+Eg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 04/10] rcu/nocb: Remove needless full barrier after callback advancing
Date:   Fri,  8 Sep 2023 22:35:57 +0200
Message-ID: <20230908203603.5865-5-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908203603.5865-1-frederic@kernel.org>
References: <20230908203603.5865-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

A full barrier is issued from nocb_gp_wait() upon callbacks advancing
to order grace period completion with callbacks execution.

However these two events are already ordered by the
smp_mb__after_unlock_lock() barrier within the call to
raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
happen.

The following litmus test shows the kind of guarantee that this barrier
provides:

	C smp_mb__after_unlock_lock

	{}

	// rcu_gp_cleanup()
	P0(spinlock_t *rnp_lock, int *gpnum)
	{
		// Grace period cleanup increase gp sequence number
		spin_lock(rnp_lock);
		WRITE_ONCE(*gpnum, 1);
		spin_unlock(rnp_lock);
	}

	// nocb_gp_wait()
	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
	{
		int r1;

		// Call rcu_advance_cbs() from nocb_gp_wait()
		spin_lock(nocb_lock);
		spin_lock(rnp_lock);
		smp_mb__after_unlock_lock();
		r1 = READ_ONCE(*gpnum);
		WRITE_ONCE(*cb_ready, 1);
		spin_unlock(rnp_lock);
		spin_unlock(nocb_lock);
	}

	// nocb_cb_wait()
	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
	{
		int r2;

		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
		spin_lock(nocb_lock);
		r2 = READ_ONCE(*cb_ready);
		spin_unlock(nocb_lock);

		// Actual callback execution
		WRITE_ONCE(*cb_executed, 1);
	}

	P3(int *cb_executed, int *gpnum)
	{
		int r3;

		WRITE_ONCE(*cb_executed, 2);
		smp_mb();
		r3 = READ_ONCE(*gpnum);
	}

	exists (1:r1=1 /\ 2:r2=1 /\ cb_executed=2 /\ 3:r3=0) (* Bad outcome. *)

Here the bad outcome only occurs if the smp_mb__after_unlock_lock() is
removed. This barrier orders the grace period completion against
callbacks advancing and even later callbacks invocation, thanks to the
opportunistic propagation via the ->nocb_lock to nocb_cb_wait().

Therefore the smp_mb() placed after callbacks advancing can be safely
removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 6e63ba4788e1..2dc76f5e6e78 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -779,7 +779,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			needwake = rdp->nocb_cb_sleep;
 			WRITE_ONCE(rdp->nocb_cb_sleep, false);
-			smp_mb(); /* CB invocation -after- GP end. */
 		} else {
 			needwake = false;
 		}
-- 
2.41.0

