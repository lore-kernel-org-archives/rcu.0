Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A01E7C11
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865894; cv=none; b=e+rf4u7BMx2PdR1J5DwMXvkGTglh7LjXKELi9a3KD80aS520MbFqnMqS3S/uuDfD7fPvYU+Qv/zekDZVDEFgteEZrh/R4WoECR1qDGfMVIgY7DKz4wi33tMFyEZOhZq+DAFQdhQTQpoftd6BSsRKlocPTPq+gqu7Q0JCEoPMDHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865894; c=relaxed/simple;
	bh=V/8+QBogDMyq8h2947266ECzIEzGrAwlE/YZoBQH82U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5Qzz+//PRNlC2+3GAEDywMgTJO1hbbAxEKa93rkclWuMH/aO6NE7DXuJ5Pu/zSji3t62OeHh0pimxQ7zIeir+FMJ8JP+LDdI+kSRUYAdvif4RN0XiBBgOEdPU60fYPB1k4DOwlJYESFtrkCnpysv1xekSxpdVfEhIUDJh+s4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zqC1cvdL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zqC1cvdL"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38dbe6a1e01so790895f8f.0
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738865891; x=1739470691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0plDjCJ1B0qZbMeycYJk7FAuIdA1LrCIxvHWeEdHoU=;
        b=zqC1cvdL5z4g+NzZXRFUwGumd9cF3Bw+U6gYvGOP0gY21Y8RsEaiQv16aOjF9LxCmQ
         Oek0NSkm7CO8Oq+TYkkSDRl0z2C4BowmKAWZqULyP35oosbqo+ZpFm0VPSN8m1ujrvpJ
         glMQ4U/CJIJWrQjtlB3sua3FNbdvhnxfDCZy7gXez2GswV0y82ZDPhgluoJjuiW/wBzO
         sigB4eKBhdH3mqISAiozgVoew+YZqBVFtTVQWDAdVGveVzNzHnCdmXBlJhUGnu7GTu8Y
         1DRPG8PBGCxM9EWuXCbEjVG9mfIKvQMwgnoHvkblJYbAmatJY/r9Ca7YaV1SOZOTPtbD
         hm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865891; x=1739470691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0plDjCJ1B0qZbMeycYJk7FAuIdA1LrCIxvHWeEdHoU=;
        b=Y9PCBJsMTbUp/Ell4Sa4FFR+o05LIjTygsTdLW9U+gd1VHMkG4Lv7l1D81lHrbhK93
         yH8xMLr8UF5By6/cpJanHnjeXR6P9dO5de07riR/vB7hewvAoaKZG1QKyATPU1yXAGMq
         OvL/atzg1drqiHuR7qf4OTpmjIqnuTdFbslyPDJVeyopW9M/lF+fCMOhZoh1hOcfSShq
         5bwOR7y8iFUyGyZJBbu2v6R2kI1hww0vYmwFfbRPIx6duZlFZBfpvLcbk0IalcNT6JhQ
         Gy84knsUjRFcgY2rMOyigB+Rzubn9WXV8iu7sNUVeFtEq/JtBD2y0eZfhWfGIOt5uwAj
         2EFw==
X-Forwarded-Encrypted: i=1; AJvYcCXDjSEWi7flNK5XT5xaRqf122Tmq1oQNJGH2ufgnIeUxsjv5tvlfePeFMR2vvnjqgrFXT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DhRgPfOflWOvtF+6OEsmh1qnl8jCoR6Za20Af2v2INwE6zO3
	SVFUSP+JK5WE81/9QXbxSK7Dg+87dyRUN4TMlEVcm5epshzP0bLDK579dDC8mSj0llHskLUS/Q=
	=
X-Google-Smtp-Source: AGHT+IEkg7Kc2bKGRgLgH3oGb3lUCUVYUhWVhdvv0Wl/Ah0jIHP7904jYfscr6wQzIioSc3ZaTf74I70+g==
X-Received: from ejcvs8.prod.google.com ([2002:a17:907:a588:b0:aa6:8676:3b2b])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64af:0:b0:386:605:77e
 with SMTP id ffacd0b85a97d-38dc933bd7amr24f8f.49.1738865890985; Thu, 06 Feb
 2025 10:18:10 -0800 (PST)
Date: Thu,  6 Feb 2025 19:10:04 +0100
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206181711.1902989-11-elver@google.com>
Subject: [PATCH RFC 10/24] compiler-capability-analysis: Change
 __cond_acquires to take return value
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

While Sparse is oblivious to the return value of conditional acquire
functions, Clang's capability analysis needs to know the return value
which indicates successful acquisition.

Add the additional argument, and convert existing uses.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 fs/dlm/lock.c                                |  2 +-
 include/linux/compiler-capability-analysis.h | 14 +++++++++-----
 include/linux/refcount.h                     |  6 +++---
 include/linux/spinlock.h                     |  6 +++---
 include/linux/spinlock_api_smp.h             |  8 ++++----
 net/ipv4/tcp_sigpool.c                       |  2 +-
 6 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c8ff88f1cdcf..e39ca02b793e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -343,7 +343,7 @@ void dlm_hold_rsb(struct dlm_rsb *r)
 /* TODO move this to lib/refcount.c */
 static __must_check bool
 dlm_refcount_dec_and_write_lock_bh(refcount_t *r, rwlock_t *lock)
