Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6B1DEFF1
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865888; cv=none; b=aeKhDEBTd+qFnHKN7e8L6nWw4q4ea7Hj9J85HPa9Za8c0EYt40Oc6v+Ij6vAnECWjexxDVLLz4xQJY5E/O9VA9SJkICXJL+y+x+ORam5Zs92yeA19FrPoDgRLX3cs5b5VDjvRi/B3NKYUZ/OW7TSL+c5tkf5BvXZ0vB52Cr67s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865888; c=relaxed/simple;
	bh=nbrPwXyZS1EvTzB5y+SypJlT/s4PiDMg7VB+pOJqZ2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OONr1Tsx+LoHU56K5WG9llP/w3ZzD9BVbn/6gsYh09LwO6JXcYw9K3r4mKqDxnvLmcEnPGeewbTXxBa1FbVC8yCsE8KvyfuvdXHS+PW5IicIDJOV6pEBbz0EBuY7H54mh9DX6/tNR3SIE9vbYMgIe5yozT3k3TUuxWuxKo3MrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bk7WjvjF; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bk7WjvjF"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa67855b3deso144665866b.1
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738865883; x=1739470683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DbQd0Feo/QZz3Rhlb0Ii9wR2JgNHixpKT0msEk4JbI=;
        b=bk7WjvjFVYAf2KOpHRMqC2KHFewZGo+a1MN8tjt1FxDZYFYpx5faGTdcW/0ozFvpLt
         nWh/ckwZyxgHi8cw1yGj5ibTIlsW3oxTxARraym7hqDgr38W6Ch/TTRPOJg476A1nJ+d
         wvWAzc8yllD0aF0ji0II36tK18mLDrvDEFtbjtyaREAG8EWlhheLF7MHh9EIgjX2Ylpg
         prGwDeHVKOFP3oGV9DZngU709BNycm5Y7QYN9q4I97dO9cGvoQB+ZLlRoQ5+p1rxD9Zn
         pSt4HoLUxVaoGTHTO+wLCwYkd/1UeoUMsafPzEp9BgvU9PhqvfTpJ5BhpAn1g4mxy0Dp
         AotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865883; x=1739470683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DbQd0Feo/QZz3Rhlb0Ii9wR2JgNHixpKT0msEk4JbI=;
        b=XZQgQEgCXipahktmzD6sZVFrRdZYKk0TaYEq98nDB3F7NoiqW0ULfXUIimDm3MuyHW
         nloXxBjnGRabz1uM1hBsVEODPGuaqM3JyAJGEvpUoMgt61q8+IhRPxpvQWfhEzgDccHJ
         v8BHHcWauM7v6kWz7hP3/zO4yb1rPc+7egXdVj4l8KeHGCh7KzYprvYxTqlJc3bhM9Gc
         5aJQXO6S4M/1C64c+kjJFnclBGckwO4PvKk7BJPr0yYIgNQ3gbmBEDow3Obs48XE1uOD
         kOFu7AvQR68lnHBMlA78mvwVi0wbCAEWacg+LnQIMrB7b2sZkbqpB0qtqiOd3WkG/CFe
         12kw==
X-Forwarded-Encrypted: i=1; AJvYcCVq74MO+cK2CLja79Iv5QF3Re+6a1tJ+2i+v8RbHlxmtmjg1cEcRWt8VhgAOF5qsLjquQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qg6ScvKkdhS3IDyANTcu3bJKMPuUc9Thflnd0VuGK2XwMJOy
	2e3MrINXR5kncBhnaboU07+SjChDsr5COVVPEdDf1flmJUo6DLZNkgKd7vJYt3hI+lxBC/QYoA=
	=
X-Google-Smtp-Source: AGHT+IEpKrf/iQkrY6KOXq/iYZBQV1l1pAnmjhSh7YEqml+QLzZmS4/pcVjkplICVk/aelHvFs7D7YrXFw==
X-Received: from edbes17.prod.google.com ([2002:a05:6402:3811:b0:5d8:7c8:cde8])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7251:b0:aa6:6885:e2f0
 with SMTP id a640c23a62f3a-ab75e35de7emr916219966b.46.1738865883628; Thu, 06
 Feb 2025 10:18:03 -0800 (PST)
Date: Thu,  6 Feb 2025 19:10:01 +0100
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206181711.1902989-8-elver@google.com>
Subject: [PATCH RFC 07/24] cleanup: Basic compatibility with capability analysis
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

Due to the scoped cleanup helpers used for lock guards wrapping
acquire/release around their own constructors/destructors that store
pointers to the passed locks in a separate struct, we currently cannot
accurately annotate *destructors* which lock was released. While it's
possible to annotate the constructor to say which lock was acquired,
that alone would result in false positives claiming the lock was not
released on function return.

Instead, to avoid false positives, we can claim that the constructor
"asserts" that the taken lock is held. This will ensure we can still
benefit from the analysis where scoped guards are used to protect access
to guarded variables, while avoiding false positives. The only downside
are false negatives where we might accidentally lock the same lock
again:

	raw_spin_lock(&my_lock);
	...
	guard(raw_spinlock)(&my_lock);  // no warning

Arguably, lockdep will immediately catch issues like this.

While Clang's analysis supports scoped guards in C++ [1], there's no way
to apply this to C right now. Better support for Linux's scoped guard
design could be added in future if deemed critical.

[1] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#scoped-capability

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/cleanup.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f7af2b..93a166549add 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -223,7 +223,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  *	@exit is an expression using '_T' -- similar to FREE above.
  *	@init is an expression in @init_args resulting in @type
  *
- * EXTEND_CLASS(name, ext, init, init_args...):
+ * EXTEND_CLASS(name, ext, ctor_attrs, init, init_args...):
  *	extends class @name to @name@ext with the new constructor
  *
  * CLASS(name, var)(args...):
@@ -243,15 +243,18 @@ const volatile void * __must_check_fn(const volatile void *val)
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
 static inline void class_##_name##_destructor(_type *p)			\
+	__no_capability_analysis					\
 { _type _T = *p; _exit; }						\
 static inline _type class_##_name##_constructor(_init_args)		\
+	__no_capability_analysis					\
 { _type t = _init; return t; }
 
-#define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+#define EXTEND_CLASS(_name, ext, ctor_attrs, _init, _init_args...)		\
 typedef class_##_name##_t class_##_name##ext##_t;			\
 static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
 { class_##_name##_destructor(p); }					\
 static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+	__no_capability_analysis ctor_attrs					\
 { class_##_name##_t t = _init; return t; }
 
 #define CLASS(_name, var)						\
@@ -299,7 +302,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
-	EXTEND_CLASS(_name, _ext, \
+	EXTEND_CLASS(_name, _ext,, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
@@ -371,6 +374,7 @@ typedef struct {							\
 } class_##_name##_t;							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+	__no_capability_analysis					\
 {									\
 	if (_T->lock) { _unlock; }					\
 }									\
@@ -383,6 +387,7 @@ static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+	__no_capability_analysis __asserts_cap(l)			\
 {									\
 	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
 	_lock;								\
@@ -391,6 +396,7 @@ static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
 
 #define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
 static inline class_##_name##_t class_##_name##_constructor(void)	\
+	__no_capability_analysis					\
 {									\
 	class_##_name##_t _t = { .lock = (void*)1 },			\
 			 *_T __maybe_unused = &_t;			\
@@ -410,7 +416,7 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
-	EXTEND_CLASS(_name, _ext,					\
+	EXTEND_CLASS(_name, _ext, __asserts_cap(l),			\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
 			_t; }),						\
-- 
2.48.1.502.g6dc24dfdaf-goog

