Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E21E9B01;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263202; cv=none; b=YRXQb2Y+sq91ZhmSP1FkmPqmQHL6EiGXIpG0MYBXulr6GwctIhTMV9wW80cPsA/Ys2cffsvWmkKDZfMaw1Hy3fbDIdv5UOCPysODU/w0CCUUREvbYneVsanHJx8gAp8PbEFSzPImTGi57poxbe+sR/NClHcWWByKwwud3jJoRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263202; c=relaxed/simple;
	bh=pBWQM9gWJIzjISp4BjGZfF1gSaGnjnAPOa+nW921OjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgbOTfs2ApbQgZr9c4PRN626TLIafXDELIhY2WDsh0UaEq08OkkVbcmljbb8S6xK1WUJ1qCS7OFhRLul6+pk+n65uqj6wOvc8j7GUgj+TrCNl9OuXJqUnHr5VTjYjVsF9ND1WDA0ejiDPQoAvuQrHNWqcClcD6bfk9lrsYkxUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEF0dVkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEF0dVkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351CFC4CEE3;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263202;
	bh=pBWQM9gWJIzjISp4BjGZfF1gSaGnjnAPOa+nW921OjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEF0dVkMM9tuQWUWVmRfABSxADy/9QiyuTy3w/XwXtQ5yGlQPhzKjVFW0NEy3Nqs/
	 G1XUn6XmlrHFXCHOCf+QpuMUUTISORIxrhWJbyhtfxRhtaUXx9Ms5+fF/RkR4uh9JW
	 RzbYwyUjD/eaIO7JIBrbfgsiBAi+vGPtZ1hKZEvC5oJ2p5FU6xIYd3UqdttJ0nMmLW
	 pT90FK5fWBVaf+ta0Qxmu1hDhPWiTjQqol88LZ3AWT1qJEel/6WljJMB3zvHtN9Rto
	 Hm2ICrXZIQGYCjt7dIR4j/ehT7qKDuauE1IPVHIPS+M/N9l34VdW7K3Fe5vJopVmRX
	 fEFsLbXmqJaDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D23EECE37DC; Thu, 30 Jan 2025 10:53:21 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu v2] 3/5] rcu: Fix get_state_synchronize_rcu_full() GP-start detection
Date: Thu, 30 Jan 2025 10:53:18 -0800
Message-Id: <20250130185320.1651910-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
functions use the root rcu_node structure's ->gp_seq field to detect
the beginnings and ends of grace periods, respectively.  This choice is
necessary for the poll_state_synchronize_rcu_full() function because
(give or take counter wrap), the following sequence is guaranteed not
to trigger:

	get_state_synchronize_rcu_full(&rgos);
	synchronize_rcu();
	WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));

The RCU callbacks that awaken synchronize_rcu() instances are
guaranteed not to be invoked before the root rcu_node structure's
->gp_seq field is updated to indicate the end of the grace period.
However, these callbacks might start being invoked immediately
thereafter, in particular, before rcu_state.gp_seq has been updated.
Therefore, poll_state_synchronize_rcu_full() must refer to the
root rcu_node structure's ->gp_seq field.  Because this field is
updated under this structure's ->lock, any code following a call to
poll_state_synchronize_rcu_full() will be fully ordered after the
full grace-period computation, as is required by RCU's memory-ordering
semantics.

By symmetry, the get_state_synchronize_rcu_full() function should also
use this same root rcu_node structure's ->gp_seq field.  But it turns out
that symmetry is profoundly (though extremely infrequently) destructive
in this case.  To see this, consider the following sequence of events:

1.	CPU 0 starts a new grace period, and updates rcu_state.gp_seq
	accordingly.

2.	As its first step of grace-period initialization, CPU 0 examines
	the current CPU hotplug state and decides that it need not wait
	for CPU 1, which is currently offline.

3.	CPU 1 comes online, and updates its state.  But this does not
	affect the current grace period, but rather the one after that.
	After all, CPU 1 was offline when the current grace period
	started, so all pre-existing RCU readers on CPU 1 must have
	completed or been preempted before it last went offline.
	The current grace period therefore has nothing it needs to wait
	for on CPU 1.

4.	CPU 1 switches to an rcutorture kthread which is running
	rcutorture's rcu_torture_reader() function, which starts a new
	RCU reader.

5.	CPU 2 is running rcutorture's rcu_torture_writer() function
	and collects a new polled grace-period "cookie" using
	get_state_synchronize_rcu_full().  Because the newly started
	grace period has not completed initialization, the root rcu_node
	structure's ->gp_seq field has not yet been updated to indicate
	that this new grace period has already started.

	This cookie is therefore set up for the end of the current grace
	period (rather than the end of the following grace period).

