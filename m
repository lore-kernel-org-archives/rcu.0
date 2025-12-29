Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE60296BCC;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035640; cv=none; b=nacvzQnGmSKUKJjt8DggFagNzBLRmOFTvbD103XOoHOHi3mFnPMEiWkkVYrtjzIgKpfUYkFfDsvj6s8KXfudvZZOCZjZpeBCunU1ngPx44lcCPAt3j4EX1wPLcGtz6aBomTBH0yhbXAstMJ7qbhe/EbxeD/E0zgfon09Ks7kJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035640; c=relaxed/simple;
	bh=oQj8+0yBSnI1zF4Lh9GHvRJO/uXOQNxd4ldUzP8UguQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPDArcycPO/sqJhbbGI7y197qyncTBZBZ6QCOSehGTpyc0ANq9GhcLdY7t1vbEMtOJTeVuyO9Qd1hObZkk4OhUzqSTVMy27xKnobaRCNQYL3IdsLfCA4BPb51Y5+liRKeANYb6RLZziRMPXxcMb+O5dOPQeUOsdhEgS2KzipF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxA+Nl2E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxA+Nl2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1968FC19423;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035640;
	bh=oQj8+0yBSnI1zF4Lh9GHvRJO/uXOQNxd4ldUzP8UguQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxA+Nl2EPiugeY8vlkJxGrtTvDGv+zLaonpDMdp7ExRItbsvlrznfKbqTymS184h2
	 wGayuMVMHTAWrqZd8QiDZ6hedz9LTJo7DgYmDKqXQV2YKFU2w4ylZZe/XsuQUg60Hy
	 5BEQwTYEnH///dp+1mf8tB0ycqnFDqiS9gYXvkqeop2044wcv7TVEerLMnwhSsI0gu
	 6CtldtWZ6gO9phuf0X9sIAK8QcfBKx2xt2XOz8oyl3LK2znFE595v/BLDGTwkMjJcT
	 69wDQ5+72ScBOpthLQcZnQwSK5iB4llRFOwcq/NDK9ts1iuaFkzfwXWYh1cwm33E0t
	 u+DdyfsoA7nyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9560FCE1078; Mon, 29 Dec 2025 11:13:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 4/6] torture: Make kvm-series.sh give run numbers and totals
Date: Mon, 29 Dec 2025 11:13:56 -0800
Message-Id: <20251229191358.693753-4-paulmck@kernel.org>
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

The kvm-series.sh script can easily be convinced to run on the order of
1,000 guest OSes, so some sort of progress indicator would be helpful.
This commit therefore updates the "Starting" output lines to read as in
the following example, adding the ("3 of 4"):

Starting TREE02/1.7e0ad1b49057 using 8 CPUs (4 of 4) Sat Nov 8 10:51:06 PM PST 2025

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-series.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-series.sh b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
index 29a2cd64835fd..277988c3e4a20 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-series.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
@@ -132,6 +132,8 @@ fi
 cpusused=0
 touch $T/successlistfile
 touch $T/faillistfile
+n2run="`wc -l $T/torunlist | awk '{ print $1; }'`"
+nrun=0
 
 # do_run_one_qemu ds resultsdir qemu_curout
 #
@@ -193,9 +195,10 @@ run_one_qemu () {
 	then
 		cleanup_qemu_batch "${batchncpus}"
 	fi
-	echo Starting ${config_sha1} using ${batchncpus} CPUs `date`
+	echo Starting ${config_sha1} using ${batchncpus} CPUs "($((nrun+1)) of ${n2run})" `date`
 	qemu_curout="${DS}/${config_sha1}/qemu-series"
 	do_run_one_qemu "$ds" "${config_sha1}" ${qemu_curout} &
+	nrun="$((nrun+1))"
 }
 
 # Re-ordering the runs will mess up the affinity chosen at build time
-- 
2.40.1

