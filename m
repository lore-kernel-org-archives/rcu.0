Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119134;
	b=RJpNZJRug9wPoVnj7MTfcdO9TB97CAy99htu36oBy+NE7stC9bAI75kWnhgQQHuRNi7z
	 5S3hbvup66lpNBjruZg8Vt50bi2S0FcjoB12UAjy+Olg/0zj2Gm/TuVnDhL5ICESJOmzj
	 8Ln4wj9k/Nz7bhYX/oG3yiaKz4JFJLihEqSg1DIHWCmL+QKR0U3zsVnSI8LKKycLE3RpK
	 ShHj1aRo0b7/m43gVH50bhLWabxPtDjo88rbfB4exHmHFDOWA8Kzl0ZeRUBQqqSowGoW3
	 ZVUh0kqm3Xfb7pbreyp0BZ3Rngr61EKYKMzxihECOHpqqfNBpdsf+0aXM+SJee0FFDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u2vDv32MA81U0LmwErTlcthaqDxgBvR1wRAzc93ugyc=;
	b=E7yCYEfQP+/KpbHyFfP1erKyZquETFjaWA/MUD0GaOtFniZ/VltMAPJUZ7pA2100QipG
	 lQ4QUDCoRQw/My8l5ybB5VmGoc3hD3Arq/v/GXvnCECqH3DQTKtbjyJjDITlV6SWYmA9d
	 WPQt7opdFM7IuSHKgvhDP8a3b8tTn0k3Gz21F41NqiLif9gd7592I6Xix0XhyKcmbfIAt
	 UnyMtSqfFLexiwJOVv9O18qoUeWSLjB7pxvAB6ijjdBi1MZ8Geb8PwUMrx2+i4MkJsF57
	 vEqcwVTDVlgLPZQZ2CbLrjJLH11Hb7R8gL6RTlBANAL+ieKW2SSu/2trkDgXTK+Pq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBf0RjX8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A51606A325
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 16:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A51606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBf0RjX8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so289505e9.1
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119132; x=1793723932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2vDv32MA81U0LmwErTlcthaqDxgBvR1wRAzc93ugyc=;
        b=vBf0RjX8254h+5Ot1OzQFloa1ymqkVidegDxNaWxZ3l/i+MQQad2y+u6UTbY3PZP/F
         I/ztS4Z5IonE2D6IS4TXVBMFZYTXsy7/kaV4jYBBPu9SbI7YpHmavTjGlWNcjG94QyhE
         JAOHzau5GaTkz8T8dt0Lr5VG0nXRF3EGiV4z41Gvn0B3qSRsHzoe57V8NyUES+WVzb5m
         gGMBFU3TbvIzoXKyHLTMH2ugXK3tcJkzDgHD7KJiwqN5jStZok5v6jBKWr+iZvAE4riU
         P7GoCyjIeY/vBOolINx60BkfDRR/eS1f0K3bjO2ARdyMS2bgKpHLptxuhtG9agXIZkay
         6EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119132; x=1793723932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2vDv32MA81U0LmwErTlcthaqDxgBvR1wRAzc93ugyc=;
        b=Pqk1bUNpXAM1VALpWdDQRxjv51mcJuCkXcTo3UeuOXzjoVpbgxd89cTOCouJG9j9aN
         G8yiGw9z1p1x2lcEIMXVRZzsNnqzxYbbvFhxayG9FwjYLBQyhrNyMYsYuPsP2BZee1c2
         NZGM28RK57zPMZlHH7s9gYuzTWg6nzX1jA30WM5JS6thAxgpmdEEkXnxtfxwUEJtKFGD
         Dmws/AkvwlHeMtQ2wUQpsFRGZ2RCHfygM3XRFQOutf0WbZZnUwfZgisbf36ya0DRZ22U
         CJnQ5U+ERJFCb8j75wmiF8dDAJXwo0PZH08sWxKaFhVnmYL1O2kiDonTtZKhYQucrrMr
         u1xQ==
