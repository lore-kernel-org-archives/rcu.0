Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A132A3D7;
	Sat, 19 Sep 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778144; cv=none; b=GZQXxq8S/rq8jbkxvrn3JLcNVVU9uNa57hnNzZ/vfRkTnK0OCC6ZkeQK9Bn0Idp/iGdEFbInlNJjvR70Enmse7S7JjolYxf4oSnbBw2/kC5I+7HeMDciNHgDGOGOyzq5M+128DjHdWo+eyyDmnJ6ufO5aYjj6BiYxBw7o1lTtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778144; c=relaxed/simple;
	bh=Tmb3+KsvPZ2RshpLy9CmRsFgYvp5kyMDkSFK2bGuiGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRVVcRF+8rFXlMSYx5hgozQIYPkkcdipd0u1+bYoBhMnY70dPWr5ixnlGyqbgEKeoXnPFLs/BkwHLi+BCb8FlIG7zpCjTnsw/FWnBUiyCEQHtawx5F1yTlfUB/4dB2snFcOQfVxIfDIUcSz51pfvaKRZGyuez09iDpEp0GZ2j5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs0UQw4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs0UQw4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B451F0089D;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=8aKQbwVV60WcY4t4d1XDKRd2UPbzWoJLpnl/oh9VIU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cs0UQw4GYUg0zjwTNBMIKbdwT5jBrt/pKuZyrNW7qdQW0CzvmIvZO8tKDhJYphbME
	 UvUmRsA/OMQHADnypr+cyWtfBF87knGtw7+tctfdT66SJEOYUGRx3KGMEFnKCZIFlA
	 MhfHfJtly2ejp/fOyR2iXNH/+ZphEX39flr4WBUiN94j9VqrVQx2t4qfjLU+bMdgC4
	 0IXroZxvUywCWPUEC1M5nX6FsXPe769FVAbtvqFavGXmD6KFgUGjV5xXO8RQvZuwEp
	 2/CqhSMxEG/3KG+FT4cW7nMiXQ6AK6hdUG9iVpeU0HNPO2Xuk6hHrqLYb/hKYW3QJ8
	 3DdMatxeqwvgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD6BECE1DCE; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 17/19] srcutree: Make init_srcu_struct_atomic() prevent transition to big
Date: Fri, 18 Sep 2026 17:35:19 -0700
Message-Id: <20260919003521.3134552-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

The is_atomic parameter of init_srcu_struct_fields() exists so that
atomic SRCU never transitions to big, but neither
init_srcu_struct_atomic() nor its lockdep counterpart
__init_srcu_struct_atomic() sets it.

On systems where srcutree.convert_to_big selects SRCU_SIZING_INIT,
this needlessly allocates a full srcu_node combining tree for any
dynamically initialized atomic srcu_struct, despite atomic SRCU
having neither callbacks nor srcu_barrier() operations.

Pass true from both atomic entry points, adding an is_atomic parameter
to __init_srcu_struct_common().

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 82e61421142e..4e9a0b8ea344 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -305,26 +305,27 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 static int
-__init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+__init_srcu_struct_common(struct srcu_struct *ssp, const char *name,
+			  struct lock_class_key *key, bool is_atomic)
 {
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
-	return init_srcu_struct_fields(ssp, false, false);
+	return init_srcu_struct_fields(ssp, false, is_atomic);
 }
 
 int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
 			     struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = 0;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);
 
 int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, false);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
 
@@ -332,14 +333,14 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 				   struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, false);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
 
 int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, true);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_atomic);
 
@@ -414,7 +415,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
 int init_srcu_struct_atomic(struct srcu_struct *ssp)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
-	return init_srcu_struct_fields(ssp, false, false);
+	return init_srcu_struct_fields(ssp, false, true);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_atomic);
 
-- 
2.40.1

