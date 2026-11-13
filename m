Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530995;
	b=jHQ5ndGoeycF3020nFmckqjJQmv0dtqUF6eIGneCVbFA/dteurayw76E6SzNPffzWls2
	 70WZXMXKFGUl8HfMyaMzCb6SxVT3T/Z3pRKPqggtZ3hYqZ17Qslv3Z8QApgL5jjyBJSvT
	 DB6/6YTOUvn+hN2c4RrnteRkmpE8Jm/AL7G+98V3vU77/6+oOYsjxDTf5gCecYezU6NGo
	 BCu5wvXk0jUaIcOWT5EJEx//IRg/540AMIqkL0HE8fEzxXnxI4LsSbCMEs+zuF9PmNIt2
	 zyyFgS+xBfZXoIbsL/+qargjZXUOa8TVqh2dHcYCXyJAM0lu0yuPuAwgjlBGYEFYsHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oCjlz6BygxvB+1x+d/mpEdbtUoFPvED0xyYHks2iJfw=;
	b=x1cm6MvE1suXE/WRDgVJYg1itP6GlN3Cqu2ixg36CIJ7/RIzRYmKtO6XtlK3eTh4U/K2
	 ezUVuFlZ/uehjxp6FRZ2j8Ixzep/tk3rx8I7Yk96vsL0DR1PqebCWL7DFbv2Qm5e88SRO
	 m0YOwuCQKVrhQfPPozMTxyjCE0dAG3IZAeCGQMW/8+fYPjio9bJXJEJyt5bdx5phbVPUx
	 ztvMKwQp/mmUvYUti/P8F9sM5vQ5XhRB1CthySocCkuxaj5gQPT4p2/pcfbWviJgG4uDy
	 2f2ynfMV8H6XZEweoXOf5J3FofH/sOQDNMyx1SXdD7kytyYN0vtLnajq4uaeqjc1i+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKN1NXPU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 87D3D606A89C;
	Fri, 13 Nov 2026 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKN1NXPU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D78531F000C4;
	Fri, 13 Nov 2026 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794530995;
	bh=oCjlz6BygxvB+1x+d/mpEdbtUoFPvED0xyYHks2iJfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKN1NXPUbr2EOzDJBq+C9eQU6X11GMya/jMDSzhxW1sKDQi7seCs+gdTkNVtHys2M
	 1iXNSBTrSLZndNDtku/2q1+E1SD/IdH4oy8dk3+rBTFTntPUywLErfUTGlpAVRrmve
	 xR+DyAtZ5nVWJV232x6qoHW93wpnJQwqXEn6IzXOcOJp87Af16qrmLfWCJ9YG5UchI
	 TIQe/f2Tz5QY9IotLH73yRJ8EUzBsHhN3APzDSk8FQO2hlyHWN2N/78J20QuvNvq4t
	 OK37EXiAj0R4XLy1XONwnpxCCeHrFuFtHm9NWCMx2GTKr1Iv1Uq3eHH5yhOCEmyQIN
	 CEpnfkRt6LoYw==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org,
	Yury Norov <ynorov@nvidia.com>
Subject: [PATCH for-v7.5 3/5] rcu: assert static storage for RCU sync and SRCU definitions
Date: Thu, 12 Nov 2026 19:49:42 -0500
Message-ID: <20261113004946.2758197-4-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113004946.2758197-1-jfern@kernel.org>
References: <20261113004946.2758197-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <ynorov@nvidia.com>

DEFINE_RCU_SYNC() contains a statically initialized wait queue. SRCU
static definitions similarly rely on persistent lockdep keys and, in
Tiny SRCU, a statically initialized work item.

Add ASSERT_STATIC_STORAGE() to DEFINE_RCU_SYNC(), both Tree SRCU
__DEFINE_SRCU() variants and Tiny SRCU's common DEFINE_SRCU() declaration.
This covers the non-static FAST and FAST_UPDOWN wrappers too. Tiny SRCU's
explicitly static declarations already enforce the required duration.
The existing per-CPU restrictions on Tree SRCU declarations still apply.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 include/linux/rcu_sync.h | 4 +++-
 include/linux/srcutiny.h | 4 +++-
 include/linux/srcutree.h | 7 +++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 3860dbb9107a..c10b6d30561a 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -10,6 +10,7 @@
 #ifndef _LINUX_RCU_SYNC_H_
 #define _LINUX_RCU_SYNC_H_
 
+#include <linux/compiler.h>
 #include <linux/wait.h>
 #include <linux/rcupdate.h>
 
@@ -48,6 +49,7 @@ extern void rcu_sync_dtor(struct rcu_sync *);
 	}
 
 #define	DEFINE_RCU_SYNC(name)	\
-	struct rcu_sync name = __RCU_SYNC_INITIALIZER(name)
+	struct rcu_sync name = __RCU_SYNC_INITIALIZER(name);	\
+	ASSERT_STATIC_STORAGE(name)
 
 #endif /* _LINUX_RCU_SYNC_H_ */
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 47a368f945e3..82901b45c9e1 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TINY_H
 #define _LINUX_SRCU_TINY_H
 
+#include <linux/compiler.h>
 #include <linux/irq_work_types.h>
 #include <linux/llist.h>
 #include <linux/swait.h>
@@ -56,7 +57,8 @@ void srcu_defer_drain(struct irq_work *irq_work);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name);	\
+	ASSERT_STATIC_STORAGE(name)
 #define DEFINE_STATIC_SRCU(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 93b76e543894..332d228da270 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TREE_H
 #define _LINUX_SRCU_TREE_H
 
+#include <linux/compiler.h>
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
 #include <linux/irq_work_types.h>
@@ -228,13 +229,15 @@ struct srcu_struct {
 								      fast);			\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
-		__section("___srcu_struct_ptrs") = &name
+		__section("___srcu_struct_ptrs") = &name;					\
+	ASSERT_STATIC_STORAGE(name)
 #else
 # define __DEFINE_SRCU(name, fast, is_static)							\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name =							\
-		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data, fast)
+		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data, fast);		\
+	ASSERT_STATIC_STORAGE(name)
 #endif
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, 0, /* !static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, 0, static)
-- 
2.54.0

