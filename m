Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E013B9D81;
	Tue, 15 Sep 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483017; cv=none; b=mjfuEIA1/hOFn8WRYT5fhbZGQ9nFkHfF1vEcrzHqJtHFY6oJRLZPq198/+4vEaSaSu14PIaZRcb8s4rKK1RarpwUYvFVraZ0iaF1lDEG4qDHayOS4tKUSNA2Q8J7bj7A4cr+GvU2Oa9RmsTRveF0/ybShqqKgBXIwLgPuvqeYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483017; c=relaxed/simple;
	bh=9UThXkXTHvCGnOabOGzH3zoqAlixx7J99jd5l60W2mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/FAK2onc8TwZtxr2YHGorZMKleWxdd0JfHjiS/TRrepqKmksZhxzs50h0xYuRaUwCdK1uQLMhF2tzTo53HSFUgIhYvjUtC1TE6JiKiRPmUbdb/vXbZjNvmoaT6holKFokvgE1TjE1BFuxUoYJOBG1jChL9i0WZG6tu+78SRwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKqpxh5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKqpxh5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9081F000FF;
	Tue, 15 Sep 2026 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483016;
	bh=XbMHL+ZLr+KFhxV+AsCLD7Kp9zctw1AD5ff8EGITQgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKqpxh5/T1CItmIl18nz6Nc5s9+B8rWbZ1KjWHOZvdKNaMfdkw3J0oECEMw6WwlbB
	 LPqliOuj+bSjFGUfFuWWkT5m7KvFNdLgOVKFo7fKrsnjDUzLPBYemXQ5qGuwY4p2iG
	 IESTG5E5LnxGQtBEsQZMdG4Yj0Tt3qiRgxMEl/EYdRqb4P5qrwSLv6hvADu0YcWdXi
	 BNkn4+pn5XqGaEZYxhQjX5UWocm00rXrdAj1DD45AgwwCCUZfNtWqVi4mnOPiNjOBw
	 XsN0f3/z7NUY+QkKPF67P45ype5El95DxpoozfvMd3udkrQzmArURZHfbyafqgP3Z1
	 DJcjdru3vP1tg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH bpf-next v3 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
Date: Tue, 15 Sep 2026 07:36:37 -0700
Message-ID: <20260915143640.36292-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915143640.36292-1-puranjay@kernel.org>
References: <20260915143640.36292-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sleepable BPF programs hold rcu_read_lock_trace(), not rcu_read_lock(),
so a plain RCU grace period does not wait for them.  A program whose
readers are sleepable needs this flavour to defer reclaim safely.

call_rcu_tasks_trace() is call_srcu() on rcu_tasks_trace_srcu_struct and
SRCU invokes callbacks with BH disabled, so the callback is still not
sleepable.  It does run from a kworker rather than softirq or the
rcuc/rcuo kthread, so a callback must not assume anything about current.

Only the queueing call differs, so the two share struct bpf_rcu_head and
all of the verifier plumbing.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/helpers.c  | 59 +++++++++++++++++++++++++++++++------------
 kernel/bpf/verifier.c |  7 +++--
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6debb92fc8740..b76e2866693af 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1428,7 +1428,7 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
 	if (prog) {
 		prog = bpf_prog_inc_not_zero(prog);
 		if (IS_ERR(prog))
-			return PTR_ERR(prog);
+			return -EBADF;
 	}
 
 	do {
@@ -4710,21 +4710,10 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	bpf_prog_put(prog);
 }
 
-/**
- * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
- * @rh: struct bpf_rcu_head in a BPF map value
- * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
- * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
- * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
- *
- * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
- * nor bpffs, or -EBADF if the calling program is going away.
- */
-__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
-			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
+static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map, void *callback,
+			  struct bpf_prog_aux *aux, bool trace)
 {
 	struct bpf_rcu_head_kern *rhk = (void *)rh;
-	struct bpf_map *map = map__const_map;
 	struct bpf_prog *prog;
 
 	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_head));
@@ -4744,13 +4733,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
 		return -EBADF;
 	}
 
-	rhk->callback_fn = (bpf_callback_t)(void *)callback;
+	rhk->callback_fn = (bpf_callback_t)callback;
 	rhk->map = map;
 	rhk->prog = prog;
-	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
+	if (trace)
+		call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);
+	else
+		call_rcu(&rhk->rcu, bpf_rcu_run_callback);
 	return 0;
 }
 
+/**
+ * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
+ * @rh: struct bpf_rcu_head in a BPF map value
+ * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
+ * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
+ * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
+ *
+ * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
+ * nor bpffs, or -EBADF if the calling program is going away.
+ */
+__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
+			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
+{
+	return __bpf_call_rcu(rh, map__const_map, callback, aux, false);
+}
+
+/**
+ * bpf_call_rcu_tasks_trace - Invoke a BPF callback after an RCU tasks trace grace period
+ * @rh: struct bpf_rcu_head in a BPF map value
+ * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
+ * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
+ * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
+ *
+ * Waits for sleepable BPF programs too.  The callback itself is not sleepable either way.
+ *
+ * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
+ * nor bpffs, or -EBADF if the calling program is going away.
+ */
+__bpf_kfunc int bpf_call_rcu_tasks_trace(struct bpf_rcu_head *rh, void *map__const_map,
+					 bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
+{
+	return __bpf_call_rcu(rh, map__const_map, callback, aux, true);
+}
+
 static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
 			    struct bpf_dynptr_kern *ptr)
 {
@@ -5045,6 +5071,7 @@ BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_call_rcu_tasks_trace, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7051e19bb78b3..33d25b0e488eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -572,7 +572,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_timer_set_callback)
 		return false;
 
-	/* bpf_call_rcu callbacks are never sleepable. */
+	/* bpf_call_rcu and bpf_call_rcu_tasks_trace callbacks are never sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 && is_call_rcu_kfunc(insn->imm))
 		return false;
 
@@ -12584,6 +12584,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_call_rcu,
+	KF_bpf_call_rcu_tasks_trace,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
@@ -12678,6 +12679,7 @@ BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_call_rcu)
+BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
@@ -12751,7 +12753,8 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_id)
 
 static bool is_call_rcu_kfunc(u32 func_id)
 {
-	return func_id == special_kfunc_list[KF_bpf_call_rcu];
+	return func_id == special_kfunc_list[KF_bpf_call_rcu] ||
+	       func_id == special_kfunc_list[KF_bpf_call_rcu_tasks_trace];
 }
 
 static bool is_task_work_add_kfunc(u32 func_id)
-- 
2.53.0-Meta

