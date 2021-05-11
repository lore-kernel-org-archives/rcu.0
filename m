Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C3EC43603
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876116192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKXNf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE45C61935;
        Tue, 11 May 2021 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=7sGKDwzsBORntn0TSy0jrNlHcBARLkVgL/a9wCs+8L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0vpGf+mlYBh+sSF4Ev7Zue+gEpwx34CTZKT13t5fBdE8uzqJJ/pcVCHBvYUaa8wc
         YfP4Si8tXr2H/zDGm5qTP7kQo14I3dWkC9ph+I5FVDezuOzOg505cFF1Pr43VYlSaq
         sX09A3lugIDuHzS9ykXazy3M2Q+pU4+iKvglQZHo/YAGnu49S02hXHHpszD0ZHEarQ
         aNyejs40wYo0e9eykpcTs8C8BVgfA1S/W0CQDbK6i0uJyQKBdpnUJ9XKcQdpDAvSXd
         Ba5fCrFxtwywbzIbYnv/aVdrBAW6wakTnrYlP7y8BUem/YbakTPzXD76zFDpeH11yh
         bguNnBZWEgBSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 73E3E5C0DB3; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/26] torture: Add kvm-remote.sh script for distributed rcutorture test runs
Date:   Tue, 11 May 2021 16:12:03 -0700
Message-Id: <20210511231223.2895398-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds a kvm-remote.sh script that prepares a tarball that
is then downloaded to the remote system(s) and executed.  The user is
responsible for having set up the remote systems to run qemu, but all the
kernel builds are done on the system running the kvm-remote.sh script.
The user is also responsible for setting up the remote systems so that
ssh can be run non-interactively, given that ssh is used to poll the
remote systems in order to detect completion of each batch.

