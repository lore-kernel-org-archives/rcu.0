Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C6C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A287208E0
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971893;
	bh=rzisah6K7IK7Z0/2c44WdQJIB3NkuOtlg66W5xePlUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fD3hx/F1ubvTqLseDisJfg6n/hAR84ISrCU+3DpmAhSsBsQXMVdrU1QtkAYSf4Wt7
	 NrGfeeBIeuBvN+uWYLovWmYMjXhoR8+7XCDRPniZ+YULGQUNx4mVJmJQ0IlclLmSTW
	 rOfmb5/WICUen5FtQvHGydI8uDD04eJbOOH9qa6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411171AbgDORbb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411132AbgDORbI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F81221707;
        Wed, 15 Apr 2020 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971867;
        bh=rzisah6K7IK7Z0/2c44WdQJIB3NkuOtlg66W5xePlUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALtUjiv+S15Xp4zctIifHy+++WSUs11wekUEQKd1hgg4c4lTQ5iHe0MT/255TbV+d
         tWYGaLzGrykK8QlxTUKCdl62s0rDmwU9VTnkv+kXcUGBl/mXKOoIWUk7qvqX9wAxh4
         GWEwNVeSWzG6lqYkkJBp6NI7sBYxB4r1xn+fVqqg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/18] torture: Add a --kasan argument
Date:   Wed, 15 Apr 2020 10:30:59 -0700
Message-Id: <20200415173100.9927-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Make it a bit easier to apply KASAN to rcutorture runs with a new --kasan
argument, again leveraging the config_override_param() bash function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 +
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 52f8966..6ff611c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -66,6 +66,7 @@ config_override_param () {
 echo > $T/KcList
 config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"
 config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
+config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
 cp $T/KcList $resdir/ConfigFragment
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e001fc4..c279cf9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -31,6 +31,7 @@ TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
+TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
@@ -134,6 +135,9 @@ do
 		TORTURE_KCONFIG_ARG="$2"
 		shift
 		;;
+	--kasan)
+		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
+		;;
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
@@ -314,6 +318,7 @@ TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
 TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
+TORTURE_KCONFIG_KASAN_ARG="$TORTURE_KCONFIG_KASAN_ARG"; export TORTURE_KCONFIG_KASAN_ARG
 TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
 TORTURE_QEMU_CMD="$TORTURE_QEMU_CMD"; export TORTURE_QEMU_CMD
-- 
2.9.5

