Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01004A843F;
	Tue, 15 Sep 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487001; cv=none; b=ai/6bfENtAiJL4+TNrJXXKKhgYd/LCOfaEIZTlSBwvlZ313RyIbeXhfBMTHl9u/zXWduPN0ujG2N+46Mh51P+QnaZ4eCVus7yZQIhQFtwif8wk1e/GH6gSvn4o0KGIz3HbqtadYsB+e2bjB/m82GH95kc3lXhUb6FVihz1fqBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487001; c=relaxed/simple;
	bh=qFCqUbrCnm9nlAl6oCdoOhTHrnAvIZ4v+CZ2YyXqn+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7mA+LRD4KWtXlW0jLkS2s821/XYfgEBpCCT+PjhKungFSegK0lohjV6wYhYaLTJEqjkhGxeDdrvFzUpLhpoZUMM7Hb+a+RuJWpi3g4sBacsLJWt4/eM6FkF59IjLUN5brA0gNM1X0EPBoOjY4UxlTxwYyQHg0K/RXdtNrXmz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjs8XPsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjs8XPsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5D51F000FF;
	Tue, 15 Sep 2026 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789486999;
	bh=Ea82/tawItNRe2IFAR6CaVCqB+s+mHaxUmuCD2UwtLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vjs8XPsRQeyYZO+Ztfb7J/IU3HYbsvw+E2/nmRp7I1IIsp2hj9/O9a5Zuqyi071hM
	 fVHQnHxbmDPnUuKIGw/IjxlsZX/1hnKxPg8k+8lHsMUaW/RTGzQfMNvNlK4ZKYFzbs
	 cuDBAO1ow1xwMmNwHmpz21F6n3YM6gANGCV28MRZtOmouoTdskaYi6va31DXngsJgO
	 md47KBxXcURP465JTZfKr+VlLY3qhio47f8F+LWUuNQhiXXIgeoSR3fUNl1mev7RSl
	 K+bjUExsytbYYsWjaycWKLvdAabnqZF8ifHm3GxS+YbyRtUWGAjgeXsy/UecOLk8cZ
	 fV2P4/1/7mCDw==
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
Subject: [PATCH bpf-next v4 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
Date: Tue, 15 Sep 2026 08:42:46 -0700
Message-ID: <20260915154248.3612028-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915154248.3612028-1-puranjay@kernel.org>
References: <20260915154248.3612028-1-puranjay@kernel.org>
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
index 6debb92fc8740..f12c612e36097 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
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

