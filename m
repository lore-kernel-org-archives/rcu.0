Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371228504B
	for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204333; cv=none; b=hTi/QD0DzILiJSeh1XJ8HleGrRhQAgKgAQNuNwcACDUpJ/GstLIYuKXr54/J2nFb/98WphSbjGYP7XKtArCzZohvbVLRnu5BVUEeWoaGjxc238gpTr5Kdd/XJQjO+4qrVgzuPdrIak8xCN6ZswGWOhXA1IrgQtva21xzD4SHP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204333; c=relaxed/simple;
	bh=hWQTFclLDMz8VDIHIRpv8/WliytLJaAhdU6JNzWrg6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EroIqV/ZKMIjJeMCEjihH/GfFFwi3RSG62unkgVWBiUN2iz9NFGueI1v4R/vO1v+ZF3IrBawvnA7OOZCS4QUigrMoY92Cy+4tqyf20IHPWjDaFh4btojWeeJ4yTKT/zJYptXdvyEMJ1xMMNTZrnErBXsO59i6L3VcnzbN4U2bx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FU49BucB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FU49BucB"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so7403955e9.3
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204329; x=1758809129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sI2tSFnbkFXEHpzRn76LXPg2QDPG5jXGC+/0hf5kEII=;
        b=FU49BucBWcWp+YVJUWl8w3U6ejvHKF66rHZXuwfQ9IDYnM4yc8HwS52AGeBN7vtSST
         GHOBkpDX98Py3IPzJTGZIk68+OXnPkHDbbz7OYQyXjyeIthlSoiUwwZHepms3xJ98mLe
         u9PC2tgaxYxXClcvaikdlgztvD4R8FJ6hih3UTTjt+B6+DJCBKR0T6DYHxemWscz1OZS
         /lAq/FS8Tug7dOufvD6p/VTz/+nYACHs2pZHOdU8SZxMOcpPQSxUQR/sJE67s0EbqeAo
         C3T+clgOry3xpRHZf7ISsMUfwL/S2RJppm2fKQZmacP0gP1gLhxAa1RDi7Lms1iOmGTF
         Szzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204329; x=1758809129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sI2tSFnbkFXEHpzRn76LXPg2QDPG5jXGC+/0hf5kEII=;
        b=NX80zLuuMEItKUeBdGRzFAUlE4Qs+WbQHWUWAjhffg0KdFmjd7acKXxMuO995JgNvN
         J/fTBbMA/xpoY3uHqNxan6WJ3bDQXBVJKBOVDjA//9Q90J5l8Ki6mrvSyzw/mgVpP5vT
         fNs9sfS3X0JPmz8UAB2VyHZm14S+x+s5lk4xKqCN7dRT0FFqTw/+ORMHapXxE51ydTSq
         RTtX8cBK0AWX/RzfnOmcnHjmZGshlA2W8otdmVuEJ5lHZrhMRtWTtqZdcNFunltDXlh7
         6YSWYEAR1Pb0YKuFYtQopGfUsHdSe+77qTuOWq20JukJayQeqOAvbUtnImV9ukuY0/nW
         ozLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3uh767HqrpVMIgIkqc1I43N7YEYWoZ1dVFRBgFYtEtlRieZ7ZUbzBBP33O4zvWS8k+po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdnrBs53BIlX1dMlhcelBMFcRPJc5FOL30oM13TLfXV0KkiwX
	oJQwaneK8HX1rlu8Iih4eWRzbKUWcgFLHcVlPkQ+Ckbt1jDY+t8DxZU6G8GbpFi+DyDmzmT5t1V
	4Kg==
X-Google-Smtp-Source: AGHT+IFRbToo2Bwf5/5PfOGlLkyE9BQ/OcfapdUErqx3YciffbcOiyjfesgIMrMTUrj6b+h7cxqfj4hCOQ==
X-Received: from wmlv10.prod.google.com ([2002:a05:600c:214a:b0:45b:9c60:76bb])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:b86:b0:455:f59e:fd9b
 with SMTP id 5b1f17b1804b1-46205eb1674mr64702705e9.24.1758204329318; Thu, 18
 Sep 2025 07:05:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:12 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-2-elver@google.com>
Subject: [PATCH v3 01/35] compiler_types: Move lock checking attributes to compiler-capability-analysis.h
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The conditional definition of lock checking macros and attributes is
about to become more complex. Factor them out into their own header for
better readability, and to make it obvious which features are supported
by which mode (currently only Sparse). This is the first step towards
generalizing towards "capability analysis".

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/compiler-capability-analysis.h | 32 ++++++++++++++++++++
 include/linux/compiler_types.h               | 18 ++---------
 2 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/compiler-capability-analysis.h

diff --git a/include/linux/compiler-capability-analysis.h b/include/linux/compiler-capability-analysis.h
new file mode 100644
index 000000000000..7546ddb83f86
--- /dev/null
+++ b/include/linux/compiler-capability-analysis.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros and attributes for compiler-based static capability analysis.
+ */
+
+#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
+#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
+
+#ifdef __CHECKER__
+
+/* Sparse context/lock checking support. */
+# define __must_hold(x)		__attribute__((context(x,1,1)))
+# define __acquires(x)		__attribute__((context(x,0,1)))
+# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __releases(x)		__attribute__((context(x,1,0)))
+# define __acquire(x)		__context__(x,1)
+# define __release(x)		__context__(x,-1)
+# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+
+#else /* !__CHECKER__ */
+
+# define __must_hold(x)
+# define __acquires(x)
+# define __cond_acquires(x)
+# define __releases(x)
+# define __acquire(x)		(void)0
+# define __release(x)		(void)0
+# define __cond_lock(x, c)	(c)
+
+#endif /* __CHECKER__ */
+
+#endif /* _LINUX_COMPILER_CAPABILITY_ANALYSIS_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 16755431fc11..c24e60e75f36 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -24,6 +24,8 @@
 # define BTF_TYPE_TAG(value) /* nothing */
 #endif
 
+#include <linux/compiler-capability-analysis.h>
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /* address spaces */
@@ -34,14 +36,6 @@
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
-/* context/locking */
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __cond_acquires(x) __attribute__((context(x,0,-1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 /* other */
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
@@ -62,14 +56,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-/* context/locking */
-# define __must_hold(x)
-# define __acquires(x)
-# define __cond_acquires(x)
-# define __releases(x)
-# define __acquire(x)	(void)0
-# define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 /* other */
 # define __force
 # define __nocast
-- 
2.51.0.384.g4c02a37b29-goog

