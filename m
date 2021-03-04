Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAB2C433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F87364F6A
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351570AbhCDBBq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452964AbhCDAkN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:40:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB4F864F3A;
        Thu,  4 Mar 2021 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818297;
        bh=DsKsFb/8dh3oKwr/8mj4az+50XgJLWM6GPaVeFRti6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gw2WweuT6P+kXJ7JZgFywa14yx3IP3kIqUHTe4NjchuhQSxc5sDqMQgljKoN2TV8V
         y+L1vKKSEJwrRvlMphFgJWnp0fvfzdGO5ybD/NAP+cPB8AEcCzKQ8rlMwkNYe6u3KU
         5ltPOCmNslOW489WGUYBx/9rqlhn25vZmLr9ByYZb8xYHAu4112MtKZIN7FGL2lkWP
         p7FMP1XXYyvkgdkwL6S+wHpr8ZcNNw8CwW023QnoHB22y2+nkIXpNv9L21XokMOMgy
         rhIidG6EIEuR6Ac/vMUFA2WATaQCdIqlmRB/Kasw52E8qCMXeVD6cvcLLRdIi0lxBt
         M+w9B4bhi8cOA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/28] torture: Make upper-case-only no-dot no-slash scenario names official
Date:   Wed,  3 Mar 2021 16:38:03 -0800
Message-Id: <20210304003812.24833-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit enforces the defacto restriction on scenario names, which is
that they contain neither "/", ".", nor lowercase alphabetic characters.
This restriction avoids collisions between scenario names and the torture
scripting's files and directories.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index efcbd12..03364f4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -104,7 +104,7 @@ do
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
-		checkarg --configs "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		checkarg --configs "(list of config files)" "$#" "$2" '^[^/.a-z]\+$' '^--'
 		configs="$configs $2"
 		shift
 		;;
-- 
2.9.5

