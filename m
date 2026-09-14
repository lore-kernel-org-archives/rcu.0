Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48E4756CA
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394020; cv=none; b=H7coQCII2f1GNDMk0NzBW/TB9+T5wrovIMVEmrUE5CtTYmMKz9S9Lb6JJJ/5U5PVTIhjAOBKtjGdg/cJfA+6sGOW2oQ7pfVKVaDoFW/AfZYAVCqENgO5W5WQrgR/04OaCMQrEL+Y/fe9W3G8P4UeT/YiQ+vhWkqHYIBu3b5FwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394020; c=relaxed/simple;
	bh=xJvd4bktnXFf0NwIcparA75QhsM+VXfRpWstC2+jKaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f59CBZ89/fDZQYKf0/U9kgYRjG7aA6nvkiZUJvq4eCl663ryTGwJ3vEQ+oqeerhT/qhl7pN/LSWmFijtHPGlZ6gA7ZCr9WnWb/GDrCqQ5CE4Z62UP1x+KxcuLA1lQ79ZNbcLgcnJIECj4+fxGmp9GQwsnqzAHrD5Z8Zukw8WZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h60i6HiN; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h60i6HiN"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso2696275e87.0
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789394015; x=1789998815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pnh8dMLBh1/L0ApWEov3Ejjcg0z+ookCCvunP662t7U=;
        b=h60i6HiNK4cXjSIHYUXKg09hU1T3FXzxPPXgBXT7B02bUFoL/YZB6zxKep/FCRNNTe
         emeDowJ/7eIFWBPanj35Bj16t1DkmVOdkSqlHhNTZmpArzlzQc4n+t4mKf3QuZutfNDt
         ecs+V79VWOq89TM7AyzizrPytClbvc7+kwoRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394015; x=1789998815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pnh8dMLBh1/L0ApWEov3Ejjcg0z+ookCCvunP662t7U=;
        b=Z2YZKvURI6NLSUDjTu20SbFkupONqqATV6txMs4rWHfNNquTfhGVLT2TZBj6f6WaEQ
         UUqAYZE8Ux3NWdydUHhO7W9W8xQ/kqaqVGngb83ecDSrLLJJJx+MBfhL8QMmfa51msuh
         5k+lfG/J2YtLipGHP5v1JGl6W334epxuHi5jYzIbnBvyrWVjijcJF9agqv4HvA9MHjpt
         PbMZQMJ8NeAj78b18UxrIBuCHZB+zySQ9sPxLZYqG0hqv3s2Mx9J1lcZby5XdwS2X/lF
         0GhoOdqzpydTuUPy9rv1FLf1WFYF/xbtiOE//sB7aClBhNang7lk71LW6dlUweolmKqH
         yP3A==
X-Forwarded-Encrypted: i=1; AKwUvByb6RDW/x/n4ifWK9ctxYxMJnVtZ8FhoNrozjsOjjzaQRtZ6H187R8DrVcygrv/NeKXlAw=@vger.kernel.org
X-Gm-Message-State: AFuF++kFFc7ErfOrZbQmnxscG6JLVuei0H37Ayjve5xVJNN2b2RMD1eg
	0QHQ5heKuR4D4RBnx27v/b2OH8fAZSyAg3R8Q01AKc24ZdB+7ffvVKwFMyGk4BmcDg==
X-Gm-Gg: AYBFou0c3Uz6C/G6hijPBcq7mHJUeMGHpOtDTv4jb32vmkUaf8QD8+UFFEEmzqg5hVG
	ZYV2DDkg7D7FekfCSYl+BFR1PQadGeQHkie/l23TBFzWDfsBiQZ1G0aZAlOur/vsGaNZyo1nkRS
	QmtnX5drjK/pHCvNpxR9AYjqc6gM4a4AbZkg41b7vjeFieRH8mMESF3vqPnEtQiZPkq/c9UV+lA
	8aSeyo/xYt3VIqxyz50jvDE4Qfn+hqXM5CuiNZvbhKZwsLs/5mP90xJyLUS7FoGGjv6jbU9KPL0
	69dXyjY10+1aKVSZ7ttTzgAGjCIKPnSD0Mgv4Kd3Twrwg6cPPpNNzy0XxfDJh8HnHZKBcYbDdDA
	f7H76NbMXHfLj+7orI7sT2ST6jSP0p8KJhWd2VPjmLrutBkm+dX0gd1yJnWvxKI8owRmJHQqk6V
	B4frB1z6ZA5mPXpp8iI65unxuKXv/NQ+eb6Adk33sKrgdn6I0UZy4zINEzGLZPR0KTn2sGu8yTv
	X3ysQ4I9Gh08VIYmSxu8IMagnqvMZ9iYnLiDAGVEplB2g73gg==
