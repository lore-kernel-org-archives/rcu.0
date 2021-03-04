Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA2C433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E108764EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbhCDBBb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452460AbhCDAix (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:38:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70E8264E56;
        Thu,  4 Mar 2021 00:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818293;
        bh=aycJ7YO1tkcyfSFzXyFQppItvLCrJkHQ0uQw/Zi17DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRgu7CXKI2Zqr6cWruRpW7fMdfJ3B0hpj9p5tD3MK754kzD7EGqiq24nUqUiNi40Q
         65CWYw+itkj1fvCkDAzqi0uOskWYtFSU02WTcRg1K1BuZRwxSB1el03YH04C0brkjn
         KxM4dYV9ir+tMS/aDvNawI9XScOsrpGMGE/DfMicOifeb4TzmZXHniVqRAQ1MGxsqf
         M7wUTzbslC75LusP75XwKiHITKHe1vzm623655qYQ78QFVyBdleB/pgWEE5JswIBXA
         oUEtK5OdOuFcJfS7tonLRA2gdGZYFPBsTgcBJEpB7epuIeTEakOc52H0MzO9qQIn+H
         NdAcVfSr0QJwg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/28] torturescript: Don't rerun failed rcutorture builds
Date:   Wed,  3 Mar 2021 16:37:45 -0800
Message-Id: <20210304003812.24833-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If the build fails when running multiple instances of a given rcutorture
scenario, for example, using the kvm.sh --configs "8*RUDE01" argument,
the build will be rerun an additional seven times.  This is in some sense
correct, but it can waste significant time.  This commit therefore checks
for a prior failed build and simply copies over that build's output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 536d103..9d8a82c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,7 +73,7 @@ config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
-if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
+if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
 then
 	# Rerunning previous test, so use that test's kernel.
 	QEMU="`identify_qemu $base_resdir/vmlinux`"
@@ -83,6 +83,17 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
+elif test "$base_resdir" != "$resdir"
+then
+	# Rerunning previous test for which build failed
+	ln -s $base_resdir/Make*.out $resdir  # for kvm-recheck.sh
+	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
+	echo Initial build failed, not running KVM, see $resdir.
+	if test -f $builddir.wait
+	then
+		mv $builddir.wait $builddir.ready
+	fi
+	exit 1
 elif kvm-build.sh $T/KcList $resdir
 then
 	# Had to build a kernel for this test.
-- 
2.9.5

