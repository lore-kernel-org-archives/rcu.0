Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E0412BEF;
	Wed,  7 Oct 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405917; cv=none; b=rO+WYHLOuRryzQpRRCZkoyG+OmHHHJRwurxo8hFrS3DAs7z1oph6i61MivJ9yOF0NtLjEZ6Li7AFgRjJb73ZqLCnJrIbSsHciGIaqWV24dom3pTlFUlv+iuYMc9UVxnT/QljmL7Mc/YcsWf42MIcxE3oalWzugnDkZVEFkLN2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405917; c=relaxed/simple;
	bh=HBY+5i+42NmzqXCHp7HTDjDtSnrAZ4HitIXf0Qi59XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1jtQxln/jKCRZZnkuGn62hzStWWx6Yg6WGPiY5qtb91JFsfohkj0kbVw3J9pNU9z09/BBCBvXf5STazKru9qj1o2NY5ITrIXwvLczR4te2Y3zP8bhNTykldSp69oq1Ny2R7XUedidz4ebJQXuX1XNHWHhaT57Dy+9/io4DCM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKRRVPiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKRRVPiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7EB1F008A0;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=wGTlmj/Armtt/ti+zn4vcxr0SUJC7DX9CyrS7eVER3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKRRVPiZFcbfEEiaqEu9JIT4fH0WPMqCnzqUkkjgZ8Q/ko67nTXsTQ6Vb/HLS4VAi
	 O54yTGKeQP9E4fw32TI4P7BomXXXvWaLRtTjFgf860ZN7rEyitTZk5GqNkJB5V2nUD
	 Ga3n6BtPwn24tbKzg5wyAQLSnmfwfr5y4kvVW89u3aQHWmSNpqqc2u8K3nLIwjCLeY
	 9FR+cUqHpJ/R5KwEg5BcDP5Hw8bQDsFhn9W/TQimHTEbGzjt5hVVogZWqjtTb7dWa7
	 56/QYysnuoPK+dOcvS3pfSJCX623toh3dyM1YvIJggsrUih5wX2U9PFhhFiUzZi9jY
	 l5hclnpAUwd7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B1CCCE274F; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 10/10] rcu: Drop the address space qualifier from the dereference macros
Date: Wed,  7 Oct 2026 13:45:11 -0700
Message-Id: <20261007204511.1982646-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

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
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/compiler.h | 17 +++++++++++++++++
 include/linux/rcupdate.h | 10 +++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cb2f6050bdf7d..70cb31d605384 100644
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
index 44c07a66edfff..3f74ae6d6e1f2 100644
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
2.40.1