X-Forwarded-Encrypted: i=1; AKwUvByoC2OAKc3pitmGapPHTck8PZqUnaazsw85vWYaba9zzbmBEwjNcfgT6buMN6QQcRJOynY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzZzEnk2k4PH1cqQYMsQLjNdE8+oYqpDG5Nya7P9oVUjOUKBKE
	oSOkuKi/4nnLYv16ZtX5cQ6zUi6dSygIC4W+4q6EIHLMOmPDYhIiOyfx
X-Gm-Gg: AYBFou2QAuFJdM7gm6ukoOdok2je3xyWQPmG/ucYLUjdk+AtvM96KQP3/Q6sE9IGmBG
	RV8ocPLAMQPTgmpWiGOlhSGocGaYxkSchioVNPrpC0VRKfyrIs8s6wz87gw5lgvmRj1KSa690QR
	EjKEQQoKcy2LyaR/JoDTjcBXXCVGhSihX34YdbI7URH+hJW0P/w9I6TfN5wphq6AFeZLx+BjSkn
	f7MaypQrmRojoEq2TzvFLfWggPIqe8eBtOBWQ9D6joI9O2mdKjgQlqF1CYPr9IcOUiLos1OlD1d
	DVxcFbezYVDnVuxim4nHu/p3hvYqh9oe6rNGXyywOJmXLktAhTZ7u5uHAXz4fNHmyeQhCnsGma3
	uQVjz1YAE9ZkitQeS+G9M70Z5APVpSdZRXM3RWSyAON1A3T3FqSyOwhemci+WPEY/2MWNgT+6lI
	Xx97n06mZVSDiSL1vxBHx7Mjc+M90rO2cg0YXgHFFpYd5eQQbvBfYdx9Z1UgVIr1Zai9dJiW4Wt
	n0TpYSQOo594o1EFCRqATl/XPS2VolEjqyqj+uSPAa9tpMGLFGTDDOVp6Eh5/5BoeRtCNtUSa1Y
	y+L0wUTCFTvRMTd+2uocbADMeGvCUgvwA5ewv5SJl08sQvo=
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr202598135e9.16.1793119131961;
        Tue, 27 Oct 2026 09:38:51 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92c21df84sm2358195e9.15.2026.10.27.09.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:38:51 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH -rcu/dev 2/4] hazptr: Check per-CPU slot owner with CONFIG_HAZPTR_DEBUG
Date: Tue, 27 Oct 2026 17:38:04 +0100
Message-ID: <20261027163811.2470569-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027163811.2470569-1-parri.andrea@gmail.com>
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
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

When a per-CPU slot records the wrong hazptr_ctx as its owner, nothing
reports it where it happens.  If the task is switched out before
releasing the slot, hazptr_note_context_switch() promotes it through the
wrong context, and if that context is detached,
hazptr_chain_backup_slot() adds its backup slot to an overflow list
again.

