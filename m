Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B0C433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6C661283
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhIPMM1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239281AbhIPMMU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 08:12:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D83061283;
        Thu, 16 Sep 2021 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631794260;
        bh=tfDgmWnDmtlb1jhk3o7XkUpRro4OZFfxS9j/HXZIfm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0quD6onjXD/503YWZU0nrtTw8F8DbJENSKwB6tM613sg2YLeQgv2/2ffG3FF3AiC
         nJmiLiw/nx3zz3bLeerKfG6J9EQ5gfhNn9F/LoMLKMS42AglJt6o4JMseaFAWTeNYK
         gpSF6ykRbUdyylzqDPNzIX54nvMJYm3lxbBiwPs8cT/Fqify+fK7hx6WQ2K1wKqahF
         OZgEtjC0ppLXGRxf9jIc2jOywdGkmsB6UEreM6K07XUQGyvjkR8x8jQ1jWH1TbeoVO
         3w9Sm+hcLtDOxJjZgBuKYluaWoLxGpzyBfe4nJHrj3U3usr4KhoBwhlswi9A483Q/F
         W0sPlev7Sn1Qw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: [PATCH 3/4] rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
Date:   Thu, 16 Sep 2021 14:10:47 +0200
Message-Id: <20210916121048.36623-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916121048.36623-1-frederic@kernel.org>
References: <20210916121048.36623-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On non-preemptible RCU, move clearing of rcu_data.cpu_no_qs.b.exp to
the actual expedited quiescent state report function, in a similar way
to preemptible RCU dealing with rdp->exp_deferred_qs.

This prepares to remove the exp_deferred_qs field and generalize the use
of cpu_no_qs.b.exp to both preemptible and non-preemptible RCU.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h    | 1 +
 kernel/rcu/tree_plugin.h | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4266610b4587..992f9475d243 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -256,6 +256,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
 	rdp->exp_deferred_qs = false;
+	rdp->cpu_no_qs.b.exp = false;
 	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4c9aeabec242..b20634fde43d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -849,10 +849,8 @@ static void rcu_qs(void)
 	trace_rcu_grace_period(TPS("rcu_sched"),
 			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
 	__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-	if (!__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
-		return;
-	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, false);
-	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
+	if (__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
+		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
 
 /*
-- 
2.25.1

