Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6592D97B8;
	Wed,  9 Jul 2025 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057916; cv=none; b=YDRctvxQXjdkKdSvpd0pV4FgC6CjqbwHSBuxL1bMNG6jXVxdpKBoYWQ27B/tWic/uKg0tfgyIB505DSbAi/fM6A4EhDSHQ06xztfjhhTVE+l0ZTJles7H8HzUlmuy3v4GBQZDUuxE6XyC3szTEp5RDQzM9SlmWM8Kq4SybuSAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057916; c=relaxed/simple;
	bh=upnrxJefzyvKGSHHSdHoOsfq0gTVYBHp39iHjGTH7F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrDRyBPUENB756riqA2Jx5qPbxWYeOm5hkuk+hAjjrCVCVyrcP0FVMrjUjFd3ZBuNwv/lJtqOPRLdW8zg0EAZ0v9somvld6J9+3v5Wlf4V6x3bk+ozYEwDIZE8WxaCeML+31bnfmOY0OMd/VQjyt6oUSKlC4F/g5BCdHSWt3OVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGCgo1yP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGCgo1yP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AE4C4CEEF;
	Wed,  9 Jul 2025 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057916;
	bh=upnrxJefzyvKGSHHSdHoOsfq0gTVYBHp39iHjGTH7F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGCgo1yPXHOALq3vwQxYWrFlldG6GxciEkIpP28FkY8JpF8lVi+wRqJm4Z6FxF0i+
	 xspXyYVJOc4nzO4mOR7viYjhOgg8XcacPONNXwbROy+py316fVZxZMgXbB9Hvdw3ju
	 9TxErMTqP1bqzFkto2/FKcqoW7rg4zfTOuGQMEra/aq1TgexMpHyaUp9fFPlE0Qcws
	 e+kxD0pb2wuCwGYVWi2c/J9X1SceIy7pReRJgke2zcKzC/MaRQ9WF2/3Ep6BHxnZBP
	 13Q3zlyhmL0mpqnPAvkhPo537R5C86PJW5jwopaNIzm5M/RYONDq3ZfIDqFnRKHGxZ
	 ZlJohfqp3xwYQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 08/13] torture: Extract testid.txt generation to separate script
Date: Wed,  9 Jul 2025 16:14:09 +0530
Message-Id: <20250709104414.15618-9-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The kvm.sh script places a testid.txt file in the top-level results
directory in order to identify the tree and commit that was tested.
This works well, but there are scripts other than kvm.sh that also create
results directories, and it would be good for them to also identify
exactly what was tested.

This commit therefore extracts the testid.txt generation to a new
mktestid.sh script so that it can be easily used elsewhere.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 13 +--------
 .../selftests/rcutorture/bin/mktestid.sh      | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/mktestid.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 9c1b850b3227..617cba339d28 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -442,18 +442,7 @@ echo $scriptname $args
 touch $resdir/$ds/log
 echo $scriptname $args >> $resdir/$ds/log
 echo ${TORTURE_SUITE} > $resdir/$ds/torture_suite
-echo Build directory: `pwd` > $resdir/$ds/testid.txt
-if test -d .git
-then
-	echo Current commit: `git rev-parse HEAD` >> $resdir/$ds/testid.txt
-	echo >> $resdir/$ds/testid.txt
-	echo ' ---' Output of "'"git status"'": >> $resdir/$ds/testid.txt
-	git status >> $resdir/$ds/testid.txt
-	echo >> $resdir/$ds/testid.txt
-	echo >> $resdir/$ds/testid.txt
-	echo ' ---' Output of "'"git diff HEAD"'": >> $resdir/$ds/testid.txt
-	git diff HEAD >> $resdir/$ds/testid.txt
-fi
+mktestid.sh $resdir/$ds
 ___EOF___
 kvm-assign-cpus.sh /sys/devices/system/node > $T/cpuarray.awk
 kvm-get-cpus-script.sh $T/cpuarray.awk $T/dumpbatches.awk
diff --git a/tools/testing/selftests/rcutorture/bin/mktestid.sh b/tools/testing/selftests/rcutorture/bin/mktestid.sh
new file mode 100755
index 000000000000..16f9907a4dae
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/mktestid.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Create a testid.txt file in the specified directory.
+#
+# Usage: mktestid.sh dirpath
+#
+# Copyright (C) Meta Platforms, Inc.  2025
+#
+# Author: Paul E. McKenney <paulmck@kernel.org>
+
+resdir="$1"
+if test -z "${resdir}" || ! test -d "${resdir}" || ! test -w "${resdir}"
+then
+	echo Path '"'${resdir}'"' not writeable directory, no ${resdir}/testid.txt.
+	exit 1
+fi
+echo Build directory: `pwd` > ${resdir}/testid.txt
+if test -d .git
+then
+	echo Current commit: `git rev-parse HEAD` >> ${resdir}/testid.txt
+	echo >> ${resdir}/testid.txt
+	echo ' ---' Output of "'"git status"'": >> ${resdir}/testid.txt
+	git status >> ${resdir}/testid.txt
+	echo >> ${resdir}/testid.txt
+	echo >> ${resdir}/testid.txt
+	echo ' ---' Output of "'"git diff HEAD"'": >> ${resdir}/testid.txt
+	git diff HEAD >> ${resdir}/testid.txt
+fi
-- 
2.40.1