The kernel can then crash later in hazptr_synchronize(), far from the
cause.  For example, from hazptrtorture with readers that nest a second
hazard pointer, as "hazptrtorture: Nest a second hazard pointer in
readers" makes them do, and without "hazptr: Record per-CPU slot owner
after claiming the slot":

    Oops: stack segment: 0000 [#1] SMP PTI
    CPU: 4 UID: 0 PID: 83 Comm: hazptr_torture_ Tainted: G        W           7.3.0-rc1-00107-ga2aa5148421f #2 PREEMPTLAZY
    RIP: 0010:hazptr_scan_overflow_list_period+0x94/0x100
    RBP: dead000000000100 R08: 00000000002fa6bc R09: 0000000000000004
    Call Trace:
     <TASK>
     hazptr_synchronize+0xb7/0xd0
     hazptr_torture_writer+0x181/0x3f0
     kthread+0xd1/0x100
     ret_from_fork+0x179/0x240
     ret_from_fork_asm+0x1a/0x30
     </TASK>

Check the recorded owner where it is used.  hazptr_release_debug() now
warns when the context releasing a per-CPU slot is not the one recorded
for it.  hazptr_note_context_switch() warns when the recorded owner's
->slot is not the slot being promoted.  In that run, the checks warned
1.3 and 0.08 seconds before the oops:

    Hazard Pointer (addr=000000006dd14922) released from a per-CPU slot recorded with another owner. Acquire: caller=hazptr_torture_read_lock+0x43/0xb0, pid=82, cpu=7.
    WARNING: ./include/linux/hazptr.h:304 at hazptr_torture_read_unlock+0x137/0x160, CPU#7: hazptr_torture_/82
    Call Trace:
     <TASK>
     hazptr_torture_reader_tail+0x80/0x220
     hazptr_torture_nested_reader+0x6c/0x90
     hazptr_torture_reader+0x2f5/0x530
     kthread+0xd1/0x100
     ret_from_fork+0x179/0x240
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Hazard Pointer (addr=00000000742d8665) in per-CPU slot 1 recorded with an owner that uses another slot.
    WARNING: ./include/linux/hazptr.h:185 at __schedule+0x7ba/0xf10, CPU#0: hazptr_torture_/82
    Call Trace:
     <TASK>
     preempt_schedule+0x2d/0x50
     preempt_schedule_thunk+0x16/0x40
     hazptr_torture_read_lock+0xaa/0xb0
     hazptr_torture_nested_reader+0x39/0x90
     hazptr_torture_reader+0x2f5/0x530
     kthread+0xd1/0x100
     ret_from_fork+0x179/0x240
     ret_from_fork_asm+0x1a/0x30
     </TASK>

hazptr_release_debug() reads the owner of ctx->slot only if that
per-CPU slot is in use, and skips the backup slot that a detached or
promoted ctx uses.  If ctx holds the per-CPU slot, no interrupt can
claim it between the ->addr check and the owner read, so the check warns
only if the slot records the wrong owner.

If ctx has already released the slot, which the hazptr_release()
kernel-doc permits, the slot is in use only if another hazard pointer
has claimed it since, and this second release would clear that hazard
pointer, so the check warns then too.

One case can escape both checks: an interrupt handler that acquires and
releases the slot instead of detaching it, then a context switch before
the task's release.  The stale owner's ->slot still names the slot, and
the promotion empties the task's per-CPU slot, so hazptr_release_debug()
warns only if another hazard pointer has claimed that slot by then.

The crash was found with the help of an LLM.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 include/linux/hazptr.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 90d8d5a3d2443..d37792af34939 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -182,6 +182,9 @@ void hazptr_note_context_switch(void)
 		if (!slot->addr)
 			continue;
 #ifdef CONFIG_HAZPTR_DEBUG
+		WARN_ONCE(item->ctx.ctx->slot != slot,
+			"Hazard Pointer (addr=%p) in per-CPU slot %u recorded with an owner that uses another slot.",
+			slot->addr, idx);
 		item->ctx.ctx->detach_cpu = true;
 #endif
 		hazptr_promote_to_backup_slot(item->ctx.ctx, slot);
@@ -284,6 +287,8 @@ void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr)
 	int pid = current->pid, cpu = smp_processor_id();
 	bool warn_remote_cpu = !ctx->detach_cpu && ctx->acquire_cpu != cpu,
 	     warn_remote_task = !ctx->detach_task && ctx->acquire_pid != pid;
+	struct hazptr_slot *slot = ctx->slot;
+	struct hazptr_slot_item *item;
 
 	WARN_ONCE(warn_remote_cpu || warn_remote_task,
 		"Hazard Pointer (addr=%p) released on remote %s without %s. Acquire: caller=%pS, pid=%d, cpu=%d. Release: pid=%d, cpu=%d.",
@@ -291,6 +296,14 @@ void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr)
 		warn_remote_task ? "task" : "cpu",
 		warn_remote_task ? "being detached from task" : "context switch",
 		(void *) ctx->acquire_caller, ctx->acquire_pid, ctx->acquire_cpu, pid, cpu);
+
+	if (hazptr_slot_is_backup(ctx, slot) || !READ_ONCE(slot->addr))
+		return;
+	/* Whoever claimed a per-CPU slot must be recorded as its owner. */
+	item = container_of(slot, struct hazptr_slot_item, slot);
+	WARN_ONCE(item->ctx.ctx != ctx,
+		"Hazard Pointer (addr=%p) released from a per-CPU slot recorded with another owner. Acquire: caller=%pS, pid=%d, cpu=%d.",
+		addr, (void *) ctx->acquire_caller, ctx->acquire_pid, ctx->acquire_cpu);
 }
 #else
 static inline void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr) { }
-- 
2.53.0

