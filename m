Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262781;
	b=j8b+iuKaMtSapxFMHyKTuqIay7fm7BjLGJzs510eW45AkxPNtRL0SS32ZcEnGrA8Q56T
	 6q+TII2jBg7bez/QfLQJrN+e5M5M7cEVmAS92aOQTugUNAerSvD026Cicz5RpBgF3k1DK
	 ljlhzql5eYqW/wVvJHrFBkRNn6AuWJLtmQxq3Kmjyvfg/tQAYbDlzOxEQ0NSaz9frKp9y
	 TKMdZ29jPv77FmmGn04TgUvbAC/Mh3VPEkxH3bX6a/fGg0vAtdt8qXFPqvUkqWgj5pXHx
	 HYjigMptvmGf/88D3Pp2qPEdeOpepMEYxN0lXl7sdxQOQeSYzh0sffwAsAnK0t7OowQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262781;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OryNfxwVsVz5lbqPtFhffPyHOBTyKVHtLCZv06UqWZY=;
	b=mILDib+4k/a8uCaLwTtLkx//Zng8WWp48tnB/RfiuqdwYvFRliKKGMb1pExAHJPGA+aK
	 LAW8RmkjzpKWC/gbVMN9gnEQejgXDnXuhU3Y6cJe0M0DlbfyZfzI+3YRLtb0f+3IRDPnb
	 MiuP6OdsFtsE+j+ifvmgCJXd6bXPxK5tsmBv9YZ9yWd/slz5Xl9xdiI25cJ539vXu1kpB
	 ae903y/YtXcBnToi0VxmEcY07fTg4L45vKDXJ8NrzUbt97CFRagZpFePPucQE9P90m0yZ
	 XVuxfe0WGOoa96Bcng5LaQOA0I+i85iWOnEen3cFEbLSvkwJsWOU30YsCefZtfjhcmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DF3w5oPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CC606A331;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DF3w5oPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C041F008A4;
	Mon,  9 Nov 2026 22:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262780;
	bh=OryNfxwVsVz5lbqPtFhffPyHOBTyKVHtLCZv06UqWZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DF3w5oPEb9wrpwdMpIrI9KZt6v1J0RxTFT/kxTzRqsSEIdWBTwpwZkZkHp4Le9Kcu
	 HtT25trnEDHhBX4gBXfAVow1YPm0NRrG2RCdj5JOC+CevaSr+iDlsulXO1RGvi0iGE
	 szCgQof1g3R1saJOyxahE+Pg0TJYXljXUFFD/jeT9ESDgJz3C0GCvFhoWbLEas4vcP
	 WenuFeFE+jPtev0xVRtVnoqTu8k/CUimF6Briy/GcaPuV5pk3Q3AS8UIizsqFDUMAe
	 9w2L/K/kPlbVO1xtWabLt8kLLQnXu7aszUstWgHDf7lzqsEEDV0b6+gFvsWen0551Y
	 eUUIfkOpMZEMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB92ACE0CC1; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/8] rcutorture: Enable RCU_BOOST where supported
Date: Mon,  9 Nov 2026 14:19:32 -0800
Message-Id: <20261109221939.2070171-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
References: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, RCU_BOOST depends on RCU_EXPERT, and is therefore often
disabled in stress-test such as those run by syzbot.  This means that if
syzbot runs a test that overloads CPUs on kernels built with PREEMPT_RCU,
RCU CPU stall warnings are not unexpected.  What happens is that a
low-priority task in an RCU read-side critical section is preempted,
cannot be priority boosted, and stays that way for more than 21 seconds.

This commit therefore drops RCU_EXPERT from the RCU_BOOST "depends on"
line and removes the prompt, thus directly driving RCU_BOOST from the
kernel configuration so as to enable it anywhere it is supported and
might help.

This commit is also marked experimental because neither Ubuntu, Fedora,
nor CentOS enable RCU_BOOST.  This suggests less testing of RCU priority
boosting than one might wish.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://lore.kernel.org/all/20260805122952.6ae38af69a0457779cb44359@linux-foundation.org/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig                                     | 10 ++++------
 tools/testing/selftests/rcutorture/configs/rcu/NOCB01  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/NOCB02  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE01  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE02  |  1 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE08  |  1 -
 .../testing/selftests/rcutorture/configs/rcuscale/TINY |  1 -
 .../selftests/rcutorture/configs/rcuscale/TRACE01      |  1 -
 .../testing/selftests/rcutorture/configs/rcuscale/TREE |  1 -
 .../selftests/rcutorture/configs/rcuscale/TREE54       |  1 -
 .../selftests/rcutorture/configs/refscale/NOPREEMPT    |  1 -
 .../selftests/rcutorture/configs/refscale/PREEMPT      |  1 -
 .../testing/selftests/rcutorture/configs/refscale/TINY |  1 -
 13 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bc9483c0b5d84..7b605fa1f576e 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -237,17 +237,15 @@ config RCU_FANOUT_LEAF
 	  Take the default if unsure.
 
 config RCU_BOOST
-	bool "Enable RCU priority boosting"
-	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
-	default y if PREEMPT_RT
+	bool
+	default y if (RT_MUTEXES && PREEMPT_RCU) || PREEMPT_RT
 	help
 	  This option boosts the priority of preempted RCU readers that
 	  block the current preemptible RCU grace period for too long.
 	  This option also prevents heavy loads from blocking RCU
-	  callback invocation.
+	  callback invocation.  It is now automatically enabled in
+	  any kernel that can benefit from it and that can support it.
 
-	  Say Y here if you are working with real-time apps or heavy loads
-	  Say N here if you are unsure.
 
 config RCU_BOOST_DELAY
 	int "Milliseconds to delay boosting after RCU grace-period start"
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
index bbe6d28210ab5..91ca7e8b5725f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
@@ -14,7 +14,6 @@ CONFIG_RCU_FANOUT_LEAF=2
 CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_EQS_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
index 4c2b8cd6d8fdb..ed3f3f7b29e73 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
@@ -14,7 +14,6 @@ CONFIG_RCU_FANOUT_LEAF=2
 CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_EQS_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
index 54b1600c7eb5f..be5bf69a1b60f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
@@ -10,6 +10,5 @@ CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02
index 2871ee599891d..36b9228ae7032 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02
@@ -13,7 +13,6 @@ CONFIG_RCU_FANOUT_LEAF=3
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_RCU_EXPERT=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08 b/tools/testing/selftests/rcutorture/configs/rcu/TREE08
index 8b561355b9ef2..ad7d7f873e1eb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08
@@ -13,7 +13,6 @@ CONFIG_RCU_FANOUT_LEAF=2
 CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_EQS_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
index c1a7d38823fba..f611b69f11895 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -11,7 +11,6 @@ CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
index f3f1368b83869..69f5764159df0 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -11,7 +11,6 @@ CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
index b10706fd03a45..5122cf08d5db2 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
@@ -12,7 +12,6 @@ CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
index 9f83e53727969..08d30edb3b99c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
@@ -15,7 +15,6 @@ CONFIG_RCU_FANOUT_LEAF=2
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index 1f215e17cbae2..3e7d7793acc73 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -14,7 +14,6 @@ CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_KPROBES=n
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
index 52e3ef6740567..feed29cf043f6 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
@@ -12,6 +12,5 @@ CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/TINY b/tools/testing/selftests/rcutorture/configs/refscale/TINY
index 9a11b578ff344..b67ea7a9128b1 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/refscale/TINY
@@ -14,7 +14,6 @@ CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_KPROBES=n
-- 
2.40.1

