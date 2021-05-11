Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D8CC43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CF36192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhEKXNc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhEKXNb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A1A61919;
        Tue, 11 May 2021 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774744;
        bh=HY7VBT4m8S8/7d/nqvvTu0wbatROPHgTmd2Csw+b3tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/y9ffEKXu243P20kU1c0U0uqQBjG7+yhh4j+usXL4gnGaSQSho+IhcoSCZd720fj
         tU2kaU95GxkgG6h4g5aE2Yey922sFeVex2jX1C8JeRj3Fd8WDPXDfm9n8Rw3XwOl0H
         lwE7OuZaVzKeZIls8+kXqXosEALKRTmAbcs8oKQ5/dwhjd7yZ4gMd6gOgiKb/Bx2E0
         3DeyJhQSxnUQjalxNPli1Jhkw9/oBK6QVkXAix3HVXaKfIAVWJTu8HaaWllwuJYm3p
         r0kbVuqVXMLEIpHjuphfNfiIKWVo339UDVES+QOynU8Sk8MWQAGKYzxCw2kCO3/jCm
         53FfX7srhYIQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69EDB5C0138; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/26] torture: Fix remaining erroneous torture.sh instance of $*
Date:   Tue, 11 May 2021 16:11:58 -0700
Message-Id: <20210511231223.2895398-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Although "eval" was removed from torture.sh, that commit failed to
update the KCSAN instance of $* to "$@".  This results in failures when
(for example) --bootargs is given more than one argument.  This commit
therefore makes this change.

There is one remaining instance of $* in torture.sh, but this
is used only in the "echo" command, where quoting doesn't matter
so much.

Fixes: 197220d4a334 ("torture: Remove use of "eval" in torture.sh")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 56e2e1a42569..53ec7c046262 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -302,7 +302,7 @@ function torture_set {
 			kcsan_kmake_tag="--kmake-args"
 			cur_kcsan_kmake_args="$kcsan_kmake_args"
 		fi
-		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
+		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
 	fi
 }
 
-- 
2.31.1.189.g2e36527f23

