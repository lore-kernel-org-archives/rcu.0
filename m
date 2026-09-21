Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DC511E9F;
	Mon, 21 Sep 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018067; cv=none; b=uP7jlP7ndlqcc8h2y9kXV9UoIAFLt8XYGjuzR8M9QkDRjzqss9WqOIDtcSmb2LnUOup/eEgX4JYteMpXzGHCerwTt3YYv+am2fPXba155bPzQ+PaaNXMqwseL2lUBK0GLbYQJAf/38wJ2t8zZxYQXjS9HB3LBZ5DGHbWWDKCfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018067; c=relaxed/simple;
	bh=LAPA7xqA2U7MEd+JgTXdlcCsPBSF+auiDYwNe9nHqag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCpSG1hYQnlf4iRf0JDq+HhVLSOYEvTCQDQPuPDZHQN45H8N/Zumc7BRPdCbOKNSSBS/FTgYnoDNR6UCvgnD8AS1ZXfdp1tp9JAzjF3rIyN6MGj/e02czpFaNyrQk7tg6Nbq0riQOXh3jRMi+gFHMV1SDJof60CP8wuHkvUymhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6zWfgcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6zWfgcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D95D1F000FF;
	Mon, 21 Sep 2026 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018064;
	bh=WZeH+GiJcegsCVwr2UtTb50H93rnt6Qn3Fqnd4NKr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6zWfgcZas3mEjcIt5Z0t8cGBfCbmGLeteT6CDJUxFFecpwLPyuptgNoFXPtasOw7
	 P73hekDLlW3Y3t2xTKeC3JAxSLMDyhk/cC/NNIj5AN6eWWoD3wHf9zDi/0loAYK/nO
	 KJQdT0E7an5mELlEoMfIc7XbyCJprrD8KeEbpCJd2pgo3zEK96ap9JWHup28d1RA/5
	 2rRojSymmSHKE8aHujmEFOq38Tj+53GhDauuiPq3kEn2URkkKRQFMLpmzpvyO/4dGC
	 XvZ8VbiJEAenPOBTZuJ4tl9OhySJP6W7c6yiirnTf9LagSJLQGuQPiZ9Kn2V0iiYAn
	 7l9Kph0TOQirw==
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
Subject: [PATCH bpf-next v5 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
Date: Mon, 21 Sep 2026 12:14:04 -0700
Message-ID: <20260921191407.1742386-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921191407.1742386-1-puranjay@kernel.org>
References: <20260921191407.1742386-1-puranjay@kernel.org>
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
 kernel/bpf/helpers.c  | 57 +++++++++++++++++++++++++++++++------------
 kernel/bpf/verifier.c |  7 ++++--
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8a01dd4058a03..301b35bd85c8a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4838,21 +4838,10 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
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
@@ -4872,13 +4861,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
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
@@ -5175,6 +5201,7 @@ BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_call_rcu_tasks_trace, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64db47964ff9f..a7c9e2d8965d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -578,7 +578,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_timer_set_callback)
 		return false;
 
-	/* bpf_call_rcu callbacks are never sleepable. */
+	/* bpf_call_rcu and bpf_call_rcu_tasks_trace callbacks are never sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 && is_call_rcu_kfunc(insn->imm))
 		return false;
 
@@ -12629,6 +12629,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_call_rcu,
+	KF_bpf_call_rcu_tasks_trace,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
@@ -12723,6 +12724,7 @@ BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_call_rcu)
+BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
@@ -12796,7 +12798,8 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_id)
 
 static bool is_call_rcu_kfunc(u32 func_id)
 {
-	return func_id == special_kfunc_list[KF_bpf_call_rcu];
+	return func_id == special_kfunc_list[KF_bpf_call_rcu] ||
+	       func_id == special_kfunc_list[KF_bpf_call_rcu_tasks_trace];
 }
 
 static bool is_task_work_add_kfunc(u32 func_id)
-- 
2.53.0-Meta

