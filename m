Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409199;
	b=tqAPlGjbShoP1+/A2fBozZcW8ndvpuQLCExNZ8AWkASM1HZKwNhFAou73ifKJlgWvzfL
	 71EjNl+3ycm1/Qyt5VTJn4keK0Uufn0tGK+/u/R8GWPtz37r1cZcbByybuoqY+pHsBoBf
	 L9DCl80qz5s0B+3QCKICmgs3sRNIpm8sS+U7vxKLQpGP2t9FhyXFB9399T7h3TD75UIuW
	 b+HbhQsBVPRCua2/d4JbhTvzvFamSOHPqruay/tY3UK5Emhy6/h5SnK6+7VhIK8Fgmq8i
	 8AIIj49vlno1AjK2tcQDUiaWsszIOvR2pZVo2VqFSeNs8MIU8wNxw0skCmw28jpjH8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409199;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mp91bdbni8GZDIBtClgcwxl0ov59ummE1gxOxhSJsjY=;
	b=M/3Rx6Ltc376cy85tMnHTU5q7TrPr/EwB8WzI0V5fvftETmYB3o5+iWk1QBPB8KQx4UG
	 0/dV9AlF4+kCHBG0hlM+ncKdMmYQv03MFLpd/Z0bhONFk722MsEEQIznZaX8T1CPKl2xA
	 3EMDrVQh2xaDICzfhH9HHti1Kp7Tzj1UL3IlPh5meTpYcV1zrVWTOyj/RoUcSY92i0ahp
	 PkzDQInfK+kUDJtMyYk09GpjnITSl2ZcRJb/n3dgA6dueemHAJfAw7nXMLcL6YK+IPQ49
	 JN6tV8/5UhvQ66M7/0P9bb+pLAu4xPykNBaFtwYU5zqbWfPTPVouLzdA5j1aWZS13YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="qci/iEt5";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C662606A882;
	Wed, 11 Nov 2026 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C662606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qci/iEt5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794409197;
	bh=Mp91bdbni8GZDIBtClgcwxl0ov59ummE1gxOxhSJsjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qci/iEt5nov/NU/dtH1JBlwHhrWC6FoIxfbXLjHDNPKM7UvWdR6pOPa60u80qOLKH
	 OWAwdqq6axGk371VZpMmHC4MgkXRkj5m/RnmifgXKhZTmcnLyJJusb5Er3bEomJUsv
	 SK5xYTJa02y1H/9v25gspM/Lj/Ea+7x+Rco7G+JTeSi42EuJOKuOpa5pvFn/3qMnhw
	 hWHaKQZCR7SG2tgWQjvJjbij7QZfZyaSbRfwRmBtCUfcOxWWPf+2/Sm9q+zancj2RO
	 t3AP+IdoT3uRItA/3BLGtEUy1kULbbavPcJtIM3xHASooslVJqXoZV6wVeOsF/eYBH
	 scjczYS/7ixeA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPms963qDzMxb;
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
Subject: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU readers
Date: Wed, 11 Nov 2026 09:59:46 -0500
Message-Id: <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
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

synchronize_srcu_atomic() may be invoked with interrupts disabled, for
example under a raw spinlock. Its kerneldoc then requires every reader
of that srcu_struct to disable interrupts too. srcu_read_lock_atomic()
only disables preemption, so such a reader has to disable interrupts
itself around it.

Add srcu_read_lock_atomic_irqsave() and
srcu_read_unlock_atomic_irqrestore(). They disable interrupts instead
of preemption, and keep the interrupt state in a flags argument, so
they are macros. Both forms share the rest of the reader through
__srcu_read_lock_atomic() and __srcu_read_unlock_atomic().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/srcu.h | 100 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 25 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e3b541ceb8dd..11e9ad914a71 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -357,31 +357,15 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)
 	return retval;
 }
 
