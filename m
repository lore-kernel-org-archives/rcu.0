Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFD3B52EB;
	Wed,  4 Mar 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645189; cv=none; b=rvqgwNJyHug7EP2XtQXjeirtJ13rMIczhvV8Brc3SojxpEY8k2Io8QhJj+KE1mr8shsC+LTMnYcVHVFzmX2QtkPJEd3iBEKlCdMv8Hs/texJwWI/7FnCHhvqKp7oEFGEW0/1l5XQyuJNAGHJoPCIzZS99Szz7cuuVt1CVamBadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645189; c=relaxed/simple;
	bh=WF1lNWz6UHUVZkGWjvPJ+5o84tbI8qpC4FodURTNwPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyZ1jsADo0+GkOfYMK70vsk0JBPBzNrsucIP4JRo9UjDyUTD4Qy5lzmCcHPFPJNSbURgPH7KjtCDF1VjfA4a/fL9Zd8zW4Zace0/R+FxMY3swg++CzRUN6j8RF2xxTfb0XOu01nBne6EtNZ8Q1epdFGTMyw1qyzonFQYcqhKyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnFI99oc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnFI99oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42C9C4CEF7;
	Wed,  4 Mar 2026 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772645188;
	bh=WF1lNWz6UHUVZkGWjvPJ+5o84tbI8qpC4FodURTNwPU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PnFI99oc4VSVgRctV5ogz0wzZuwUmN04aqcngBqcKgqy+hRt8TTFqcwjbLcDVHGhy
	 Ds3FOucbl306tGDx16ILNHLVlkpZnhrpPzP2gFX6vmSjLB8Ei7Mj0lA76np5AsIv0x
	 jLB2GWxvZJQtP0PfOsqe6S9LsSr95mUpAOUsC3rBSVGssysqnAn4jykMbNAu/m3zM1
	 ey5SExBZf9sjaHzFWuyB2yqCgPZX0Y0ZscAv+yDPzBM3TauKSjR6rxOImUomxgQC1R
	 ovhuFnw0rKZxJL7STN56me0itD/XdDwU813r9OCHSFVybFStLD/MIS7HgDXlJMjEF2
	 5vN/SrgUDXfNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C3CECE0EE1; Wed,  4 Mar 2026 09:26:28 -0800 (PST)
Date: Wed, 4 Mar 2026 09:26:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
Message-ID: <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303235903.1967409-1-paulmck@kernel.org>

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors.  This commit therefore switches such rcutorture scenarios
to CONFIG_PREEMPT_LAZY.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---

Changes since v1:

o	Add CONFIG_PREEMPT_DYNAMIC=n in order to test non-preemptible RCU.

o	Remove CONFIG_PREEMPT_COUNT=n because it conflicts with
	CONFIG_PREEMPT_LAZY=y.

o	Remove some stray conflicting CONFIG_PREEMPT_LAZY=n instances.

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
index 07f5e0a70ae70..f943cdfb0a741 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
@@ -2,7 +2,9 @@ CONFIG_RCU_TRACE=n
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_HOTPLUG_CPU=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_DYNAMIC=n
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
index bc9eeabaa1b18..71da6e3e94886 100644
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
@@ -7,4 +8,3 @@ CONFIG_PREEMPT_DYNAMIC=n
 CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
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
index bd5ed7b0da5f0..2be53bf60d65b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -1,9 +1,9 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TINY_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
@@ -12,4 +12,3 @@ CONFIG_RCU_TRACE=n
 #CHECK#CONFIG_RCU_STALL_COMMON=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
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
index f49fda1c88811..ac857d5bcb222 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -1,10 +1,10 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT_NONE=n
-CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TREE_RCU=y
 #CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 0513aa33c32c4..61d15b1b54d16 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -1,9 +1,10 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TREE_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
index bfd88c46dbd73..0e090bb68a0f6 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -1,9 +1,10 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-CONFIG_PREEMPT_LAZY=n
 #CHECK#CONFIG_TREE_RCU=y
 #CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
index 5d546efa68e83..696fba9968c60 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
@@ -1,6 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
