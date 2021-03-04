Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43056C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D43164E7C
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbhCDBAk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353201AbhCDADm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7140A64FD0;
        Thu,  4 Mar 2021 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816023;
        bh=U0pkZGfxvPXzP41Wnbtcb5M7LOdeJNoh0cq/g7hlzfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiqivoCus+5dH1Ll8ZP8vFj/3djmC2pb+NFJA1nUAgDQbosHOnJfTvrY4/pSotPrP
         qVQN6cCoDSGEylzr/bW+wLhs58x5Df966lvDQ2kLDivoHDqLp1RoNFedlMrZCTUDrs
         k2NLOWvQLSA/LeuzUmViMmjriyYjt4Yoo0UO7DTTuAT/BGs3j/wYONOgvKJNxcIBrG
         SIRkeR2DoVNsihoPfuuEpkBh64JZIWaP5pFMty721UTuqdLf2A6PI81EwEw2ZsMXgM
         bL8wW8BJHBqrzUgKls3otVlTpfJdGkH7d9UgxHhewnGIOR1ZGTqee7ROJNu3wDtk/H
         noCC31gyKmBDg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/10] docs: Correctly spell Stephen Hemminger's name
Date:   Wed,  3 Mar 2021 16:00:17 -0800
Message-Id: <20210304000019.22459-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces "Steve" with the his real name, which is "Stephen".

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/RTFP.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 3b0876c..588d973 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -847,7 +847,7 @@ Symposium on Distributed Computing}
 	'It's entirely possible that the current user could be replaced
 	by RCU and/or seqlocks, and we could get rid of brlocks entirely.'
 	.
-	Steve Hemminger responds by replacing them with RCU.
+	Stephen Hemminger responds by replacing them with RCU.
 }
 }
 
-- 
2.9.5

