Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E88293C67;
	Wed,  9 Jul 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057833; cv=none; b=aPzSrtK9FrT8a84ziYRJwaFHPwL+LKNlr4e0fAPUFaUmkfe31JVOJxmRwHJFGOT/Z9MVeUzfx2ALUjwmTDVtTMd9CovAcSiXMxC+64SN1BsGoz1NP07LUROkbV3cj046ytCbAupWMdMFk2ARAqZngIKzotVlw+6RrCMUC6iWx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057833; c=relaxed/simple;
	bh=D+BR2jJNoFiZtF4yiFKLu/WnVHe1gWYYXH0zMlfkHXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+x4+zz5XWBSd4qaDmYrYmypO8YlzGpWNTZ154r0Tai7BNU8KWnyuBxqa9mBYZrmBLILli4qJyVlkGCHi5nJiSCenMiVSpS24EE7kjGVezk1EtCK5UEEeYDMtLGr431LEAbc88741DQHQLuTXDecfDZA9P38CBOIAxM8eOgQcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX1qbgCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX1qbgCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA37C4CEF7;
	Wed,  9 Jul 2025 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057833;
	bh=D+BR2jJNoFiZtF4yiFKLu/WnVHe1gWYYXH0zMlfkHXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pX1qbgCzsMmankC3cWQue3qLzFw3zApDUyK5O2P3hzw4HH4VQJzPkpJgigNI94EMI
	 KaB0/TU244jiB2niLytsJC92CNNWjvuRwcKn7UQ3luCXu6fsnrdQSzID6Hl+saZnGp
	 0mF/DqPaxZKGWP5NxM4vduw/+weX85BQxdlHqgGWUiZHZqHwgM00GECHS9L/+NBYCx
	 uvT9DxlIfwH1WaT6if0eYOlbACkUaS+w3weWwzzlxGoOfSXnCGhr3m9NHbz2X/sRc4
	 7ieAf2xdhDPXvI0jWPbR7vT5BZeV6DXiv0nS9FF2a9VxOs54GmMyEzoe+6T/RRut5A
	 SGcXp/B6Odr/A==
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
Subject: [PATCH rcu 14/15] rcutorture: Remove SRCU-lite scenarios
Date: Wed,  9 Jul 2025 16:12:14 +0530
Message-Id: <20250709104215.15562-15-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit prepares for the removal of SRCU-Lite by removing the SRCU-L
rcutorture scenario that tests it.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L  | 10 ----------
 .../selftests/rcutorture/configs/rcu/SRCU-L.boot       |  3 ---
 3 files changed, 14 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index 45f572570a8c..98b6175e5aa0 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -5,7 +5,6 @@ TREE04
 TREE05
 TREE07
 TREE09
-SRCU-L
 SRCU-N
 SRCU-P
 SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
deleted file mode 100644
index 3b4fa8dbef8a..000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
+++ /dev/null
@@ -1,10 +0,0 @@
-CONFIG_RCU_TRACE=n
-CONFIG_SMP=y
-CONFIG_NR_CPUS=6
-CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_RCU_EXPERT=n
-CONFIG_KPROBES=n
-CONFIG_FTRACE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
deleted file mode 100644
index 0207b3138c5b..000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-rcutorture.torture_type=srcu
-rcutorture.reader_flavor=0x4
-rcutorture.fwd_progress=3
-- 
2.40.1

