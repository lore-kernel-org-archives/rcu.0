Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4C4F054F
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412543; cv=none; b=t9zHVMsHe02vKfWl2cNW8bsdWAWMMzndVVwWmWkzlgmcfRYcpgSvVJvmGLRgJJLCNcgaN/E+uV94v91b4YFrrjKDOi6AyfCgM37X7oT3jEmSYJ7gXu3vAcOUDyJ0EQ4k3Ryh9NVDWH/QU4407pbK0nx6hQCSmdrYTxnFIYD0meY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412543; c=relaxed/simple;
	bh=O2Ovo7CX962BS0/Z6cftR8Tb3kQt+/W0I6yvMuTHxZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Bh9jZzgDb+KqKl/6N0Mmn2EEwgp7Mqo+4Pb/yLZwbj9DwCRdI6CkBg9ZRXZESWKV2iIggre52ScMSKhOFzcjAwBc/ywKXR+/o2beYxv/hKCYXbYQI1qijzBjkLEBicnQwHif7T/4yKUtKKrWq63cttB/OCF5BfjSGoyzZF1Nwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjQydfyX; arc=none smtp.client-ip=91.218.175.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjQydfyX"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O2Ovo7CX962BS0/Z6cftR8Tb3kQt+/W0I6yvMuTHxZM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792412537; v=1; x=1793017337;
 b=LjQydfyXt1FciaeSuUGlNIfC9SqOXSqEchElgr416yRYifZThUohgW/eb+Jrr/esyjL1iH5z
 FVu0BvonQztJMr5IJBQPTvLpavp1jZB5rubWgEf4Zk1/xPte8KJldLmwc+yMiMZGWqd6gq9BNmv
 bBxeevZjvUJOqxE/xyaUIDHI=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 47c52328367cb38a;
	Mon, 19 Oct 2026 12:22:17 +0000
X-Mizu-Trace-ID: 47c52328367cb38a
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc: Update recent RCU/SRCU API additions to whatisRCU.rst
Date: Mon, 19 Oct 2026 20:22:09 +0800
Message-Id: <20261019122209.15604-2-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261019122209.15604-1-qiang.zhang@linux.dev>
References: <20261019122209.15604-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The following commit introduces some new RCU/SRCU APIs:

Commit 'd3f52f53a562 ("srcu: Create an SRCU-fast-updown API")'
Commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
Commit 'cacadb630375 ("srcu: Add guards for notrace variants of SRCU-fast readers")'
Commit 'fa8a2d55139f ("srcu: Add lock guard for srcu_fast_updown flavor")'
Commit '954c0d741299 ("srcu: Add guards for SRCU-fast readers")'

This commit therefore update thems and some missing RCU related APIs
to whatisRCU.rst.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 Documentation/RCU/whatisRCU.rst | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index e6767baff2d3..fe9dc3948690 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1084,8 +1084,9 @@ RCU::
 	rcu_dereference			call_rcu
 	rcu_dereference_check		call_rcu_hurry
 	rcu_dereference_protected	kfree_rcu
-	rcu_read_lock_held		kvfree_rcu
-	rcu_read_lock_any_held		kfree_rcu_mightsleep
+	rcu_dereference_all		kvfree_rcu
+	rcu_read_lock_held		kfree_rcu_mightsleep
+	rcu_read_lock_any_held		kvfree_rcu_mightsleep
 	rcu_pointer_handoff		cond_synchronize_rcu
 	unrcu_pointer			cond_synchronize_rcu_full
 					cond_synchronize_rcu_expedited
@@ -1209,13 +1210,23 @@ SRCU::
 	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
 	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
 	srcu_read_lock_notrace		poll_state_synchronize_srcu
-	srcu_read_unlock_notrace
+	srcu_read_unlock_notrace	synchronize_srcu_atomic
 	srcu_down_read
 	srcu_up_read
 	srcu_down_read_fast
 	srcu_up_read_fast
+	srcu_read_lock_fast_updown
+	srcu_read_unlock_fast_updown
+	srcu_read_lock_atomic
+	srcu_read_unlock_atomic
 	guard(srcu)()
+	guard(srcu_fast)()
+	guard(srcu_fast_notrace)()
+	guard(srcu_fast_updown)()
 	scoped_guard(srcu)
+	scoped_guard(srcu_fast)
+	scoped_guard(srcu_fast_notrace)
+	scoped_guard(srcu_fast_updown)
 	srcu_read_lock_held
 	srcu_dereference
 	srcu_dereference_check
@@ -1229,9 +1240,16 @@ SRCU: Initialization/cleanup/ordering::
 	DEFINE_STATIC_SRCU
 	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
 	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
+	DEFINE_SRCU_FAST_UPDOWN		// for srcu_read_lock_fast_updown() and friends
+	DEFINE_STATIC_SRCU_FAST_UPDOWN	// for srcu_read_lock_fast_updown() and friends
+	DEFINE_SRCU_ATOMIC		// for srcu_read_lock_atomic() and friends
+	DEFINE_STATIC_SRCU_ATOMIC	// for srcu_read_lock_atomic() and friends
 	init_srcu_struct
 	init_srcu_struct_fast
+	init_srcu_struct_fast_updown
+	init_srcu_struct_atomic
 	cleanup_srcu_struct
+	smp_mb__after_srcu_read_lock
 	smp_mb__after_srcu_read_unlock
 
 All: lockdep-checked RCU utility APIs::
-- 
2.17.1

