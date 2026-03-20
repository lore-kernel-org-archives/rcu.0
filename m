Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354B3CFF73;
	Fri, 20 Mar 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030451; cv=none; b=EEi5Nm+6FkaYr4t4KfLI16s2TN0OuIW0Ezlb1Orr57JCoaKnNbrcaSQJ4Apj8nSPcIsesiZ7S2Nl+25+PzPaX4mGPYWuX1HxExqQLRU58BJQlxoasz9TUr96QK0RJC2BGl86A/+ekOgMv+csRvOC5cKoMzLDRyGp1MClhd56byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030451; c=relaxed/simple;
	bh=hncUE3/G3wchEwlkqP2K6lw79bAHrT75f2KEQMgSAk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef8gcmqLfviRFEhJKhZgTVTEqJVlpzfXtb8ZaREXgYfWbl+cw/+vzPVrGa5ADwZAtaeK4g8gKGfMm5WPUVttLF1Z3MBgWk3Q85ywn+Piy1DQKnwxKzIVyQBDFmv579h6nByIuhEv3JtdJ38yqbPdwZ+T9rI65u1s94ng59hVoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgETVZxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgETVZxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC88C2BC87;
	Fri, 20 Mar 2026 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030450;
	bh=hncUE3/G3wchEwlkqP2K6lw79bAHrT75f2KEQMgSAk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgETVZxjyfeTZyEsO+U81E6HgIvtsr0EKy2latmSrvDFGMA6+TrPzOf9w7TSBoDu4
	 n1asHWrlm0r3j28fzmyp7a2Met8UFi5tqausOtGksZVKRdMwQZ6AuiOPQjXxLPqcZF
	 aFY61h6dd8yh+8obIFMI1oqu53InuCMncHp0wUyyDtpmAvEwe9McivNnyJDcvBwuvM
	 cDjNuc1OPIORPC+x3m1Oo4wdBEIvNP2CFLG08dnUV7052Kiox3wbJvgsnWqClVTZiZ
	 BtH5Gaynp2yvBzKJqVjv/676tS5ZTN0791zEJl3cPyWxLiip+sshwKVGPDJjEfCmmh
	 krIcxItj+J7aQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0419EF40068;
	Fri, 20 Mar 2026 14:14:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 14:14:09 -0400
X-ME-Sender: <xms:cI69abZyW3OKzAcD61prYT8hfETgECn4Onu2WcT7Z3fETvRttd48bw>
    <xme:cI69aTynLaxABLN2H6ABKREBQUkYmrGUHyTCIYn9-ySF-aJ3PUIjfEEe7Qvbm9Nci
    TQrVnfDVWoQzKH0JgJenD0MwSwGUe7MjCr5t4-MEC75_5I6hKogdTA>
X-ME-Received: <xmr:cI69aWda_1ZVp3tE6ERIxG5vZ88Vq5B-_X0cQqetP2M1ItkT0jIv11FjuJTlnsqwCCr6NUEVR-eKGf6YkLCkLDEYwVAcva_W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    duvdfhgedvueeihfeiffetveevkedvtddtiefffedvjeegueeguddtkeefheefudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomh
    dprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cI69aRKGHltnEBqDHoIqyocdvUhtme4k3w2b0a1w3pKlKDLpRLBcCA>
    <xmx:cI69aX1HuEtfzooX3jzER0cSm42tlKxav-kL6COCmJOo9wP4n14Ggg>
    <xmx:cI69aSaIbsgyAdlNpTm1IPFqKFBf2nBjHN6vOpcNAaZ1DPC8mFmwkQ>
    <xmx:cI69aZi-X9ZVTZtsToAWUx2fqoCQI9vQXkDxaQ7mRH7aw1BrfyDImw>
    <xmx:cI69aZ91ZRkGtqVLvGPUTbbwZULQDpem6UEYUvgTPjuJetCfcxNz-bv_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 14:14:08 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org,
	neeraj.iitr10@gmail.com,
	urezki@gmail.com,
	boqun.feng@gmail.com,
	rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Date: Fri, 20 Mar 2026 11:14:00 -0700
Message-ID: <20260320181400.15909-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
happen basically everywhere (including where a scheduler lock is held),
call_srcu() now needs to avoid acquiring scheduler lock because
otherwise it could cause deadlock [1]. Fix this by following what the
previous RCU Tasks Trace did: using an irq_work to delay the queuing of
the work to start process_srcu().

[boqun: Apply Joel's feedback]

Reported-by: Andrea Righi <arighi@nvidia.com>
Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
@Zqiang, I put your name as Suggested-by because you proposed the same
idea, let me know if you rather not have it.

@Joel, I did two updates (including your test feedback, other one is
call irq_work_sync() when we clean the srcu_struct), please give it a
try.

 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index dfb31d11ff05..be76fa4fc170 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -95,6 +95,7 @@ struct srcu_usage {
 	unsigned long reschedule_jiffies;
 	unsigned long reschedule_count;
 	struct delayed_work work;
+	struct irq_work irq_work;
 	struct srcu_struct *srcu_ssp;
 };
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2328827f8775..73aef361a524 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
+#include <linux/irq_work.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -75,6 +76,7 @@ static bool __read_mostly srcu_init_done;
 static void srcu_invoke_callbacks(struct work_struct *work);
 static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
 static void process_srcu(struct work_struct *work);
+static void srcu_irq_work(struct irq_work *work);
 static void srcu_delay_timer(struct timer_list *t);
 
 /*
@@ -216,6 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
+	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
@@ -713,6 +716,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
+	/* Wait for irq_work to finish first as it may queue a new work. */
+	irq_work_sync(&sup->irq_work);
 	flush_delayed_work(&sup->work);
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
@@ -1118,9 +1123,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		// it isn't.  And it does not have to be.  After all, it
 		// can only be executed during early boot when there is only
 		// the one boot CPU running with interrupts still disabled.
+		//
+		// Use an irq_work here to avoid acquiring runqueue lock with
+		// srcu rcu_node::lock held. BPF instrument could introduce the
+		// opposite dependency, hence we need to break the possible
+		// locking dependency here.
 		if (likely(srcu_init_done))
-			queue_delayed_work(rcu_gp_wq, &sup->work,
-					   !!srcu_get_delay(ssp));
+			irq_work_queue(&sup->irq_work);
 		else if (list_empty(&sup->work.work.entry))
 			list_add(&sup->work.work.entry, &srcu_boot_list);
 	}
@@ -1979,6 +1988,22 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
+static void srcu_irq_work(struct irq_work *work)
+{
+	struct srcu_struct *ssp;
+	struct srcu_usage *sup;
+	unsigned long delay;
+
+	sup = container_of(work, struct srcu_usage, irq_work);
+	ssp = sup->srcu_ssp;
+
+	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+	delay = srcu_get_delay(ssp);
+	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+
+	queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
+}
+
 void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
 {
-- 
2.50.1 (Apple Git-155)

