Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11717221DA3
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865930; cv=none; b=mdbtZSQmo1TtS9tzr+N5kZe9LOuOoH955QEZeNduN5XVw7A5PkOSM81KPZGvjBxsYBt6qCMp5xqGVnQf0tPspx7xQrHwSQ4fjd5L+Y7FBZz4mSfHPlrI578fyWK6YW1/l8QGF+rSyQ6k/yYtxFoaHZdhpcDGlPlbB46+rVVHXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865930; c=relaxed/simple;
	bh=U9Zquo+I28n7D6l89QyMvjgCk9CUHGORATxUF8MOC08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bw7jVbUFSI3yFvdBSveQm18oidZF6kvbzIpZNWRCl473Bbtujc8UvVaTb6qrVM80h6oM5Gr75IGfKNQgBhkXUiLp9VK+3dpYDNOpcJa+LQzCjsv1r5CE0UW+qU2IBGQvx58oe3xa5SjICAF/s0JEXYVXZHlrgHOuH0sxnbBlNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9kTI7MY; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9kTI7MY"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ab6e2b653a0so145212866b.3
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738865926; x=1739470726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3npqKmcD7idosYB3Rql5Qlei3J/L1gfZsrIz0sfHUY=;
        b=K9kTI7MY6mQK9tOS73I2v9K0v65AtDd4n2pwmcc2R29p6EGO8u8elONw3yS7WssT8K
         2FHQRGGn5qIIdvXVfYQH2et5AXGmhlmxy0BmuU3xEwqdcM/o8ba5J2zJcA1CL/xpeBdx
         F4jVmtxMSilRSRL6zzEIXnSCGo4sRE06XlD2vkwUvbNqSfXTTu17vThH93vHfWfHUhqw
         lBF8udw97YWafgY7Z7tih/DRm0fv7V9kgZyjbQX0MAWKUwbaKoFg8Ks9267UqO8bkIcL
         cmLrOtlVN8sW1+T3WWfve5PL4QtjE3xGXyCfPiCfGQ27JIqGDQrC1CJqUmZNGH6BnJr6
         kiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865926; x=1739470726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3npqKmcD7idosYB3Rql5Qlei3J/L1gfZsrIz0sfHUY=;
        b=Vq1VhG3gu8U89lGmBLxGcT7NgYqsXwRX5CocWTr+Pb3+2vb8SK4BJu7Tg3NFXPK2CA
         OrBT8iicAnY9KB8mpY0hxiZ9DtEKkW4RoyY0v/m/swjVUjeT4hyKNkCZ2rBr6qajtj65
         TtIktqT7XGpAW7rG6S4Z1Jeje2MXxmVT6AEq/K/lj6EeaPkCRjHKR9zK/nKBZ+wefPMm
         3JkeD6VpRMo3WM2eRTaf4xDjU34eBUY3o0lAJNLuM3lOR4Dd2yZPUwZSf32Ur8L80fvq
         ZijiyTorWhuB8NZor37R1sExBZXIqIxYtXyJ6zTGfFaZpTEtpZ4kTc/AQpv2WkljWWwK
         TTJA==
X-Forwarded-Encrypted: i=1; AJvYcCX82BzA1KSzKeJWq7oKrHDN91NY5o8BQPOE/c3q8sfvml4YAXdxnVPbLvtOdOxAjVf0aqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIiiaKMQNpMoCOS+pTdnkiGLW8SXPUCOh8lY8+WqxFY14WJHN
	oTcZgaROark24dn2KphyweSF48phb+Zbp0Pk8YmwjnYcheZ0gbDv0w1pXpGxTtibQgimSoIC/g=
	=
X-Google-Smtp-Source: AGHT+IHaR4OtYgVkoAVUDStYqYv+9thvNuzjxTMXa8LJQryBI8+iut5U512tyfYG9g1hUPYb+umuGfZNFg==
X-Received: from edben5.prod.google.com ([2002:a05:6402:5285:b0:5dc:c943:7c1])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:dc8d:b0:aac:622:8f6
 with SMTP id a640c23a62f3a-ab75e26558fmr633944866b.17.1738865926699; Thu, 06
 Feb 2025 10:18:46 -0800 (PST)
Date: Thu,  6 Feb 2025 19:10:18 +0100
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206181711.1902989-25-elver@google.com>
Subject: [PATCH RFC 24/24] rhashtable: Enable capability analysis
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Enable capability analysis for rhashtable, which was used as an initial
test as it contains a combination of RCU, mutex, and bit_spinlock usage.

