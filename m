Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848ADC433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F452083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897364;
	bh=PO/ymn47zoTtl+4GWO5XGsTjjXluSYSZ26cp39dkN3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ds2Ec9F3SNmghhJ8Hp+8By91Q4X5oBb2mTaoXFoRQok6F4vnZsewazat2nK6yKSsC
	 Gzj+nlrOqTALUVR0ZzGUDavHWnqNmQ86FIvP4YcVvzsRewEMkeADy4qN9BVohdPEvd
	 hPuKdIRjXz9/4G6r3g1ewjC0ckcMwP/YSYrAZkFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgHaSJY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgHaSHx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E7B214DB;
        Mon, 31 Aug 2020 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897272;
        bh=PO/ymn47zoTtl+4GWO5XGsTjjXluSYSZ26cp39dkN3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJIJltOa+PNbxfHJJJM/A7YjIiOs4mpyXXEn3y4eu89Su7IGgWGzaWx2ewZ7XDfDE
         f/CTKmpM7uKaSqgcEjgH0BXiUFznyHBeCifWuaW9nAMoTG4iE2NdJkAAHT1EVk5I3s
         jxcIGPM++smv3z/EFTPizMFS0MmxmPn6aRCfeENQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/19] torture: Add scftorture to the rcutorture scripting
Date:   Mon, 31 Aug 2020 11:07:33 -0700
Message-Id: <20200831180749.843-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit updates the rcutorture scripting to include the new scftorture
torture-test module.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-recheck-scf.sh    | 38 ++++++++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  2 +-
 .../selftests/rcutorture/configs/scf/CFLIST        |  2 ++
 .../selftests/rcutorture/configs/scf/CFcommon      |  2 ++
 .../selftests/rcutorture/configs/scf/NOPREEMPT     |  9 +++++
 .../rcutorture/configs/scf/NOPREEMPT.boot          |  1 +
 .../selftests/rcutorture/configs/scf/PREEMPT       |  9 +++++
 .../rcutorture/configs/scf/ver_functions.sh        | 30 +++++++++++++++++
 8 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
new file mode 100755
index 0000000..671bfee
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for rcutorture progress.
+#
+# Usage: kvm-recheck-rcu.sh resdir
+#
+# Copyright (C) Facebook, 2020
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+i="$1"
+if test -d "$i" -a -r "$i"
+then
+	:
+else
+	echo Unreadable results directory: $i
+	exit 1
+fi
+. functions.sh
+
+configfile=`echo $i | sed -e 's/^.*\///'`
+nscfs="`grep 'scf_invoked_count ver:' $i/console.log 2> /dev/null | tail -1 | sed -e 's/^.* scf_invoked_count ver: //' -e 's/ .*$//' | tr -d '\015'`"
+if test -z "$nscfs"
+then
+	echo "$configfile ------- "
+else
+	dur="`sed -e 's/^.* scftorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`"
+	if test -z "$dur"
+	then
+		rate=""
+	else
+		nscfss=`awk -v nscfs=$nscfs -v dur=$dur '
+			BEGIN { print nscfs / dur }' < /dev/null`
+		rate=" ($nscfss/s)"
+	fi
+	echo "${configfile} ------- ${nscfs} SCF handler invocations$rate"
+fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e655983..44dfdd9 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -184,7 +184,7 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\|scf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
 		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refscale
diff --git a/tools/testing/selftests/rcutorture/configs/scf/CFLIST b/tools/testing/selftests/rcutorture/configs/scf/CFLIST
new file mode 100644
index 0000000..4d62eb4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/CFLIST
@@ -0,0 +1,2 @@
+NOPREEMPT
+PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/scf/CFcommon b/tools/testing/selftests/rcutorture/configs/scf/CFcommon
new file mode 100644
index 0000000..c11ab91
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_SCF_TORTURE_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
new file mode 100644
index 0000000..b8429d6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
@@ -0,0 +1,9 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=n
+CONFIG_NO_HZ_FULL=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
new file mode 100644
index 0000000..d6a7fa0
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
@@ -0,0 +1 @@
+nohz_full=1
diff --git a/tools/testing/selftests/rcutorture/configs/scf/PREEMPT b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
new file mode 100644
index 0000000..ae4992b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/PREEMPT
@@ -0,0 +1,9 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
diff --git a/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
new file mode 100644
index 0000000..d3d9e35
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Torture-suite-dependent shell functions for the rest of the scripts.
+#
+# Copyright (C) Facebook, 2020
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+# scftorture_param_onoff bootparam-string config-file
+#
+# Adds onoff scftorture module parameters to kernels having it.
+scftorture_param_onoff () {
+	if ! bootparam_hotplug_cpu "$1" && configfrag_hotplug_cpu "$2"
+	then
+		echo CPU-hotplug kernel, adding scftorture onoff. 1>&2
+		echo scftorture.onoff_interval=1000 scftorture.onoff_holdoff=30
+	fi
+}
+
+# per_version_boot_params bootparam-string config-file seconds
+#
+# Adds per-version torture-module parameters to kernels supporting them.
+per_version_boot_params () {
+	echo $1 `scftorture_param_onoff "$1" "$2"` \
+		scftorture.stat_interval=15 \
+		scftorture.shutdown_secs=$3 \
+		scftorture.verbose=1 \
+		scf
+}
-- 
2.9.5

