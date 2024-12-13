Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300B17C61;
	Fri, 13 Dec 2024 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734051561; cv=none; b=UANvMMc4QI/L4cTkFNu6hzNKlSGvv07XUnXF/6OTNh9VabdtrtrODqswLB6zn0cujjQoUcaGnYmw4dK9A0eaEI+419Z6uWjpXN+aVnn1U03QYCtrF7uGXgye1JDLeTKrPALcH78jniyAR7QO7lb3WYhA9fhQUQRbkMmNLU6ZhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734051561; c=relaxed/simple;
	bh=4qLhceJW6aN0/OJOSUt56lRronabnyMeEr0mGVlrkCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WwcWIP+4ugh8ZCu5Yk61jgNWAyV8R6xUZCUokTFTjyIBqzQ8Ec6Tt8kHY8fb31AAaYAWw0a7lyW4gRKTeWCS5gVNVFGPn1O+220IoUzEwEXVgEpG2/3CtstNepugXgkxPtMdCNVLAAKy5Z1EiwSE6QrtBwQTe5tds2IkkGC8CSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il1p1GMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il1p1GMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C16BC4CECE;
	Fri, 13 Dec 2024 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734051561;
	bh=4qLhceJW6aN0/OJOSUt56lRronabnyMeEr0mGVlrkCQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=Il1p1GMXwee8VXF2FB0Gf4nA9/+AynWVTqJ26oicSJ5VL6ACbACCOVrHZ5jR6CtNF
	 4W7BW+EpVf/t9o34iHc3TeXKfiSm5athY2cP8ncYxf94sy/LPloPRJPaTxsRVnQ19w
	 3qscEt7Id87zbR/GRkVk2+2vmmp7eDa8q+UNlYDTIWDrwrT26W7/jZtEOGUsJn9oZJ
	 xsEgQKnyaJqY2rY5rVTSmC6+ch6pGz1YZp0ULS/GX/GsfEOLQ9RoI7bPSDvAo+E5Gz
	 09ZJ8vnUiUHa+wOUAgMfb+EmcXP4IQKEk1y2DJiIiFFY3JWQw/p/4Y7mPslkoNreO0
	 HwF0SBSDU+SHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7D42CE09DB; Thu, 12 Dec 2024 16:59:20 -0800 (PST)
Date: Thu, 12 Dec 2024 16:59:20 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH RFC rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Although this fixes 91a967fd6934 ("rcu: Add full-sized polling for
get_completed*() and poll_state*()"), it is not clear that it is worth
backporting this commit.  First, it took me many weeks to convince
rcutorture to reproduce this more frequently than once per year.  Second,
this cannot be reproduced at all without frequent CPU-hotplug operations,
as in waiting all of 50 milliseconds from the end of the previous
operation until starting the next one.  Third, extremely heavy use of
get_state_synchronize_rcu_full() and/or poll_state_synchronize_rcu_full()
is required to reproduce this, and as of v6.12, only kfree_rcu() uses it,
and even then not particularly heavily.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

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