Users of rhashtable now also benefit from annotations on the API, which
will now warn if the RCU read lock is not held where required.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/rhashtable.h | 14 +++++++++++---
 lib/Makefile               |  2 ++
 lib/rhashtable.c           | 12 +++++++++---
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 8463a128e2f4..c6374691ccc7 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -245,16 +245,17 @@ void *rhashtable_insert_slow(struct rhashtable *ht, const void *key,
 void rhashtable_walk_enter(struct rhashtable *ht,
 			   struct rhashtable_iter *iter);
 void rhashtable_walk_exit(struct rhashtable_iter *iter);
-int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires(RCU);
+int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires_shared(RCU);
 
 static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
+	__acquires_shared(RCU)
 {
 	(void)rhashtable_walk_start_check(iter);
 }
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
-void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
+void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases_shared(RCU);
 
 void rhashtable_free_and_destroy(struct rhashtable *ht,
 				 void (*free_fn)(void *ptr, void *arg),
@@ -325,6 +326,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket_insert(
 
 static inline unsigned long rht_lock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt)
+	__acquires(__bitlock(0, bkt))
 {
 	unsigned long flags;
 
@@ -337,6 +339,7 @@ static inline unsigned long rht_lock(struct bucket_table *tbl,
 static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
 					struct rhash_lock_head __rcu **bucket,
 					unsigned int subclass)
+	__acquires(__bitlock(0, bucket))
 {
 	unsigned long flags;
 
@@ -349,6 +352,7 @@ static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
 static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head __rcu **bkt,
 			      unsigned long flags)
+	__releases(__bitlock(0, bkt))
 {
 	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(0, (unsigned long *)bkt);
@@ -402,13 +406,14 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt,
 				     struct rhash_head *obj,
 				     unsigned long flags)
+	__releases(__bitlock(0, bkt))
 {
 	if (rht_is_a_nulls(obj))
 		obj = NULL;
 	lock_map_release(&tbl->dep_map);
 	rcu_assign_pointer(*bkt, (void *)obj);
 	preempt_enable();
-	__release(bitlock);
+	__release(__bitlock(0, bkt));
 	local_irq_restore(flags);
 }
 
@@ -589,6 +594,7 @@ static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
 static inline struct rhash_head *__rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhashtable_compare_arg arg = {
 		.ht = ht,
@@ -642,6 +648,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 static inline void *rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he = __rhashtable_lookup(ht, key, params);
 
@@ -692,6 +699,7 @@ static inline void *rhashtable_lookup_fast(
 static inline struct rhlist_head *rhltable_lookup(
 	struct rhltable *hlt, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he = __rhashtable_lookup(&hlt->ht, key, params);
 
diff --git a/lib/Makefile b/lib/Makefile
index f40ba93c9a94..c7004270ad5f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -45,6 +45,8 @@ lib-$(CONFIG_MIN_HEAP) += min_heap.o
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
 
+CAPABILITY_ANALYSIS_rhashtable.o := y
+
 obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 3e555d012ed6..47a61e214621 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -11,6 +11,10 @@
  * pointer as suggested by Josh Triplett
  */
 
+#include <linux/rhashtable.h>
+
+disable_capability_analysis();
+
 #include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -22,10 +26,11 @@
 #include <linux/mm.h>
 #include <linux/jhash.h>
 #include <linux/random.h>
-#include <linux/rhashtable.h>
 #include <linux/err.h>
 #include <linux/export.h>
 
+enable_capability_analysis();
+
 #define HASH_DEFAULT_SIZE	64UL
 #define HASH_MIN_SIZE		4U
 
@@ -358,6 +363,7 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 static int rhashtable_rehash_alloc(struct rhashtable *ht,
 				   struct bucket_table *old_tbl,
 				   unsigned int size)
+	__must_hold(&ht->mutex)
 {
 	struct bucket_table *new_tbl;
 	int err;
@@ -392,6 +398,7 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
  * bucket locks or concurrent RCU protected lookups and traversals.
  */
 static int rhashtable_shrink(struct rhashtable *ht)
+	__must_hold(&ht->mutex)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	unsigned int nelems = atomic_read(&ht->nelems);
@@ -724,7 +731,7 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_exit);
  * resize events and always continue.
  */
 int rhashtable_walk_start_check(struct rhashtable_iter *iter)
-	__acquires(RCU)
+	__acquires_shared(RCU)
 {
 	struct rhashtable *ht = iter->ht;
 	bool rhlist = ht->rhlist;
@@ -940,7 +947,6 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
  * hash table.
  */
 void rhashtable_walk_stop(struct rhashtable_iter *iter)
-	__releases(RCU)
 {
 	struct rhashtable *ht;
 	struct bucket_table *tbl = iter->walker.tbl;
-- 
2.48.1.502.g6dc24dfdaf-goog

