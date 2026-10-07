Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6A41D124;
	Wed,  7 Oct 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=Hf/8ZHbnWSJSoUdXABuGIB8jKYHGRPOnTpN08P51wBe0j2L5bsRk0+SzGRuVqC3XfVsclXv3e62Ll5znW1zBA5p23gWjnKhj0ANM8pCPsCX6LONoAsRcKs30pBFbxmtN43cRBsobCy06i4MmjFp6mF+8exgOclPuzA+0FAoy+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=w6A2UtNstQHMaD9sv5jIbXcoSmueIavpwfCKXAFyC3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgyNAxSacjmuh/vT9zI38EVNmcDZUz1XLvoj+ZMYYZ5nb4X8yYIHb1vcwX3ymvDVPOmB7igLVZBws+AC486PjGR5q3PPxanJkLgb94AAgRe5xMv0iWxPjrdssNqfBvaF49xyz1kfS2Em5rl9ZWU8zqOcIhydSmh/HVHzmtOWz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGBmuUd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGBmuUd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3D91F008A3;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=YSFWTI41PpIIY7Jn4JySKrCbQV5AzLp9rlEtcJa+d3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MGBmuUd6do4ETbJaoDUCSs3WxPRvDnS3ZBvIejqOPeHUbd9R+o3415brhQ/ZHdan1
	 ddBJmLAZCSU+KrufVtAki21/xd3UqL0fjxRc1wW/j8YBc4RNoF0wq8MJZqQI2odJQy
	 qrcAfRI5nmOs6tcizefJgeBugScciYtxkL++nfsq4sEaSwDjPAITzW6uyglYbgzkeW
	 ZZKE7jckleg8UgV+wTvAaavHstFM8iV4Bb2wc366yiZ0xd6Ux3RGjgDq7v9iyEM4KW
	 VR+heSmwXvkZ/vIAyttFVZnk3C4GZe/9GLBcbi63vNqX9XDZDqtoFGVSVe6V7Q6iH9
	 5Mt3fy+oT9BxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 384A5CE3994; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 16/21] srcutree: Make init_srcu_struct_atomic() prevent transition to big
Date: Wed,  7 Oct 2026 13:59:19 -0700
Message-Id: <20261007205924.1983367-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
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
index 82e61421142e5..4e9a0b8ea3449 100644
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

