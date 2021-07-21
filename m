Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD6FC6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A35E61244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhGUTlB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240381AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEF476137D;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898890;
        bh=wEu8mtu9foqhl4vybGYweZH7nS4hW3NBN/vzNcI3m3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XybP3n/kcIqe8sbpm68LJpkBOtg1RehbmH5DwI2II/+DZGYFtp2oiDdIMUUygX/qH
         oyqIriNylwWj5XILOF29LmQEG4OSwRF41dzPwZQMQuay8MwR8MknOCO+JEnzS+/cFt
         HF199bgrYNTWO6hNfgu0Z4GkE/Ap1qLwigsKIRPV/ZI0GxeVzKUtyA2fRp59ixyuRn
         AsDIm6+jpWPdG5QHTOEQeT0iMvEV16v1F9Pulcz4yDJjbditLe7sLUAdUMbTZEnA7N
         d/kySepwx4db0SbuNALnTEutGYIIEN6hj7DminPbzHhqpiIo66skbhMoBicy5PnStb
         wH9lF/VsWR1Zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A75C5C22F7; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/18] rcu: Mark lockless ->qsmask read in rcu_check_boost_fail()
Date:   Wed, 21 Jul 2021 13:21:19 -0700
Message-Id: <20210721202127.2129660-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Accesses to ->qsmask are normally protected by ->lock, but there is an
exception in the diagnostic code in rcu_check_boost_fail().  This commit
therefore applies data_race() to this access to avoid KCSAN complaining
about the C-language writes protected by ->lock.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 42847caa3909b..6dd6c9aa3f757 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -766,7 +766,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 
 	rcu_for_each_leaf_node(rnp) {
 		if (!cpup) {
-			if (READ_ONCE(rnp->qsmask)) {
+			if (data_race(READ_ONCE(rnp->qsmask))) {
 				return false;
 			} else {
 				if (READ_ONCE(rnp->gp_tasks))
-- 
2.31.1.189.g2e36527f23

