Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D903325483;
	Sat, 19 Sep 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776067; cv=none; b=S0sEjLqSW4LT0t30rs2hXTL8E/r3F9111A9vwN+QmmeLskwR0pA8mLF6kfLRtwZ1EYqTBatIs7bqlL6abDh0RFbErrfH7KzY2dQR2UUXDy2/oEx1XUKEGiyDTPC9X+0pEyv/WEvls27V0s9Lxr8smJySCtBJsL6+MlqYdfvPGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776067; c=relaxed/simple;
	bh=Olz859tJdw1DLVLbFZXJGchk+IIuM7/vHsHBXkb5qf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqSTAcAn+ls7DWqDntouz8PwbQPuK18/zHgStCky6LwHfupca7/GbZMzoaQiEG9uX0UDmlxj9LyXewwtmOe92JNFX7/TBBIc0rD/QjTiiZUm0Dnt5O7j0M7ryNvvXTGoeSCUFGu19Ww1E67PIXbHoQZPosuxjMtm7oRP7xH+koU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlNOJijQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlNOJijQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E11F0092B;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=SUO85UX+jT1fuZFY9WY+i80xd11ZQjlwCLaKXR6Va/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TlNOJijQR6HzKN4kr9Y9ycLbu3PzSzNCaiXZO4Vrut2XUhO3QbAp8w33stMGsBCj5
	 YmDoV/yY9BCIW1ih9SfF0SKvIJuCYji1Rj5TWXdgkoDBXJopBgDEC+NWgDjeEEzb73
	 o6bDcLys2ZnFVsVXQY6o0QOkxG6YVEBJ/I2DVSvX4XyMQwvB8P3KZkvL474cUNCL5Q
	 wSE7VY1Tj0u170o/svoF+U294RW9ZbNLuRmyZpPD9NzJBoUEGNnfJ/HXZ+9GYcklhW
	 ZQkwIIoULvA05m76SU2ZPjunweNDTf1bJogj/2od2L3B+zkHjKaOGdmHndNYV1DKbw
	 mXuEx6rQkafaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8693ECE0F12; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 21/28] hazptr: Introduce CONFIG_HAZPTR_DEBUG misuse detection
Date: Fri, 18 Sep 2026 17:00:49 -0700
Message-Id: <20260919000056.3132131-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Introduce Hazard Pointers debug assert, which detects misuse of hazard
pointers, namely failure to detach the hazard pointer from its owner
thread before releasing it from a different thread.

Prints the following to the console when a failure is detected:

   Hazard Pointer (addr=000000006885a05f) released on remote task without being detached from task. Acquire: caller=hazptr_torture_read_lock+0x43/0xa0 [hazptrtorture], pid=3727, cpu=1. Release: pid=3725, cpu=139.
   WARNING: ./include/linux/hazptr.h:225 at hazptr_torture_read_unlock+0x68/0xf0 [hazptrtorture], CPU#139: hazptr_torture_/3725
   Modules linked in: hazptrtorture torture nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink
   CPU: 139 UID: 0 PID: 3725 Comm: hazptr_torture_ Not tainted 7.1.0-rc4+ #9 PREEMPT(full)
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
   RIP: 0010:hazptr_torture_read_unlock+0x74/0xf0 [hazptrtorture]
   Code: 74 31 8b 4f 40 4c 8b 43 48 49 c7 c2 22 c9 56 c0 48 c7 c7 3b c9 56 c0 4c 8d 1d b8 32 f1 ff 52 48 89 fa 4c 89 df 50 51 4c 89 d1 <67> 48 0f b9 3a 48 83 c4 18 48 8b 03 48 8d 53 18 48 c7 00 00 00 00
   RSP: 0018:ff621a2a479b3de0 EFLAGS: 00010293
   RAX: 0000000000000e8d RBX: ff12ea30d3913488 RCX: ffffffffc056c922
   RDX: ffffffffc056c93b RSI: ffffffffc0562280 RDI: ffffffffc0562030
   RBP: ff621a2a479b3e50 R08: ffffffffc064ee53 R09: 0000000000000e8f
   R10: ffffffffc056c922 R11: ffffffffc0562030 R12: 0000000000000000
   R13: ffffffffc0562280 R14: ff12ea30d3913488 R15: ff621a2a479b3e50
   FS:  0000000000000000(0000) GS:ff12ea5011a84000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00007f39b6e4b010 CR3: 0000000114c6e005 CR4: 0000000000771ef0
   PKRU: 55555554
   Call Trace:
    <TASK>
    hazptr_torture_reader_tail+0x8e/0x210 [hazptrtorture]
    hazptr_torture_reader+0x145/0xb30 [hazptrtorture]
    ? srso_alias_return_thunk+0x5/0xfbef5
    ? set_cpus_allowed_ptr+0x36/0x60
    ? srso_alias_return_thunk+0x5/0xfbef5
    ? srso_alias_return_thunk+0x5/0xfbef5
    ? __pfx_hazptr_torture_reader+0x10/0x10 [hazptrtorture]
    kthread+0xdf/0x120
    ? __pfx_kthread+0x10/0x10
    ret_from_fork+0x216/0x2d0
    ? __pfx_kthread+0x10/0x10
    ret_from_fork_asm+0x1a/0x30
    </TASK>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 include/linux/hazptr.h   | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/rcu/Kconfig.debug | 14 ++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 8197a51b9f7a..415316282142 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -51,6 +51,11 @@ struct hazptr_ctx {
 	/* Backup slot in case all per-CPU slots are used. */
 	struct hazptr_backup_slot backup_slot;
 	struct hlist_node preempt_node;
+#ifdef CONFIG_HAZPTR_DEBUG
+	bool detach_task, detach_cpu;	/* Whether the ctx has been detached from task/cpu. */
+	int acquire_pid, acquire_cpu;	/* Note the task and cpu number at acquire. */
+	unsigned long acquire_caller;	/* Acquire instruction pointer. */
+#endif
 };
 
 struct hazptr_slot_ctx {
@@ -127,6 +132,9 @@ void hazptr_detach(struct hazptr_ctx *ctx)
 	struct hazptr_slot *slot;
 
 	guard(preempt)();
+#ifdef CONFIG_HAZPTR_DEBUG
+	ctx->detach_task = ctx->detach_cpu = true;
+#endif
 	slot = ctx->slot;
 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
 		return;
@@ -145,6 +153,9 @@ void hazptr_note_context_switch(void)
 
 		if (!slot->addr)
 			continue;
+#ifdef CONFIG_HAZPTR_DEBUG
+		item->ctx.ctx->detach_cpu = true;
+#endif
 		hazptr_promote_to_backup_slot(item->ctx.ctx, slot);
 	}
 }
