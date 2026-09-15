Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4984A3D44;
	Tue, 15 Sep 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472600; cv=none; b=FkSzyIieb+iAbPrtGRw7K4OKODXhh1aySYGYBfR5cDLWeyAQi3wpuWAVBwKd4Bb5ClNA/ON355JpIpnV+AD4t+butVf0OYc7IE9+itQ+ggJNDJNRXAH4T4zwBJBco45sf5jfU1MFZVliPTNGKM0v4FCpUr4TrPvWtrDBkVdzFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472600; c=relaxed/simple;
	bh=Nb7hVie3mm6ibRXDyMDtPX5nM7Ii2VbTxMmMqHNGrpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCrqbjbFj5+BaWD8n6iVKMuOzyRdoL6pYjLFVn1YE7gZIJ8ndcpAhBF5LEBoFvrSUG410vHNYjVmWWcOJWe2wk8IEVL+MP8b1iD/p9Ht4XyELsn1g7CvZFI4niM32GVWtBlLQstEnQw4Y2eNAMwgh2di8sdlUzEAsFcf2fQBmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo7OI8cO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo7OI8cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703D41F000FF;
	Tue, 15 Sep 2026 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472598;
	bh=yqyzXBbuuKxX7WS1Kg05gMz9CavGlGitCT1eWF/VWss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jo7OI8cOgYNmUmbm6+yBSPSAG7xyrKhwAcK+Q/P3HJxxP48gTOIxOkiEwS8rHGIJH
	 giAgZAID5mXJ60HocXekZUW/8z60Dj84gYAbu0cATZjD++33nIpeBMgQG3RR3eSCYL
	 76D57qkMItatB1BHB7xoWT5WQQhj/RtUbpuUVM7pWHqtB3w+kNz4EkSxrhzRL6kS57
	 3A08pZroJ95G01OIii2494H1wVmLC4cxjSqeqIGMatvg80R7vYvIewzV9cWCPYzcHM
	 HgpQQaIZDkjvHDjg7s0VqlHqx4zoTZ3QYj0/cFwHhNWIeKteG9axJ/xLkG1yCrSCXY
	 kM8hS6qXTd1aw==
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
Subject: [PATCH bpf-next v2 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
Date: Tue, 15 Sep 2026 04:42:36 -0700
Message-ID: <20260915114240.3269184-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915114240.3269184-1-puranjay@kernel.org>
References: <20260915114240.3269184-1-puranjay@kernel.org>
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
 kernel/bpf/helpers.c | 57 ++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 74474b8f0ea14..43897e56b57d0 100644
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
@@ -4744,13 +4733,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
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
@@ -5045,6 +5071,7 @@ BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_call_rcu_tasks_trace, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
-- 
2.53.0-Meta

