Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E318C002;
	Fri, 13 Dec 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119390; cv=none; b=K3z5GEwNgX/2HSdrooHhY0OCazN515SEDUqKe4hjOeuFk6v+TqVsa4FM4hAlqYFBYY7cNWwfCPUgb6KHjfqwJ/1Xd2mj3uDL8MuS9ZUjITavbaasTgoW9HsennztGgoZqk8CBkg8LuIYnxc6iH+ZcwaAJ6HzKtqBtoO38gCHdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119390; c=relaxed/simple;
	bh=+o+mvnqZTJP7gt8olhH5rlsdpb9WCYcqAv8nwKQMpYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMTVP8IPkErCHIzOtTVbwedG16uL+NalQ1IDXAmAz8G+8EWVpyCqsLB8XXJVgOtvpa7NG30Z6lBRrEwkmilZl0V/cvcwJ7KtABhjoBlfPw3I/Ziy0nv/mkS5Le/nAD4ib11N/PCRLkJOsu5YKR+ZT6bdl/HJuUKEJO/zXi+nmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULP8Xe48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULP8Xe48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED355C4CED0;
	Fri, 13 Dec 2024 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119390;
	bh=+o+mvnqZTJP7gt8olhH5rlsdpb9WCYcqAv8nwKQMpYw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ULP8Xe48Y8M2g4sIlmL1qJErMw4S1Q9Us7ch4lm2RjV0nHyD1/M4mYfFyFO37oWzY
	 vvTi9fWIjxj29sZH5g4NPsHDZb40oiIq0MHXeyIhGkD2xeALoyB6mKlQAFsqcU3O4a
	 6Ee1INW92xifcejSkVdlDe3eMNGG+BtrUn6h5jaLNZvbOrBX0XrGlg9y16cF6BTqbx
	 F1lkh/ZA9oasSc48F0pqI0DGNUV+6Ae/kgaZfCQroDSTBeoqxT6ThFQ21MixoNTg4t
	 Ap36Y9St+Q18kGZZYon0HywDKooFa5ZzV7Zd/1m2TZlUNP+u2tGmTtZGtblEdLoARB
	 AhWUGxzjHYZpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CEC4CE09E4; Fri, 13 Dec 2024 11:49:49 -0800 (PST)
Date: Fri, 13 Dec 2024 11:49:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>

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

1.      CPU 0 starts a new grace period, and updates rcu_state.gp_seq
        accordingly.

2.      As its first step of grace-period initialization, CPU 0 examines
        the current CPU hotplug state and decides that it need not wait
        for CPU 1, which is currently offline.

3.      CPU 1 comes online, and updates its state.  But this does not
        affect the current grace period, but rather the one after that.
        After all, CPU 1 was offline when the current grace period
        started, so all pre-existing RCU readers on CPU 1 must have
        completed or been preempted before it last went offline.
        The current grace period therefore has nothing it needs to wait
        for on CPU 1.

4.      CPU 1 switches to an rcutorture kthread which is running
        rcutorture's rcu_torture_reader() function, which starts a new
        RCU reader.

5.      CPU 2 is running rcutorture's rcu_torture_writer() function
        and collects a new polled grace-period "cookie" using
        get_state_synchronize_rcu_full().  Because the newly started
        grace period has not completed initialization, the root rcu_node
        structure's ->gp_seq field has not yet been updated to indicate
        that this new grace period has already started.

        This cookie is therefore set up for the end of the current grace
        period (rather than the end of the following grace period).

6.      CPU 0 finishes grace-period initialization.

7.      If CPU 1’s rcutorture reader is preempted, it will be added to
        the ->blkd_tasks list, but because CPU 1’s ->qsmask bit is not
        set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
        will not be updated.  Thus, this grace period will not wait on
        it.  Which is only fair, given that the CPU did not come online
        until after the grace period officially started.

8.      CPUs 0 and 2 then detect the new grace period and then report
        a quiescent state to the RCU core.

9.      Because CPU 1 was offline at the start of the current grace
        period, CPUs 0 and 2 are the only CPUs that this grace period
        needs to wait on.  So the grace period ends and post-grace-period
        cleanup starts.  In particular, the root rcu_node structure's
        ->gp_seq field is updated to indicate that this grace period
        has now ended.

10.     CPU 2 continues running rcu_torture_writer() and sees that,
        from the viewpoint of the root rcu_node structure consulted by
        the poll_state_synchronize_rcu_full() function, the grace period
        has ended.  It therefore updates state accordingly.

11.     CPU 1 is still running the same RCU reader, which notices this
        update and thus complains about the too-short grace period.

The fix is for the get_state_synchronize_rcu_full() function to use
rcu_state.gp_seq instead of the the root rcu_node structure's ->gp_seq
field.  With this change in place, if step 5's cookie indicates that the
grace period has not yet started, then any prior code executed by CPU 2
must have happened before CPU 1 came online.  This will in turn prevent
CPU 1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
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
get_completed*() and poll_state*()"), it is not clear that it is worth
backporting this commit.  First, it took me many weeks to convince
rcutorture to reproduce this more frequently than once per year.  Second,
this cannot be reproduced at all without frequent CPU-hotplug operations,
as in waiting all of 50 milliseconds from the end of the previous
operation until starting the next one.  Third, the TREE03.boot settings
cause multi-millisecond delays during RCU grace-period initialization,
which greatly increase the probability of the above sequence of events.
(Don't do this in production workloads!)  Fourth, extremely heavy use of
get_state_synchronize_rcu_full() and/or poll_state_synchronize_rcu_full()
is required to reproduce this, and as of v6.12, only kfree_rcu() uses it,
and even then not particularly heavily.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

---

Changes since RFC v1:

o	Update rcu_seq_done_exact() to handle backwards-gp_seq effects
	of get_state_synchronize_rcu_full() using rcu_state.gp_seq and
	poll_state_synchronize_rcu_full() continuing to use the root
	rcu_node structure's ->gp_seq field.  With this commit, rcutorture
	passes 10 hours of 400 instances of TREE03.  Without this commit,
	there are about 50 too-short grace periods per hour, again with
	400 instances of TREE03.

o	Add TREE03.boot's multi-millisecond delays for grace-period
	initialization.

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 2f9c9272cd486..d2a91f705a4ab 100644
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
index 980f1fa719665..71620a8a2eb3d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4204,14 +4204,17 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
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
