Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E29FC4321E
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA8C61242
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhIOXfK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhIOXfF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 610FB61216;
        Wed, 15 Sep 2021 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=P1LOJ0jb929Ql25NTh67Ib2ZHOXICwcs825LoWP1W+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbPK51Rh+6tSMmF0SvrfS7jRkfamszmFiUfamttnbdEz34dmmRmuuGv6QOL5M04SH
         x1rpD8Ur+CCOh87qGgjj7NBNwK5B2PNgwDYdw+E7ps7ZJWXcZ0u44O0SatZYRaVH6a
         FbFUZnv8gWazsduWKHUMJdLPqoTU++RQg49YkFn3jMMP/+uTMIksEDz9AdHhD8v4FW
         UhCLRvPy9JGPDmplutzChhRMSJZfQtXGmB6HsitGTF3RMqD+kOJYOMV43i3wj3Zr5c
         t+V7woTv13V24GyhMvid8q0Bpupft3kkBT5PE4stA/qo5OMRuPVdWHh4V34ju1fa0v
         gX7bazrj2IlJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D25DE5C0DEE; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/14] rcu: Fix existing exp request check in sync_sched_exp_online_cleanup()
Date:   Wed, 15 Sep 2021 16:33:42 -0700
Message-Id: <20210915233343.3906738-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

The sync_sched_exp_online_cleanup() checks to see if RCU needs
an expedited quiescent state from the incoming CPU, sending it
an IPI if so. Before sending IPI, it checks whether expedited
qs need has been already requested for the incoming CPU, by
checking rcu_data.cpu_no_qs.b.exp for the current cpu, on which
sync_sched_exp_online_cleanup() is running. This works for the
case where incoming CPU is same as self. However, for the case
where incoming CPU is different from self, expedited request
won't get marked, which can potentially delay reporting of
expedited quiescent state for the incoming CPU.

Fixes: e015a3411220 ("rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d9e4f8eb9ae2..f3947c49eee7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -759,7 +759,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	my_cpu = get_cpu();
 	/* Quiescent state either not needed or already requested, leave. */
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
-	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp)) {
+	    rdp->cpu_no_qs.b.exp) {
 		put_cpu();
 		return;
 	}
-- 
2.31.1.189.g2e36527f23

