Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D3C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044D761246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhGUUVM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7722761351;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=Ox86RKzcpKtqu7hfs6qD9lIKhVFBwJacMDbxadeyVmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTHPkyguTUrT4D5NqJzBRzbeIvcxax90HbqipIpHT7FTji8Hleoa5xwNpgyLS1Va/
         Kra5mtMA2yuJb5RV9kzhq1Dnok+J+tz3hgeiE08KK6yHBZi1vy+tHnP8D46HzNKqNg
         a2KYzNTrXmeVO6ehGkNQGvAwyFoaEo8aS6IfcPGrayq4nLbUUN2UHqIYqSs4vOaTvi
         pyTp+HhHxTI10n4IYpkzRfwON8ZcIbetb0H+nlRvP5N1co30ZSf5s7+EH8r7ZCZv5N
         eQYYO7g0x5mRw129SUrYbaZffeYBERc66Cnk7QfUxas+tdaotYk7ihxpoi9vXaUpbz
         awvJzSqisZWCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DECC85C0F91; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/21] torture: Make kvm.sh select per-scenario affinity masks
Date:   Wed, 21 Jul 2021 14:01:31 -0700
Message-Id: <20210721210140.787717-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit causes kvm.sh to use the new kvm-assign-cpus.sh and
kvm-get-cpus-script.sh scripts to create a TORTURE_AFFINITY environment
variable containing either an empty string (for no affinity) or a list
of CPUs to pin the scenario's vCPUs to.  A later commit will make
use of this information to actually pin the vCPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/bin/kvm-assign-cpus.sh         | 105 ++++++++++++++++++
 .../rcutorture/bin/kvm-get-cpus-script.sh     |  87 +++++++++++++++
 .../rcutorture/bin/kvm-test-1-run-batch.sh    |   1 +
 tools/testing/selftests/rcutorture/bin/kvm.sh |  14 ++-
 4 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-get-cpus-script.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh b/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
