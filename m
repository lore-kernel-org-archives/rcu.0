Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89333603E9;
	Fri, 17 Apr 2026 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467552; cv=none; b=GmLNU205eLNcABRDUxWveEa9u+pOCoL/5/88LZIP7l0te5lFsoT6Vvgd44KKaZOpWK8XZID9BJ9Dpwy5L3hibZdK9x8h5u5Lrx2jHNXc4xX6lGhilFWnfvcU74dqQ7H0JygFivfX5motoYtym3K7gfL0Hn/fAU//3hQMYRInYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467552; c=relaxed/simple;
	bh=1W7O0Gupk/fhCc1ZvalgWFm75zQLOtGkGPJtXSmJ+Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0VeVeMdGIhXngpRgTfBqoHPAP8t/zg0LkwZ8Q2A1iM/hZ/jWiZPnY6f/oeNLxyEYYjA+15E/s8UgsuqCIV0kB5Efbam0z1Rcx8pBlgU5pf7t+2jYxsj+WX2XKdncVSUYD5kEwwCVgd95zfPU+0IqqIavx7gSlO2XR9l5uaqM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzhpFV/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzhpFV/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41370C19425;
	Fri, 17 Apr 2026 23:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467552;
	bh=1W7O0Gupk/fhCc1ZvalgWFm75zQLOtGkGPJtXSmJ+Hg=;
	h=From:To:Cc:Subject:Date:From;
	b=hzhpFV/P+/Kzj6s/3YEI1/0sVcXIwBOyeQaEeP3jTb/9hCZyrnd5oA0xMGr5RSVWN
	 Lwlo60piqiVB5nuIbxYFtgHq8DqqoaohVx8sDjqJYPAYVKn50KHVV1f90pVfvRz8Ad
	 Teh14zWiktcvUrl7HMjr9Uwnus2y/w14679VHOerJ9GnW7+s+euVrDKMUCcPLFw/wc
	 zuTvb7QcO+12bpGkRMtwZSA+v9d4AR7wrju6WyfNtghExyTnh2+g4Dy9dm9enwGv+q
	 XlCzgHcvh875s/6/VKX6ldnpkQXTQdHNMBWeO5dZHLs0TabAfc5Iwr78TxabaNxATX
	 tFg+qT2JQ9A8w==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH 00/10] RCU: Enable callbacks to benefit from expedited grace periods
Date: Fri, 17 Apr 2026 16:11:48 -0700
Message-ID: <20260417231203.785172-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU callbacks only track normal grace period sequence numbers. This
means callbacks must wait for normal GPs even when expedited GPs have
already elapsed.

This series tracks both normal and expedited GP sequences in the
callback infrastructure using struct rcu_gp_oldstate, so callbacks
advance when either GP type completes.

Commits 1-4 prepare the callback infrastructure: SRCU and Tasks RCU are
isolated behind wrapper functions, the segment compaction logic is
factored out for reuse, gp_seq is widened to struct rcu_gp_oldstate, and
RCU_GET_STATE_NOT_TRACKED is added for subsystems that do not track
expedited GPs.

Commit 5 is the core change: rcu_segcblist_advance() checks both normal
and expedited GP completion via poll_state_synchronize_rcu_full(), and
rcu_accelerate_cbs() captures both GP sequences via
get_state_synchronize_rcu_full(). SRCU wrappers become standalone
implementations since they cannot use poll_state_synchronize_rcu_full()
which reads RCU-specific globals.

Commits 7-9 fix three notification paths so that expedited GP completion
triggers callback processing: NOCB rcuog kthreads are woken,
rcu_pending() detects the completion, and rcu_core() advances the
callbacks.

Commit 10 adds nexp and exp_interval parameters to rcuscale for testing
callback drain under concurrent expedited GP load.

Puranjay Mohan (10):
  rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
  rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
  rcu/segcblist: Change gp_seq to struct rcu_gp_oldstate gp_seq_full
  rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
    GPs
  rcu: Enable RCU callbacks to benefit from expedited grace periods
  rcu: Update comments for gp_seq_full and expedited GP tracking
  rcu: Wake NOCB rcuog kthreads on expedited grace period completion
  rcu: Detect expedited grace period completion in rcu_pending()
  rcu: Advance callbacks for expedited GP completion in rcu_core()
  rcuscale: Add concurrent expedited GP threads for callback scaling
    tests

 include/linux/rcu_segcblist.h |  16 ++--
 include/trace/events/rcu.h    |   5 +-
 kernel/rcu/rcu.h              |  13 ++-
 kernel/rcu/rcu_segcblist.c    | 145 ++++++++++++++++++++++++----------
 kernel/rcu/rcu_segcblist.h    |   8 +-
 kernel/rcu/rcuscale.c         |  84 +++++++++++++++++++-
 kernel/rcu/srcutree.c         |  14 ++--
 kernel/rcu/tasks.h            |   8 +-
 kernel/rcu/tree.c             |  54 +++++++++----
 kernel/rcu/tree.h             |   1 +
 kernel/rcu/tree_exp.h         |   1 +
 kernel/rcu/tree_nocb.h        |  77 ++++++++++++++----
 12 files changed, 324 insertions(+), 102 deletions(-)


base-commit: 51289896149317e0b6a4abf5d300a569c3353dca
-- 
2.52.0

