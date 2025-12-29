Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD2295511;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035640; cv=none; b=ifDr5ncaBIAOQ/b1Z085nYjnLWZ+AGNJ9apePBxQxq6OxVUyCiXITqGet57P5DZ+lPC7vR2DZKbrlbKoaemZQGT8y3vpl1005ScCkzqeM6z7M9Or1ub2pjtA623efiZNlNg5V9QNCiG5q387C8Ex0YgTPGQjAHOuVXnNjV6nnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035640; c=relaxed/simple;
	bh=d7kEec1Fu/bQ/lnrxbbAvKpYSpSr8iZL9kTn30+SxQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEOG10ypVTQRZnklpRZcSVUlVZCMBLLLA/UDBqazKmcAjrNG8GByXN1+yzy7i6zTCbw8HAc3qPnIKM+fNSgL25beQHz0ExeKihwvlDkO8mAdZhfJDACgspeQaOGv2nwVHmabYaSAmMB/Ow5JsucAj4MduuZ30D9ie044AWoDxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDAlZ3JZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDAlZ3JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20A7C116D0;
	Mon, 29 Dec 2025 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035639;
	bh=d7kEec1Fu/bQ/lnrxbbAvKpYSpSr8iZL9kTn30+SxQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDAlZ3JZdGd30uRyK6PKHMhXYs5xIy86PKXRw4H4vnsr1BSvcmtl8HCR7PfIYgfbW
	 QqsnA5JL4xjwpNLDBuiYo+PNVlBpYPdgMVADguKe591K+F1DqcbWJppEfUamkf5dbk
	 iKiAUc3nEKEZRgQNZBCFHA9inEIzvzsnbdbMkPY4z6U50UksEHejcuSgiH+wXw1yyd
	 llTXjrFWJn2/q1QTEwbvdJ3dU2e9ELcQ0i6ANEcO6a1SKv5jO2WL68MCBqIynR7mwf
	 zfNS2lI8I1PXq/AFZeTJekkLG/LU50TFJmYV3NikSgtLKuLceUNXW8ZCE1cT2Ioyuy
	 98EU0JlKScqbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FF20CE0CAF; Mon, 29 Dec 2025 11:13:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 2/6] torture: Parallelize kvm-series.sh guest-OS execution
Date: Mon, 29 Dec 2025 11:13:54 -0800
Message-Id: <20251229191358.693753-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
References: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kvm-series.sh builds and runs serially, which makes for
long execution times.  This commit changes its logic to build all of
the needed kernels serially, but then run the corresponding guest OSes
concurrently in batches using the entire machine.  On large systems,
this results in order-of-magnitude speedups of the guest-OS execution
portion of the runtime.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-series.sh    | 176 +++++++++++++++---
 1 file changed, 154 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-series.sh b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
index 2ff905a1853bd..d020d0672023a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-series.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
@@ -8,14 +8,14 @@
 # then runs each commit through the specified list of commits using kvm.sh.
 # The runs are grouped into a -series/config/commit directory tree.
 # Each run defaults to a duration of one minute.
-#
+# 
 # Run in top-level Linux source directory.  Please note that this is in
 # no way a replacement for "git bisect"!!!
 #
 # This script is intended to replace kvm-check-branches.sh by providing
 # ease of use and faster execution.
 
