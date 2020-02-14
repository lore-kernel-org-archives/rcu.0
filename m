Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F16AC35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB5622314
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724582;
	bh=wSmco/Aj++Js7E9iUxiBfk6npGHQUrzPWCJ9ucxNPYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aRkDhFtsw+MEL/7s2jm8TxE3CvPv8UzPo+6mFfDUWqshfTkcLDkui4Lk9cfdWjSRp
	 4595a7Rc6UXiQBWpyaYrsEa4yhBiMFx9YAtcljmVSq8wX9oVs1/dlk3I1dSaeAKw1I
	 yYo/3fpumSAvuSAxG5MmDr19/tSOsszgKkh8MUIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgBNX4W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNX4V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:21 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1C12081E;
        Fri, 14 Feb 2020 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724581;
        bh=wSmco/Aj++Js7E9iUxiBfk6npGHQUrzPWCJ9ucxNPYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5GrWpsIonBsJHDwWvFA/ze2sbSw4cyMnQ+jYm8U4/bf7W3zG2u44jiOUSLo3LMwo
         MmDwNWG5NUi1dFAPN5ze57TQqQoTQZmn1tbpvLDBBosBJGes2WTVUwbE7pP/0/L7p1
         7zh6yfGrjKNP7upshDJP4jaCum1pSsbVD4UJ0/OE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/30] rcu: Fix exp_funnel_lock()/rcu_exp_wait_wake() datarace
Date:   Fri, 14 Feb 2020 15:55:40 -0800
Message-Id: <20200214235607.13749-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->exp_seq_rq field is accessed locklessly, so
updates must use WRITE_ONCE().  This commit therefore adds the needed
WRITE_ONCE() invocation where it was missed.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index dcbd757..d7e0484 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -589,7 +589,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 			spin_lock(&rnp->exp_lock);
 			/* Recheck, avoid hang in case someone just arrived. */
 			if (ULONG_CMP_LT(rnp->exp_seq_rq, s))
-				rnp->exp_seq_rq = s;
+				WRITE_ONCE(rnp->exp_seq_rq, s);
 			spin_unlock(&rnp->exp_lock);
 		}
 		smp_mb(); /* All above changes before wakeup. */
-- 
2.9.5