new file mode 100755
index 0000000000000..494ae91cc1f0e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+#
+# Produce awk statements roughly depicting the system's CPU and cache
+# layout.  If the required information is not available, produce
+# error messages as awk comments.  Successful exit regardless.
+#
+# Usage: kvm-assign-cpus.sh /path/to/sysfs
+
+T=/tmp/kvm-assign-cpus.sh.$$
+trap 'rm -rf $T' 0 2
+mkdir $T
+
+sysfsdir=${1-/sys/devices/system/node}
+if ! cd "$sysfsdir" > $T/msg 2>&1
+then
+	sed -e 's/^/# /' < $T/msg
+	exit 0
+fi
+nodelist="`ls -d node*`"
+for i in node*
+do
+	if ! test -d $i/
+	then
+		echo "# Not a directory: $sysfsdir/node*"
+		exit 0
+	fi
+	for j in $i/cpu*/cache/index*
+	do
+		if ! test -d $j/
+		then
+			echo "# Not a directory: $sysfsdir/$j"
+			exit 0
+		else
+			break
+		fi
+	done
+	indexlist="`ls -d $i/cpu* | grep 'cpu[0-9][0-9]*' | head -1 | sed -e 's,^.*$,ls -d &/cache/index*,' | sh | sed -e 's,^.*/,,'`"
+	break
+done
+for i in node*/cpu*/cache/index*/shared_cpu_list
+do
+	if ! test -f $i
+	then
+		echo "# Not a file: $sysfsdir/$i"
+		exit 0
+	else
+		break
+	fi
+done
+firstshared=
+for i in $indexlist
+do
+	rm -f $T/cpulist
+	for n in node*
+	do
+		f="$n/cpu*/cache/$i/shared_cpu_list"
+		if ! cat $f > $T/msg 2>&1
+		then
+			sed -e 's/^/# /' < $T/msg
+			exit 0
+		fi
+		cat $f >> $T/cpulist
+	done
+	if grep -q '[-,]' $T/cpulist
+	then
+		if test -z "$firstshared"
+		then
+			firstshared="$i"
+		fi
+	fi
+done
+if test -z "$firstshared"
+then
+	splitindex="`echo $indexlist | sed -e 's/ .*$//'`"
+else
+	splitindex="$firstshared"
+fi
+nodenum=0
+for n in node*
+do
+	cat $n/cpu*/cache/$splitindex/shared_cpu_list | sort -u -k1n |
+	awk -v nodenum="$nodenum" '
+	BEGIN {
+		idx = 0;
+	}
+
+	{
+		nlists = split($0, cpulists, ",");
+		for (i = 1; i <= nlists; i++) {
+			listsize = split(cpulists[i], cpus, "-");
+			if (listsize == 1)
+				cpus[2] = cpus[1];
+			for (j = cpus[1]; j <= cpus[2]; j++) {
+				print "cpu[" nodenum "][" idx "] = " j ";";
+				idx++;
+			}
+		}
+	}
+
+	END {
+		print "nodecpus[" nodenum "] = " idx ";";
+	}'
+	nodenum=`expr $nodenum + 1`
+done
+echo "numnodes = $nodenum;"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-get-cpus-script.sh b/tools/testing/selftests/rcutorture/bin/kvm-get-cpus-script.sh
new file mode 100755
index 0000000000000..0ab7fca5bec12
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-get-cpus-script.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+#
+# Create an awk script that takes as input numbers of CPUs and outputs
+# lists of CPUs, one per line in both cases.
+#
+# Usage: kvm-get-cpus-script.sh /path/to/cpu/arrays /path/to/put/script [ /path/to/state ]
+#
+# The CPU arrays are output by kvm-assign-cpus.sh, and are valid awk
+# statements initializing the variables describing the system's topology.
+#
+# The optional state is input by this script (if the file exists and is
+# non-empty), and can also be output by this script.
+
+cpuarrays="${1-/sys/devices/system/node}"
+scriptfile="${2}"
+statefile="${3}"
+
+if ! test -f "$cpuarrays"
+then
+	echo "File not found: $cpuarrays" 1>&2
+	exit 1
+fi
+scriptdir="`dirname "$scriptfile"`"
+if ! test -d "$scriptdir" || ! test -x "$scriptdir" || ! test -w "$scriptdir"
+then
+	echo "Directory not usable for script output: $scriptdir"
+	exit 1
+fi
+
+cat << '___EOF___' > "$scriptfile"
+BEGIN {
+___EOF___
+cat "$cpuarrays" >> "$scriptfile"
+if test -r "$statefile"
+then
+	cat "$statefile" >> "$scriptfile"
+fi
+cat << '___EOF___' >> "$scriptfile"
+}
+
+# Do we have the system architecture to guide CPU affinity?
+function gotcpus()
+{
+	return numnodes != "";
+}
+
+# Return a comma-separated list of the next n CPUs.
+function nextcpus(n,  i, s)
+{
+	for (i = 0; i < n; i++) {
+		if (nodecpus[curnode] == "")
+			curnode = 0;
+		if (cpu[curnode][curcpu[curnode]] == "")
+			curcpu[curnode] = 0;
+		if (s != "")
+			s = s ",";
+		s = s cpu[curnode][curcpu[curnode]];
+		curcpu[curnode]++;
+		curnode++
+	}
+	return s;
+}
+
+# Dump out the current node/CPU state so that a later invocation of this
+# script can continue where this one left off.  Of course, this only works
+# when a state file was specified and where there was valid sysfs state.
+# Returns 1 if the state was dumped, 0 otherwise.
+#
+# Dumping the state for one system configuration and loading it into
+# another isn't likely to do what you want, whatever that might be.
+function dumpcpustate(  i, fn)
+{
+___EOF___
+echo '	fn = "'"$statefile"'";' >> $scriptfile
+cat << '___EOF___' >> "$scriptfile"
+	if (fn != "" && gotcpus()) {
+		print "curnode = " curnode ";" > fn;
+		for (i = 0; i < numnodes; i++)
+			if (curcpu[i] != "")
+				print "curcpu[" i "] = " curcpu[i] ";" >> fn;
+		return 1;
+	}
+	if (fn != "")
+		print "# No CPU state to dump." > fn;
+	return 0;
+}
+___EOF___
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
index 7ea0809e229e9..005a048c55aa0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
@@ -54,6 +54,7 @@ for i in "$@"
 do
 	echo ---- System running test: `uname -a` > $i/kvm-test-1-run-qemu.sh.out
 	echo > $i/kvm-test-1-run-qemu.sh.out
+	export TORTURE_AFFINITY=
 	kvm-test-1-run-qemu.sh $i >> $i/kvm-test-1-run-qemu.sh.out 2>&1 &
 done
 for i in $runfiles
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0f26a81599f5c..f442d84fb2a3e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -430,7 +430,9 @@ then
 	git diff HEAD >> $resdir/$ds/testid.txt
 fi
 ___EOF___
-cat << '___EOF___' > $T/dumpbatches.awk
+kvm-assign-cpus.sh /sys/devices/system/node > $T/cpuarray.awk
+kvm-get-cpus-script.sh $T/cpuarray.awk $T/dumpbatches.awk
+cat << '___EOF___' >> $T/dumpbatches.awk
 BEGIN {
 	i = 0;
 }
@@ -442,7 +444,7 @@ BEGIN {
 }
 
 # Dump out the scripting required to run one test batch.
-function dump(first, pastlast, batchnum)
+function dump(first, pastlast, batchnum,  affinitylist)
 {
 	print "echo ----Start batch " batchnum ": `date` | tee -a " rd "log";
 	print "needqemurun="
@@ -474,6 +476,14 @@ function dump(first, pastlast, batchnum)
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Starting build. `date` | tee -a " rd "log";
 		print "mkdir " rd cfr[jn] " || :";
 		print "touch " builddir ".wait";
+		affinitylist = "";
+		if (gotcpus()) {
+			affinitylist = nextcpus(cpusr[jn]);
+		}
+		if (affinitylist ~ /^[0-9,-][0-9,-]*$/)
+			print "export TORTURE_AFFINITY=" affinitylist;
+		else
+			print "export TORTURE_AFFINITY=";
 		print "kvm-test-1-run.sh " CONFIGDIR cf[j], rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Waiting for build to complete. `date` | tee -a " rd "log";
 		print "while test -f " builddir ".wait"
-- 
2.31.1.189.g2e36527f23

