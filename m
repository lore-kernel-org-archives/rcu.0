Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D5C433FE
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 19:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiKWTUu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKWTUt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 14:20:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B153CE3B
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 11:20:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B58E861EC9
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 19:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10487C433D6;
        Wed, 23 Nov 2022 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669231247;
        bh=qnQmOUSwAPJcDkrbRThgDyJzYlf7DFd+/bNOsDde5D4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CwQE4V+4/oJupOtIKtbyE+d+iVOKsNAYEd2XsBDUOHVgeAmT4n7PDw/BIpV5W/mIN
         Ro+PRYWUUhZOLagrYI55a4+RryrLck2gdlowjvXjfMi/72QfLHIHU6WPoRcks6pqX4
         XTXuu5/D8ZheSbvcF1aNE1uD3yUm60V5q497+IDw9NyM3HgXWnoksB35JpStYhh5lZ
         /rlNpQfc140hU8GfRQLRn+Ka/seq8hgvowV3nz6wP7oWXAmDqISJRD9a02PJ9HjUS3
         vUzWPFzlIrNYxbOW4xu/w6pL6xBdBSLjvZOfqXCdEPdhsi8LD8AWKjSLs3Tfu1p57e
         DJbqHDZyop3Ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E8E85C1286; Wed, 23 Nov 2022 11:20:46 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:20:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123135638.79021-3-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> Since the srcu read lock is still held during srcu_funnel_gp_start(),
> the seq snap should be the largest number for the slot
> srcu_have_cbs[idx].
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  include/linux/rcupdate.h |  1 +
>  kernel/rcu/srcutree.c    | 11 ++++++-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d..a09007236660 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -32,6 +32,7 @@
>  #include <linux/context_tracking_irq.h>
>  
>  #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
> +#define ULONG_CMP_GT(a, b)	(ULONG_MAX / 2 > (a) - (b))

Please see below...

>  #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
>  #define ulong2long(a)		(*(long *)(&(a)))
>  #define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2fc0e775ade4..41902b823687 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
>  			spin_lock_irqsave_rcu_node(snp, flags);
>  			snp_seq = snp->srcu_have_cbs[idx];
> -			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> +			/*
> +			 * s should be the biggest in the current slot. Hence only LE is
> +			 * valid
> +			 */
> +			BUG_ON(ULONG_CMP_GT(snp_seq, s));

Why not this?  (Plus adjusting the comment above, of course.)

			WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));

That way we don't need ULONG_CMP_GT().  Plus if we are confused about
s being the biggest in the current slot, we get a splat and can debug
further.  We both might be quite sure that we are not confused, but
that is exactly when we are most prone to making mistakes.  ;-)

I also ask that you run with this check for some time.  After all, if
the assumption is incorrect, the resulting SRCU hangs off in various
systems around the world will not be so much fun to debug.

Given that this is slowpath code, it is much better to take an extra
compare and branch than to introduce even an extremely small risk of
hanging SRCU.

							Thanx, Paul

> +			if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
>  				if (snp == snp_leaf && snp_seq == s)
>  					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
>  				spin_unlock_irqrestore_rcu_node(snp, flags);
> -				if (snp == snp_leaf && snp_seq != s) {
> -					srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> -					return;
> -				}
>  				if (!do_norm)
>  					srcu_funnel_exp_start(ssp, snp, s);
>  				return;
> -- 
> 2.31.1
> 
