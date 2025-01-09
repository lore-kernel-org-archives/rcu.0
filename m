Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231619C556
	for <rcu@vger.kernel.org>; Thu,  9 Jan 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449664; cv=none; b=SaiEYXyD6NItKUDM/uKq90qXtEHfWD8Egnqb3wDjafgZW6w8LAobpejgvHax4YafudUId5VhSRI9QxCZT6Gtj2GZunUd+uDBLztE7Mqxzgq+P3uScz8ZMRTSWXsgBrRVyZefmltTNaO8VYTMTcNw2L5aQy8j8MIkEJ0+BTL0vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449664; c=relaxed/simple;
	bh=DPkQ40FBUAaj9IHEH0Qec+XhXevOidtvsQHxrPGjdJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=udVte7Lds+E/I6k9WoRnN8WFms1bG7zmlGlFYNs6sq28jPxHXRy2Hb5pTrILN3Thsj6K+DWKyu3ASmuxRLuGEEGShLSOmzwtZyr/serJ8p2Du2vRtcnjWLHV8n+cTyrpT2IoaGCw4omo6QuGFAciUteAPYQKYyeaAqMlBLBAaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOEXCfZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOEXCfZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B8C4CED2;
	Thu,  9 Jan 2025 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736449663;
	bh=DPkQ40FBUAaj9IHEH0Qec+XhXevOidtvsQHxrPGjdJg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=uOEXCfZzVKezzlC80jmDU+zt8jKuPsmh8gU56nS7XvMvwduFwww0989GGpOpKfhcD
	 8Ny/8qTgq/L4jiTQPsj2OB7WTWRBy8KZfPwOlvbI0rR4LXwXmpyaPSlzUTlrNk8Kse
	 4UTauw+BwRAcR56c5vlVqMSxTvwGlba/6jA2syn99Z+mr9d6h210/8zJFu3rm7JuTU
	 OojE+LxxDCUAQNEu+4gVCmXruOP/h5HrlzZXG5w232yBXRIQZOCKNgt4vkMhWM+5ci
	 fpL2R40mZZcIAtNfpaw+pM5tRxpivtYJkWRrYPoxwdOA4J6YSBFyqsbIpR3DZKn+Zc
	 xxc4J9s1feaGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D18CFCE0B6D; Thu,  9 Jan 2025 11:07:42 -0800 (PST)
Date: Thu, 9 Jan 2025 11:07:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	neeraj.iitr10@gmail.com, joel@joelfernandes.org
Subject: [PATCH RFC] rcu/nocb: Print segment lengths in
 show_rcu_nocb_gp_state()
Message-ID: <e5d8a9d6-ec86-40e8-8b9e-3fd90ecc7dbf@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Analysis of an rcutorture callback-based forward-progress test failure was
hampered by the lack of ->cblist segment lengths.  This commit therefore
adds this information, so that what would have been ".W85620.N." (there
are some callbacks waiting for grace period sequence number 85620 and
some number more that have not yet been assigned to a grace period)
now prints as ".W2(85620).N6." (there are 2 callbacks waiting for grace
period 85620 and 6 not yet assigned to a grace period).  Note that
"D" (done), "N" (next and not yet assigned to a grace period, and "B"
(bypass, also not yet assigned to a grace period) have just the number
of callbacks without the parenthesized grace-period sequence number.

In contrast, "W" (waiting for the current grace period) and "R" (ready
to wait for the next grace period to start) both have parenthesized
grace-period sequence numbers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 295789004d071..b7d5564104a5b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3047,6 +3047,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	n_launders_cb_snap = READ_ONCE(rfp->n_launders_cb);
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
+	rcu_fwd_progress_check(rfp->rcu_fwd_id);
 	pr_alert("%s: Waiting for CBs: %pS() %d\n", __func__, cur_ops->cb_barrier, rfp->rcu_fwd_id);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
 	(void)rcu_torture_fwd_prog_cbfree(rfp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index a03fc19abde73..4a954ecf1c36e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1551,8 +1551,11 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 /* Dump out nocb kthread state for the specified rcu_data structure. */
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
-	char bufw[20];
-	char bufr[20];
+	char bufd[22];
+	char bufw[45];
+	char bufr[45];
+	char bufn[22];
+	char bufb[22];
 	struct rcu_data *nocb_next_rdp;
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
@@ -1566,9 +1569,13 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      typeof(*rdp),
 					      nocb_entry_rdp);
 
-	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
-	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
+	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL], rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
+		      rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
+	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
@@ -1580,12 +1587,15 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		jiffies - rdp->nocb_nobypass_last,
 		rdp->nocb_nobypass_count,
 		".D"[rcu_segcblist_ready_cbs(rsclp)],
+		rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ? "" : bufd,
 		".W"[!rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL)],
 		rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL) ? "" : bufw,
 		".R"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL)],
 		rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL) ? "" : bufr,
 		".N"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL) ? "" : bufn,
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
+		!rcu_cblist_n_cbs(&rdp->nocb_bypass) ? "" : bufb,
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
 		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
