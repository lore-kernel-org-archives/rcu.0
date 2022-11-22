Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2951C433FE
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 01:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKVBNw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKVBNs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Nov 2022 20:13:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B707FB49A
        for <rcu@vger.kernel.org>; Mon, 21 Nov 2022 17:13:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5494161503
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 01:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A632AC433C1;
        Tue, 22 Nov 2022 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079625;
        bh=gx4j/AQTTbCJVlHaCZeUIe6jDxdImvcqjCWC4yUIu8E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XOnCfpxFGF7Ier6amLwMG7QVhEQ1wK3cOb/KHiMGezCUPZPDVpVTeQljedNexXDMf
         DKNkuLOhJNXHGf9ndWQLVQyfuBkC8zur0Jn26E7iZYziZEQj0nAc6qryGsWPJxv8QC
         DLgmL6l/unOJoD6ERrYSq8Cdg2nhQ1fIgjw6kxgB1MUOZZ0IhtUXBBUT5E8qBgU3Vy
         dL1Lg2665k5PPeZAjhr4pxWE22KnZifW2eIbEaMAaOQEOOWw1WPW3SF7Bs+ds6oeBG
         +uiePslu9iNplE8tRRa7BCM/PxF76uW8xA8orUDOvWlpa/BgtFFQsd5HCg65+6NhYQ
         r9c+sDAb5hv6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 412745C0641; Mon, 21 Nov 2022 17:13:45 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:13:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] srcu: Remove needless rcu_seq_done() check while
 holding read lock
Message-ID: <20221122011345.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120034014.7390-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 20, 2022 at 11:40:13AM +0800, Pingfan Liu wrote:
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
> Test info:
>   Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> without any failure.

Nice catch!!!  And I do appreciate the testing.

But if we are going to do this, let's please also place lockdep assertions
in srcu_funnel_exp_start() and srcu_funnel_gp_start() to verify that these
functions are in fact invoked within an SRCU read-side critical section.
Also a WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)), please.

Things changed to make the rcu_seq_done() unnecessary, so they could just
as easily change again.

							Thanx, Paul

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..7df59fc8073e 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -851,8 +851,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
>  	if (snp)
>  		for (; snp != NULL; snp = snp->srcu_parent) {
>  			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
> -			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
> -			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
> +			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s))
>  				return;
>  			spin_lock_irqsave_rcu_node(snp, flags);
>  			sgsne = snp->srcu_gp_seq_needed_exp;
> @@ -878,6 +877,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
>   *
>   * Note that this function also does the work of srcu_funnel_exp_start(),
>   * in some cases by directly invoking it.
> + *
> + * The srcu read lock should be hold around this function. And s is a seq snap
> + * after holding that lock.
>   */
>  static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  				 unsigned long s, bool do_norm)
> @@ -898,8 +900,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  	if (snp_leaf)
>  		/* Each pass through the loop does one level of the srcu_node tree. */
>  		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> -			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
> -				return; /* GP already done and CBs recorded. */
>  			spin_lock_irqsave_rcu_node(snp, flags);
>  			snp_seq = snp->srcu_have_cbs[idx];
>  			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> @@ -935,9 +935,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
>  		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
>  
> -	/* If grace period not already done and none in progress, start it. */
> -	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> +	/* If grace period not already in progress, start it. */
> +	if (rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
>  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
>  		srcu_gp_start(ssp);
>  
> -- 
> 2.31.1
> 
