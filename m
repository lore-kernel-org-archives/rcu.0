Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426103537E0;
	Tue, 29 Sep 2026 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641159; cv=none; b=MrJKr9GzUW5Q6euuWOinOGZXZOr3h4vadI6f4j6jWAdyfMt7rcZtpkWYc7+jRQBV3O++S9r4AdpifaefaWazQ+3dy556+82tTYvG5+Zayarm9IWy2s8omZreJXVKuDvQuWjRZAY3AQpi8NnIe3vJFMnGr+99HV/0nUrr70dWySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641159; c=relaxed/simple;
	bh=f4M0na3TTgrDUfdd+Rya8TMCa7o41CInfo0IcNmDj4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EoMhVhV6WEPEbeLX4lQSmh73+v0PMUxyIkI00Ra+WeFUOZP4eM9nXJGna//sEo5oMyT34wN7qZHU0cZZgQAvgxi1VQj3hgNFKS673Us7pZYUNxm8CsJLCwSgS/ENRRTDNi8trken6iH9L68CPPCx5GEhjpJ5t+N4FmHCUIWjyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMMSv/+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMMSv/+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CDB1F000FF;
	Tue, 29 Sep 2026 00:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641156;
	bh=h+G2VNrnKZlrsJmMOrkWRzG9gN3oOhIYpHLTvyN6bZQ=;
	h=From:To:Cc:Subject:Date;
	b=EMMSv/+0BHsi8kQS5dVPoQ80KzWDWtJfFJefsEnHikwgnayqQ9M3Q/9D4e40U75hk
	 9F5ttlH89ivo3S4KK775aoSeiCI4GfgGlTBeflOguW1kwVNwzP2VinCDof7qf2YRTG
	 Xfp0LbBxMTo8CCY2riiwZ+Og3eCfgnuC923smRnOrbc9S50hq4iH3/8kH5P58Rre9k
	 pT7GMM102oX5nKOiWBJCx8jAZW30YPY1wXF9QWDamRZ9X6LXq3YwLPT9+5JnZL5Txi
	 +0U+ZHHBWuy6lWLOuhJdpf6gAz+fQiJmkLf4j1VtwXGCcFPVxxKwqa/h4z5sB2Fkis
	 QXap2Rv1D66Kw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH] fprobe: Use guard(rcu_sched_notrace) and check rcu_is_watching()
Date: Tue, 29 Sep 2026 09:19:12 +0900
Message-ID: <179064115227.394389.16910234241400391996.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

unregister_fprobe() and unregister_fprobe_async() (used by BPF
kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
and call_rcu()) to wait until in-flight fprobe handlers complete before
freeing the fprobe.

However, if an fprobe handler executes while RCU is not watching (such
as in the idle loop or nohz_full extended quiescent states), standard
RCU does not track preemption-disabled sections. Consequently,
synchronize_rcu() does not wait for those executions, which can lead
to a use-after-free if the fprobe is freed immediately after
unregistration. Ensure handlers exit early when !rcu_is_watching().

Furthermore, fprobe_fgraph_entry() and fprobe_ftrace_entry() previously
used guard(rcu)() and rcu_read_lock(), which invoke lockdep on every
hit under CONFIG_PROVE_LOCKING. This adds overhead and can cause lockdep
recursion if probed functions interact with lockdep.

Since rhltable_lookup() and rhl_for_each_entry_rcu() use
rcu_dereference_all_check() (which checks rcu_read_lock_any_held()),
holding preemption disabled via rcu_read_lock_sched_notrace() is fully
valid and sufficient so long as rcu_is_watching() is true.

Define and use guard(rcu_sched_notrace)() across fprobe_ftrace_entry(),
fprobe_fgraph_entry(), and fprobe_return(). This eliminates fast-path
rcu_read_lock() and lockdep overhead while guaranteeing safe grace
period synchronization.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace period")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9f2d98181779..da286619c5d8 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -47,6 +47,10 @@ static struct rhltable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
 static struct fgraph_ops fprobe_graph_ops;
 
+DEFINE_LOCK_GUARD_0(rcu_sched_notrace,
+		    rcu_read_lock_sched_notrace(),
+		    rcu_read_unlock_sched_notrace())
+
 static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
 	return hash_ptr(*(unsigned long **)data, 32);
@@ -329,16 +333,14 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct fprobe *fp;
 	int bit;
 
+	if (!rcu_is_watching())
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
 
-	/*
-	 * ftrace_test_recursion_trylock() disables preemption, but
-	 * rhltable_lookup() checks whether rcu_read_lcok is held.
-	 * So we take rcu_read_lock() here.
-	 */
-	rcu_read_lock();
+	guard(rcu_sched_notrace)();
 	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
 
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
@@ -353,7 +355,6 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 		else
 			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
 	}
-	rcu_read_unlock();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_ftrace_entry);
@@ -567,10 +568,13 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 	struct fprobe *fp;
 	int used, ret;
 
+	if (!rcu_is_watching())
+		return 0;
+
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
-	guard(rcu)();
+	guard(rcu_sched_notrace)();
 	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
 	reserved_words = 0;
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
@@ -665,13 +669,16 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	int size, curr;
 	int size_words;
 
+	if (!rcu_is_watching())
+		return;
+
 	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
 	if (WARN_ON_ONCE(!fgraph_data))
 		return;
 	size_words = SIZE_IN_LONG(size);
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
-	preempt_disable_notrace();
+	guard(rcu_sched_notrace)();
 
 	curr = 0;
 	while (size_words > curr) {
@@ -687,7 +694,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		}
 		curr += size;
 	}
-	preempt_enable_notrace();
 }
 NOKPROBE_SYMBOL(fprobe_return);
 