6.	CPU 0 finishes grace-period initialization.

7.	If CPU 1’s rcutorture reader is preempted, it will be added to
	the ->blkd_tasks list, but because CPU 1’s ->qsmask bit is not
	set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
	will not be updated.  Thus, this grace period will not wait on
	it.  Which is only fair, given that the CPU did not come online
	until after the grace period officially started.

8.	CPUs 0 and 2 then detect the new grace period and then report
	a quiescent state to the RCU core.

9.	Because CPU 1 was offline at the start of the current grace
	period, CPUs 0 and 2 are the only CPUs that this grace period
	needs to wait on.  So the grace period ends and post-grace-period
	cleanup starts.  In particular, the root rcu_node structure's
	->gp_seq field is updated to indicate that this grace period
	has now ended.

10.	CPU 2 continues running rcu_torture_writer() and sees that,
	from the viewpoint of the root rcu_node structure consulted by
	the poll_state_synchronize_rcu_full() function, the grace period
	has ended.  It therefore updates state accordingly.

11.	CPU 1 is still running the same RCU reader, which notices this
	update and thus complains about the too-short grace period.

The fix is for the get_state_synchronize_rcu_full() function to use
rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq field.
With this change in place, if step 5's cookie indicates that the grace
period has not yet started, then any prior code executed by CPU 2 must
have happened before CPU 1 came online.  This will in turn prevent CPU
1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
thus preventing CPU 1 from being subjected to a too-short grace period.

This commit therefore makes this change.  Note that there is no change to
the poll_state_synchronize_rcu_full() function, which as noted above,
must continue to use the root rcu_node structure's ->gp_seq field.
This is of course an asymmetry between these two functions, but is an
asymmetry that is absolutely required for correct operation.  It is a
common human tendency to greatly value symmetry, and sometimes symmetry
is a wonderful thing.  Other times, symmetry results in poor performance.
But in this case, symmetry is just plain wrong.

Nevertheless, the asymmetry does require an additional adjustment.
It is possible for get_state_synchronize_rcu_full() to see a given
grace period as having started, but for an immediately following
poll_state_synchronize_rcu_full() to see it as having not yet started.
Given the current rcu_seq_done_exact() implementation, this will
result in a false-positive indication that the grace period is done
from poll_state_synchronize_rcu_full().  This is dealt with by making
rcu_seq_done_exact() reach back three grace periods rather than just
two of them.

Although this fixes 91a967fd6934 ("rcu: Add full-sized polling for
get_completed*() and poll_state*()"), it is not clear that it is
worth backporting this commit.  First, it took me many weeks to
convince rcutorture to reproduce this more frequently than once
per year.  Second, this cannot be reproduced at all without frequent
CPU-hotplug operations, as in waiting all of 50 milliseconds from the
end of the previous operation until starting the next one.  Third,
the TREE03.boot settings cause multi-millisecond delays during RCU
grace-period initialization, which greatly increase the probability of
the above sequence of events.  (Don't do this in production workloads!)
Fourth, the TREE03 rcutorture scenario was modified to use four-CPU
guest OSes, to have a single-rcu_node combining tree, no testing of RCU
priority boosting, and no random preemption, and these modifications
were necessary to reproduce this issue in a reasonable timeframe.
Fifth, extremely heavy use of get_state_synchronize_rcu_full() and/or
poll_state_synchronize_rcu_full() is required to reproduce this, and as of
v6.12, only kfree_rcu() uses it, and even then not particularly heavily.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcu.h  | 2 +-
 kernel/rcu/tree.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..f87c9d6d36fc 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
 	unsigned long cur_s = READ_ONCE(*sp);
 
-	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e49bcb86b6d3..9ba34206e20d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4197,14 +4197,17 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
-	struct rcu_node *rnp = rcu_get_root();
-
 	/*
 	 * Any prior manipulation of RCU-protected data must happen
 	 * before the loads from ->gp_seq and ->expedited_sequence.
 	 */
 	smp_mb();  /* ^^^ */
-	rgosp->rgos_norm = rcu_seq_snap(&rnp->gp_seq);
+
+	// Yes, rcu_state.gp_seq, not rnp_root->gp_seq, the latter's use
+	// in poll_state_synchronize_rcu_full() notwithstanding.  Use of
+	// the latter here would result in too-short grace periods due to
+	// interactions with newly onlined CPUs.
+	rgosp->rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
 	rgosp->rgos_exp = rcu_seq_snap(&rcu_state.expedited_sequence);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
-- 
2.40.1