-/**
- * srcu_read_lock_atomic - register a new reader promising an atomic section
- * @ssp: srcu_struct in which to register the new reader.
- *
- * As srcu_read_lock(), but the caller promises that the read-side
- * critical section never sleeps and never blocks on anything which
- * may itself depend on memory allocation to make progress. Preemption
- * is disabled for the duration, which both enforces that promise (any
- * sleepable call in the section will splat on every configuration)
- * and bounds the section so that the update side may spin rather
- * than sleep when waiting for readers: see synchronize_srcu_atomic().
- *
- * The lock and matching srcu_read_unlock_atomic() must be invoked on
- * the same CPU, from the same context; passing the return value to
- * another task is not permitted for this flavor.
- *
- * This function is NMI-safe, in a manner similar to
- * srcu_read_lock_nmisafe().
+/*
+ * Register an atomic-section reader.  The caller has disabled preemption,
+ * or interrupts.
  */
-static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
+static inline int __srcu_read_lock_atomic(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
 {
 	int retval;
 
-	preempt_disable();
 	/*
 	 * Arm might_sleep() to catch even a *potentially* sleeping call
 	 * in the section, not just an actual schedule: the atomic-domain
@@ -406,6 +390,50 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
 	return retval;
 }
 
+/**
+ * srcu_read_lock_atomic - register a new reader promising an atomic section
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * As srcu_read_lock(), but the caller promises that the read-side
+ * critical section never sleeps and never blocks on anything which
+ * may itself depend on memory allocation to make progress. Preemption
+ * is disabled for the duration, which both enforces that promise (any
+ * sleepable call in the section will splat on every configuration)
+ * and bounds the section so that the update side may spin rather
+ * than sleep when waiting for readers: see synchronize_srcu_atomic().
+ *
+ * The lock and matching srcu_read_unlock_atomic() must be invoked on
+ * the same CPU, from the same context; passing the return value to
+ * another task is not permitted for this flavor.
+ *
+ * This function is NMI-safe, in a manner similar to
+ * srcu_read_lock_nmisafe().
+ */
+static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
+{
+	preempt_disable();
+	return __srcu_read_lock_atomic(ssp);
+}
+
+/**
+ * srcu_read_lock_atomic_irqsave - register an atomic reader, interrupts off
+ * @ssp: srcu_struct in which to register the new reader.
+ * @flags: interrupt state to restore at srcu_read_unlock_atomic_irqrestore().
+ *
+ * As srcu_read_lock_atomic(), but with interrupts disabled for the
+ * duration instead of preemption.  Use it when synchronize_srcu_atomic()
+ * may be invoked with interrupts disabled for this srcu_struct: its
+ * readers must then disable interrupts too.
+ *
+ * Returns the index to pass to srcu_read_unlock_atomic_irqrestore().
+ */
+#define srcu_read_lock_atomic_irqsave(ssp, flags)			\
+({									\
+	local_irq_save(flags);						\
+	__srcu_read_lock_atomic((ssp));					\
+})
+
 /**
  * srcu_read_lock_fast - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -598,12 +626,11 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock(ssp, idx);
 }
 
-/**
- * srcu_read_unlock_atomic - unregister an atomic-section reader
- * @ssp: srcu_struct from which to unregister the old reader.
- * @idx: return value from corresponding srcu_read_lock_atomic().
+/*
+ * Unregister an atomic-section reader.  The caller then enables preemption,
+ * or interrupts, again.
  */
-static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
+static inline void __srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
 	__releases_shared(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
@@ -612,9 +639,32 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock_nmisafe(ssp, idx);
 	if (in_task())
 		non_block_end();
+}
+
+/**
+ * srcu_read_unlock_atomic - unregister an atomic-section reader
+ * @ssp: srcu_struct from which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock_atomic().
+ */
+static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
+	__releases_shared(ssp)
+{
+	__srcu_read_unlock_atomic(ssp, idx);
 	preempt_enable();
 }
 
+/**
+ * srcu_read_unlock_atomic_irqrestore - unregister an irqsave atomic reader
+ * @ssp: srcu_struct from which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock_atomic_irqsave().
+ * @flags: interrupt state saved by srcu_read_lock_atomic_irqsave().
+ */
+#define srcu_read_unlock_atomic_irqrestore(ssp, idx, flags)		\
+do {									\
+	__srcu_read_unlock_atomic((ssp), (idx));			\
+	local_irq_restore(flags);					\
+} while (0)
+
 /**
  * srcu_read_unlock_fast - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
-- 
2.47.3

