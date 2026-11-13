Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531495;
	b=4fm30cH0ARwA15MyQn6rm6cbQwwXSTQHyG2oaglgLBTKiO3hVYkN3UbIYhc6KXpgIAGv
	 1S50oOdJMGm8K4LWCojutUfyhrCVUZWH61i5m9XNaEDpSi4nMX9COSG1Ok38iDGUuQ3cp
	 bDe09rDPAEkQ8DV3L7gdc3KSm5Px8BQ0yenQEZ6+F1v4IdbMmAKnfCs94RiEJ7INKZ+uo
	 M4YsMSYy0fsUQ0+SLA4KSFyqSlZ83YaQvu7GWoXh3lRpkaETBK5IbK1lFaBH53lvvAyff
	 1fvGeqBKEuao93nQrCQgA+1NF2blTF//4HZ2nvWnNNMG2Qio3/duQQyOr39kHclMcuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4xezTsMykPCsRBdoB+0kcRf+vAPkHdzKTx2cPhaHPL4=;
	b=1Nu0cK5rHkKjyffpv7UHBWeu6AajaJeFYyqJU05eDEu7hHzdJdfwZrAsESMugXm6oOcF
	 1lIqh9fA9WzKS0TC7CrNqIMAU86wGb+4MgcgH/vFnM50PhFmP6/5TTyr+17KZxLtV2Cgq
	 jtfs9QX9/cx3XsYfj52DoFsH6gZcQhQCdf4ZsruDTQMZAoe0Yc5gN7FTVsz8JVNDPhOHN
	 bS+ZYLlnSqfkh+WMS0ex+Um7eUnqD9uV56hptJkgqwqyrdgR2NI6rx8UQltKfYXdBNQRw
	 BQ7ijhvLSpTq1Zguz9Q/8Xk7/Ajjv+kHcWN4vFWJkaW8HmPiSS3q/udOH8suYgj+Urw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+DlcIHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7641860A3839;
	Fri, 13 Nov 2026 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+DlcIHi
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0B5671F000C5;
	Fri, 13 Nov 2026 00:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531495;
	bh=4xezTsMykPCsRBdoB+0kcRf+vAPkHdzKTx2cPhaHPL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+DlcIHiRJdJVMUqoZBGhlrWK/NvAB5alD/1JuTwSTaqIw3nW9yiHsUp92pmzxK5a
	 YvxSZD7MI6+pSWFIbZINew0klu3Rk25qMj/4rsPnFjxFYkG2a4Y5dGuDx7AnlQGLS9
	 /5KnPIYe2jmGCiXw+I5I9ViGBXq+nfEODz241ef5HPA+Y1Zjkc23Bppy3PKtTWC7hG
	 0yFSDvuMSTCGQDy9p0zy8PUWyk7uD65MkbT9hIzY0YsVWNvOb/e/vaI7560mF4wwgD
	 UvxwZrM7tSx9217Kgph3+k0cLbTgzMnwpk1sg0104OVOb0KlLD8RyFZZU71yKeEhIh
	 Tuytw/wjA9HSw==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH for-v7.5 12/14] rcutorture: Enable RCU_BOOST where supported
Date: Thu, 12 Nov 2026 19:57:39 -0500
Message-ID: <20261113005747.2977123-13-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

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
Signed-off-by: Joel Fernandes <jfern@kernel.org>
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
index b6d3597758fc..2d0132e0a90f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -238,17 +238,15 @@ config RCU_FANOUT_LEAF
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
index bbe6d28210ab..91ca7e8b5725 100644
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
index 4c2b8cd6d8fd..ed3f3f7b29e7 100644
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
index 54b1600c7eb5..be5bf69a1b60 100644
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
index 2871ee599891..36b9228ae703 100644
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
index 8b561355b9ef..ad7d7f873e1e 100644
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
index c1a7d38823fb..f611b69f1189 100644
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
index f3f1368b8386..69f5764159df 100644
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
index b10706fd03a4..5122cf08d5db 100644
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
index 9f83e5372796..08d30edb3b99 100644
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
index 1f215e17cbae..3e7d7793acc7 100644
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
index 52e3ef674056..feed29cf043f 100644
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
index 9a11b578ff34..b67ea7a9128b 100644
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
2.54.0

