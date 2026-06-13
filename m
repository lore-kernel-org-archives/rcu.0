Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF0D3655E6;
	Sat, 13 Jun 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333650; cv=none; b=gBP2KTqoaIqO7uwDLxynhwu2/tXVxIuNr7kV1hjL8WJWemzRZ05pgBuBUfmDve/p7nwZDgHiUAmnSnWCvx7MeElm5yPdXVo48PoByaOK3iI8DQTZS8dbalRn6wLjNJpraBs31mIOEDYDJ7C9YuTOTj729QqlyfPCeS63Ym6MYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333650; c=relaxed/simple;
	bh=UxPL61cAL8FBcbgRJawi7GJB2AGaWoe/hkYJzpKwq98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOLV1Yqiz37avP2/gyq7TQ422aBA/jhhckJmRSMMqcGF/19d5YmJv50a67OhLf67p2nMrqWIUwhN8ij7ThjhFnGXIbZhyjwnzSneo5gsU2fViiAOMyDzTGzop/g/HrHXoZPKxAAuJ7GDoHEsscYjat5MWUmipWKgaoh89bdnjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=wLvNgV+y; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="wLvNgV+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781333640; x=1781592840;
	bh=sKppuNYTAT9bsVS/KBYFxpNr3/Vnq9FaKBkjPAr6/YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wLvNgV+yRfnq+eRlnJqsx3IVgFspGo+BFFsrAY9ylL1RnfdGkM9OtmWkQCxSO4wE8
	 AgfQ52py37+S/Zy7WLuyeECHtkao+oP1zUIosv9J0S/K8JSztB7s2Xybx5v3w6lILd
	 hKd/zh+Hz9/2EhG/wqag5/L/iI9bNT/8q4Kp7BvbsAE/V9TuWkISIXyj7zZUy88eRw
	 jG95Rp5/w6gS+eUgYWuFuc9eBdo9HnKeadjLZREJutuT9IDrSBva77c5W5px3RXXwK
	 IgP7bc0ZvWk+emwGlBLawAH8jki1Ms7G6lR9BQn5JdUh0Z2TESSNRHiGGlKX6yHflt
	 0a6j1L8mmer0g==
X-Pm-Submission-Id: 4gcnD35gvZz1DF7d
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v10 1/5] srcu: make init_srcu_struct() consistently wrap __init_srcu_struct()
Date: Sat, 13 Jun 2026 09:40:07 +0300
Message-ID: <20260613065348.96750-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260613065348.96750-1-work@onurozkan.dev>
References: <20260613065348.96750-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Restructure the SRCU initialization functions so it always follows
one direction:

    init_srcu_struct() -> __init_srcu_struct() -> lockdep or generic

This uses the same wrapper style as mutex. It avoids the old confusing
style where init_srcu_struct() and __init_srcu_struct() called each
other in different configs. It also helps Rust side to have simpler
helper for SRCU initialization.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 include/linux/srcu.h  | 29 ++++++++++++++++++++---------
 kernel/rcu/srcutiny.c | 12 ++++++------
 kernel/rcu/srcutree.c | 11 ++++++-----
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5..a028a5b5ebef 100644
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
index a2e2d516e51b..47d48ed31848 100644
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
index 0d01cd8c4b4a..e4496488a7d8 100644
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
2.51.2

