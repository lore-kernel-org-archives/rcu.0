Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B729D264;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161706; cv=none; b=gIwLhTWFREeBdPjkRIZzPYde35VHRlUFJwZwvw9Ekc0EMYipQmzmtvYkSOzAo5SCe/+tOBgdhNveRtk/Wma7ncxzf7fdhZUrA2klCjjHLOHop4L07VGAnal7+zNevseElTB6XwARkJecyDujPaUlMnu6poMjEp+zM5Ig7BSq7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161706; c=relaxed/simple;
	bh=FtEA8Zj2G3mxt0eUOqFJ/FvL1Poe/zy9hd8F2gKa4ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/n5wI4YGgTH79J8BB2/RTlhtEIvLqxVWDHtFK3/0/jqiYhWjm2VFvB6/O2AAO3C53vO1QngSWsm1m99czz9n38cUthAbffVAe7Lt6wh9IFkdvEaPK+ZuY7xSPi05ObLXqVUof/1BJDdwRI0zHA1U9y46naG7R3mWDXxjmt7550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHWs+qWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHWs+qWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D6A1F000E9;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161705;
	bh=EETxFP0D7dYMA03aJTLn94vN1cl3zTd6Fd052SBDZns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHWs+qWEOBSCu7dmx2ziUBPjYEEiK4uxvqwF3mahn9jazB2Uv5D7P4vzoqsTAClVR
	 +4DXzp3VVTbgnmlXO6eua7VUcKVzaJF9dlrdRChH5DdQ9/7bOgUYkqaf16g295O5Wh
	 v180+vzYZM33su3lUREpWr1NbBTSMiNA+Wsvm3kgBnWGrSVvSlD/9i5Y/9h6uAEWBU
	 Fiuu6g0rWZ0aHD1B8qP3lDuKbghxgS1ml1Q2LIlE9dmrfd88/djjj2z5quKgmvxKaz
	 +PhXR4M4qDeRciftexZmePzEfZFFiMqz/YBYR4fWnKj57rllwZv28BXwq4/n3Wjr2w
	 tZtaJ1NvnxRbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF0F1CE0569; Wed, 15 Jul 2026 17:28:24 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/6] srcu: make init_srcu_struct() consistently wrap __init_srcu_struct()
Date: Wed, 15 Jul 2026 17:28:18 -0700
Message-Id: <20260716002823.12176-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
References: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Onur Özkan <work@onurozkan.dev>

Restructure the SRCU initialization functions so it always follows
one direction:

    init_srcu_struct() -> __init_srcu_struct() -> lockdep or generic

This uses the same wrapper style as mutex. It avoids the old confusing
style where init_srcu_struct() and __init_srcu_struct() called each
other in different configs. It also helps Rust side to have simpler
helper for SRCU initialization.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h  | 29 ++++++++++++++++++++---------
 kernel/rcu/srcutiny.c | 12 ++++++------
 kernel/rcu/srcutree.c | 11 ++++++-----
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a54ce9e808b92c..c5ab7df6fe5c70 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -25,20 +25,19 @@ context_lock_struct(srcu_struct, __reentrant_ctx_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
+int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
+				     struct lock_class_key *key);
+static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
+				     struct lock_class_key *key)
+{
+	return init_srcu_struct_lockdep(ssp, name, key);
+}
 #ifndef CONFIG_TINY_SRCU
 int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
 int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 				   struct lock_class_key *key);
 #endif // #ifndef CONFIG_TINY_SRCU
 
-#define init_srcu_struct(ssp) \
-({ \
-	static struct lock_class_key __srcu_key; \
-	\
-	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
-})
-
 #define init_srcu_struct_fast(ssp) \
 ({ \
 	static struct lock_class_key __srcu_key; \
@@ -56,7 +55,12 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
-int init_srcu_struct(struct srcu_struct *ssp);
+int init_srcu_struct_generic(struct srcu_struct *ssp);
+static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
+				     struct lock_class_key *key)
+{
+	return init_srcu_struct_generic(ssp);
+}
 #ifndef CONFIG_TINY_SRCU
 int init_srcu_struct_fast(struct srcu_struct *ssp);
 int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
@@ -65,6 +69,13 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 #define __SRCU_DEP_MAP_INIT(srcu_name)
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+#define init_srcu_struct(ssp) \
+({ \
+	static struct lock_class_key __srcu_key; \
+	\
+	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
+})
+
 /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
 #define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index a2e2d516e51b9d..47d48ed318483a 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -48,31 +48,31 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
-		       struct lock_class_key *key)
+int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
+		     struct lock_class_key *key)
 {
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
 	return init_srcu_struct_fields(ssp);
 }
-EXPORT_SYMBOL_GPL(__init_srcu_struct);
+EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);
 
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /*
- * init_srcu_struct - initialize a sleep-RCU structure
+ * init_srcu_struct_generic - initialize a sleep-RCU structure
  * @ssp: structure to initialize.
  *
  * Must invoke this on a given srcu_struct before passing that srcu_struct
  * to any other function.  Each srcu_struct represents a separate domain
  * of SRCU protection.
  */
-int init_srcu_struct(struct srcu_struct *ssp)
+int init_srcu_struct_generic(struct srcu_struct *ssp)
 {
 	return init_srcu_struct_fields(ssp);
 }
-EXPORT_SYMBOL_GPL(init_srcu_struct);
+EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7ae..56c5db5c29a09b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -266,12 +266,13 @@ __init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock
 	return init_srcu_struct_fields(ssp, false);
 }
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
+			     struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = 0;
 	return __init_srcu_struct_common(ssp, name, key);
 }
-EXPORT_SYMBOL_GPL(__init_srcu_struct);
+EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);
 
 int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
@@ -291,7 +292,7 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
- * init_srcu_struct - initialize a sleep-RCU structure
+ * init_srcu_struct_generic - initialize a sleep-RCU structure
  * @ssp: structure to initialize.
  *
  * Use this in place of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
@@ -301,12 +302,12 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
  * to any other function.  Each srcu_struct represents a separate domain
  * of SRCU protection.
  */
-int init_srcu_struct(struct srcu_struct *ssp)
+int init_srcu_struct_generic(struct srcu_struct *ssp)
 {
 	ssp->srcu_reader_flavor = 0;
 	return init_srcu_struct_fields(ssp, false);
 }
-EXPORT_SYMBOL_GPL(init_srcu_struct);
+EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 
 /**
  * init_srcu_struct_fast - initialize a fast-reader sleep-RCU structure
-- 
2.40.1

