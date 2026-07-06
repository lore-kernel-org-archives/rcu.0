Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C543B7B68;
	Mon,  6 Jul 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358886; cv=none; b=Q3D1HZ8mwOhwzMo+uMoUyNqApakuHIeddIhSL1ho2fvmBWXY2j08eur66ykXsftI/BCM+FYWrBmhjYuNnoAam9IAO1+/ZPItOkd/vkFNEVBe1KEPwKPjkBx5SLx1GZEbqK9/xTh5loSbIVJpLdVWW6Sx8I46ACH6rjZcOqTSrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358886; c=relaxed/simple;
	bh=SYFpDKAk8+dFtlASujFsmgU216MKeio7L6quS4HPEBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZhxhWjjq8Jk8ENvo7PMcO8cT6nNTY8JXHaMQVfxJeY9YzRtmZQ8MtoLU8t8k3m9PDCqG9W7ukIb7aF+OQzVpSRImg0DZMUfK+TxsvXwRW0s83UtTyhTa/5w2bQTQCIHUNtBAhvM/pTyWZ8U7kpgEfVcOnS6wZuLkdWt1sni0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKACWxd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKACWxd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7533E1F000E9;
	Mon,  6 Jul 2026 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783358884;
	bh=5nL9Cg67aT7fpoC4oBGnVgDZdUYDNOflSikqbePlEFk=;
	h=From:To:Cc:Subject:Date;
	b=RKACWxd3s9uvx06CEHCTYK4zZcHUQXhKTk4i/YrXpmZMLC3XsrfQF+T4i8AtOWI3C
	 R3NhclRz0L+ONPDkWUxhgZzPgP/HQMrMIgl0IDE0RUFBF+RlP5CnNvw9qo45q7WFcP
	 BoklitrvITbH5atWgdx6QjKCMuQVdRNZJCiG55DJkKlHaTSNlZ0USEVu+OnjgqlnsO
	 TAMIWHJOtvpg6kKxe5tR2CIvwLLbPO1cFu85Ij1Gif7TiWnzr311+VzY5hZtVBKN68
	 hSS9NAljcyQlQl47UXzbwRZ1AGWHai9/DBGL9PPY2S/5t+jznVx5JrAh5HEddGJX3r
	 94dLvm25w7D4A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
Date: Mon,  6 Jul 2026 10:27:40 -0700
Message-ID: <20260706172744.3920417-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uretprobes_srcu currently uses normal SRCU. Normal SRCU issues an
smp_mb() on both srcu_read_lock() and srcu_read_unlock(), i.e. two full
memory barriers per read-side critical section. For uretprobes this cost
is paid on every uretprobe invocation: prepare_uretprobe() takes the
read lock that is later dropped on the normal return path
(hprobe_finalize()) or from ri_timer()/dup_utask() (hprobe_expire()).

Switch uretprobes_srcu to the SRCU-fast-updown flavor. SRCU-fast moves
the read-side ordering off the reader and onto the (rare) grace-period
side: synchronize_srcu() rides on synchronize_rcu() instead of relying
on reader-side smp_mb(). This is a good trade for uretprobes, where
reader-side hits vastly outnumber grace periods (uprobe unregistration).

The updown variant (rather than plain SRCU-fast) is required because the
read lock is acquired in prepare_uretprobe() on the way out to user
space and is released only once the return instance is finalized -- from
a different context than it was taken: the normal return path
(uprobe_handle_trampoline() -> hprobe_finalize()), the timer callback,
or the fork path (ri_timer()/dup_utask() -> hprobe_expire()).
srcu_down_read_fast()/srcu_up_read_fast() are designed for this
semaphore-like, cross-context pattern and, unlike the same-context
srcu_read_lock_fast() variant, do not carry lockdep read-side tracking
that would warn on it -- which is why the old code had to use the raw
__srcu_read_lock() here. For the short, same-context sections in
ri_timer() and dup_utask(), guard(srcu_fast_updown) is used instead,
giving proper lockdep coverage.

Patch 1 adds the guard(srcu_fast_updown) definition, following the
existing guard(srcu)/guard(srcu_fast) pattern.
Patch 2 does the uretprobes_srcu conversion.

Note
----
Only uretprobes_srcu is converted; the main uprobe readers (RB-tree
lookup and consumer-list iteration) are deliberately left on RCU Tasks
Trace. RCU Tasks Trace is already implemented on top of
srcu_read_lock_fast(), so the reader-side cost is identical, and it has
a nesting fast path that the uprobe -> sleepable-BPF-program call chain
relies on (the BPF trampoline takes rcu_read_lock_trace() while uprobes
already holds it; the nested acquire is just a counter bump). Converting
those readers to a separate srcu_struct would turn one real + one nested
lock into two real locks and lose that optimization for no reader-side
gain. uretprobes_srcu is different: it uses normal SRCU (not Tasks
Trace), its readers are long-lived and cross-context, and it genuinely
benefits from dropping the per-reader barriers.

Puranjay Mohan (2):
  srcu: Add lock guard for srcu_fast_updown flavor
  uprobes: Switch uretprobes_srcu to SRCU-fast-updown

 include/linux/srcu.h    |  7 +++++++
 include/linux/uprobes.h |  5 +++--
 kernel/events/uprobes.c | 29 +++++++++++++++++------------
 3 files changed, 27 insertions(+), 14 deletions(-)


base-commit: 87bfe634b1193db90e5170e1ddbad04a63ef4501
-- 
2.53.0-Meta

