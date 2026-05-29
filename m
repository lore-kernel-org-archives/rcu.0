Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774A1EB5C2;
	Fri, 29 May 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062020; cv=none; b=Y+Nk7/bnxQNuSrlRBZC0wWKEIc+rW+VfYjINqmQCG/g4MF86ZXLwvJtgPdrIy7xAjKPaUXdlK1FEjU6M9Pz38z9JKHHv3RtqH+AYaWxpMkhetZnisUn4G51++E6ufCHSD5FJnboxbH4rFvzQ4qmOF0uQDClOyaTvDyyf2+np6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062020; c=relaxed/simple;
	bh=GRu2w6Yl53hjYDtCSyWax23qkoJc99/mS9lhpS2cZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWmJ6ZYRNwUvY9gTMTVeaLZm1j21Hw53Se8lwFWo53bZggIttEsYjzKOrcu0zyOOIT8hdjDJAAUZUq59TNhAmIb9csJ09DipoiTuJPKTi7zy+NLxe1rq3rg2bkor/O9hrJPDedNquVIHxDkG3qRPisjQ7JUoBe7+ncYfWLJhWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=QpxB0QRR; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="QpxB0QRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780062014; x=1780321214;
	bh=ZL9ESIKvQirxwn04NTuae03syak/bnIEqsL+uBn0S2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QpxB0QRRMygiPZjw1oV34QjExJrxrqAkCwknEpeMVyiFSEa0sh+6rIRO+2HcXiHtE
	 r8i4FTFmOR0vNj5Se2zIwa1/2QIr0LFjtCm7PQbYGg+8CM5fugC5yee1CyjdWpPJeN
	 4cdlEbccFe/ffRjLHfi0EGfanamgIPy7cGSMnBZO4NUSuu30zbh6ToKcBu607l1SvL
	 t1q/aqRscmt//RZNPfjJOnDKnpqlbmclaNvGuDJK3sluOhPcGEle5qBY1SDuiq82Lp
	 171WSKio6Ks9gvuZYrParYATnU30YkZRDbkVqIn1+hvauWTbu41/5P+yre2rrVrQuq
	 Ts2aAxsxYqbWg==
X-Pm-Submission-Id: 4gRkxk4FqHz1DDLL
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
Subject: [PATCH v9 1/4] rust: helpers: add SRCU helpers
Date: Fri, 29 May 2026 16:39:51 +0300
Message-ID: <20260529134004.396743-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260529134004.396743-1-work@onurozkan.dev>
References: <20260529134004.396743-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add helper wrappers for SRCU functions that are exposed to Rust
through generated bindings.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 include/linux/srcu.h   | 29 ++++++++++++++++++++---------
 kernel/rcu/srcutiny.c  | 10 +++++-----
 kernel/rcu/srcutree.c  |  9 +++++----
 rust/helpers/helpers.c |  1 +
 rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 18 deletions(-)
 create mode 100644 rust/helpers/srcu.c

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
index a2e2d516e51b..780a95e8cad7 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -48,15 +48,15 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 
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
 
@@ -68,11 +68,11 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);
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
index 0d01cd8c4b4a..45154630c54e 100644
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
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..f3562d3b3888 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -88,6 +88,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "srcu.c"
 #include "sync.c"
 #include "task.c"
 #include "time.c"
diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
new file mode 100644
index 000000000000..225b3bf9334a
--- /dev/null
+++ b/rust/helpers/srcu.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/srcu.h>
+
+__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
+							const char *name,
+							struct lock_class_key *key)
+{
+	return __init_srcu_struct(ssp, name, key);
+}
+
+__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
+{
+	return srcu_read_lock(ssp);
+}
+
+__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp, int idx)
+{
+	srcu_read_unlock(ssp, idx);
+}
+
+__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)
+{
+	srcu_barrier(ssp);
+}
+
+__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_struct *ssp)
+{
+	synchronize_srcu_expedited(ssp);
+}
-- 
2.51.2

