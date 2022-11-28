Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A128C43217
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 23:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiK1X5g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiK1X5f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 18:57:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4E110D
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 15:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73F361508
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 23:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30261C433D6;
        Mon, 28 Nov 2022 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669679853;
        bh=uLU0gJzbqQiA2vfOvKhWHOOBFoF15JqGij0MrQDBVbY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nGa5jo8/blQfdSnfVEUk+1QbDWQOPWy12bCva2badABVs0jOVYhIrA2DgPRNcH4RA
         LyCCdiCtvMhFUtYzlCL7NL1+eq2oYcfT+ZYWTDvrQMykZUndLKDs4DVIzj67+lnobo
         7Hctp8vTQ4ueWc27hHUWoiFH4Q8e2Mt3fLxqfBkg2s6i880OPeewXi7lGrw3jd0pxl
         3tlv9DIGRdW5rVijlx/MIjs6LkeoPJxI7S1Vhl/xp/ql4cGFFc2RAxbFhDrQI746/P
         vxhKs01XPu/lg8qIMfvb8QKqFgeHBArxLIory5ruDPg8BjFDDx4QS6XL3JZ4paxeer
         Qs6T3BfCiX8AA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C60045C0EBE; Mon, 28 Nov 2022 15:57:32 -0800 (PST)
Date:   Mon, 28 Nov 2022 15:57:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 1/2] srcu: Remove needless rcu_seq_done() check while
 holding read lock
Message-ID: <20221128235732.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123135638.79021-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 09:56:37PM +0800, Pingfan Liu wrote:
> As the code changes, now, srcu_gp_start_if_needed() holds the srcu read
> lock, gets the gp_seq snap and call srcu_funnel_gp_start() passing that
> snap value.
> 
> As the rcu_seq_snap() promises "a full grace period has elapsed since
> the current time".  In srcu_funnel_gp_start(), the statement
>   rcu_seq_done(&ssp->srcu_gp_seq, s)
> always return false.
> 
> The same condition stands for srcu_funnel_exp_start(). Hence removing
> all the checks of rcu_seq_done().
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org

Thank you!  I have queued this with some wordsmithing and modifications,
as shown below.  Please check these.

Also, please test future patches with the debug options shown in
Documentation/process/submit-checklist.rst.  In this case, testing with
CONFIG_PROVE_RCU=y would have located a bug with this repeat-by:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2m --configs "SRCU-P SRCU-N" --trust-make

							Thanx, Paul

------------------------------------------------------------------------

commit 17a874a71faed9e38b69c6ec7bae6aa309a2530e
Author: Pingfan Liu <kernelfans@gmail.com>
Date:   Wed Nov 23 21:56:37 2022 +0800

    srcu: Remove needless rcu_seq_done() check while holding read lock
    
    The srcu_gp_start_if_needed() function now read-holds the srcu_struct
    whose grace period is being started, which means that the corresponding
    SRCU grace period cannot end.  This in turn means that the SRCU
    grace-period sequence number returned by rcu_seq_snap() cannot expire
    during this time.  And that means that the calls to rcu_seq_done() in
    srcu_funnel_exp_start() and srcu_funnel_gp_start() can never return true.
    
    This commit therefore removes these rcu_seq_done() checks, but adds checks
    in kernels built with CONFIG_PROVE_RCU=y that splats if rcu_seq_done()
    does somehow return true.
    
    [ paulmck: Rearrange checks to handle kernels built with lockdep. ]
    
    Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    To: rcu@vger.kernel.org
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6af0312005801..b25f77df9e5e7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -915,8 +915,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	if (snp)
 		for (; snp != NULL; snp = snp->srcu_parent) {
 			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
-			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
+			WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
+				     rcu_seq_done(&ssp->srcu_gp_seq, s));
+			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
 			sgsne = snp->srcu_gp_seq_needed_exp;
@@ -942,6 +943,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
  *
  * Note that this function also does the work of srcu_funnel_exp_start(),
  * in some cases by directly invoking it.
+ *
+ * The srcu read lock should be hold around this function. And s is a seq snap
+ * after holding that lock.
  */
 static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 				 unsigned long s, bool do_norm)
@@ -962,8 +966,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
-				return; /* GP already done and CBs recorded. */
+			WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
+				     rcu_seq_done(&ssp->srcu_gp_seq, s));
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
 			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
@@ -999,9 +1003,9 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 
-	/* If grace period not already done and none in progress, start it. */
-	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
-	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
+	/* If grace period not already in progress, start it. */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && rcu_seq_done(&ssp->srcu_gp_seq, s));
+	if (rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 
