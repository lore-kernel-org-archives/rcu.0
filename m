Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409198;
	b=k4Vj/9WyzCRXRq4qr65hOyekZPzso1oXppqA2UdKwHpwkmee8VreU+WbWkGYL4rB7i/s
	 OPNgJi0N6xq3i/KEZqU+kAgiWA8vo9tSNKiHvjNYYPzozhEM0J4JvptRMEXJ86TxMXmqv
	 Q06wyGfBoYclFYukvS339wCHa1oqqpjsz8FD1TZ9EBMUB7Lw0dZA5c6k1Uofo8jKzf8Fw
	 059D/vK+DRBYGIXhhTIy6NUuf4y4v7pnRh0Gh4ZAzrHxcWMVghOlQrWmkKJTj6pLYM6Yj
	 jXV9Wp1b0J2pgoTN+5hRE3eGckOWkS4RfcP0PG1fkdyk+5rYDINEKn3n5XSHmDb/NeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409198;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GKurPDAOZ+T3nOWa3yKlJpxNDqqn2BpXamQouxQaMNk=;
	b=qwhGod1JTphniVIaNPMKygarwBx7/3uEoFa0klDMhxbJc0el0BVZ7woNRvxNCClZUWEW
	 +cb9yAPfAwED/uc/htFUtcSP/wDvoUfZBljkiGIha22NubfSr2jfoEPZCo8DtecQNQ3+G
	 3LO93cPL8l1Wr0Gq/ntRhL1HBEveQzDKr/sWuCaDkaGt0anDc64gdCEfoOGu3zDLI71EF
	 2UEE0Q1c+Hxq9UKDFj9cLsxc03QNQpjRYuvVE7i9c36nJ1Dfuo5mj58v/aEzbHeXBdDvR
	 OUn57vscWBOfOR8b88oPl2vIzlHp3cZVQ9pRqRwzT7d/uao9H/Tv0jxxeWJbg0wnNdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=FDICFRJu;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76254606A33E;
	Wed, 11 Nov 2026 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76254606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=FDICFRJu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794409197;
	bh=GKurPDAOZ+T3nOWa3yKlJpxNDqqn2BpXamQouxQaMNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDICFRJuiDPiXLCjSy6ctJChWLRir4vSR92Nbo8F1ZlKqcBu7QA2WblopfGqeWzo9
	 qAQ1rfvwyR+rOl5xHWBa0tFgezJ73iA7z2Q0Lkzc93x2qdVZTll6iRsQ+qB8cTZSjb
	 bIipFgzhj0VNfNQ5yDGQhcsU5UeWqWzWdlMJ7qr4cqRdfGVjsVngyxhyvYna97F0L3
	 i7UNMD8zzRIzgmgnfeYWDhlvYzNaegN7Dw0hnO4FPIhjSMDS4X+36BAivimdyIxO93
	 NZRSM3mVor/7jA0/EsFJUwcv0Varm/fIY2bCFHd1RGvkkJVB/TXfVi/2DvlHwu3RcR
	 JWbyXgmsn0JZw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPms951FNzNkj;
	Wed, 11 Nov 2026 09:59:57 -0500 (EST)
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
Subject: [PATCH v2 3/7] srcu: Make atomic SRCU readers NMI-safe
Date: Wed, 11 Nov 2026 09:59:45 -0500
Message-Id: <20261111145949.70845-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
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

