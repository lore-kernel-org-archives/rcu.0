Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281F3EDADC;
	Mon,  6 Jul 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358892; cv=none; b=AZ6YFQ+hQMu/6jidR8U6vo2h6h6rqADl9riW7lPtU/X/9M34RFW+LQXmATstblL4xKg7IRU6Ws6W8iBr289+HSDPizkL+qHz3uoYjLzHl49Kk84Jlv1acmq7ds5akjiJnGpGNwMEZNac+ysuW+UVR/mEFjepRih52LZBj8V+/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358892; c=relaxed/simple;
	bh=727OLjZVHc7EyTnBJrxsFUiX26uGYaQ82jmgDmlbc14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsWz8HH0ZZMak5BKz7bp/zGjpES5eSz4Vtze5qUvlpA4Q4vk3jGUbDVh3dGLZvZadT3ajpORD0CkEDwde70Uge7l8Jn22KAHptzZg7okZq408A7UuFnx1zdDkHTaHYSSWFvQHwcwFWdo/jG/LWtHOiq1J0Mh3P8+foDcBdKdo8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew9vbn5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew9vbn5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F198E1F000E9;
	Mon,  6 Jul 2026 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783358891;
	bh=hrdUm0bKeClTNQkaldI7+ExZLa4nxjY9gPviXhqQi24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ew9vbn5I9+D72lvYQUujKWa7gNxiHWgVnU0FrLg6pTtuhJMUuSFcTYfJ3AMJvlbxd
	 kSozIUi5AwSWe5MO/OmUB3aXVk7ix5S+fWrq/ubRcgQfFO0bpUfvEbnkWR7qnhWjRr
	 sXmUszZTyY3FzLDULe42i9r5Yd4RY/Mh1nS6ZsG/5bnlqS8YRrntI0uY3Of84C8Rrs
	 4EyFQDQm/Og2xn/z16CReh0yjMybJcyrnkOMMrXoE+I/ywn7XamvR9gG9z3a46jXmJ
	 e209HUB4znF2MtLnZPK5HJa1eD/CpyOu9ivvd0TL2WzErOtVOwLygh6+RLtHRb3xse
	 wAK/6JKe1RmCw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
Date: Mon,  6 Jul 2026 10:27:42 -0700
Message-ID: <20260706172744.3920417-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706172744.3920417-1-puranjay@kernel.org>
References: <20260706172744.3920417-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uretprobes_srcu currently uses normal SRCU, which issues
two smp_mb() per read lock/unlock pair. This overhead is
paid on every uretprobe hit.

Switch to SRCU-fast-updown, which eliminates the per-reader
memory barriers by moving the ordering cost to the
grace-period side (synchronize_rcu() instead of smp_mb()).
This is acceptable because grace periods (uprobe
unregistration) are infrequent compared to reader-side
uretprobe hits.

The updown flavor is required because the SRCU read lock is
taken in prepare_uretprobe() when a return instance is
created and is held until that return instance is finalized.
The traced thread returns to user space in between, so the
lock is inherently released in a different context from
where it was acquired: on the normal return path via
uprobe_handle_trampoline() -> hprobe_finalize(), or from
ri_timer() (expiry) or dup_utask() (fork) via
hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
are designed for this acquire-here / release-elsewhere
pattern and, unlike the same-context srcu_read_lock_fast()
variant, do not carry the lockdep read-side tracking that
would warn on it.

