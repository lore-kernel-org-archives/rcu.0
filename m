Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490656;
	b=FPViNl8dP6Pef4x+KlhfZLHZsXiUCnG8HVdbAsPlDH9GecJ0Q3140nMJa2UDf+FOz4VK
	 pNnLI3yVIuLC/nfP/yKTzpEpCl/Xn5U7/TOSPwh0MCjRPdtE3CnvDjOwBVUyVn72wsxGX
	 wsE2FYsTdD87OYvGjdYEfkAvkQssoohft9LDCKaIVhXKd6wb/XKL2vSsbJ1TpuMnmGqxh
	 i/G1x0sNt0n1c5HFMYU1010Oj0VU9eze5yYR+DoOMwNIGOvjkyT97miNUPDaTNAmSUcM6
	 YzHbDzgpBMccKOslFQQvRxUr5Q08Ap66bZpMzmvTK4le2jCalK5NvebPdhGPsny1F7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490656;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZM+oP3R40A9RyJq1NTdN9fuN4MA+z/poc7Aw0lCy0ms=;
	b=szBGmk8q5HRzhRBBvTe+15xW+mxpMdLu3H2To4lDnJ3pdWiMBSOLdPzKs8CrphFCgKJA
	 jDH16oYyJZE2lR7EWQGj9JVLEFK2G6zPRNUZqH9/15NnIynmYoi1wXXqoRSpZcN2xJvEC
	 ye9aX+a3va00m5WgJbI/gw44UyQNuwJpqxVN+GMPrq1yX2ipOdUKlvrJHCxOkudVakKY0
	 uiS9qQz/eE039GPV5NkQXpjv8cCqB8W82shykoa7w/WVnffKVVhnDCpOWGtpvE7Y3dgup
	 qk2Q2a0dbqnRlP6s+LD5ZIUYI5ZAuvuEbY8rBB6EjvK3pDicXz/iYab+NobtMIgJAeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=mx5T5D5o;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57653606A323;
	Thu, 12 Nov 2026 13:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57653606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=mx5T5D5o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794490655;
	bh=ZM+oP3R40A9RyJq1NTdN9fuN4MA+z/poc7Aw0lCy0ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx5T5D5oNRl4Mhx9wFjarkIFRlDnzImJgwuQbCH4mWcfevkANz7fojPynjQGBCQNZ
	 EepYITo76oWeNfBGxjad60DHcrrJjfJLS5iMsA8AX720cEtHDS0dhCl70SJPBkPRu0
	 J9lVeGJlPDDji//ntDtLjqAxISdGjQxmeFfnhEgk76cQm0yGuTq0C2pqpPRGo1/sYk
	 BwbPqI19mJjtk/MbD8BL/68upyGUgONmUAwm9hGL/QWZrnT+rE2mQokiv1bzQH3aS3
	 WmUe7l1XbBXTvyD9X/og9NQfFmdL16wnkGJM1fO0dJGHUSxaD+l4LmQ0dyKFHuEOnG
	 1yjDt6WBOy4qw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQLzg3qS2zN5m;
	Thu, 12 Nov 2026 08:37:35 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3 3/7] srcu: Make atomic SRCU readers NMI-safe
Date: Thu, 12 Nov 2026 08:37:27 -0500
Message-Id: <20261112133731.127221-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
References: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
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

Atomic SRCU readers count themselves with __srcu_read_lock(), whose
this_cpu_inc() is not NMI-safe on every architecture. With
CONFIG_PROVE_RCU, which lockdep enables, __srcu_check_read_flavor() also
warns when an atomic reader runs in NMI. So an NMI handler cannot use
atomic SRCU, while a tracer or a BPF program may need to read a
structure that atomic SRCU protects.

Count atomic readers with __srcu_read_lock_nmisafe() and
__srcu_read_unlock_nmisafe() instead. They use NMI-safe increments on
the architectures that need them, and keep the full barriers that
synchronize_srcu_atomic() pairs with. The __srcu_read_lock_fast()
helpers have no such barriers: they rely on a grace period that calls
synchronize_rcu(), which synchronize_srcu_atomic() cannot do while it
spins.

Also accept the atomic flavor in NMI in __srcu_check_read_flavor().
Annotate an atomic reader in NMI as a trylock for lockdep, as
srcu_read_lock_nmisafe() does. An NMI can interrupt lockdep itself, and
lockdep then reports any other acquisition of a lock that a grace
period has used.

On the architectures that need NMI-safe counters, every atomic reader
now pays an atomic increment at lock and at unlock.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Kunwu Chan <chentao@kylinos.cn>
---
 include/linux/srcu.h  | 18 ++++++++++++++----
 kernel/rcu/srcutree.c |  3 ++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index d4dcaeb83e2b..e3b541ceb8dd 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -93,7 +93,7 @@ int init_srcu_struct_atomic(struct srcu_struct *ssp);
 //					0x04		// SRCU-lite is no longer with us.
 #define SRCU_READ_FLAVOR_FAST		0x04		// srcu_read_lock_fast(), also NMI-safe.
 #define SRCU_READ_FLAVOR_FAST_UPDOWN	0x08		// srcu_read_lock_fast_updown().
-#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic().
+#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic(), also NMI-safe.
 #define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN | \
 					 SRCU_READ_FLAVOR_ATOMIC)
@@ -372,6 +372,9 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)
  * The lock and matching srcu_read_unlock_atomic() must be invoked on
  * the same CPU, from the same context; passing the return value to
  * another task is not permitted for this flavor.
+ *
+ * This function is NMI-safe, in a manner similar to
+ * srcu_read_lock_nmisafe().
  */
 static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
@@ -391,8 +394,15 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
 	if (in_task())
 		non_block_start();
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
-	retval = __srcu_read_lock(ssp);
-	srcu_lock_acquire(&ssp->dep_map);
+	retval = __srcu_read_lock_nmisafe(ssp);
+	/*
+	 * An NMI may interrupt lockdep itself.  Annotate it as a trylock
+	 * there, as srcu_read_lock_nmisafe() does.
+	 */
+	if (in_nmi())
+		rcu_try_lock_acquire(&ssp->dep_map);
+	else
+		srcu_lock_acquire(&ssp->dep_map);
 	return retval;
 }
 
@@ -599,7 +609,7 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
 	srcu_lock_release(&ssp->dep_map);
-	__srcu_read_unlock(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 	if (in_task())
 		non_block_end();
 	preempt_enable();
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8075da4b1bb5..8fa366861dcc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -828,7 +828,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 
 	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
 	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
-		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
+		     read_flavor != SRCU_READ_FLAVOR_FAST &&
+		     read_flavor != SRCU_READ_FLAVOR_ATOMIC && in_nmi());
 	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
 
 	sdp = raw_cpu_ptr(ssp->sda);
-- 
2.47.3

