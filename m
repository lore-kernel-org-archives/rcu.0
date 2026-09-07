Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B919067C;
	Mon,  7 Sep 2026 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788780; cv=none; b=OCFVSwHaNMot+lB29bG7O77w5ontowRkHauPSB+OJ5iOc74tkMWQYz3z5/5kwznJ+/Nlof+EGRazPCqbWhcaCyCozd9aJg01grTbvBs/hGziNXc0OSWgLdP/2qF3PewrLy6tTSJY4oe1mxT8zbkSHYhlYo2G2Oa7Fgb22v/Hcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788780; c=relaxed/simple;
	bh=1rdopg9zEij50bC4azkuauNWprEQ5+Yt71j05jHKaW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD49TTUYGvE80639cG/a+Ke4pEqGyC4CniK+fOxRJ9YqTtIzV37DRze2xFg/g3QuY404rCV+PgwOdM6T4HYZ5DIe+ZPfsIY0+j21jx1kwdjtX2+5ZFWIILsczzt+m96u+CEBRuDPYIf2nlyQyaOXwKcD6R9+qi2r62OzPzi+Qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brPS6QH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brPS6QH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7621F00A3E;
	Mon,  7 Sep 2026 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788788771;
	bh=Q2xzZPh/aD2R7BFCnq5xbWz061nTxMqeFMHs59osVrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brPS6QH3Bm1lhJb7CtvGyrTYoh08y5/eTA5S05MbNxMJxcjMI9CQkGbWvGUeK1Ah6
	 FSseD49P9KtYnSC8Z1dT5Y0uNI/kQ/TiBucO1IBY4YrFL91ZnIJe0LL5IVMOguhtML
	 R0xO/qD+der2fDggOlINGT47/mbNrqK7mn+c0YCQPBy6EnbFoMLi1oVymZ/ZyNA4O1
	 CaQA8JO8HtrDxXzSPL2aM9V7mSomEH95VaWZTXqdH9tSGS9gT7R4yY4hMaFGjAPahR
	 bzrVab58iBLKE84eHf0VUvMFshYkouMGinvHyqFEyPC3c1Q3MLIMj0G6PMIfJcbBYT
	 Zq2FzlLCn2FUA==
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
Subject: [PATCH bpf-next 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
Date: Mon,  7 Sep 2026 06:45:50 -0700
Message-ID: <20260907134552.1772405-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907134552.1772405-1-puranjay@kernel.org>
References: <20260907134552.1772405-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same as bpf_call_rcu(), but waits for sleepable BPF programs too.
call_rcu_tasks_trace() is call_srcu() on rcu_tasks_trace_srcu_struct and
SRCU invokes callbacks with BH disabled, so the callback is still not
sleepable.  It does run from a kworker rather than softirq or the
rcuc/rcuo kthread, so current is a kworker.

Only the queueing call differs, so the two share struct bpf_rcu_head and
all of the verifier plumbing.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/helpers.c  | 57 +++++++++++++++++++++++++++++++------------
 kernel/bpf/verifier.c |  5 +++-
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 609c47e9cc85a..eba55015a0c63 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4711,21 +4711,10 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
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
- * nor bpffs, or -ENOENT if the calling program is going away.
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
@@ -4745,13 +4734,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
 		return PTR_ERR(prog);
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
+ * nor bpffs, or -ENOENT if the calling program is going away.
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
+ * nor bpffs, or -ENOENT if the calling program is going away.
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
@@ -5046,6 +5072,7 @@ BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_call_rcu_tasks_trace, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e07bb707a99d2..cfca7ddc2e3a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12014,6 +12014,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_call_rcu,
+	KF_bpf_call_rcu_tasks_trace,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_session_is_return,
@@ -12105,6 +12106,7 @@ BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_call_rcu)
+BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 #ifdef CONFIG_BPF_EVENTS
@@ -12160,7 +12162,8 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_id)
 
 static bool is_call_rcu_kfunc(u32 func_id)
 {
-	return func_id == special_kfunc_list[KF_bpf_call_rcu];
+	return func_id == special_kfunc_list[KF_bpf_call_rcu] ||
+	       func_id == special_kfunc_list[KF_bpf_call_rcu_tasks_trace];
 }
 
 static bool is_task_work_add_kfunc(u32 func_id)
-- 
2.53.0-Meta

