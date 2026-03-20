Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1A383C97
	for <rcu@vger.kernel.org>; Fri, 20 Mar 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045761; cv=none; b=bQBBfFaxtHK4OERk7SyhnOz1tyJpy350xNLxQ5eWrImagPAvuUO6HKoeisHmOvA+ImJzdCe8FJPVjD07GCVSGdjoxOET30g/RRmoTFJvgmCojepg00UOOzA2HGbRSI9BR9E0oJVEZrP1B/nXlFf/ZNjMG0ycVixQ+5BsaTQUEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045761; c=relaxed/simple;
	bh=v3zfhE3MnG2xnWuC+PB/Cx3HJPumGkjd2CbvS7FoOP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8RO5t793bI+4AZrGVplUGgcwQb3huz9JDJH4Nd9ieefS7sZe30a8UhiiPUhijI9StJQX7P5W9hceNlZ404Rgl31xYN5/93eL2PfkWFSUxm6ldBXKuR2WZPZ7WRURb0PdW/YuUQ68D/1i8bM2DZhhAmqOKLHCnPMQaPc9SsA2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3OlCNQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3OlCNQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F270C2BC87;
	Fri, 20 Mar 2026 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774045760;
	bh=v3zfhE3MnG2xnWuC+PB/Cx3HJPumGkjd2CbvS7FoOP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3OlCNQhbGAoBirhO+PcNVYE6UCOovqrdN8Qhs5s4G4X40j0Gon10SyUX0HLWaKRd
	 i30oS2k8kZEJKpL+jLz+A3CyvrW8Y7cIUPzzcwrVVwCihS2CQsIjmYFnJOcugkzb40
	 3GwLA0ci1dGywutZmrWZvHPKI7sukXQO8YV1G/NuB6wCm+nrmadCRsctQRSWaEkaoW
	 Wj9df2yctUQbT8HlUppseMI08zqFTxbRXZBfLEF60LxwHc83c5513rEv34fOhgQ3dA
	 9D6XO0LC3lVl2Yp+2uNQYdLX9ezh+DVO/fo75LmCbJteSCPHURb93/evUXYumTMb43
	 knPhfmcq/UWew==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 36273F40089;
	Fri, 20 Mar 2026 18:29:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 18:29:19 -0400
X-ME-Sender: <xms:P8q9aTZ-HhamBV5VH6BkIWQmEgaefIwUzkuNeRL2tWR90dGPZ3WK0w>
    <xme:P8q9abyMjs9t-IEWwg4DJBnbqbH0GoG2lhZY4t1ZCjEp_iMMBeukWPlzMJWI1q3tY
    ViWpWe_8hsKBSVHqqJU-urvfhDuVP0-ZOpcoYOnij-IgIHJdffuTO0>
X-ME-Received: <xmr:P8q9aecRcgfjZK8K-9D_Q6cTiajpthQRJjSksmT_NlNl_hd8gUN-wf-etF7YfilIBIDWgRS9Dd6xE3jwM7NhMLDunlfL3aZl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:P8q9aZKn07ZPc_XfPAauEC6b5VrM44tRtPfho-SYhhDqictHK0Wb6g>
    <xmx:P8q9af2K8PVdg4eLPmBdbgX8DSGLB6TadCeKVXetxtNoZwbYIme8bQ>
    <xmx:P8q9aaZFCAlQTnx39F-FB45Z8fSsN1-HggrkhmmbJaJQd61w_mYFFA>
    <xmx:P8q9aRhuFiqe53-Rg45MlGF8WHlAA1FtTp_13ZMyL7KkkWH6NyqvjA>
    <xmx:P8q9aR8v26l_wrhVB2d5JsTO2ESWdntUJJ5y8H0Qtutd9h3nHSzg_k0k>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 18:29:18 -0400 (EDT)
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
Subject: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
Date: Fri, 20 Mar 2026 15:29:16 -0700
Message-ID: <20260320222916.19987-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ab2yd35rm6OgZUmb@gpd4>
References: <ab2yd35rm6OgZUmb@gpd4>
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
[boqun: Apply Andrea's test feedback]

Reported-by: Andrea Righi <arighi@nvidia.com>
Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
Suggested-by: Zqiang <qiang.zhang@linux.dev>
Tested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

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
index 2328827f8775..e08aaacad695 100644
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
@@ -1979,6 +1988,23 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
+static void srcu_irq_work(struct irq_work *work)
+{
+	struct srcu_struct *ssp;
+	struct srcu_usage *sup;
+	unsigned long delay;
+	unsigned long flags;
+
+	sup = container_of(work, struct srcu_usage, irq_work);
+	ssp = sup->srcu_ssp;
+
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
+	delay = srcu_get_delay(ssp);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+
+	queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
+}
+
 void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
 {
-- 
2.50.1 (Apple Git-155)

