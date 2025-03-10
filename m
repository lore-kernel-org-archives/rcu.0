Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE617A2E8;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=PZ3UXwsgDVutX94B3gCq7Ayvz+UzcpA9fAbvxqJKwoC1ZpNCz6PLmQ5N6trif7E4zPngsX8waBM+cNgCFLiHEUp8RPBAHj/nnYHn5SK9SfDmTf5DV3OA6tqgq9f00Zh4+mzDUBonCIdX0JYlv3zmn9s7fl/KNaICjUjgwdygrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=9sDMN4XZIcJRgoHQjxyZQce37ueUrgjbAHGywNbSEVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFln4PKVY1BNA+BXy42b0gdijN46TcGfTb/bQKd6GDEcskUQZ/1p1VVbuVjY76jDMqM9IdmuSzjR/6iGqUE9w9pgbKL4/ouH3t1KU+uHQP1kvnlMKnP5urQHWKYJXqHd6cQ3FkdFm0p/OiRG3VUIlXYiy/7m3KFWBkjtye8zpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBraPChY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBraPChY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A07AC4CEF0;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631892;
	bh=9sDMN4XZIcJRgoHQjxyZQce37ueUrgjbAHGywNbSEVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBraPChYmnALx5Y2wGL+tBRbECOLIs4TW2P4nZbpnFuKeO0FqxNljMlOuYV2vLPHR
	 8Qt756opii3LzhM9xrENH5OcEPorhFasrFb9rD/tSvfbU6jFUSlJOF6CjAslNFutlj
	 2z3xfeyQHn5DXbqDIttpaWgv48iQxsvUNFeyq2cxhik5AAbkMXruBV0NCRYxQctU+e
	 WlJgXodlSLRsulWx/imFSqlIRIFcQxnv0vBClkr2B4hEx8dIo96d08Ofhsju3QQNPQ
	 jgYb7O86WCqCvE/4zhxuUfmLulnGz1T9oAl0GRIhBInAd6/XPBVqPYsn2EfD0l6Nj2
	 sX442rE1AfN4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9663DCE1163; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/9] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
Date: Mon, 10 Mar 2025 11:38:04 -0700
Message-Id: <20250310183809.3576320-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The torture.sh --do-rt command-line parameter is intended to mimic -rt
kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
mimicking more precise.

Note that testing of RCU priority boosting is disabled in favor
of forward-progress testing of RCU callbacks.  If it turns out to be
possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
testing of both, both will be enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0447c4a00cc4d..9cabe505585ea 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -448,13 +448,17 @@ fi
 
 if test "$do_rt" = "yes"
 then
+	# In both runs, disable testing of RCU priority boosting because
+	# -rt doesn't like its interaction with testing of callback
+	# flooding.
+
 	# With all post-boot grace periods forced to normal.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_normal=1"
-	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_normal=1"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
 
 	# With all post-boot grace periods forced to expedited.
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_expedited=1"
-	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.test_boost=0 rcupdate.rcu_expedited=1"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_LAZY=n CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y" --trust-make
 fi
 
 if test "$do_srcu_lockdep" = "yes"
-- 
2.40.1

