Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E2C433F5
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0691E60FC2
	for <rcu@archiver.kernel.org>; Wed, 29 Sep 2021 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347226AbhI2WMT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347214AbhI2WMQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Sep 2021 18:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0F6D61423;
        Wed, 29 Sep 2021 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953435;
        bh=DBWs3V0sa4GChCABC3MuvhuPRpOsaCGotPLqeHtOz8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+MXbULhCLx+ghC+3HJI03IlziVsmR3t4kshPrmZ5vCuJ6TAVsxrU+Ly1f8PihJYV
         jJcQGyFVEzBzO7bZ1d1/jCbPT1FaaEBVF2Rp9cmLpoJf8KeJE6XVSxQx7xaE8HFVYS
         YqjJ+92fuFKH/YP5Cw03WsjDAQ1BbDqS5rGhXE/XQTuQcBnQs0wcPHzjlZiyyzfy2v
         dOtXwVQeXkIRqLwRU295/SmJ9eNEGXyhf56Ps9PMK3At9F0cv92ZwQNYFapUW4sHtF
         2LAfm29AT9PgaB4LQY5fE8+x6C6U6K5kppw3UtyolSkDG55DvQzN92hhqVyorTaoGu
         keQ4Z3L07evwA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [RFC PATCH 06/11] rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
Date:   Thu, 30 Sep 2021 00:10:07 +0200
Message-Id: <20210929221012.228270-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929221012.228270-1-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It's unclear why rdp->qlen_last_fqs_check is updated only on offloaded
rdp. Also rcu_core() and NOCB kthreads can run concurrently, should
we do the update on both cases? Probably not because one can erase the
initialized value of the other.

For now shutdown the RT warning due to volatile offloading state check
and wait for a debate after this half-baked patch.

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 73971b8024d8..b1fc6e498d90 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2508,7 +2508,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-	if (offloaded)
+	if (rcu_rdp_is_offloaded(rdp))
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
-- 
2.25.1

