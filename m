Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795870130;
	b=rR6MYKYwR8Mznp8AXlxE7HnoqQQXTtcEG5Q1hmJivxmUNNaBRpvJjx4MpZE0NCxyHQec
	 jxeFT8RKYEfGg6sZzKBTRClmymJYPtdl3W+V86FpUoL8vtDesGJRYetsDJZazWnbb/HjS
	 Ap+uqUAoqLpTyPhTnWp4pSgf70h5sxb3jIfZKB22KIHpP6rFf8UVH803wtYTtsLPLyTlv
	 RvIh1P9Hg5il5pG1Luuxaf/TvP/OKUEUi0oAQBUE//9hnxc04q9lU/0klzcB8PyBVOFFl
	 tJCqJrSUMBJGsYuvGoOrAxAmWXfOfzTdCCNZc4stQNveURi1KUKKD04BY0S+OlkaxEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870130;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UF//dmNAJJzk/m2uhwoWmAftuEdeMTm9d9hiO3hH72s=;
	b=v141ZtHXHnIQiSVSp0WLr14Sp+AR74qJ5aa/zQFPp7xRPEwwG+fChsEkw9F7R3qy+F5j
	 oK13MsG+0gJr5iOnhEo8+5meeYe6OEob1SQiVXGyE04Wg5/XjeNqUgh0Df8BZkLm+WUxR
	 IHG/Nm2iawILq6Hc+JR2BPCEmBuMxK7i5A66HeY4aXjvvTr4i1t/ic/3OXBKQMK3yW5cC
	 90EEv2MSVI6qbz+ZcdEdVRT+8nZnmmrxFOMvLFUY8EhaMqbPEVz11Qn7lEPBZfHcTSxas
	 kU0KyC7bdscdZBsawGkpt/4dt2TFFg0AP2QvUmK2o2Lu7CfgDINUzTdl/Jxlj9rTZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gqUC3gX4;
	arc=none smtp.remote-ip=95.215.58.207
Received: from mta1.migadu.com (out-207.mta1.migadu.com [95.215.58.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA838606A31F
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 12:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA838606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gqUC3gX4
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5i4l49kDaQxjWbURdIJa0x3CEiJdxt+CawUN+fvPlrc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795870128; v=1; x=1796474928;
 b=gqUC3gX46XD/zf8qJbVwU5+IZkCfIYlAZlyx2pWHdbgOaGBjC6LQ28lA8KMGcTfW68aPQUOM
 BcrZ5rpFGUhp38oUXFZkN/dj2jS7SsXidu3r0g2DOpGOJKLrvm5Gn16ts/lv/oxetRvau85pJP+
 jule7HPS5pa/VNULekjqJh1c=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 957d714c61a12333;
	Sat, 28 Nov 2026 12:48:47 +0000
X-Mizu-Trace-ID: 957d714c61a12333
X-Migadu-Flow: FLOW_OUT
Date: Sat, 28 Nov 2026 12:48:47 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Sechang Lim <rhkrqnwk98@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <jfern@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
CC: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 rcu@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rcu: Mark rcu_read_unlock_special() notrace
In-Reply-To: <20261128061955.174288-1-rhkrqnwk98@gmail.com>
References: <20261128061955.174288-1-rhkrqnwk98@gmail.com>
Message-ID: <E81D3CA7-DB12-4A2E-BA60-C371FC420F77@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 November 2026 06:19:26 GMT, Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>The BPF trampoline takes and drops the RCU read lock itself. When the
>outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
>calls rcu_read_unlock_special(). If an fentry program is attached to
>rcu_read_unlock_special(), the unlock on the trampoline exit path still
>sees .s set and calls rcu_read_unlock_special() again, which recurses
>until the stack overflows:
>
>  BUG: TASK stack guard page was hit at ffffc90001657ff8
>  ...
>   bpf_trampoline_6442575622+0x5e/0xac
>   rcu_read_unlock_special+0x5/0x490
>   __rcu_read_unlock+0x9c/0x120
>   rcu_read_unlock_migrate+0x93/0x220
>   bpf_trampoline_6442575622+0x5e/0xac
>   rcu_read_unlock_special+0x5/0x490
>   ...
>
>With fexit it recurses even earlier, from percpu_ref_get() in
>__bpf_tramp_enter(), which takes and drops the RCU read lock before the
>program runs.
>
>Mark rcu_read_unlock_special() notrace. rcu_unlock_needs_exp_handling()
>also runs with .s set, so mark it notrace too.

I took a double look, like loads of looks, this seriously LGTM, like, I
like this, thanks for the patch,

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

>
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>---
>v4:
>- Go back to notrace as in v1
>- Also mark rcu_unlock_needs_exp_handling() notrace (Alexei)
>
>v3: https://lore.kernel.org/bpf/20261125055359.2715140-1-rhkrqnwk98@gmail.com/
>v2: https://lore.kernel.org/bpf/20261125040106.2200628-1-rhkrqnwk98@gmail.com/
>v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/
>
> kernel/rcu/tree_plugin.h | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>index 3500e4874833..9c1b227f5fa0 100644
>--- a/kernel/rcu/tree_plugin.h
>+++ b/kernel/rcu/tree_plugin.h
>@@ -689,10 +689,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  *
>  * Returns true if expedited processing of the rcu_read_unlock() is needed.
>  */
>-static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>-				      struct rcu_data *rdp,
>-				      struct rcu_node *rnp,
>-				      bool irqs_were_disabled)
>+static notrace bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>+						  struct rcu_data *rdp,
>+						  struct rcu_node *rnp,
>+						  bool irqs_were_disabled)
> {
> 	/*
> 	 * Check if this task is blocking an expedited grace period. If the
>@@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>  * notify RCU core processing or task having blocked during the RCU
>  * read-side critical section.
>  */
>-static void rcu_read_unlock_special(struct task_struct *t)
>+static notrace void rcu_read_unlock_special(struct task_struct *t)
> {
> 	unsigned long flags;
> 	bool irqs_were_disabled;
>
>base-commit: 2348d158c7fcc2c9557b2fb550ee841c62942fbd
>

--- Thanks!
