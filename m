Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B9C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043792076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971996;
	bh=T7FxZ8VnQOBCafeNxp213vIGSqauNPjYZLVRJ/8AAMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+iu41PTADN2/ASTpppN77APB6fXU7E5Xs+SlEEnhUnaQFecRCtls1x2rekhrVbwk
	 DDKotBLdta25eduvDzIoiZPgEj7RsPiB0DovXio/nn5PyR0lVSRIsMo8DoI8gavEMN
	 h5bQlj1/lUQOol6W7JsTpzdUXXgvObaMxtI2PPwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411194AbgDORdO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411121AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9840D20784;
        Wed, 15 Apr 2020 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971864;
        bh=T7FxZ8VnQOBCafeNxp213vIGSqauNPjYZLVRJ/8AAMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMXIwifzhGVaEty5gGE+cZrSq8CFyZbXR9s2LwMQ3rXXM7Y1cEHiJiqyJb8JmZXpn
         d6HnprPvQh8wyKceE9EyMd96r1T7wvkaOREOyiJJUAebp2e2BnBJOe+vNonN69llzq
         gtV1c6pr7oXBBv3iZWOB/CE6IESqIIKPrtBrx2uE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH tip/core/rcu 09/18] torture: Add --kcsan argument to top-level kvm.sh script
Date:   Wed, 15 Apr 2020 10:30:51 -0700
Message-Id: <20200415173100.9927-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the existing --kconfig argument can be used to run KCSAN for
an rcutorture test, it is not as straightforward as one might like:

	--kconfig "CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y \
		   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n \
		   CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n \
		   CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 \
		   CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"

This commit therefore adds a "--kcsan" argument that emulates the above
--kconfig command.  Note that if you specify a Kconfig option using
-kconfig that conflicts with one that --kcsan adds, you get whatever
the script and the build system decide to give you.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 2315e2e..34b368d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -31,6 +31,7 @@ TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
+TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
 TORTURE_SHUTDOWN_GRACE=180
@@ -133,6 +134,9 @@ do
 		TORTURE_KCONFIG_ARG="$2"
 		shift
 		;;
+	--kcsan)
+		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		;;
 	--kmake-arg)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
 		TORTURE_KMAKE_ARG="$2"
@@ -201,6 +205,9 @@ else
 	exit 1
 fi
 
+TORTURE_KCONFIG_ARG="${TORTURE_KCONFIG_ARG} ${TORTURE_KCONFIG_KCSAN_ARG}"
+TORTURE_KCONFIG_ARG="`echo ${TORTURE_KCONFIG_ARG} | sed -e 's/^ *//' -e 's/ *$//'`"
+
 CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
 defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
@@ -310,6 +317,7 @@ TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
 TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
+TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
 TORTURE_QEMU_CMD="$TORTURE_QEMU_CMD"; export TORTURE_QEMU_CMD
 TORTURE_QEMU_INTERACTIVE="$TORTURE_QEMU_INTERACTIVE"; export TORTURE_QEMU_INTERACTIVE
-- 
2.9.5