The short, same-context SRCU sections in ri_timer() and
dup_utask() (which guard the uprobe against reuse across the
hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
for proper lockdep coverage.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/uprobes.h |  5 +++--
 kernel/events/uprobes.c | 29 +++++++++++++++++------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f548fea2adec8..f3b07753c2f3d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -25,6 +25,7 @@ struct mm_struct;
 struct inode;
 struct notifier_block;
 struct page;
+struct srcu_ctr;
 
 /*
  * Allowed return values from uprobe consumer's handler callback
@@ -106,7 +107,7 @@ enum hprobe_state {
  *     underlying uprobe is not guaranteed anymore. __UPROBE_DEAD is just an
  *     internal marker and is handled transparently by hprobe_fetch() helper.
  *
- * When uprobe is SRCU-protected, we also record srcu_idx value, necessary for
+ * When uprobe is SRCU-protected, we also record srcu_scp value, necessary for
  * SRCU unlocking.
  *
  * See hprobe_expire() and hprobe_fetch() for details of race-free uprobe
@@ -115,7 +116,7 @@ enum hprobe_state {
  */
 struct hprobe {
 	enum hprobe_state state;
-	int srcu_idx;
+	struct srcu_ctr __percpu *srcu_scp;
 	struct uprobe *uprobe;
 };
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e2844..afa491b0bd3f9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -54,7 +54,7 @@ static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
 /* Covers return_instance's uprobe lifetime. */
-DEFINE_STATIC_SRCU(uretprobes_srcu);
+DEFINE_STATIC_SRCU_FAST_UPDOWN(uretprobes_srcu);
 
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
@@ -707,12 +707,13 @@ static void put_uprobe(struct uprobe *uprobe)
 }
 
 /* Initialize hprobe as SRCU-protected "leased" uprobe */
-static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
+static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe,
+			       struct srcu_ctr __percpu *srcu_scp)
 {
 	WARN_ON(!uprobe);
 	hprobe->state = HPROBE_LEASED;
 	hprobe->uprobe = uprobe;
-	hprobe->srcu_idx = srcu_idx;
+	hprobe->srcu_scp = srcu_scp;
 }
 
 /* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
@@ -720,7 +721,7 @@ static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
 {
 	hprobe->state = uprobe ? HPROBE_STABLE : HPROBE_GONE;
 	hprobe->uprobe = uprobe;
-	hprobe->srcu_idx = -1;
+	hprobe->srcu_scp = NULL;
 }
 
 /*
@@ -757,7 +758,7 @@ static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
 {
 	switch (hstate) {
 	case HPROBE_LEASED:
-		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+		srcu_up_read_fast(&uretprobes_srcu, hprobe->srcu_scp);
 		break;
 	case HPROBE_STABLE:
 		put_uprobe(hprobe->uprobe);
@@ -829,7 +830,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
 		 */
 		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
 			/* We won the race, we are the ones to unlock SRCU */
-			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+			srcu_up_read_fast(&uretprobes_srcu, hprobe->srcu_scp);
 			return get ? get_uprobe(uprobe) : uprobe;
 		}
 
@@ -2045,7 +2046,7 @@ static void ri_timer(struct timer_list *timer)
 	struct return_instance *ri;
 
 	/* SRCU protects uprobe from reuse for the cmpxchg() inside hprobe_expire(). */
-	guard(srcu)(&uretprobes_srcu);
+	guard(srcu_fast_updown)(&uretprobes_srcu);
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
@@ -2142,7 +2143,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	t->utask = n_utask;
 
 	/* protect uprobes from freeing, we'll need try_get_uprobe() them */
-	guard(srcu)(&uretprobes_srcu);
+	guard(srcu_fast_updown)(&uretprobes_srcu);
 
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
@@ -2254,8 +2255,8 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 {
 	struct uprobe_task *utask = current->utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
+	struct srcu_ctr __percpu *srcu_scp;
 	bool chained;
-	int srcu_idx;
 
 	if (!get_xol_area())
 		goto free;
@@ -2293,8 +2294,12 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
 
-	/* __srcu_read_lock() because SRCU lock survives switch to user space */
-	srcu_idx = __srcu_read_lock(&uretprobes_srcu);
+	/*
+	 * Use srcu_down_read_fast() because the SRCU lock survives a switch to
+	 * user space and can be unlocked from a different context by ri_timer()
+	 * or dup_utask().
+	 */
+	srcu_scp = srcu_down_read_fast(&uretprobes_srcu);
 
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
@@ -2303,7 +2308,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 
 	utask->depth++;
 
-	hprobe_init_leased(&ri->hprobe, uprobe, srcu_idx);
+	hprobe_init_leased(&ri->hprobe, uprobe, srcu_scp);
 	ri->next = utask->return_instances;
 	rcu_assign_pointer(utask->return_instances, ri);
 
-- 
2.53.0-Meta

