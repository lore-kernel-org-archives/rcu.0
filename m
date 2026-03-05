Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525333EC;
	Thu,  5 Mar 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668880; cv=none; b=iwA0DayUP9rSp8Hgz7O8EBLvWiFqx9Wq/0KfYOZak2dlFlLhtXHHLm9Gq64t29CHy3esG3mhh1p/VRzpmVPz4oIa+0kn7JBZ8qoZzgmM212RlO/TqzvMaiitRbEmXxd25/CESzLXnTcTEPgqEWmdluTqmjldze8IBpvqwEgIUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668880; c=relaxed/simple;
	bh=XTBmwNNVK5jw2hgb/gmbZRHb/v5RrS0Axkig4T0GtB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGHBNQlb/dsZeLYwZOwxmtioOR8xT4Ra9a5T+QhZZTJCGw6ntlPPuk2FV2g9AV6JwHmvmjCMXX56IE6BlC14DHInl66t2dBsh+kHd0vG/SS073VcS4aJC5thW2fwzg/WFC8uDUTBDXTXI1DdfkH849MserWRTbuxPlQGExg6yvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epoyeoCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epoyeoCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABC9C4CEF7;
	Thu,  5 Mar 2026 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772668879;
	bh=XTBmwNNVK5jw2hgb/gmbZRHb/v5RrS0Axkig4T0GtB0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=epoyeoCaI8+jntrnG1wONcsFvf+bGLBK0Bfpyh1cgi+oXLR4IfVc4HOj2OC5guZwy
	 rOYsI7yUxvcAeXD2HthTFHAdDP5ZwqpS8+wprAo1sIW2n6SI7Plsjjc66Xz7GFNHxM
	 plhhN3dRu4xW6Sal9UAlqyw6fnDAvu/6HyZMOro/1pH/awRjTVhx7uxI4L7aoZYw/O
	 lFBBAA9VTYNP95+bSrsGtBSD4UkGKf/KhgB4Xoj2vFbUN9riZyPmpPAOveSWGYd1vT
	 eoqPy57EtOe3vN01wauRR7AVOtZUPIkr/AG2Z/6zGEsaKxzj2PZZZAAOSpCYgeOyad
	 QTpen8zZ362Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5BF81CE0DFD; Wed,  4 Mar 2026 16:01:19 -0800 (PST)
Date: Wed, 4 Mar 2026 16:01:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v3 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
Message-ID: <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
 <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors.  This commit therefore switches such rcutorture scenarios
to CONFIG_PREEMPT_LAZY.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

---

Changes since v2:

o	Fold in c69ac5693540 ("rcutorture: Adjust scenarios for default
	lazy preemption")

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
index 34aee1acb8662..ac857d5bcb222 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -1,11 +1,12 @@
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
+#CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
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
index cc3ea23c76557..0e090bb68a0f6 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -1,10 +1,12 @@
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
+#CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 420632b030dc4..b2ce37861e71a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -6,6 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
+CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
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