X-Received: by 2002:a05:6512:2256:b0:5b2:a558:b222 with SMTP id 2adb3069b0e04-5b8ae68c48emr1497898e87.10.1789394015587;
        Mon, 14 Sep 2026 06:53:35 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3304b38sm29433921fa.13.2026.09.14.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:53:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Sep 2026 13:53:31 +0000
Subject: [PATCH v2 1/2] rcu: Drop the address space qualifier from the
 dereference macros
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-unqual-v2-1-60a1407a0cd4@chromium.org>
References: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
In-Reply-To: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Li <sparse@chrisli.org>, Dan Carpenter <error27@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

The RCU dereference macros end with a cast that is meant to hand back a
plain kernel pointer from a __rcu pointer.

For that it uses:
	((typeof(*p) __force __kernel *)(local))

The problem is that typeof preserves every qualifier, including the
address space qualifiers (__rcu).

Recent versions of smatch[1] care about this and throw tens of warnings
like this one:
  ./include/trace/events/vb2.h:46:1: warning: incorrect type in assignment (different address spaces)
  ./include/trace/events/vb2.h:46:1:    expected struct tracepoint_func *it_func_ptr
  ./include/trace/events/vb2.h:46:1:    got struct tracepoint_func __rcu *

Use a new macro TYPEOF_NO_ADDRESS_SPACE() for the result type. This new
macro strips all the qualifiers when running with sparse (so const and
volatile are gone). But keeps all the qualifiers when running with the
compiler, caring about const/volatile mismatch.

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20260825-unqual-v1-1-7024fb81b4f9@chromium.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/compiler.h | 17 +++++++++++++++++
 include/linux/rcupdate.h | 10 +++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cb2f6050bdf7..70cb31d60538 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -239,6 +239,23 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define TYPEOF_UNQUAL(exp) __typeof__(exp)
 #endif
 
+/*
+ * TYPEOF_NO_ADDRESS_SPACE() - typeof() without the address space qualifiers
+ *
+ * No operator strips only the address space qualifiers: typeof() keeps every
+ * qualifier and TYPEOF_UNQUAL() drops every qualifier, const and volatile
+ * included.
+ *
+ * Approximate one by dropping the qualifiers for sparse only, as it is the
+ * only one that knows about address spaces. The compiler keeps seeing the fully
+ * qualified type, so a missing const or volatile will still throw a warning.
+ */
+#ifdef __CHECKER__
+# define TYPEOF_NO_ADDRESS_SPACE(exp) TYPEOF_UNQUAL(exp)
+#else
+# define TYPEOF_NO_ADDRESS_SPACE(exp) __typeof__(exp)
+#endif
+
 #endif /* __KERNEL__ */
 
 #if defined(CONFIG_CFI) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44c07a66edff..3f74ae6d6e1f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
 context_unsafe(								\
 	typeof(*p) *local = (typeof(*p) *__force)(p);			\
 	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(local))			\
+	((TYPEOF_NO_ADDRESS_SPACE(*p) __force __kernel *)(local))	\
 )
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
@@ -503,7 +503,7 @@ context_unsafe(								\
 ({ \
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((TYPEOF_NO_ADDRESS_SPACE(*p) __force __kernel *)(local)); \
 }) )
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
@@ -511,19 +511,19 @@ context_unsafe(								\
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((TYPEOF_NO_ADDRESS_SPACE(*p) __force __kernel *)(local)); \
 })
 #define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(p)); \
+	((TYPEOF_NO_ADDRESS_SPACE(*p) __force __kernel *)(p)); \
 })
 #define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
 	typeof(p) local = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((TYPEOF_NO_ADDRESS_SPACE(*p) __force __kernel *)(local)); \
 })
 #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 

-- 
2.55.0.1007.g17ff1f9808-goog

