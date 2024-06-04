Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1714B07B;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540014; cv=none; b=MwZ1GWg/gf1ZrfphJ0ceSlsRVa6L/CcldBZc1P6LIpqLuuOry37T5YLbPL+2rpvvBuIaioYqidTMgPg0v+0MHQBPPMjGzfs180zx2syg0U/d7LrUm7S5H297bG2g7p0LWCO8NiA9mQbywtVeDf/WgfwLFzSifWvMvIkxt5vAdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540014; c=relaxed/simple;
	bh=eTYCEt4S09cbBIvwTWJRKuNdHno4GV8Da6nEtMiRHjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5/FdJT2z31+NJ53focm491XWppSkokGQjKEmWXjZhi0ReGHvBLtdoelMTyigzcTOjvwUKvNvXH4FXe0fLg7ick8D+HEqpiceYrKa9yniVe63Q9b9G2O1Mt9j0B2bnzGbvoNWIM59zHcv/2RLvhCc1484Hbe8MacDJQlZ3lyEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAWo6mlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAWo6mlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BED1C3277B;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540014;
	bh=eTYCEt4S09cbBIvwTWJRKuNdHno4GV8Da6nEtMiRHjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAWo6mlbDhfzDWNpWWScNcWSR5t5VJjBGdLPbUTLhzKQPUB6xgnFv3Pkw2fjANkGf
	 KBnEd95v9S+5oS4dmvUbGK6pRJh7Ud6ULW95udpU7SNUzrK7Tg3DQna6pG50RxRnr8
	 TVMLO7k9kCM5EJAI/zZZsgEFoAv60N+lFufHoJ7Gftcuqas5i+Wf0wK/pwpruv7v9+
	 n5naJIYMOBb+xMVqkVn1bSnsjDcpeH0/d1Y3C7HL/B1x482eGpkomdnV2KZiO/aHtb
	 5AosWwwxV+cs3avkEbCD1V2J5vwJ1yEDLeyVN5b3e+q6whrkWPzIA1ND1mu9gvo2rg
	 2rMFN2HCt1AXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EE455CE3F0F; Tue,  4 Jun 2024 15:26:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon first EQS snapshot
Date: Tue,  4 Jun 2024 15:26:48 -0700
Message-Id: <20240604222652.2370998-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When the grace period kthread checks the extended quiescent state
counter of a CPU, full ordering is necessary to ensure that either:

* If the GP kthread observes the remote target in an extended quiescent
  state, then that target must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it exits that extended quiescent state.

or:

* If the GP kthread observes the remote target NOT in an extended
  quiescent state, then the target further entering in an extended
  quiescent state must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it enters that extended quiescent state.

This ordering is enforced through a full memory barrier placed right
before taking the first EQS snapshot. However this is superfluous
because the snapshot is taken while holding the target's rnp lock which
provides the necessary ordering through its chain of
smp_mb__after_unlock_lock().

Remove the needless explicit barrier before the snapshot and put a
comment about the implicit barrier newly relied upon here.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++---
 kernel/rcu/tree.c                                          | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 5750f125361b0..728b1e690c646 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
-The grace-period kthread invokes ``rcu_dynticks_snap()`` and
-``rcu_dynticks_in_eqs_since()`` (both of which invoke
-an ``atomic_add_return()`` of zero) to detect idle CPUs.
+The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
+(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
+(both of which rely on acquire semantics) to detect idle CPUs.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f07b8bff4621b..1a6ef9c5c949e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
+	/*
+	 * Full ordering against accesses prior current GP and also against
+	 * current GP sequence number is enforced by current rnp locking
+	 * with chained smp_mb__after_unlock_lock().
+	 */
+	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
-- 
2.40.1

