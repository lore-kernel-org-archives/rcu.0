Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF96C433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E65611C6
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhIPA3W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233065AbhIPA3V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 980326108F;
        Thu, 16 Sep 2021 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752081;
        bh=eQTLYgoj8+4mlhQ+RPSR0Fqi388xvYHYOCFVyXLrovc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzy3AhsVBgDHxbb/j619z0GueW0HvzotkFKFfXM+xnSVMYEZAXu8bz0teiRpwPeEI
         APHi3tzMNaI46taIUguejjSt7hLfzTxguI9/fOdmSOLb+roxKouxnA/QrOHd6HJRS8
         UpBxYSr28GFmk3wNqPyyoUeMnAOnKKkpQJ95gNeEyLl5PD6GF11644YefypXwOG9A9
         q74MR2mBAt/YK8BoCcLiKBIKh87llSqFOv/ZbMrxIP8tZfEcoI5uNePaa7fOSeLLar
         m2WDBvmOIF/KEy722BrzUMHyEM20KnZpWwVSZd6dsYx+80x4xH5nBKF4wU5UUBUinm
         LM/ZHJVwylcPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6D68D5C054E; Wed, 15 Sep 2021 17:28:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] torture: Apply CONFIG_KCSAN_STRICT to kvm.sh --kcsan argument
Date:   Wed, 15 Sep 2021 17:27:56 -0700
Message-Id: <20210916002800.3910056-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
References: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, the --kcsan argument to kvm.sh applies a laundry list of
Kconfig options.  Now that KCSAN provides the CONFIG_KCSAN_STRICT Kconfig
option, this commit reduces the laundry list to this one option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index f442d84fb2a3..6cf9ec6a3d1c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -184,7 +184,7 @@ do
 		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
 		;;
 	--kcsan)
-		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_INTERRUPT_WATCHER=y CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
-- 
2.31.1.189.g2e36527f23

