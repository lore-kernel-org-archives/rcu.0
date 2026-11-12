Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490658;
	b=3qBUxoFmVRAhpo9veE6k4/LKgj5wOTYw9K/BbzGAthi6Q/A6XdIbjHXh37DBLmfDJpIl
	 tcF/g9tkTGxlbUf8PY5K62DTtMwAMkyjmZ2ltWFq2Ooc5yF4LRwH1QalRqm0SupUo92zD
	 mM/fiQn6SYy5mf4AYUnWSynbxOMfGUz9m9yG4jfRLNgaYd6n6jvCLwvZKOFZURmWjG/F7
	 2qth3IQMMw2GlqoRYdeVDfJU18mnUIfVYzo/q16Wo8pbsJ7WePWL7GWl+aw5aEXrAd6Pj
	 9ghVVVte8P5gegzPrCzTNUrn87IIwW3AbuHcbEh7AZF5UaWIdfCtS1BWY5tLtR9nLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490658;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0iKL/e14uzr9Dhe40pD56SKtcf7y7/nxw69dEEtpKMc=;
	b=wEp7m0au/8t0uWUv5aoaTA4Fv4sF6oicuXgg6DwaiLwN97lgrFkXgJBe3ZbuZ4YjoV61
	 QQpxFnRS/WisGXhc5sx9VFP/+YRDiI/E5LhBqcB65S2wnuQBeMBB+mSuOtswBrIg/n9oT
	 dndDIEy4uFNscllE7kJRaRcUvIGUPnjNIT/Y3T6sz9K58/WQ1zSkDEiMoqADyw+rpSeVg
	 kUNQ69ZLk8cwweO/MVJnlOu8OK9cFlC9HAQZqw9UvVXg3Sp45HA8FGgpof025FEW/gsJ0
	 CEhjoKdnU2umcr0PJt90dj1Zn6Dn6zJxIN79mg/1tglv5ywyK1QxBxr6old8bcg4vwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=TzK5ZLwf;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900FB606A89D;
	Thu, 12 Nov 2026 13:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900FB606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=TzK5ZLwf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794490656;
	bh=0iKL/e14uzr9Dhe40pD56SKtcf7y7/nxw69dEEtpKMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TzK5ZLwfI0CxyTmdl+yITjdBTNOTBQyteEQ7Qch5UlvpaYAVoxd8mp0EbNhF/kahj
	 nc5RxBHbPPXG/MsTxNwUnIR9Z8h/3MygZS7VaFvOW9ZcmNuojWhISy8JaJ+v26iVK3
	 gPwkNUDZWewv5tVW5KgZkYxvXGyEB34oZubrMbwfYMS6OicvFSW1EdOQd60k44+a5z
	 K87+B+LHXM0R38ZPBkYezOZuNxwavpevoPxhYeMVpzBMHQZHmcMjWFNABoLcj5ezpo
	 UmNBR4tgcj5/fuNK+axa6DAmOifRTQqw/UEMzoJ7/FNVqT2NRabHAbYBnc+F0LtWXj
	 EYvTsXHx8IFOg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQLzh04vlzP5w;
	Thu, 12 Nov 2026 08:37:36 -0500 (EST)
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
Subject: [PATCH v3 6/7] rcutorture: Test the irqsave forms of atomic SRCU readers
Date: Thu, 12 Nov 2026 08:37:30 -0500
Message-Id: <20261112133731.127221-7-mathieu.desnoyers@efficios.com>
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

Nothing tests srcu_read_lock_atomic_irqsave() and
srcu_read_unlock_atomic_irqrestore(). Testing them in the normal readers
has two obstacles. rcutorture_one_extend() ends the readers of a CPU in
any order, but each irqrestore restores the state its own irqsave saw.
A reader extension may also enable interrupts or bottom halves within
a reader, which an irqsave reader forbids.

Add an atomic_irqsave module parameter. With it, the atomic readers of
each CPU alternate between the plain and the irqsave forms. A per-CPU
count tracks the irqsave readers: the first one saves the interrupt
state, and only the last one restores it. The others restore the
current state, with interrupts disabled. The irqsave readers run only
for a torture type without reader extensions: every srcu type but
busted_srcud. The parameter also stops readers from ending under
->pi_lock, which would enable interrupts under a raw spinlock.

An irqsave reader checks that interrupts are still disabled when it
ends.

Add an atomic-srcu-irqsave run of SRCU-P to torture.sh.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kernel/rcu/rcutorture.c                       | 80 +++++++++++++++++--
 .../selftests/rcutorture/bin/torture.sh       |  6 ++
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7773862b06b5..e177a94da14e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -61,6 +61,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 #define RCUTORTURE_RDR_MASK_1	(0xff << RCUTORTURE_RDR_SHIFT_1)
 #define RCUTORTURE_RDR_SHIFT_2	16	// Put SRCU index in upper bits.
 #define RCUTORTURE_RDR_MASK_2	(0xff << RCUTORTURE_RDR_SHIFT_2)
+#define SRCU_TORTURE_IRQSAVE	0x80	// In an SRCU reader index (MASK_1 or _2):
+					//  the atomic reader disabled interrupts.
 #define RCUTORTURE_RDR_BH	0x01	// Extend readers by disabling bh.
 #define RCUTORTURE_RDR_IRQ	0x02	//  ... disabling interrupts.
 #define RCUTORTURE_RDR_PREEMPT	0x04	//  ... disabling preemption.
@@ -134,6 +136,8 @@ torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions
 torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
 torture_param(int, reader_flavor, SRCU_READ_FLAVOR_NORMAL, "Reader flavors to use, one per bit.");
