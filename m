Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E937DEB7;
	Sat, 19 Sep 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776066; cv=none; b=opEPhyXrn5UjUP+taYRMcBdw0niSPKeMFMiLuhP+1vNXsUFIV6VlehKO1h5bJ5JM/i9LbJdDvBO+/gADkn4/Aa1qa6ijuQvEkGOzPg+JFILJ81rZsim064PZpQmsmKxdJcryM9dkAer3vDDnRL19glILj0n8Vhr+LCcu3Ad8E54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776066; c=relaxed/simple;
	bh=HvXJiWwcZQrUT/fpwAhQ7/IC5+21eMR3lTMNawaum5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyeQefNo6RmyAnCHGtgsUIMVfR8dhT/LR1nrWsoLPOrJFIJIirb8MFbWFmrEiOdX7nLLzRPXvJ/+yt8MAmVlfHS89Xdc1HQI5GRvUy3bAaYtKUqKWhjlrNQu2m+AYxeKvvoKn+ZfKexvoVzeQek4Ax+/+8ajQaX19ngD+kwcxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UShS6Yf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UShS6Yf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A50F1F00922;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=Z9pYQXC8xaKRrAVY66IUiHTRotyuEwBjDtvW6jYoY/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UShS6Yf0JlpA75VAhjAvWTGwEibS4JIxPj0Mm7f+JdjMS7M1ayDZ4qyxhBJGMMJaL
	 sjT4q7CaAiy+9yIdEqH32uQLHuxfOQO9K+MKVMUnFvaEqoiL8tY6dGdtjkKufQUelV
	 Uw3hFpVwPK2kVaykqCZk1y/hiEPHlr+c9PAPzbIOp2dlZYNcYWcq29A12AGH155teN
	 tYSjkrcVO+Ax5e56h1gr9xuwYsD8fYDrgcVS32KVG1io/B7X5O1Xa5mo2VUsfL7LQV
	 4uxl/XVd9oSqUvSneLCtm7f/ZfiID2I5F+hOaAO2s5e/DhFAhI4zw2L2kxZkRbEory
	 KvKF/zrOB34MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F745CE0F28; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 24/28] hazptr: Upgrade kernel-doc headers
Date: Fri, 18 Sep 2026 17:00:52 -0700
Message-Id: <20260919000056.3132131-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upgrade the kernel-doc headers for hazptr_acquire(), hazptr_release(),
and hazptr_detach_from_task().

[ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 include/linux/hazptr.h | 87 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 415316282142..43998bf43de4 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -75,12 +75,16 @@ DECLARE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
 
 void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p);
 
-/*
- * hazptr_synchronize: Wait until @addr is released from all slots.
+/**
+ * hazptr_synchronize: Wait for release from hazard-pointer protection
+ *
+ * @addr: The address to be released from hazard-pointer protection
+ *
+ * Wait for the specified @addr to be released from protection from all
+ * hazard pointers.  The caller should make @addr inaccessible to all
+ * hazard-pointer readers before invoking this function.
  *
- * Wait to observe that each slot contains a value that differs from
- * @addr before returning.
- * Should be called from preemptible context.
+ * Must be called from preemptible context.
  */
 void hazptr_synchronize(void *addr);
 
@@ -126,6 +130,28 @@ void hazptr_promote_to_backup_slot(struct hazptr_ctx *ctx, struct hazptr_slot *s
 	ctx->slot = backup_slot;
 }
 
+/**
+ * hazptr_detach - Allow a hazard pointer to be released in some other context
+ *
+ * @ctx: The hazard-pointer context to be detached.
+ *
+ * By default, a given hazptr_acquire() and the corresponding
+ * hazptr_release() must run in a single execution context, for example,
+ * the context of a single task or a single interrupt handler.  When you
+ * have acquired a hazard pointer in one context and need to release it
+ * in another, you must invoke hazptr_detach() on that hazard pointer's
+ * context.  It is permissible to invoke hazptr_detach() multiple times
+ * on the same @ctx while it is protecting the same pointer, however,
+ * the first invocation absolutely must be in the same context that did
+ * the hazptr_acquire(), and must take place after the return from that
+ * hazptr_acquire().
+ *
+ * For example, if a hazard pointer is acquired by a task and released
+ * by a timer handler, that task would need to pass the hazard pointer's
+ * context to hazptr_detach() after return from the hazptr_acquire() and
+ * before arming the timer (or at least before the handler had a chance
+ * to access that hazard-pointer context).
+ */
 static inline
 void hazptr_detach(struct hazptr_ctx *ctx)
 {
@@ -160,12 +186,37 @@ void hazptr_note_context_switch(void)
 	}
 }
 
-/*
- * hazptr_acquire: Load pointer at address and protect with hazard pointer.
+/**
+ * hazptr_acquire - Load pointer at address and protect with hazard pointer.
+ *
+ * @ctx: The hazard-pointer context to be passed to hazptr_release().
+ * @addr_p: Pointer to the pointer that is to be hazard-pointer protected.
  *
  * Load @addr_p, and protect the loaded pointer with hazard pointer.
- * When using hazptr_acquire from interrupt handlers, the acquired slots
- * need to be released before returning from the interrupt handler.
+ * This protection is roughly similar to (but way faster than) that of a
+ * reference counter, and ends with a later call to hazptr_release().
+ *
+ * This protection is unconditional, and has limitations similar to
+ * that of unconditional reference-counter acquisition.  In particular,
+ * although holding a hazard pointer prevents a hazard-pointer-protected
+ * object from being freed, it does not prevent that object from being
+ * removed from a linked data structure, and does not prevent other
+ * hazard-pointer-protected objects referenced by this object from being
+ * both removed and freed.  At which point, invoking hazptr_acquire()
+ * on these dangling pointers would be a bug.  On the other hand, use of
+ * hazptr_acquire() is safe for immortal pointers to objects that do not
+ * themselves contain pointers to hazard-pointer-protected objects.
+ * Other (more complex) use cases are also possible.
+ *
+ * By default, the call to hazptr_release() must be running in the same
+ * execution context as the corresponding hazptr_acquire(), for example,
+ * within the same task or interrupt handler.  When it is necessary to
+ * instead call hazptr_release() from some other context, pass @ctx to
+ * hazptr_detach() in the original context after invoking hazptr_acquire()
+ * but before making the hazard pointer available to that other context.
+ *
+ * It is not permissible to invoke hazptr_acquire() twice on the same @ctx
+ * without an intervening hazptr_release().
  *
  * Returns a non-NULL protected address if the loaded pointer is non-NULL.
  * Returns NULL if the loaded pointer is NULL.
@@ -233,7 +284,23 @@ void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr)
 static inline void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr) { }
 #endif
 
-/* Release the protected hazard pointer from @slot. */
+/**
+ * hazptr_release - Release the specified hazard pointer
+ *
+ * @ctx: The hazard-pointer context that was passed to hazptr_acquire().
+ * @addr_p: The pointer that is to be hazard-pointer unprotected.
+ *
+ * Release the protected hazard pointer recorded in @ctx.
+ *
+ * By default, hazptr_release() must execute in the same execution context
+ * that invoked the corresponding hazptr_acquire(), for example, within the
+ * same task or the same interrupt handler.  However, if this restriction
+ * is problematic for your use case, please see hazptr_detach().
+ *
+ * It is permissible (though unwise from a maintainability viewpoint)
+ * to invoke hazptr_release() twice on the same @ctx without an intervening
+ * hazptr_acquire().
+ */
 static inline
 void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 {
-- 
2.40.1

