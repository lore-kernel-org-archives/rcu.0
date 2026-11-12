Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490657;
	b=WFCnfvAyAw53KV7mnmgmeV8Fk7nj2pWSIXrTcdbLQBUN/thr8d/hLjNGJydoEzvnHMsV
	 1NoiEymjiA4KRJmGHrnutmv+g+puLlyXSCMw6rNUQOyLVCQRW/jVbd9P1OOOAM8fMDozp
	 oWSIhqGjc289ct0JX6QqNurClJK5/uBWMAq91Lb0FvM1y1h4G7G6c7pIp1cSIUR3H1zXk
	 p2JqNiW6cRgDYOE7Nxo4EXbw5NHB9bKn6xyvcy3SxP8w7DE6YECLn0U97r4PIohSsMvqY
	 sMsDsMJhDDFOlUz4wNEVM4vNWJZe0zdtWe+pt7Z/6IX+TOUBwu+etv1UXM0Psl7amEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490657;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=twaJc06QDXsiwYuuU3tYSAMo5HciDlzdWKVvoXuY788=;
	b=Ka3tctGa/fUujsLMimofsTPgTrO5FpEAFgb31RPs2olfoFxuX/20A2BWIM1jzOh8w6/E
	 s1qD5wxby0YSmLyLwW6oXQewcWHRq2k9b/oMsvhgH5FDRpxYUmBR0uxmJh5opVq+PTbi0
	 XYO3v5UN4bcOKx8dPVDkQ5/UPACAvKFjlvKqDg6sWIOgLqwnJnM+FSNSndtwhSAtY1PLm
	 Epjqla3iLwo2AmXMVBQVUYW0m1S/gK8u/Ije4sDM/oDJhGHESnsXc6vuMMHLPCZwKtXR9
	 ugBKuSKnesG6ygtdrS/qxu0WpjlvoR7mo52YAxTtpoKw+muEN8M0so5balxdnjBi6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=W9n31ELd;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53A606A884;
	Thu, 12 Nov 2026 13:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E53A606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=W9n31ELd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794490655;
	bh=twaJc06QDXsiwYuuU3tYSAMo5HciDlzdWKVvoXuY788=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9n31ELdKlLKxqmOF7KJDRmGTp7wbtVIcKIay18fhXItm0XhjHMYwQQRbAi0ZJhDS
	 mlb6d9QnWPkB3j3Etx+PZ6IObW9m+TZM4lWbpcNXl0z7hyx83DiJvV8pzpKh/JPqPV
	 J0mhTCIhPTUmXkd9SU8fvD0y8vTrOnuN7HRX9W/rM4OSFQ2MRnVkQCvfEGFd6FodPd
	 nM7VGPosB3ttwkFnOH+VNx07swg4Zg0K/cPkMg8A1Sae963q9+htW3v+n+UhBZhUoP
	 sn0HrZ4awijh0XMbKMwg2l2wFk5Iyz2Lj2kycdcIYo1VbXvWs/b5ahv9F5qy5kcOBS
	 lYvrT1zm2nWOQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQLzg4wNKzN5n;
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
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 4/7] srcu: Add irqsave variants of the atomic SRCU readers
Date: Thu, 12 Nov 2026 08:37:28 -0500
Message-Id: <20261112133731.127221-5-mathieu.desnoyers@efficios.com>
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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
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

