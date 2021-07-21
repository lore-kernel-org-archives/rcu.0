Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C67C63793
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C30061244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbhGUTk7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239993AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6D736135A;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=nr6BcxUc21koPlFlKSknCV36xz+31oD6hCpBOcJTGJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhrlDJPyJq7OVYgj1LvtCYLOUgW+uefK8IvCeZ0/a3awscr4As7LIy2iTx3x2Yxmd
         qS434JsmyKh46cU3A3nEqUbUrRyG0xm3SdcW8hvQHSFCb6JkNuuiGET69eudDzg9xA
         TzH75e9Cm+Jp/feyQ0uMvyhdw9Cp4fQK0H7LUd1IlNCFdgefAfjCPy7oaQ6gkx43vU
         9bEfO/5xklwygUx2U0rVGuaT7IdRM3VZMvvWF9TdLLUWC/aGiNZzMbPY6Nfj+Dz9nB
         GHtHUzfAN5/qyutIODTaqp7+FiIwExO07iqd+QPbo61meqFV7HFi36wuMLFBEKudNB
         d5zZHjvq31FSA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 446A85C22E5; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/18] rcu: Remove trailing spaces and tabs
Date:   Wed, 21 Jul 2021 13:21:21 -0700
Message-Id: <20210721202127.2129660-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Run the following command to find and remove the trailing spaces and tabs:

find kernel/rcu/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e472c78036011..37bc3a702b6ea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -259,7 +259,7 @@ static noinstr unsigned long rcu_dynticks_inc(int incby)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
-	
+
 	seq = READ_ONCE(rdp->dynticks) + incby;
 	smp_store_release(&rdp->dynticks, seq);
 	smp_mb();  // Fundamental RCU ordering guarantee.
-- 
2.31.1.189.g2e36527f23

