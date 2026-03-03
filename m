Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58056375F86;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582346; cv=none; b=g15MjqD0+XTdObIab+exdeLMwUnr+KdxwRuLo/Ah3RDXaT35rqNzjVzYJd3784eWwNdLB9eXqIF+NO9Lu2txLJ1ulLCLdS9xU2ZO66cJnqGr5ZfdxG7sQNmnsoe+xObQJtjckze/MVNS6n4TqC/rLkBD3c5Z0aD8aoNhWI+8Wf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582346; c=relaxed/simple;
	bh=nO8CYYfzGFAugMvr1scTvmnivZv8/SWZWUO9Q9xFQD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eN4UFHoFZzbgkW8of+fSikZcD3yNNVPUU6jmOAz2hCn95mt/EMq9X/kK1sDBUV6GsGDCpvd4t2M4bMpc3kCqXJRQj7OGR5iEEsV7Wb8YBk2oj43INMbjuiraiZdzcfEOdKgNZvfydRR9qwF6DuOEUQxxlhmVADzQ7EELyRH5ySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS0prf0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS0prf0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC09EC116C6;
	Tue,  3 Mar 2026 23:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582346;
	bh=nO8CYYfzGFAugMvr1scTvmnivZv8/SWZWUO9Q9xFQD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kS0prf0EhFct9ns7RYZarOPWxSWsIZKWs4EcR1aav/zqEpNV0yOHh3Mx1mqDDXaHf
	 8jFuhe68HyditVMmPqyC+TPAWCeR9R9uXqakDJ1B2HUwfM/OsHA7D5aPK/T1T9MhYN
	 vggBi7g4VLIEayFUWGRdNwhbC6u7CW7qDpAE13vlyEUUwBAMuFLGYgC58DjK6vrioi
	 Qt+eo9qQFwGz71SNgIqyeicI8BiyAPEl/2jVDqy0SLEphlVbO1MWfEyac/cWgIigk3
	 OVk9v4k/M0ZhmYpP0G5zfMflhSRsiNKDTMbknd6X0aZBqw5xTN3SX2v/rFegegLhzU
	 ZrN4WjUPcghVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9FE71CE0D66; Tue,  3 Mar 2026 15:59:05 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/4] rcutorture: Update due to x86 not supporting none/voluntary preemption
Date: Tue,  3 Mar 2026 15:59:00 -0800
Message-Id: <20260303235903.1967409-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors.  This commit therefore switches such rcutorture scenarios
to CONFIG_PREEMPT_LAZY.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-N  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TASKS02 | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TINY01  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TINY02  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01 | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE04  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE05  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE06  | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL | 3 ++-
 11 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
index 07f5e0a70ae70..90797c9e9410e 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
@@ -2,7 +2,8 @@ CONFIG_RCU_TRACE=n
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_RCU_EXPERT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
index c70cf0405f248..06e4d1030279c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
index bc9eeabaa1b18..540fa4ee6b1ba 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
index 2f9fcffff5ae3..dd2bd4e08da4e 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
index bd5ed7b0da5f0..37be5468c9d9f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
index 30439f6fc20e6..be8860342ef71 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 18efab346381a..8fb124c28f283 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -1,7 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=5
 CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index f49fda1c88811..f9d54ddc73a20 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -1,7 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT_NONE=n
-CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 CONFIG_PREEMPT_LAZY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 0513aa33c32c4..93a17fe050bd4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_LAZY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
index bfd88c46dbd73..73a8945780abd 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_LAZY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
index 5d546efa68e83..d18cfbd606220 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
-- 
2.40.1

