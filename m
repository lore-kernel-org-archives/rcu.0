Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39725F7A5;
	Thu, 16 Jul 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161097; cv=none; b=jBfssdfqFPbBJCS4q8qbccNyxzix0LJ6TNa6id+jIRJ1+mY0A1Lz7kW/71pSknUSOLumG+2MWx+9XzpFRXjJacG6Q2fxxliDO2FR9zAr7md5vQRzVEXF7GDkq+i8A6Zz7REZR+v77wIhGCQnaa2ODqbLSXmHOKeSGKJ8BJiEqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161097; c=relaxed/simple;
	bh=mxJOPif/jV8Wcsk1RJDevaQLZEfK2ZjRh6SiVmLZHKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzmXQ7WTWpN7m4PALmnF42QsRRD6Q1pmeDkj/OoMVRpf16BSePAMETb/s0OgFEYSo4lV4mK2C8Xooll/e9IZPMrbgzRo/gvqUf1cr1jVe4SBmtQ1fZ6wYIcIHbkp+h70EzLarhDzMX5/yA+gsoYPhrrVL+/hWbnzci3JRgclCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1ZTZZmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1ZTZZmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E362E1F01564;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=4Fw3aNAw+royQiOfx6tNUiBUQW4ffB4TkgOEDFkEVR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1ZTZZmVSF87WeIftSeLjIJYJEqcERtPpknSWZf/tKCKl1cSZ6iu9KURxSTYk/Gd5
	 wT7gZmLgxowVwj00TRj2W39Y1goTgL/cbwef+/TlEKvlpxcZwXPlMLPK26VmLFHNS1
	 B7fhnQQ21htG6zijiTnw8As6385ojiSbWvBefhkVYx5A+ScnTQcnAfUwXQe+ly/Cvv
	 uyKxZepFSUXbZEyV3sDmNVH3UCnQ35fDM3R+XfKskmP9XEQRLm5xtQvcFplqRd4FpI
	 r4zp0hO9zxuLgktxQHbDi8Uu63vsGIv5KjYsDhmzLpzn0pG7Tye6g4Mf8jDZfBX5ts
	 1njenqJ5RkaAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5EE22CE0569; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>
Subject: [PATCH RFC v2 24/24] hazptr: Upgrade kernel-doc headers
Date: Wed, 15 Jul 2026 17:18:09 -0700
Message-Id: <20260716001809.11084-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
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
---
 include/linux/hazptr.h | 75 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 70db3ca7b95be0..80232eb6a592d5 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -75,12 +75,16 @@ DECLARE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
 
 void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p);
 
-/*
- * hazptr_synchronize: Wait until @addr is released from all slots.
+/**
+ * hazptr_synchronize: Wait for release from hazard-pointer protection
+ *
+ * @addr: The address to be released from hazard-pointer protection
  *
- * Wait to observe that each slot contains a value that differs from
- * @addr before returning.
- * Should be called from preemptible context.
+ * Wait for the specified @addr to be released from protection from all
+ * hazard pointers.  The caller should make @addr inaccessible to all
+ * hazard-pointer readers before invoking this function.
+ *
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
@@ -160,12 +186,25 @@ void hazptr_note_context_switch(void)
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
@@ -233,7 +272,23 @@ void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr)
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

