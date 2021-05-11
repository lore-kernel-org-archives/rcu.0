Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F91AC43140
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB896192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhEKXNp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A54A961972;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=0GWhW/hCulbARv7+j0XEFQtQlx4ol+9OsgZn7m0LbX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoMcg1Ye25S+wzlfBrtKkpgQydx7z4zc22FqiiZMMZZUznXFTmNeQ2V/mGLNOxKtF
         38zQmImlexYRop50lJSqZWnTknRlDjLt8GS+mDRaV27SoGJ1uw42Sx9OUPk9ClSY99
         UPhp+R0HyYJDsWPWp/yb0ubyximK/iMm3UadtiI2c3ukdwa5xsh+88tMP0rmChddXY
         QXYbLOmUFoX2Zv0+If/Tcw3/qcos5+hAZxEAA2dGE8DBIdRnkTTYN6kA+NZNqUYx6c
         unMkhfH56xsnbkvxnH4gAuQK5dnxB8wfPgXvkO0DXDLSH6P4ABgMyIL64ipzjP1yYT
         0xhHpRPdy7gBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 957545C0EB2; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 24/26] torture: Don't cap remote runs by build-system number of CPUs
Date:   Tue, 11 May 2021 16:12:21 -0700
Message-Id: <20210511231223.2895398-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, if a torture scenario requires more CPUs than are present
on the build system, kvm.sh and friends limit the CPUs available to
that scenario.  This makes total sense when the build system and the
system running the scenarios are one and the same, but not so much when
remote systems might well have more CPUs.

This commit therefore introduces a --remote flag to kvm.sh that suppresses
this CPU-limiting behavior, and causes kvm-remote.sh to use this flag.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 20e848d2c0bb..79e680e0e7bf 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -66,7 +66,7 @@ then
 		if (ds != "")
 			print "--datestamp " ds;
 	}'`"
-	kvm.sh "$@" $datestamp --buildonly > $T/kvm.sh.out 2>&1
+	kvm.sh --remote "$@" $datestamp --buildonly > $T/kvm.sh.out 2>&1
 	ret=$?
 	if test "$ret" -ne 0
 	then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 390bb97b07d8..b4ac4ee33222 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -44,6 +44,7 @@ TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
+TORTURE_REMOTE=
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
 TORTURE_MOD=rcutorture
@@ -80,6 +81,7 @@ usage () {
 	echo "       --no-initrd"
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
+	echo "       --remote"
 	echo "       --results absolute-pathname"
 	echo "       --torture lock|rcu|rcuscale|refscale|scf"
 	echo "       --trust-make"
@@ -115,10 +117,13 @@ do
 		checkarg --cpus "(number)" "$#" "$2" '^[0-9]*$' '^--'
 		cpus=$2
 		TORTURE_ALLOTED_CPUS="$2"
-		max_cpus="`identify_qemu_vcpus`"
-		if test "$TORTURE_ALLOTED_CPUS" -gt "$max_cpus"
+		if test -z "$TORTURE_REMOTE"
 		then
-			TORTURE_ALLOTED_CPUS=$max_cpus
+			max_cpus="`identify_qemu_vcpus`"
+			if test "$TORTURE_ALLOTED_CPUS" -gt "$max_cpus"
+			then
+				TORTURE_ALLOTED_CPUS=$max_cpus
+			fi
 		fi
 		shift
 		;;
@@ -209,6 +214,9 @@ do
 		TORTURE_QEMU_CMD="$2"
 		shift
 		;;
+	--remote)
+		TORTURE_REMOTE=1
+		;;
 	--results)
 		checkarg --results "(absolute pathname)" "$#" "$2" '^/' '^error'
 		resdir=$2
-- 
2.31.1.189.g2e36527f23