See the script's header comment for usage information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-remote.sh    | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
new file mode 100755
index 000000000000..c4859fca87b2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -0,0 +1,227 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run a series of tests on remote systems under KVM.
+#
+# Usage: kvm-remote.sh "systems" [ <kvm.sh args> ]
+#	 kvm-remote.sh "systems" /path/to/old/run [ <kvm-again.sh args> ]
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+scriptname=$0
+args="$*"
+
+if ! test -d tools/testing/selftests/rcutorture/bin
+then
+	echo $scriptname must be run from top-level directory of kernel source tree.
+	exit 1
+fi
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+
+starttime="`get_starttime`"
+
+systems="$1"
+if test -z "$systems"
+then
+	echo $scriptname: Empty list of systems will go nowhere good, giving up.
+	exit 1
+fi
+shift
+
+# Pathnames:
+# T:	  /tmp/kvm-remote.sh.$$
+# resdir: /tmp/kvm-remote.sh.$$/res
+# rundir: /tmp/kvm-remote.sh.$$/res/$ds ("-remote" suffix)
+# oldrun: `pwd`/tools/testing/.../res/$otherds
+#
+# Pathname segments:
+# TD:	  kvm-remote.sh.$$
+# ds:	  yyyy.mm.dd-hh.mm.ss-remote
+
+TD=kvm-remote.sh.$$
+T=${TMPDIR-/tmp}/$TD
+trap 'rm -rf $T' 0
+mkdir $T
+
+resdir="$T/res"
+ds=`date +%Y.%m.%d-%H.%M.%S`-remote
+rundir=$resdir/$ds
+echo Results directory: $rundir
+echo $scriptname $args
+if echo $1 | grep -q '^--'
+then
+	# Fresh build.  Create a datestamp unless the caller supplied one.
+	datestamp="`echo "$@" | awk -v ds="$ds" '{
+		for (i = 1; i < NF; i++) {
+			if ($i == "--datestamp") {
+				ds = "";
+				break;
+			}
+		}
+		if (ds != "")
+			print "--datestamp " ds;
+	}'`"
+	kvm.sh "$@" $datestamp --buildonly > $T/kvm.sh.out 2>&1
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo $scriptname: kvm.sh failed exit code $?
+		cat $T/kvm.sh.out
+		exit 2
+	fi
+	oldrun="`grep -m 1 "^Results directory: " $T/kvm.sh.out | awk '{ print $3 }'`"
+	touch "$oldrun/remote-log"
+	echo $scriptname $args >> "$oldrun/remote-log"
+	echo | tee -a "$oldrun/remote-log"
+	echo " ----" kvm.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
+	cat $T/kvm.sh.out | tee -a "$oldrun/remote-log"
+	# We are going to run this, so remove the buildonly files.
+	rm -f "$oldrun"/*/buildonly
+	kvm-again.sh $oldrun --dryrun --remote --rundir "$rundir" > $T/kvm-again.sh.out 2>&1
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo $scriptname: kvm-again.sh failed exit code $? | tee -a "$oldrun/remote-log"
+		cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
+		exit 2
+	fi
+else
+	# Re-use old run.
+	oldrun="$1"
+	if ! echo $oldrun | grep -q '^/'
+	then
+		oldrun="`pwd`/$oldrun"
+	fi
+	shift
+	touch "$oldrun/remote-log"
+	echo $scriptname $args >> "$oldrun/remote-log"
+	kvm-again.sh "$oldrun" "$@" --dryrun --remote --rundir "$rundir" > $T/kvm-again.sh.out 2>&1
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo $scriptname: kvm-again.sh failed exit code $? | tee -a "$oldrun/remote-log"
+		cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
+		exit 2
+	fi
+	cp -a "$rundir" "$KVM/res/"
+	oldrun="$KVM/res/$ds"
+fi
+echo | tee -a "$oldrun/remote-log"
+echo " ----" kvm-again.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
+cat $T/kvm-again.sh.out
+echo | tee -a "$oldrun/remote-log"
+echo Remote run directory: $rundir | tee -a "$oldrun/remote-log"
+echo Local build-side run directory: $oldrun | tee -a "$oldrun/remote-log"
+
+# Create the kvm-remote-N.sh scripts in the bin directory.
+awk < "$rundir"/scenarios -v dest="$T/bin" -v rundir="$rundir" '
+{
+	n = $1;
+	sub(/\./, "", n);
+	fn = dest "/kvm-remote-" n ".sh"
+	scenarios = "";
+	for (i = 2; i <= NF; i++)
+		scenarios = scenarios " " $i;
+	print "kvm-test-1-run-batch.sh" scenarios > fn;
+	print "rm " rundir "/remote.run" >> fn;
+}'
+chmod +x $T/bin/kvm-remote-*.sh
+( cd "`dirname $T`"; tar -chzf $T/binres.tgz "$TD/bin" "$TD/res" )
+
+# Check first to avoid the need for cleanup for system-name typos
+for i in $systems
+do
+	ncpus="`ssh $i lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo System $i unreachable, giving up. | tee -a "$oldrun/remote-log"
+		exit 4 | tee -a "$oldrun/remote-log"
+	fi
+done
+
+# Download and expand the tarball on all systems.
+for i in $systems
+do
+	echo Downloading tarball to $i `date` | tee -a "$oldrun/remote-log"
+	cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo Unable to download $T/binres.tgz to system $i, giving up. | tee -a "$oldrun/remote-log"
+		exit 10 | tee -a "$oldrun/remote-log"
+	fi
+done
+
+# Function to start batches on idle remote $systems
+#
+# Usage: startbatches curbatch nbatches
+#
+# Batches are numbered starting at 1.  Returns the next batch to start.
+# Be careful to redirect all debug output to FD 2 (stderr).
+startbatches () {
+	local curbatch="$1"
+	local nbatches="$2"
+	local ret
+
+	# Each pass through the following loop examines one system.
+	for i in $systems
+	do
+		if test "$curbatch" -gt "$nbatches"
+		then
+			echo $((nbatches + 1))
+			return 0
+		fi
+		if ssh "$i" "test -f \"$resdir/$ds/remote.run\"" 1>&2
+		then
+			continue # System still running last test, skip.
+		fi
+		ssh "$i" "cd \"$resdir/$ds\"; touch remote.run; PATH=\"$T/bin:$PATH\" nohup kvm-remote-$curbatch.sh > kvm-remote-$curbatch.sh.out 2>&1 &" 1>&2
+		ret=$?
+		if test "$ret" -ne 0
+		then
+			echo ssh $i failed: exitcode $ret 1>&2
+			exit 11
+		fi
+		echo " ----" System $i Batch `head -n $curbatch < "$rundir"/scenarios | tail -1` `date` 1>&2
+		curbatch=$((curbatch + 1))
+	done
+	echo $curbatch
+}
+
+# Launch all the scenarios.
+nbatches="`wc -l "$rundir"/scenarios | awk '{ print $1 }'`"
+curbatch=1
+while test "$curbatch" -le "$nbatches"
+do
+	startbatches $curbatch $nbatches > $T/curbatch 2> $T/startbatches.stderr
+	curbatch="`cat $T/curbatch`"
+	if test -s "$T/startbatches.stderr"
+	then
+		cat "$T/startbatches.stderr" | tee -a "$oldrun/remote-log"
+	fi
+	if test "$curbatch" -le "$nbatches"
+	then
+		sleep 30
+	fi
+done
+echo All batches started. `date`
+
+# Wait for all remaining scenarios to complete and collect results.
+for i in $systems
+do
+	while ssh "$i" "test -f \"$resdir/$ds/remote.run\""
+	do
+		sleep 30
+	done
+	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu_pid */qemu-retval; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+done
+
+( kvm-end-run-stats.sh "$oldrun" "$starttime"; echo $? > $T/exitcode ) | tee -a "$oldrun/remote-log"
+exit "`cat $T/exitcode`"
-- 
2.31.1.189.g2e36527f23