-T="`mktemp -d ${TMPDIR-/tmp}/kvm-series.sh.XXXXXX`"
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-series.sh.XXXXXX`"; export T
 trap 'rm -rf $T' 0
 
 scriptname=$0
@@ -53,40 +53,62 @@ shift
 
 RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
 PATH=${RCUTORTURE}/bin:$PATH; export PATH
+RES="${RCUTORTURE}/res"; export RES
 . functions.sh
 
 ret=0
-nfail=0
+nbuildfail=0
+nrunfail=0
 nsuccess=0
-faillist=
+ncpus=0
+buildfaillist=
+runfaillist=
 successlist=
 cursha1="`git rev-parse --abbrev-ref HEAD`"
 ds="`date +%Y.%m.%d-%H.%M.%S`-series"
+DS="${RES}/${ds}"; export DS
 startdate="`date`"
 starttime="`get_starttime`"
 
 echo " --- " $scriptname $args | tee -a $T/log
 echo " --- Results directory: " $ds | tee -a $T/log
 
+# Do all builds.  Iterate through commits within a given scenario
+# because builds normally go faster from one commit to the next within a
+# given scenario.  In contrast, switching scenarios on each rebuild will
+# often force a full rebuild due to Kconfig differences, for example,
+# turning preemption on and off.  Defer actual runs in order to run
+# lots of them concurrently on large systems.
+touch $T/torunlist
 for config in ${config_list}
 do
 	sha_n=0
 	for sha in ${sha1_list}
 	do
 		sha1=${sha_n}.${sha} # Enable "sort -k1nr" to list commits in order.
+		echo
 		echo Starting ${config}/${sha1} at `date` | tee -a $T/log
-		git checkout "${sha}"
-		time tools/testing/selftests/rcutorture/bin/kvm.sh --configs "$config" --datestamp "$ds/${config}/${sha1}" --duration 1 "$@"
+		git checkout --detach "${sha}"
+		tools/testing/selftests/rcutorture/bin/kvm.sh --configs "$config" --datestamp "$ds/${config}/${sha1}" --duration 1 --build-only --trust-make "$@"
 		curret=$?
 		if test "${curret}" -ne 0
 		then
-			nfail=$((nfail+1))
-			faillist="$faillist ${config}/${sha1}(${curret})"
+			nbuildfail=$((nbuildfail+1))
+			buildfaillist="$buildfaillist ${config}/${sha1}(${curret})"
 		else
-			nsuccess=$((nsuccess+1))
-			successlist="$successlist ${config}/${sha1}"
-			# Successful run, so remove large files.
-			rm -f ${RCUTORTURE}/$ds/${config}/${sha1}/{vmlinux,bzImage,System.map,Module.symvers}
+			batchncpus="`grep -v "^# cpus=" "${DS}/${config}/${sha1}/batches" | awk '{ sum += $3 } END { print sum }'`"
+			echo run_one_qemu ${sha_n} ${config}/${sha1} ${batchncpus} >> $T/torunlist
+			if test "${ncpus}" -eq 0
+			then
+				ncpus="`grep "^# cpus=" "${DS}/${config}/${sha1}/batches" | sed -e 's/^# cpus=//'`"
+				case "${ncpus}" in
+				^[0-9]*$)
+					;;
+				*)
+					ncpus=0
+					;;
+				esac
+			fi
 		fi
 		if test "${ret}" -eq 0
 		then
@@ -95,22 +117,132 @@ do
 		sha_n=$((sha_n+1))
 	done
 done
+
+# If the user did not specify the number of CPUs, use them all.
+if test "${ncpus}" -eq 0
+then
+	ncpus="`identify_qemu_vcpus`"
+fi
+
+cpusused=0
+touch $T/successlistfile
+touch $T/faillistfile
+
+# do_run_one_qemu ds resultsdir qemu_curout
+#
+# Start the specified qemu run and record its success or failure.
+do_run_one_qemu () {
+	local ret
+	local ds="$1"
+	local resultsdir="$2"
+	local qemu_curout="$3"
+
+	tools/testing/selftests/rcutorture/bin/kvm-again.sh "${DS}/${resultsdir}" --link inplace-force > ${qemu_curout} 2>&1
+	ret=$?
+	if test "${ret}" -eq 0
+	then
+		echo ${resultsdir} >> $T/successlistfile
+		# Successful run, so remove large files.
+		rm -f ${DS}/${resultsdir}/{vmlinux,bzImage,System.map,Module.symvers}
+	else
+		echo "${resultsdir}(${ret})" >> $T/faillistfile
+	fi
+}
+
+# cleanup_qemu_batch batchncpus
+#
+# Update success and failure lists, files, and counts at the end of
+# a batch.
+cleanup_qemu_batch () {
+	local batchncpus="$1"
+
+	echo Waiting, cpusused=${cpusused}, ncpus=${ncpus} `date` | tee -a $T/log
+	wait
+	cpusused="${batchncpus}"
+	nsuccessbatch="`wc -l $T/successlistfile | awk '{ print $1 }'`"
+	nsuccess=$((nsuccess+nsuccessbatch))
+	successlist="$successlist `cat $T/successlistfile`"
+	rm $T/successlistfile
+	touch $T/successlistfile
+	nfailbatch="`wc -l $T/faillistfile | awk '{ print $1 }'`"
+	nrunfail=$((nrunfail+nfailbatch))
+	runfaillist="$runfaillist `cat $T/faillistfile`"
+	rm $T/faillistfile
+	touch $T/faillistfile
+}
+
+# run_one_qemu sha_n config/sha1 batchncpus
+#
+# Launch into the background the sha_n-th qemu job whose results directory
+# is config/sha1 and which uses batchncpus CPUs.  Once we reach a job that
+# would overflow the number of available CPUs, wait for the previous jobs
+# to complete and record their results.
+run_one_qemu () {
+	local sha_n="$1"
+	local config_sha1="$2"
+	local batchncpus="$3"
+	local qemu_curout
+
+	cpusused=$((cpusused+batchncpus))
+	if test "${cpusused}" -gt $ncpus
+	then
+		cleanup_qemu_batch "${batchncpus}"
+	fi
+	echo Starting ${config_sha1} using ${batchncpus} CPUs `date`
+	qemu_curout="${DS}/${config_sha1}/qemu-series"
+	do_run_one_qemu "$ds" "${config_sha1}" ${qemu_curout} &
+}
+
+# Re-ordering the runs will mess up the affinity chosen at build time
+# (among other things, over-using CPU 0), so suppress it.
+TORTURE_NO_AFFINITY="no-affinity"; export TORTURE_NO_AFFINITY
+
+# Run the kernels (if any) that built correctly.
+echo | tee -a $T/log # Put a blank line between build and run messages.
+. $T/torunlist
+cleanup_qemu_batch "${batchncpus}"
+
+# Get back to initial checkout/SHA-1.
 git checkout "${cursha1}"
 
-echo ${nsuccess} SUCCESSES: | tee -a $T/log
-echo ${successlist} | fmt | tee -a $T/log
-echo | tee -a $T/log
-echo ${nfail} FAILURES: | tee -a $T/log
-echo ${faillist} | fmt | tee -a $T/log
-if test -n "${faillist}"
+# Throw away leading and trailing space characters for fmt.
+successlist="`echo ${successlist} | sed -e 's/^ *//' -e 's/ *$//'`"
+buildfaillist="`echo ${buildfaillist} | sed -e 's/^ *//' -e 's/ *$//'`"
+runfaillist="`echo ${runfaillist} | sed -e 's/^ *//' -e 's/ *$//'`"
+
+# Print lists of successes, build failures, and run failures, if any.
+if test "${nsuccess}" -gt 0
+then
+	echo | tee -a $T/log
+	echo ${nsuccess} SUCCESSES: | tee -a $T/log
+	echo ${successlist} | fmt | tee -a $T/log
+fi
+if test "${nbuildfail}" -gt 0
 then
 	echo | tee -a $T/log
-	echo Failures across commits: | tee -a $T/log
-	echo ${faillist} | tr ' ' '\012' | sed -e 's,^[^/]*/,,' -e 's/([0-9]*)//' |
+	echo ${nbuildfail} BUILD FAILURES: | tee -a $T/log
+	echo ${buildfaillist} | fmt | tee -a $T/log
+fi
+if test "${nrunfail}" -gt 0
+then
+	echo | tee -a $T/log
+	echo ${nrunfail} RUN FAILURES: | tee -a $T/log
+	echo ${runfaillist} | fmt | tee -a $T/log
+fi
+
+# If there were build or runtime failures, map them to commits.
+if test "${nbuildfail}" -gt 0 || test "${nrunfail}" -gt 0
+then
+	echo | tee -a $T/log
+	echo Build failures across commits: | tee -a $T/log
+	echo ${buildfaillist} | tr ' ' '\012' | sed -e 's,^[^/]*/,,' -e 's/([0-9]*)//' |
 		sort | uniq -c | sort -k2n | tee -a $T/log
 fi
+
+# Print run summary.
+echo | tee -a $T/log
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
-echo Summary: Successes: ${nsuccess} Failures: ${nfail} | tee -a $T/log
-cp $T/log tools/testing/selftests/rcutorture/res/${ds}
+echo Summary: Successes: ${nsuccess} " "Build Failures: ${nbuildfail} " "Runtime Failures: ${nrunfail}| tee -a $T/log
+cp $T/log ${DS}
 
 exit "${ret}"
-- 
2.40.1

