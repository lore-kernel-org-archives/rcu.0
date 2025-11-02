Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243A1A9FBF;
	Sun,  2 Nov 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117551; cv=none; b=VNToxiO6NR1WAVH/0ECVb1VsdGI1x8IkigEMQuYt4P3/OT0Dr/ndZQb1BHrS5X5y1mcQHzvQQeMXaRx2ApErmtANdZZyL2h7nmI+mJAlx4kbPKzfYXBIx4gMvMwcZww8rkgrSqzLZkBE6zGJU/Rluq1KictOOwu8S/mUYxisHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117551; c=relaxed/simple;
	bh=HlubEs5OuiijkixzaLlAICetG732GktzK4GSPaRKir4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjbAsBI1tDYqBntZcxuqwkXAi9KAA3N47pMpfgPy29zxIhLVVnPcyx9E2tgyxkUMo7HRSE0YFOc1rri6blon6iYcJterZcFK2m84PLpXceuc8LPVrlEODBc/oGuMkegbv/mpsF7op0mG768b54IjVJ12lRJhFEalUmF/hT05YsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4NQh7Da; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4NQh7Da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742B1C116D0;
	Sun,  2 Nov 2025 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762117551;
	bh=HlubEs5OuiijkixzaLlAICetG732GktzK4GSPaRKir4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4NQh7DaUDx8NA10VtEeAqnL33XJOy9cS0Rng94XQAOdmG+IorKYJWnNkckKhXbcV
	 MTRNjD4dzLMNq3/t2KonL5lWCaKzZwlrH5RyR525VL3iPA6OOkGXn6cXy30CccBXDA
	 JkQ59GDV9mGKu2CgkAeUoypA+WI+Xe+FTjXpNJzj9lzk91vpwARJWuO6V7SGbNIRg6
	 3Rv0wIjPrG/jzCiW4J5nYAGSipanG/9aQJmypfzQI1SMqZ/vRdQyKrIGMF5hcdJSLa
	 QIkXh5q0UZ8yPVeFwlZLEh+mLOaj6O3AGdpE0JDiNbiiCCfYuB5kpU8YbHG+FolQrZ
	 b5EoIRbWRr5bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3CEF9CE0F8F; Sun,  2 Nov 2025 13:05:50 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/3] torture: Add kvm-series.sh to test commit/scenario combination
Date: Sun,  2 Nov 2025 13:05:47 -0800
Message-Id: <20251102210547.3898972-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
References: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a kvm-series.sh script that takes a list of scenarios and
a list of commits, and then runs each scenario on all of the commits.
A given scenario is run on all the commits before advancing to the
next scenario to minimize build times.  The successes and failures are
summarized at the end of the run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-series.sh    | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-series.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-series.sh b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
new file mode 100755
index 000000000000..a39e401c8d4d
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
@@ -0,0 +1,115 @@
+#!/bin/bash
+#
+# Usage: kvm-series.sh config-list commit-id-list [ kvm.sh parameters ]
+#
+# Tests the specified list of unadorned configs ("TREE01 SRCU-P" but not
+# "CFLIST" or "3*TRACE01") and an indication of a set of commits to test,
+# then runs each commit through the specified list of commits using kvm.sh.
+# The runs are grouped into a -series/config/commit directory tree.
+# Each run defaults to a duration of one minute.
+# 
+# Run in top-level Linux source directory.  Please note that this is in
+# no way a replacement for "git bisect"!!!
+#
+# This script is intended to replace kvm-check-branches.sh by providing
+# ease of use and faster execution.
+
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-series.sh.XXXXXX`"
+trap 'rm -rf $T' 0
+
+scriptname=$0
+args="$*"
+
+config_list="${1}"
+if test -z "${config_list}"
+then
+	echo "$0: Need a quoted list of --config arguments for first argument."
+	exit 1
+fi
+if test -z "${config_list}" || echo "${config_list}" | grep -q '\*'
+then
+	echo "$0: Repetition ('*') not allowed in config list."
+	exit 1
+fi
+
+commit_list="${2}"
+if test -z "${commit_list}"
+then
+	echo "$0: Need a list of commits (e.g., HEAD^^^..) for second argument."
+	exit 2
+fi
+git log --pretty=format:"%h" "${commit_list}" > $T/commits
+ret=$?
+if test "${ret}" -ne 0
+then
+	echo "$0: Invalid commit list ('${commit_list}')."
+	exit 2
+fi
+sha1_list=`cat $T/commits`
+
+shift
+shift
+
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
+. functions.sh
+
+ret=0
+nfail=0
+nsuccess=0
+faillist=
+successlist=
+cursha1="`git rev-parse --abbrev-ref HEAD`"
+ds="`date +%Y.%m.%d-%H.%M.%S`-series"
+startdate="`date`"
+starttime="`get_starttime`"
+
+echo " --- " $scriptname $args | tee -a $T/log
+echo " --- Results directory: " $ds | tee -a $T/log
+
+for config in ${config_list}
+do
+	sha_n=0
+	for sha in ${sha1_list}
+	do
+		sha1=${sha_n}.${sha} # Enable "sort -k1nr" to list commits in order.
+		echo Starting ${config}/${sha1} at `date` | tee -a $T/log
+		git checkout "${sha}"
+		time tools/testing/selftests/rcutorture/bin/kvm.sh --configs "$config" --datestamp "$ds/${config}/${sha1}" --duration 1 "$@"
+		curret=$?
+		if test "${curret}" -ne 0
+		then
+			nfail=$((nfail+1))
+			faillist="$faillist ${config}/${sha1}(${curret})"
+		else
+			nsuccess=$((nsuccess+1))
+			successlist="$successlist ${config}/${sha1}"
+			# Successful run, so remove large files.
+			rm -f ${RCUTORTURE}/$ds/${config}/${sha1}/{vmlinux,bzImage,System.map,Module.symvers}
+		fi
+		if test "${ret}" -eq 0
+		then
+			ret=${curret}
+		fi
+		sha_n=$((sha_n+1))
+	done
+done
+git checkout "${cursha1}"
+
+echo ${nsuccess} SUCCESSES: | tee -a $T/log
+echo ${successlist} | fmt | tee -a $T/log
+echo | tee -a $T/log
+echo ${nfail} FAILURES: | tee -a $T/log
+echo ${faillist} | fmt | tee -a $T/log
+if test -n "${faillist}"
+then
+	echo | tee -a $T/log
+	echo Failures across commits: | tee -a $T/log
+	echo ${faillist} | tr ' ' '\012' | sed -e 's,^[^/]*/,,' -e 's/([0-9]*)//' |
+		sort | uniq -c | sort -k2n | tee -a $T/log
+fi
+echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
+echo Summary: Successes: ${nsuccess} Failures: ${nfail} | tee -a $T/log
+cp $T/log tools/testing/selftests/rcutorture/res/${ds}
+
+exit "${ret}"
-- 
2.40.1

