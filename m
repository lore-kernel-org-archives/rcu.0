Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC74C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6BB2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897072;
	bh=W+gEJmR4xbXH73cYn3wV+uY9hiLuX4oIlcZi5GWxPFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X0O+NfXiJfXUbBRDMgW/3Vct9oHZP5ullNCYauNI/UqbSzi714yF78SNuYr18Gfo7
	 2hA7C1jEMewHak6Z9Ol0dD8QeyD+mgxYbf4x4m4PgRx3y4Eg19q7oQ15qg+lC3BcFY
	 roivosahptXTOWQ1/FEm4i4Lvy6UCQh84GYQ0FEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgHaSEP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgHaSEO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:14 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55811217A0;
        Mon, 31 Aug 2020 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897052;
        bh=W+gEJmR4xbXH73cYn3wV+uY9hiLuX4oIlcZi5GWxPFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opBk+QJFgGfyaqyL/0T9NV+6BiYvJfZLB0WYblqvIfRPEJRKeHV0eew1tak7lCkqe
         QEqDoTPxRUB9IWXBlAXSLunE9gWtFS9WfYjt//pX/HmtnhSZkDmiXRECyNE79QP2I6
         1hBYKfwpJqByH/gvskHQP9/zO5dEIzXWvU4IQY14=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/14] torture: Add gdb support
Date:   Mon, 31 Aug 2020 11:04:06 -0700
Message-Id: <20200831180406.494-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a "--gdb" parameter to kvm.sh, which causes
"CONFIG_DEBUG_INFO=y" to be added to the Kconfig options, "nokaslr"
to be added to the boot parameters, and "-s -S" to be added to the qemu
arguments.  Furthermore, the scripting prints messages telling the user
how to start up gdb for the run in question.

Because of the interactive nature of gdb sessions, only one "--configs"
scenario is permitted when "--gdb" is specified.  For most torture types,
this means that a "--configs" argument is required, and that argument
must specify the single scenario of interest.

The usual cautions about breakpoints and timing apply, for example,
staring at your gdb prompt for too long will likely get you many
complaints, including RCU CPU stall warnings.  Omar Sandoval further
suggests using gdb's "hbreak" command instead of the "break" command on
systems supporting hardware breakpoints, and further using the "commands"
option because the resulting non-interactive breakpoints are less likely
to get you RCU CPU stall warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 33 ++++++++++++++++------
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 21 ++++++++++++++
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index e07779a..6dc2b49 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -66,6 +66,7 @@ config_override_param () {
 echo > $T/KcList
 config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"
 config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
+config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
 config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
@@ -152,7 +153,11 @@ qemu_append="`identify_qemu_append "$QEMU"`"
 boot_args="`configfrag_boot_params "$boot_args" "$config_template"`"
 # Generate kernel-version-specific boot parameters
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
-echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
+if test -n "$TORTURE_BOOT_GDB_ARG"
+then
+	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
+fi
+echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
@@ -171,14 +176,26 @@ echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
 # Attempt to run qemu
 ( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
-sleep 10 # Give qemu's pid a chance to reach the file
-if test -s "$resdir/qemu_pid"
+if test -z "$TORTURE_KCONFIG_GDB_ARG"
 then
-	qemu_pid=`cat "$resdir/qemu_pid"`
-	echo Monitoring qemu job at pid $qemu_pid
-else
-	qemu_pid=""
-	echo Monitoring qemu job at yet-as-unknown pid
+	sleep 10 # Give qemu's pid a chance to reach the file
+	if test -s "$resdir/qemu_pid"
+	then
+		qemu_pid=`cat "$resdir/qemu_pid"`
+		echo Monitoring qemu job at pid $qemu_pid
+	else
+		qemu_pid=""
+		echo Monitoring qemu job at yet-as-unknown pid
+	fi
+fi
+if test -n "$TORTURE_KCONFIG_GDB_ARG"
+then
+	echo Waiting for you to attach a debug session, for example: > /dev/tty
+	echo "    gdb $base_resdir/vmlinux" > /dev/tty
+	echo 'After symbols load and the "(gdb)" prompt appears:' > /dev/tty
+	echo "    target remote :1234" > /dev/tty
+	echo "    continue" > /dev/tty
+	kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 fi
 while :
 do
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index fc15b52..c30047e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -31,6 +31,9 @@ TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
+TORTURE_KCONFIG_GDB_ARG=""
+TORTURE_BOOT_GDB_ARG=""
+TORTURE_QEMU_GDB_ARG=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
@@ -56,6 +59,7 @@ usage () {
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
 	echo "       --duration minutes"
+	echo "       --gdb"
 	echo "       --help"
 	echo "       --interactive"
 	echo "       --jitter N [ maxsleep (us) [ maxspin (us) ] ]"
@@ -128,6 +132,11 @@ do
 		dur=$(($2*60))
 		shift
 		;;
+	--gdb)
+		TORTURE_KCONFIG_GDB_ARG="CONFIG_DEBUG_INFO=y"; export TORTURE_KCONFIG_GDB_ARG
+		TORTURE_BOOT_GDB_ARG="nokaslr"; export TORTURE_BOOT_GDB_ARG
+		TORTURE_QEMU_GDB_ARG="-s -S"; export TORTURE_QEMU_GDB_ARG
+		;;
 	--help|-h)
 		usage
 		;;
@@ -253,6 +262,15 @@ do
 done
 touch $T/cfgcpu
 configs_derep="`echo $configs_derep | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
+if test -n "$TORTURE_KCONFIG_GDB_ARG"
+then
+	if test "`echo $configs_derep | wc -w`" -gt 1
+	then
+		echo "The --config list is: $configs_derep."
+		echo "Only one --config permitted with --gdb, terminating."
+		exit 1
+	fi
+fi
 for CF1 in $configs_derep
 do
 	if test -f "$CONFIGFRAG/$CF1"
@@ -328,6 +346,9 @@ TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
 TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
+TORTURE_KCONFIG_GDB_ARG="$TORTURE_KCONFIG_GDB_ARG"; export TORTURE_KCONFIG_GDB_ARG
+TORTURE_BOOT_GDB_ARG="$TORTURE_BOOT_GDB_ARG"; export TORTURE_BOOT_GDB_ARG
+TORTURE_QEMU_GDB_ARG="$TORTURE_QEMU_GDB_ARG"; export TORTURE_QEMU_GDB_ARG
 TORTURE_KCONFIG_KASAN_ARG="$TORTURE_KCONFIG_KASAN_ARG"; export TORTURE_KCONFIG_KASAN_ARG
 TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
-- 
2.9.5

