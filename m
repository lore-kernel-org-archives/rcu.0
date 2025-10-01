Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D104256C76;
	Wed,  1 Oct 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330117; cv=none; b=JRqyEWNuFUCXvL/n8i0PEAjdBD3HGnN+3DwW2agbOwzOdgiRChoA0xwgUZJN5IwN14HraOa3AV8SVCFOlmeLJ37N+PlUTrzPSmPiHzQngTFLFXlX9+VNLTKEezRclJR2+sXxHK6206pWnjhVt4EJ065Tf51fdYDUzJ+oi11AteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330117; c=relaxed/simple;
	bh=7msjYfr0Kv43ez5IZwT7gg8cr4MufUyBGd2HMG5qBx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6GGeTtIszPKUif5hi8to23yt0tIIledmq7CLPvE5xxgASkNeACS4x2QBEvRWXYLskyYm5LFcNvmqHSvnmWHXy3x5p05fHLXzN0tH2H8rYrc4Pn988B48hZraxhUzhhvQVoQCVmGaBtHbUgibjlNDFRmnxtFpRd+d75EbNVu+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBxNV/QM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBxNV/QM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4B1C4CEF9;
	Wed,  1 Oct 2025 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330117;
	bh=7msjYfr0Kv43ez5IZwT7gg8cr4MufUyBGd2HMG5qBx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBxNV/QMK3vrkwVsCv58npjpNtxaxi9C1UgimyViknw3CkgkMAKUtbOozk/UQjZZB
	 isDTKH3+aR5bW1A7SEfrKPqBdUx0r1NglQFOBQ2mRJxbAbDZ1vPJ2jITkt2S99jDPc
	 BSSeNhT0cTRRi837jqXcYFsxzlwrY/C55foKsghvcNfFTN+tTb6keR5UuwPHpyXGIR
	 ZtKyVWpBhDF3PKFVcDjrcaP3d8D34Kgl1DVH7yOYZVmQkNZKypauFeluAfkJTSZ8YM
	 KF08WxneuP8tBIvfXIxuHqWappUwfeV+rK5ke+XHyIfW/+r36LxLZa7m/LYs3wpsI4
	 4f7FeHPISw3gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D3F4CE1148; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 05/21] rcu: Move rcu_tasks_trace_srcu_struct out of #ifdef CONFIG_TASKS_RCU_GENERIC
Date: Wed,  1 Oct 2025 07:48:16 -0700
Message-Id: <20251001144832.631770-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving the rcu_tasks_trace_srcu_struct structure instance out
from under the CONFIG_TASKS_RCU_GENERIC Kconfig option permits
the CONFIG_TASKS_TRACE_RCU Kconfig option to stop enabling this
CONFIG_TASKS_RCU_GENERIC Kconfig option.  This commit also therefore
makes it so.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/Kconfig |  2 +-
 kernel/rcu/tasks.h | 38 +++++++++++++-------------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 54b4c4aa553a4a..73a6cc364628b5 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -82,7 +82,7 @@ config NEED_SRCU_NMI_SAFE
 	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
 
 config TASKS_RCU_GENERIC
-	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
+	def_bool TASKS_RCU || TASKS_RUDE_RCU
 	help
 	  This option enables generic infrastructure code supporting
 	  task-based RCU implementations.  Not for manual selection.
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fd1fe80ddde484..833e180db744f2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1439,31 +1439,6 @@ EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
 
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
-////////////////////////////////////////////////////////////////////////
-//
-// Tracing variant of Tasks RCU.  This variant is designed to be used
-// to protect tracing hooks, including those of BPF.  This variant
-// is implemented via a straightforward mapping onto SRCU-fast.
-
-#ifdef CONFIG_TASKS_TRACE_RCU
-
-DEFINE_SRCU(rcu_tasks_trace_srcu_struct);
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
-
-// Placeholder to suppress build errors through transition period.
-void __init rcu_tasks_trace_suppress_unused(void)
-{
-	show_rcu_tasks_generic_gp_kthread(NULL, NULL);
-	rcu_spawn_tasks_kthread_generic(NULL);
-	synchronize_rcu_tasks_generic(NULL);
-	call_rcu_tasks_generic(NULL, NULL, NULL);
-	call_rcu_tasks_iw_wakeup(NULL);
-	cblist_init_generic(NULL);
-	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
-}
-
-#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-
 #ifndef CONFIG_TINY_RCU
 void show_rcu_tasks_gp_kthreads(void)
 {
@@ -1617,3 +1592,16 @@ core_initcall(rcu_init_tasks_generic);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+
+////////////////////////////////////////////////////////////////////////
+//
+// Tracing variant of Tasks RCU.  This variant is designed to be used
+// to protect tracing hooks, including those of BPF.  This variant
+// is implemented via a straightforward mapping onto SRCU-fast.
+
+DEFINE_SRCU(rcu_tasks_trace_srcu_struct);
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
+
+#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.40.1

