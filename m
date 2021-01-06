Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B5AC4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B9C23133
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbhAFR2M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbhAFR1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEF8D23137;
        Wed,  6 Jan 2021 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953971;
        bh=CuylK/3ld/QslqUQa+NZJEi9KQaEP6WVXoJI+8xCi4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXIZqGCh7wdlbhHOSiG2hUwkF1sa+EwBTa5OMzzFzRXg4qt9/7DAYxXKfIEReaX4s
         H3i9+Z55ISO7THTNvTZqJS3M6lz2R0eCb2uiiI01P2SssKF59+6dO9jt5m1O41NVFv
         pUS0ob4MennZ2PJcHJ0JV4awrQ1LKBkIdWJJ/PuJSda/100iV94tCbBg7VHF3znUzD
         GrwFqzDApP0oB2m6+ZWKhK8rJliE6D9cCGSOYc3MRnTNfDX8LOd+hgb/PKi2x9Hcdh
         oSXvYG879kOkv0OfdBkAT6O/VxRmANmnoVaDXGrbrdt8XMhe4CELwyL8oXsdWzynfp
         rZ+wgb330bW0Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/20] torture: Make kvm.sh arguments accumulate
Date:   Wed,  6 Jan 2021 09:25:56 -0800
Message-Id: <20210106172607.22816-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that kvm.sh in invoked from scripts, it is only natural for
different levels of scripting to provide their own Kconfig option values,
for example.  Unfortunately, right now, the last such argument on the
command line wins.

This commit therefore makes the --bootargs, --configs, --kconfigs,
--kmake-args, and --qemu-args argument values accumulate.  For example,
where "--configs TREE01 --configs TREE02" would previously have run only
scenario TREE02, now it will run both scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c8356d5..6fd7ef7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -85,7 +85,7 @@ do
 		;;
 	--bootargs|--bootarg)
 		checkarg --bootargs "(list of kernel boot arguments)" "$#" "$2" '.*' '^--'
-		TORTURE_BOOTARGS="$2"
+		TORTURE_BOOTARGS="$TORTURE_BOOTARGS $2"
 		shift
 		;;
 	--bootimage)
@@ -97,8 +97,8 @@ do
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
-		checkarg --configs "(list of config files)" "$#" "$2" '^[^/]*$' '^--'
-		configs="$2"
+		checkarg --configs "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs="$configs $2"
 		shift
 		;;
 	--cpus)
@@ -162,7 +162,7 @@ do
 		;;
 	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
-		TORTURE_KCONFIG_ARG="$2"
+		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
 	--kasan)
@@ -173,7 +173,7 @@ do
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
-		TORTURE_KMAKE_ARG="$2"
+		TORTURE_KMAKE_ARG="`echo "$TORTURE_KMAKE_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
 	--mac)
@@ -191,7 +191,7 @@ do
 		;;
 	--qemu-args|--qemu-arg)
 		checkarg --qemu-args "(qemu arguments)" $# "$2" '^-' '^error'
-		TORTURE_QEMU_ARG="$2"
+		TORTURE_QEMU_ARG="`echo "$TORTURE_QEMU_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
 	--qemu-cmd)
-- 
2.9.5

