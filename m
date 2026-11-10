Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338942;
	b=gZLn5HmvgAz8BT2N8DpiUih4Wb2iIxBOs4HNKixVgY83vQkcagchjvNKgMCN4DFGWB6o
	 BHiT1xMyzHe9z8BpShVcfBNL4f4ojmENoWsnfrxhj03iMjqInqOdq9NxtQccdYALk+igW
	 oEfNkaWDLjIe5GToCQX4aks9dSVycVNSv+M3hqI8szTthBVYiwi8EgShyE+H5yeU7s1O9
	 8rjqPHHJSAocRS4Hn6WWfiQ/4YUh1CGTcz1cCpsf9qDF+S1lCph4UiMFkF+EMdiQXlA7M
	 U34yWDiGKHO3N6SJd4KkTMgTaWV9R9OxePb6oP+LuFn/mvSCzqvBLjT9PcNbW82LKmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338942;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WdVysHpiv9k2Rk32uMh5ZOlKJvP5JpLNPcRzIpV1Nls=;
	b=wX6sU8Am7DRnOqDJAxEM+MP6EBgDX5IeGLle1wjujAC3LQeKqiz3U4w40+lg1Rg7g/x2
	 rLUtbZ0Tmq2EPGncNFqWOWMFVNmhAHe0NDSEl7+CeC3jOq4LY4APJV7q9ECsAOjob8li3
	 k6b7ykSY/3lRzYZaXHfQzpvVto4MnMjcDZJf/NF6VE8hHRd0p6EwcMxn52yj4B1/JjXYd
	 KOEAqyVdHc77Qsxy4MGS0RN+k71PSUcv8M3CwnPWlHkpz0OCzcnu0cjFxRVsN8zwZDBgd
	 NjVaXiMH2xHy502zYXgcgstmu0zQdsJIVKC+lTIbKqNlZITQdvbS9DqanWUHn3/Jvcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=mxPOxszD;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E47606A32D;
	Tue, 10 Nov 2026 19:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E47606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=mxPOxszD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794338934;
	bh=WdVysHpiv9k2Rk32uMh5ZOlKJvP5JpLNPcRzIpV1Nls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxPOxszD8ugPPTvkmM3sbXDVYsv0DUQykZusO1wYvzU+/NuEaU34RFppxclAmS7bw
	 13c29tlfSd24Ibdu+z+H181HbWaFxYiyCUwjOdhvVjgdUVrjtOkdjPuAT2wwIW4cYD
	 KrSDkTZU4rDYQmtS+Cx9hXMK4Mfj7LyIIF/4XWfipwz0KZZjlIUL1EzBZFCl78aPx5
	 RJX4CMb6cwy/Ne5L6LYHtxQ93vm6dj5Z2J11GBMUno2GqVytMM5SUUSb5EpghmSPfy
	 KrC+SUmus5bM7WbNtQWVvofeZcxvHs8hh8oWz+uxuWjw3Rao56OhL0/gNYxLBb9gca
	 wWvT60OukKWqQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPGsy6DxGzNHR;
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
Subject: [PATCH 4/4] rcutorture: Test the irqsave forms of atomic SRCU readers
Date: Tue, 10 Nov 2026 14:28:44 -0500
Message-Id: <20261110192844.44713-5-mathieu.desnoyers@efficios.com>
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

Nothing tests srcu_read_lock_atomic_irqsave() and
srcu_read_unlock_atomic_irqrestore(). Testing them in the normal readers
has two obstacles. rcutorture_one_extend() ends the readers of a CPU in
any order, but each irqrestore restores the state its own irqsave saw.
It also enables interrupts and bottom halves within readers, which an
irqsave reader forbids.

Add an atomic_irqsave module parameter. With it, half the atomic
readers use the irqsave forms, alternating per CPU. A per-CPU count
tracks these readers: the first one saves the interrupt state, and only
the last one restores it. The others restore the current state, with
interrupts disabled. The parameter also removes the bottom-half and
interrupt reader extensions, and the reader end under ->pi_lock, which
would enable interrupts under a raw spinlock.

An irqsave reader checks that interrupts are still disabled when it
ends.

Add an atomic-srcu-irqsave run of SRCU-P to torture.sh.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rcu/rcutorture.c                       | 74 +++++++++++++++++--
 .../selftests/rcutorture/bin/torture.sh       |  6 ++
 2 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3b9c08a094cd..99dde988f974 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -134,6 +134,7 @@ torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions
 torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
 torture_param(int, reader_flavor, SRCU_READ_FLAVOR_NORMAL, "Reader flavors to use, one per bit.");
+torture_param(bool, atomic_irqsave, false, "Half the atomic SRCU readers disable irqs");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -728,6 +729,66 @@ static void srcu_torture_init_forbidden_apis(void)
 	cur_ops->start_gp_poll = NULL;
 }
 
+/*
+ * With atomic_irqsave, half the atomic SRCU readers disable interrupts instead
+ * of preemption.  rcutorture_one_extend() may end the readers of a CPU in any
+ * order, so the first one saves the interrupt state and the last one restores
+ * it.  An extension must then neither enable interrupts nor enable bottom
+ * halves within such a reader, and no reader may end under ->pi_lock.
+ */
+#define SRCU_TORTURE_IRQSAVE	0x20	// The reader disabled interrupts.
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
+	if (!atomic_irqsave || !(reader_flavor & SRCU_READ_FLAVOR_ATOMIC))
+		return;
+	cur_ops->extendables &= ~(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH |
+				  RCUTORTURE_RDR_IRQ);
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
+	if (!atomic_irqsave || in_nmi() || !(this_cpu_inc_return(srcu_torture_irqsave.count) & 0x1))
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
@@ -747,6 +808,7 @@ static void srcu_torture_init(void)
 		srcu_ctlp = &srcu_ctla;
 		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
 		srcu_torture_init_forbidden_apis();
+		srcu_torture_init_irqsave();
 	}
 }
 
@@ -786,9 +848,9 @@ static int srcu_torture_read_lock(void)
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
@@ -828,9 +890,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
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
@@ -1015,6 +1078,7 @@ static void srcud_torture_init(void)
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

