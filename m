Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409199;
	b=lLgkS43+80GhIBtL5TOc+0jcCUzSXY+5oM0qTmY/29G8EuL76mUjZaMQs0s4Rvpy+4lK
	 H9kPMxubKwp87r633W9tuNu+ch0jWwwUmbFi0qqM96yMaRgt92ls0g8iS76TR5ZvmvN0K
	 hqY9PZR+3L1BtxpWBTjCwb6WK0m20dlLkKDTkDyN/38P2mILvIDMDnB6fjblfZmwGzuMQ
	 rAhGi64sABQidc6lRcyU4VTI85+TZRJoAiaWi6TTlMFOG04nZQl1TGaZjFjYjm4tavqFt
	 7AldBQKbgbkqi4iPOxfXBo13lIO3/zkCoNH/6u9mSqehd52myQ/Jvwnf+88NEMw3/BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409199;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GGgoUm9zsWSiRU5uF6nIaDWAlte8dUdT5DAhAr4Yf+I=;
	b=1h+fUKADl+ewHZy5chtOnIG+W2UWve8Y+5YYTCtoL7tfiH4qv82ZNmUsmfDME1jJWmIW
	 uEmot7/Ld9VhzKiyCyFHY3jLUqcfK9uU7cjHhAgDCaAB32WuoKMA4OG0HPyzGvM0fSeZj
	 KxBNa3uSdDDZfdnw0fUYdLtdfPeupH3dYBVbFkmgqHPC2UPFbeTDvSzo3G8OIej5PL8RH
	 rCnxlX+BXuJ3k2j3WCq4ab7w/2mSM8eAZ2BhKfSi9xT+RJUeC3XUHmbOtErduF7CM0HpI
	 T5hcKeOTWOlKdzL5kKVYxDfAZl0i75c5kpYBhtEAX3RNQRrYo5mG0mucRxIVdYKPnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=v9n5v8wc;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C21606A332;
	Wed, 11 Nov 2026 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C21606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=v9n5v8wc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794409197;
	bh=GGgoUm9zsWSiRU5uF6nIaDWAlte8dUdT5DAhAr4Yf+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v9n5v8wcAIiagjzBnJdSUKlcXCdrOJLtOQUjcbsyCybV8D0vx9cXqtiva2/CvtQ6V
	 hF6HzdxCedMzNbVWDnsUtsMbxoStp7FAooFRwINsNCzPor5LNrkewuRIha+ljsLc8p
	 pgby7QIOc7xGKCgli9wepFlApMCPj9iPvyrJOo56X7exlHHfBWpk9ECBRCUyb2HGrw
	 HcJO/vKnH/2r1z4u2Sve4wmdqUrbP4hFCFE2/9Pxu7DnXDMBpQ2ljVOB7/tyGlDl55
	 c8m8VUNmkWRG3z/PXdjFPiT6DOFu3dkqS3cWM4nqRPqDmubLbFZZASJw/oXtBFfR25
	 1wyyPScQLGnkg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPms93xt2zNgj;
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
Subject: [PATCH v2 2/7] srcu: Rule for using synchronize_srcu_atomic() from interrupt handlers
Date: Wed, 11 Nov 2026 09:59:44 -0500
Message-Id: <20261111145949.70845-3-mathieu.desnoyers@efficios.com>
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

This is about the update side.  A user that calls
synchronize_srcu_atomic() from an interrupt handler must disable
interrupts around all its calls on that srcu_struct, task context
included.  Document this rule, and warn when it is broken.  The rules
for readers are unchanged.

synchronize_srcu_atomic() spins rather than sleeps, so it may be called
from atomic context, interrupt handlers included.  Its callers on one
srcu_struct exclude each other with ->srcu_atomic_gp_flag.  One of them
drives the grace period.  The others spin until a grace period ends.

The flag owner disables only preemption.  So an interrupt can arrive on
its CPU while it holds the flag.  If that interrupt handler calls
synchronize_srcu_atomic() on the same srcu_struct, it spins forever:

  CPU 0, task                        CPU 0, hardirq
  synchronize_srcu_atomic()
    takes ->srcu_atomic_gp_flag
                                     synchronize_srcu_atomic()
                                       spins until a grace period ends
                                       it never ends: its driver is the
                                       task this interrupt interrupted

Nothing reports it.  lockdep cannot, because lock_sync() records no
interrupt state.

synchronize_srcu_atomic() cannot disable interrupts itself.  A reader
that disables only preemption may wait for an IPI to the waiter's CPU.
That IPI never runs while the waiter spins with interrupts disabled.
The kernel-doc already lets the caller choose the waiter's context.
It then asks the readers to run in that context, or a stricter one.

So the caller disables interrupts.  The existing reader rule then
requires the readers of that srcu_struct to disable interrupts too.

Also store the owner's CPU number plus one in the flag, instead of 1.
A waiter that finds its own CPU as the owner warns once, rather than
hanging silently.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rcu/srcutree.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2b0e2b2d2c18..8075da4b1bb5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2108,6 +2108,13 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
  * and srcu_read_unlock_atomic() must be invoked from that same context,
  * or one that is even more strict.
  *
+ * If synchronize_srcu_atomic() is invoked from an interrupt handler for
+ * a given srcu_struct structure, then for that structure, all calls to
+ * synchronize_srcu_atomic() must be invoked with interrupts disabled,
+ * including those from task context.  Its callers take turns to drive a
+ * grace period, and the others spin until it ends.  An interrupt handler
+ * that calls it on the CPU of an interrupted caller would spin forever.
+ *
  * If synchronize_srcu_atomic() is invoked on a given srcu_struct
  * structure, then none of call_srcu(), synchronize_srcu(),
  * synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
@@ -2144,7 +2151,13 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	srcu_state = get_state_synchronize_srcu(ssp);
 	preempt_disable();
 	while (atomic_read(&sup->srcu_atomic_gp_flag) ||
-	       atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
+	       atomic_cmpxchg(&sup->srcu_atomic_gp_flag, 0,
+			      smp_processor_id() + 1)) {
+		// The flag holds its owner's CPU number plus one.  An owner on
+		// this CPU is a caller that this one interrupted.  It cannot
+		// release the flag, so this caller would spin forever.
+		WARN_ON_ONCE(atomic_read(&sup->srcu_atomic_gp_flag) ==
+			     smp_processor_id() + 1);
 		preempt_enable();
 		if (poll_state_synchronize_srcu(ssp, srcu_state))
 			return;
-- 
2.47.3

