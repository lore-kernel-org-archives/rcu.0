Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338942;
	b=TVtBHqlO06at9dZnQ6oJKBcohmkOh+q4iN5IMSacjdIzr3k1CkmKzGH/OxaGNPNLW/yD
	 8RXonEV/o+jWgt8YZpMZbTl6p4rlJrLo4AGckVprRXNQ133E+VMFLq7w96EwbqrXOJc9B
	 7oaiubru5M1kly0FKL9/TGm20HpCMbI2JQZGR3+yxqLLIJGrnp5fLZKFrewmeUVUzikGf
	 2D+MxP9+s799s/o6jevQS9L7bo6QPWzHJTyJF6XBYaccdAwYr7n9/n6GUVHDCJ3qDJ0Kt
	 AI6f8/5S0ls3fzxd+8IfGCNWbDTxiKE3fyp88+we+48zJVkWIFAT1fHqY1eb+c4gHhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338942;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dyKcnLAvAYKtrMEMzfs0adKmhf/djCkSCIhMXt4fJbE=;
	b=jKpvoROh/eZmz1522fPEOq8y1urrnxeQZIkYxgALHKOqAxCYMFLt5oNIsJktnwmr0rtf
	 VbMNdEoc36xO9VcuXIMU8aLOaPdI2Xt7DkoAIB921XdxRLNaGdQhuQ+xguQ6lrwIKndVA
	 ugq5HIsnIHPHE3wfz4RgM5EaRWKMr/C52wRkS5IY0sqiHG8xN+et4lT4fQNCsXiaI3ilW
	 cXM1XjxwN1yseuGI2OVA301yiWXNZLbo7q65k/70Ydr1l8/0GBLI6SvRmyKEApBPBP/BX
	 zEyweisWweEl6f1hVb3rwi4u5f55cnmz3yqK5SX+mVIBul3kDhEdy/Ep6CyuSt9y+wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ZnJCOPwx;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45155606A31C;
	Tue, 10 Nov 2026 19:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45155606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ZnJCOPwx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794338934;
	bh=dyKcnLAvAYKtrMEMzfs0adKmhf/djCkSCIhMXt4fJbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnJCOPwxvM6jMh4QBIj27YZrR8mgDEE0cxmrvL4Uwyc5pJnnQwlcuD4o7BzRS5rPl
	 gP0b74zSX7oKHapGDziAyK7SXcrEcE962h0WP+jV9FvaZ1MuwUDZ9AESqTSCyrUMd0
	 lqgTNkde0Te8SSJA4lHmUqNl8TKDrw2wHix2T3Vu4QHXmwWNMm7DqWlNvEWRZLaCqm
	 J387FdhfH4IGkSSr+Sorhc0qtbEtiovGBsmjy+FMEjZFYpJJMnNT9YDJy8LzwkXkmU
	 Q3/jwp4GDs/VyljApvW5wIp0hKyP1QQvuMfRNcfn2MKEkE8b4hMqjGaQpil2fgDibF
	 STMH0ot1DiQWQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPGsy344fzNHQ;
	Tue, 10 Nov 2026 14:28:54 -0500 (EST)
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
	rcu@vger.kernel.org
Subject: [PATCH 1/4] srcu: Make atomic SRCU readers NMI-safe
Date: Tue, 10 Nov 2026 14:28:41 -0500
Message-Id: <20261110192844.44713-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
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
---
 include/linux/srcu.h  | 18 ++++++++++++++----
 kernel/rcu/srcutree.c |  3 ++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1a8a465a5650..7a338e3a63d3 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -92,7 +92,7 @@ int init_srcu_struct_atomic(struct srcu_struct *ssp);
 //					0x04		// SRCU-lite is no longer with us.
 #define SRCU_READ_FLAVOR_FAST		0x04		// srcu_read_lock_fast(), also NMI-safe.
 #define SRCU_READ_FLAVOR_FAST_UPDOWN	0x08		// srcu_read_lock_fast_updown().
-#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic().
+#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic(), also NMI-safe.
 #define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN | \
 					 SRCU_READ_FLAVOR_ATOMIC)
@@ -336,6 +336,9 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)
  * The lock and matching srcu_read_unlock_atomic() must be invoked on
  * the same CPU, from the same context; passing the return value to
  * another task is not permitted for this flavor.
+ *
+ * This function is NMI-safe, in a manner similar to
+ * srcu_read_lock_nmisafe().
  */
 static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
@@ -355,8 +358,15 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
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
 
@@ -563,7 +573,7 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
 	srcu_lock_release(&ssp->dep_map);
-	__srcu_read_unlock(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 	if (in_task())
 		non_block_end();
 	preempt_enable();
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2b0e2b2d2c18..6aebd3e31654 100644
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