-__cond_acquires(lock)
+      __cond_acquires(1, lock)
 {
 	if (refcount_dec_not_one(r))
 		return false;
diff --git a/include/linux/compiler-capability-analysis.h b/include/linux/compiler-capability-analysis.h
index ca63b6513dc3..10c03133ac4d 100644
--- a/include/linux/compiler-capability-analysis.h
+++ b/include/linux/compiler-capability-analysis.h
@@ -231,7 +231,7 @@
 # define __must_hold(x)		__attribute__((context(x,1,1)))
 # define __must_not_hold(x)
 # define __acquires(x)		__attribute__((context(x,0,1)))
-# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __cond_acquires(ret, x) __attribute__((context(x,0,-1)))
 # define __releases(x)		__attribute__((context(x,1,0)))
 # define __acquire(x)		__context__(x,1)
 # define __release(x)		__context__(x,-1)
@@ -277,12 +277,14 @@
 /**
  * __cond_acquires() - function attribute, function conditionally
  *                     acquires a capability exclusively
+ * @ret: value returned by function if capability acquired
  * @x: capability instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given capability instance @x exclusively, but does not release it.
+ * given capability instance @x exclusively, but does not release it. The
+ * function return value @ret denotes when the capability is acquired.
  */
-# define __cond_acquires(x)	__try_acquires_cap(1, x)
+# define __cond_acquires(ret, x) __try_acquires_cap(ret, x)
 
 /**
  * __releases() - function attribute, function releases a capability exclusively
@@ -349,12 +351,14 @@
 /**
  * __cond_acquires_shared() - function attribute, function conditionally
  *                            acquires a capability shared
+ * @ret: value returned by function if capability acquired
  * @x: capability instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given capability instance @x with shared access, but does not release it.
+ * given capability instance @x with shared access, but does not release it. The
+ * function return value @ret denotes when the capability is acquired.
  */
-# define __cond_acquires_shared(x) __try_acquires_shared_cap(1, x)
+# define __cond_acquires_shared(ret, x) __try_acquires_shared_cap(ret, x)
 
 /**
  * __releases_shared() - function attribute, function releases a
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 35f039ecb272..f63ce3fadfa3 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -353,9 +353,9 @@ static inline void refcount_dec(refcount_t *r)
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
-extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
-extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
+extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(1, lock);
+extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(1, lock);
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
-						       unsigned long *flags) __cond_acquires(lock);
+						       unsigned long *flags) __cond_acquires(1, lock);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1646a9920fd7..de5118d0e718 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -362,7 +362,7 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 }
 
 static __always_inline int spin_trylock(spinlock_t *lock)
-	__cond_acquires(lock) __no_capability_analysis
+	__cond_acquires(1, lock) __no_capability_analysis
 {
 	return raw_spin_trylock(&lock->rlock);
 }
@@ -420,13 +420,13 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned lo
 }
 
 static __always_inline int spin_trylock_bh(spinlock_t *lock)
-	__cond_acquires(lock) __no_capability_analysis
+	__cond_acquires(1, lock) __no_capability_analysis
 {
 	return raw_spin_trylock_bh(&lock->rlock);
 }
 
 static __always_inline int spin_trylock_irq(spinlock_t *lock)
-	__cond_acquires(lock) __no_capability_analysis
+	__cond_acquires(1, lock) __no_capability_analysis
 {
 	return raw_spin_trylock_irq(&lock->rlock);
 }
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index fab02d8bf0c9..9b6f7a5a0705 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -34,8 +34,8 @@ unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 unsigned long __lockfunc
 _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock, int subclass)
 								__acquires(lock);
-int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)		__cond_acquires(lock);
-int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(lock);
+int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)		__cond_acquires(1, lock);
+int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(1, lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
@@ -84,7 +84,7 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
-	__cond_acquires(lock)
+	__cond_acquires(1, lock)
 {
 	preempt_disable();
 	if (do_raw_spin_trylock(lock)) {
@@ -177,7 +177,7 @@ static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 }
 
 static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
-	__cond_acquires(lock)
+	__cond_acquires(1, lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	if (do_raw_spin_trylock(lock)) {
diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
index d8a4f192873a..10b2e5970c40 100644
--- a/net/ipv4/tcp_sigpool.c
+++ b/net/ipv4/tcp_sigpool.c
@@ -257,7 +257,7 @@ void tcp_sigpool_get(unsigned int id)
 }
 EXPORT_SYMBOL_GPL(tcp_sigpool_get);
 
-int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquires(RCU_BH)
+int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquires(0, RCU_BH)
 {
 	struct crypto_ahash *hash;
 
-- 
2.48.1.502.g6dc24dfdaf-goog

