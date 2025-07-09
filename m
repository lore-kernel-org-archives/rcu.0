Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6629B797;
	Wed,  9 Jul 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057921; cv=none; b=UJgpcN/nFpdNgHnB+x6ZS3a6gms0O/1obylVGMCbatc3vIUNVOxbK7sRixLvAyXkCfhn1umbkliO7auIoF1nk2hP3FQveM+lS3W8KMhaV9/VKvOblzWP+ytG8wzsPhnjJ76NMNBbIr6CfvPHjLKM/IZu80wTk8A5++XN7wAGWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057921; c=relaxed/simple;
	bh=EpVLDv+UFyWsLAdOuz96ohc1ChU0EvuSqJ1cqGq6mek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urye8tRUuwrIFgV7Ea9rmityj5tEdH7sQDsT/aIJhfr0yjODPnsi2hBGLkRx4DwAhyJEcPv0yVHQck2udKruWNadVV4gnO+ZmZuSR3GHe/tj1uBaMKf5o9HAAC0Xa9BRzuMH2zFomXbXDc+lLOpmz0FgTgdjziwxSfhLeYPBJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJXFOAOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJXFOAOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA006C4CEEF;
	Wed,  9 Jul 2025 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057921;
	bh=EpVLDv+UFyWsLAdOuz96ohc1ChU0EvuSqJ1cqGq6mek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJXFOAOF7fC1+704ozvZ4liDRbJXWv5JyZSknC/YKlcQ0D6w5CvQPpDvzMg9eFiw5
	 XaFFXFBVFrHLHjpEvm8MYEdebaJKlNAVX+h6v5h2UyR8E++mQcCQUu0gN0M4BSUpOP
	 z7l3sufQ2N1WnjFEaUmWdL1FlmiDZvUaQnwPiQ64587HumiZxbcVSGIQaol/Z+rVem
	 pAeRBu7EuTI+qNrKCXwR3GNhGG7nCrQnJXFd1md0FORFY0DYrOHtXCcxsUiVaH8LxZ
	 isd8eiFO2aUppX1Gk/vov5abRbc/uVB8Wowhe0S/CtiSGrtrkjyhc4jZlHKQEdDcg1
	 ocNN8BznmF9ZQ==
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
Subject: [PATCH rcu 09/13] torture: Add textid.txt file to --do-allmodconfig and --do-rcu-rust runs
Date: Wed,  9 Jul 2025 16:14:10 +0530
Message-Id: <20250709104414.15618-10-neeraj.upadhyay@kernel.org>
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

This commit causes the torture.sh --do-allmodconfig and --do-rcu-rust
parameters to add testid.txt files to their results directories, thus
allowing easier analysis of the results of a series of runs kicked off by
"git bisect".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index ed59bd43d4f8..a7a8e801283d 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -410,6 +410,7 @@ then
 	echo " --- allmodconfig:" Start `date` | tee -a $T/log
 	amcdir="tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
 	mkdir -p "$amcdir"
+	mktestid.sh "$amcdir"
 	echo " --- make clean" | tee $amcdir/log > "$amcdir/Make.out" 2>&1
 	make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
 	retcode=$?
@@ -516,6 +517,7 @@ then
 	echo " --- do-rcu-rust:" Start `date` | tee -a $T/log
 	rrdir="tools/testing/selftests/rcutorture/res/$ds/results-rcu-rust"
 	mkdir -p "$rrdir"
+	mktestid.sh "$rrdir"
 	echo " --- make LLVM=1 rustavailable " | tee -a $rrdir/log > $rrdir/rustavailable.out
 	make LLVM=1 rustavailable > $T/rustavailable.out 2>&1
 	retcode=$?
-- 
2.40.1

