Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B15C4332D
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A16C23123
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbhAFR0u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbhAFR0u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 635BA23123;
        Wed,  6 Jan 2021 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953969;
        bh=g6xFz6KNBLko29IRD/YbFS6JckGAmVoqE3iqOjOrGdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJwXh+Iobb1pIPHSfE5nV50n1pAVIvFIsjusGovwPOv5SlMgMubI89lEGEPM34kXI
         7lPMWG88oYVF6pEMeqW7G45sofzLl3+kbPzDtkeaW7nB8xeVgOXjdKZyjo/cBznw6l
         9Rho5DJrMAJu2m9nz8zqq7gRBrqRyY3VxVoCaTRy7LQOeag8LfftUL4K5oEpR+FKeQ
         hGEg+ft7A/bEVgvXFDs9xnrjRVSyH8dFGlimPecxOwznlbHuhQj5E9P8EbxXgXeZ4S
         8S2hMTvpEW+nUJhNohZtSHaQHMydHJz2UuCGZ/qSNXY7PNdXVKj/GSRtfRYFOBIdvT
         W5UMA2CpY6csA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/20] torture: Make --kcsan specify lockdep
Date:   Wed,  6 Jan 2021 09:25:48 -0800
Message-Id: <20210106172607.22816-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The --kcsan argument to kvm.sh adds CONFIG_KCSAN_VERBOSE=y in order to
get more detail from the KCSAN reports.  However, this Kconfig option
requires lockdep to be enabled.  This commit therefore causes --kcsan
to also enable lockdep.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 45d07b7..bd07df7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -169,7 +169,7 @@ do
 		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
 		;;
 	--kcsan)
-		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_INTERRUPT_WATCHER=y CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
-- 
2.9.5

