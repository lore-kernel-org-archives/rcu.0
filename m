Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D1BC433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C42964F39
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351384AbhCDBBk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452940AbhCDAjs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA5D764F25;
        Thu,  4 Mar 2021 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818296;
        bh=2POJFiyU+T/PAOvZ5cD53kP7TvVhTud6nR2QKxJoiUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXZ8v/es3a/+asNzIwmxwEAOrlmZcbs7RBMYL9Htz0zoiRebWr8vlOCM9whgbZwTA
         GFG0UEYU6MK/6RNI/rAE3LbmMGYt/Zw416srxcP4UnuIna9KPq6MrjiQZM9Sy++oE4
         CV7OZl42HifkzwimMJg2aGQ0p7jdmZxZRRSZpWWddK22bgyxS57Z2XL8OuDbpjm1OU
         Ufu3Fnz0QLy04dRx2tDqoNaAH061msKMPZcqfttkj3cN17c/5Rf1r11yAltxJ2Znj6
         gG5oI0ztIJuJP+EqnUtOe8ygJxzhlucJwW8lDdL+4i9YCw0XpwgzfxO022xI4KX33r
         nt6k4n8dGKW4A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/28] torture: Rename SRCU-t and SRCU-u to avoid lowercase characters
Date:   Wed,  3 Mar 2021 16:38:02 -0800
Message-Id: <20210304003812.24833-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The convention that scenario names are all uppercase has two exceptions,
SRCU-t and SRCU-u.  This commit therefore renames them to SRCU-T and
SRCU-U, respectively, to bring them in line with this convention.  This in
turn permits tighter argument checking in the torture-test scripting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST                 | 4 ++--
 tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t => SRCU-T}     | 0
 .../selftests/rcutorture/configs/rcu/{SRCU-t.boot => SRCU-T.boot}     | 0
 tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u => SRCU-U}     | 0
 .../selftests/rcutorture/configs/rcu/{SRCU-u.boot => SRCU-U.boot}     | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t => SRCU-T} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-t.boot => SRCU-T.boot} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u => SRCU-U} (100%)
 rename tools/testing/selftests/rcutorture/configs/rcu/{SRCU-u.boot => SRCU-U.boot} (100%)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index f2b20db..98b6175 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -7,8 +7,8 @@ TREE07
 TREE09
 SRCU-N
 SRCU-P
-SRCU-t
-SRCU-u
+SRCU-T
+SRCU-U
 TINY01
 TINY02
 TASKS01
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
rename to tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot
rename to tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
rename to tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot
rename to tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot
-- 
2.9.5