+torture_param(bool, atomic_irqsave, false,
+	      "Atomic SRCU readers alternate per CPU with irqsave readers");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -732,6 +736,69 @@ static void srcu_torture_init_forbidden_apis(void)
 	cur_ops->start_gp_poll = NULL;
 }
 
+/*
+ * With atomic_irqsave, every other atomic SRCU reader of a CPU disables
+ * interrupts instead of preemption.  rcutorture_one_extend() may end the
+ * readers of a CPU in any order, so the first one saves the interrupt state
+ * and the last one restores it.  No extension may enable interrupts or bottom
+ * halves within such a reader.  So the irqsave readers run only for a torture
+ * type without extendables: every srcu type but busted_srcud.  No reader may
+ * end under ->pi_lock.
+ */
+static bool srcu_torture_irqsave_on;
+
+struct srcu_torture_irqsave {
+	unsigned int count;	// Picks the form of the next reader.
+	int depth;		// Readers of this CPU that disabled interrupts.
+	unsigned long flags;	// Interrupt state before the first one.
+};
+
+static DEFINE_PER_CPU(struct srcu_torture_irqsave, srcu_torture_irqsave);
+
+static void srcu_torture_init_irqsave(void)
+{
+	if (!atomic_irqsave || !(reader_flavor & SRCU_READ_FLAVOR_ATOMIC) ||
+	    cur_ops->extendables)
+		return;
+	srcu_torture_irqsave_on = true;
+	cur_ops->no_pi_lock = 1;
+	VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU, irqsave readers");
+}
+
+static int srcu_torture_read_lock_atomic(void)
+{
+	struct srcu_torture_irqsave *stip;
+	unsigned long flags;
+	int idx;
+
+	if (!srcu_torture_irqsave_on || in_nmi() ||
+	    !(this_cpu_inc_return(srcu_torture_irqsave.count) & 0x1))
+		return srcu_read_lock_atomic(srcu_ctlp);
+	idx = srcu_read_lock_atomic_irqsave(srcu_ctlp, flags);
+	stip = this_cpu_ptr(&srcu_torture_irqsave);
+	if (!stip->depth++)
+		stip->flags = flags;
+	return idx | SRCU_TORTURE_IRQSAVE;
+}
+
+static void srcu_torture_read_unlock_atomic(int idx)
+{
+	struct srcu_torture_irqsave *stip;
+	unsigned long flags;
+
+	if (!(idx & SRCU_TORTURE_IRQSAVE)) {
+		srcu_read_unlock_atomic(srcu_ctlp, idx);
+		return;
+	}
+	idx &= ~SRCU_TORTURE_IRQSAVE;
+	WARN_ON_ONCE(!irqs_disabled());  // Its section must be interrupts-off.
+	stip = this_cpu_ptr(&srcu_torture_irqsave);
+	local_save_flags(flags);  // Disabled: keep it so for the other readers.
+	if (!WARN_ON_ONCE(stip->depth <= 0) && !--stip->depth)
+		flags = stip->flags;
+	srcu_read_unlock_atomic_irqrestore(srcu_ctlp, idx, flags);
+}
+
 static void srcu_torture_init(void)
 {
 	rcu_sync_torture_init();
@@ -751,6 +818,7 @@ static void srcu_torture_init(void)
 		srcu_ctlp = &srcu_ctla;
 		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
 		srcu_torture_init_forbidden_apis();
+		srcu_torture_init_irqsave();
 	}
 }
 
@@ -790,9 +858,9 @@ static int srcu_torture_read_lock(void)
 		ret += idx << 3;
 	}
 	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC) {
-		idx = srcu_read_lock_atomic(srcu_ctlp);
-		WARN_ON_ONCE(idx & ~0x1);
-		ret += idx << 4;
+		idx = srcu_torture_read_lock_atomic();
+		WARN_ON_ONCE(idx & ~(0x1 | SRCU_TORTURE_IRQSAVE));
+		ret += ((idx & 0x1) << 4) | (idx & SRCU_TORTURE_IRQSAVE);
 	}
 	return ret;
 }
@@ -832,9 +900,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
 static void srcu_torture_read_unlock(int idx)
 {
-	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	WARN_ON_ONCE((reader_flavor && (idx & ~(reader_flavor | SRCU_TORTURE_IRQSAVE))) ||
+		     (!reader_flavor && (idx & ~0x1)));
 	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
-		srcu_read_unlock_atomic(srcu_ctlp, (idx & 0x10) >> 4);
+		srcu_torture_read_unlock_atomic(((idx & 0x10) >> 4) | (idx & SRCU_TORTURE_IRQSAVE));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
 		srcu_read_unlock_fast_updown(srcu_ctlp,
 					     __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
@@ -1019,6 +1088,7 @@ static void srcud_torture_init(void)
 		WARN_ON(init_srcu_struct_atomic(&srcu_ctld));
 		VERBOSE_TOROUT_STRING("srcud_torture_init atomic SRCU");
 		srcu_torture_init_forbidden_apis();
+		srcu_torture_init_irqsave();
 	} else {
 		WARN_ON(init_srcu_struct(&srcu_ctld));
 	}
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e7b578ec152f..18a03fad1038 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -519,6 +519,12 @@ then
 	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
 		--allcpus --duration "$duration_rcutorture" \
 		--configs "$configs_atomic_srcu" --trust-make
+
+	# Half the readers then use srcu_read_lock_atomic_irqsave().
+	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1"
+	torture_set "atomic-srcu-irqsave" tools/testing/selftests/rcutorture/bin/kvm.sh \
+		--allcpus --duration "$duration_rcutorture" \
+		--configs "SRCU-P" --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
-- 
2.47.3

