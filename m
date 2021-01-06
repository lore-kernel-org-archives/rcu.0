Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1147C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C2522EBD
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAFQxO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbhAFQxO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:53:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81EF82313F;
        Wed,  6 Jan 2021 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951953;
        bh=cXheTuQ4x1aiyI69dvp9kCvnCfE+d3M6Gi4mDOGKAYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tr3rjLJ69xl7infr3kjvFl3fOtwe/EHvKkaQKpAmy8eO1tOlbAPXvm9QC/ED/Thif
         NUvTl2BQF4Ont9BFbOgjjFfGbR/EHy9jAEu+PCt062FhFIEAzpWH027vWu35lEbz0+
         Kyt9M67i6fhxk1+M2bN4H4VP0o3H5gb+SOA4tP1XARLv7yGWx3Mvk64iBwg6lf/B6s
         xg7EJX3hQ7gHXy9D4MDtjdLn+x5Q40dyN68KUZfLwK45jmV9AoQAQ1zengATEOJd27
         IvkU0ps2owZFbnF9P7ZZNORs5hLdBc9IVyNrr1Orel4acmUcxXtDfVFfFe4u5eoWJQ
         Xu/lj4KYxp06g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] rcu: Mark obtuse portion of stall warning as internal debug
Date:   Wed,  6 Jan 2021 08:52:28 -0800
Message-Id: <20210106165231.20441-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165210.GA20296@paulmck-ThinkPad-P72>
References: <20210106165210.GA20296@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a rather obtuse string that can be printed as part of an
expedited RCU CPU stall-warning message that starts with "blocking
rcu_node structures".  Under normal conditions, most of this message
is just repeating the list of CPUs blocking the current expedited grace
period, but in a manner that is rather difficult to read.  This commit
therefore marks this message as "(internal RCU debug)" in an effort to
give people the option of avoiding wasting time attempting to extract
nonexistent additional meaning from this portion of the message.

Reported-by: Jonathan Lemon <bsd@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8760b6e..6c6ff06 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -545,7 +545,7 @@ static void synchronize_rcu_expedited_wait(void)
 			data_race(rnp_root->expmask),
 			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
-			pr_err("blocking rcu_node structures:");
+			pr_err("blocking rcu_node structures (internal RCU debug):");
 			rcu_for_each_node_breadth_first(rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
-- 
2.9.5