@@ -173,6 +184,12 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	percpu_slots = this_cpu_ptr(&hazptr_percpu_slots);
 	slot_item = &percpu_slots->items[0];
 	slot = &slot_item->slot;
+#ifdef CONFIG_HAZPTR_DEBUG
+	ctx->detach_cpu = ctx->detach_task = false;
+	ctx->acquire_pid = current->pid;
+	ctx->acquire_cpu = smp_processor_id();
+	ctx->acquire_caller = _THIS_IP_;
+#endif
 	if (unlikely(slot->addr))
 		return __hazptr_acquire(ctx, addr_p);
 	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
@@ -196,6 +213,26 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	return addr;
 }
 
+#ifdef CONFIG_HAZPTR_DEBUG
+/* Called with preemption disabled. */
+static inline
+void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr)
+{
+	int pid = current->pid, cpu = smp_processor_id();
+	bool warn_remote_cpu = !ctx->detach_cpu && ctx->acquire_cpu != cpu,
+	     warn_remote_task = !ctx->detach_task && ctx->acquire_pid != pid;
+
+	WARN_ONCE(warn_remote_cpu || warn_remote_task,
+		"Hazard Pointer (addr=%p) released on remote %s without %s. Acquire: caller=%pS, pid=%d, cpu=%d. Release: pid=%d, cpu=%d.",
+		addr,
+		warn_remote_task ? "task" : "cpu",
+		warn_remote_task ? "being detached from task" : "context switch",
+		(void *) ctx->acquire_caller, ctx->acquire_pid, ctx->acquire_cpu, pid, cpu);
+}
+#else
+static inline void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr) { }
+#endif
+
 /* Release the protected hazard pointer from @slot. */
 static inline
 void hazptr_release(struct hazptr_ctx *ctx, void *addr)
@@ -205,6 +242,7 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 	if (!addr)
 		return;
 	guard(preempt)();
+	hazptr_release_debug(ctx, addr);
 	slot = ctx->slot;
 	smp_store_release(&slot->addr, NULL);
 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index fe64356f0088..7c3c6017b266 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -251,4 +251,18 @@ config TRIVIAL_PREEMPT_RCU
 
 	  This has no value for production and is only for testing.
 
+config HAZPTR_DEBUG
+	bool "Provide debugging asserts for Hazard Pointers"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  This option provides consistency checks for hazard pointers.
+	  These checks detect cases where a hazard pointer is acquired in
+	  one context and released in another, but without the required
+	  call to hazptr_detach() before exiting the context in which
+	  the hazard pointer was acquired.  For more detail, please see
+	  the hazptr_detach() kernel-doc header.
+
+	  Say Y here if you want to enable those assert, N otherwise.
+
 endmenu # "RCU Debugging"
-- 
2.40.1

