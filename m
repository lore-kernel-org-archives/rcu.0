Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471FFC433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288A364EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352359AbhCDBBr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452977AbhCDAkS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:40:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8241964F4D;
        Thu,  4 Mar 2021 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818298;
        bh=1UlKIYLplr4MOLs3f55rP4x+zBSH2Z1DCNuQmoH30aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwMMh8wFM8QzDJDSZ/uRF3f4RWqxgauollBxUCfq30Ai0VVq901+vnW12ULCL5gid
         qgztvE3tOoVnUFVsHyUAa0fYi+tA+j0wafuV3zMdbKWsULlo41rqvlmCkpgOHJ5j7n
         12SC95/IkAi1DW2jkYqYVP9wAeft0VFCIJ3qELLiAgGYhTjghQAiBEfjc1vElKDylj
         ezJIx1aVZDU6fbaOAoHX3W0GZiuAbpEgL2sfRJ7BSgbG56nN7XpMnrnHQRpqYpxvvV
         0loDxW2hLXuYo7CXI6kDCV2tiZgB9ycDmepYLPEwBTxUqM+o+wuJrjrRVoOvflwNlU
         zasK4yo7m5uGQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 28/28] torture: Fix kvm.sh --datestamp regex check
Date:   Wed,  3 Mar 2021 16:38:12 -0800
Message-Id: <20210304003812.24833-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Some versions of grep are happy to interpret a nonsensically placed "-"
within a "[]" pattern as a dash, while others give an error message.
This commit therefore places the "-" at the end of the expression where
it was supposed to be in the first place.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0add163..6bf00a0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -120,7 +120,7 @@ do
 		shift
 		;;
 	--datestamp)
-		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._-/]*$' '^--'
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
 		ds=$2
 		shift
 		;;
-- 
2.9.5

