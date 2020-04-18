Return-Path: <SRS0=hY+h=6C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDFC2BA19
	for <rcu@archiver.kernel.org>; Sat, 18 Apr 2020 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45726221EA
	for <rcu@archiver.kernel.org>; Sat, 18 Apr 2020 03:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587179964;
	bh=BRPxEYxqPyP5CIPMdaAMBsOuPKCkanjJQ+re+uJ8/QA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MF9LQtjsFAqmGpu6rlfbdF5iIR21bYmr+hr/h9le7BvK5GfR75AhLBLnFT+0ZS2yn
	 RsAz3bqelvBJ6yiWy77nRWmFSGm7wOxpe5ZKQVHBwjRoqRxCeTPNBlifYjWofSUwE1
	 s7tk3vweiRz68OcdzA+MnZOuyc+cikf5CmzgjA6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgDRDTY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgDRDTX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Apr 2020 23:19:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E62A21D94;
        Sat, 18 Apr 2020 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587179963;
        bh=BRPxEYxqPyP5CIPMdaAMBsOuPKCkanjJQ+re+uJ8/QA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zbqiZKSLCBs5B7jP+12cUhhFoE/+WI7eJpnczPaM62Uq2krCsxV/8/CECPYxA4sDT
         fS7PldbcGCN2K6W5eY2L3CejSBf2Zk8GKH78Hx1mcZ2wVxmmLci5QZ1UZq86Luly3f
         bNe/+05n6rWVHuDTOhnQ4orphsbeG2DQU2+yr3MQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E6B0935233A2; Fri, 17 Apr 2020 20:19:22 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:19:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: simplify the calculation of rcu_state.ncpus
Message-ID: <20200418031922.GR17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200417213951.29837-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417213951.29837-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 17, 2020 at 09:39:51PM +0000, Wei Yang wrote:
> There is only 1 bit set in mask, which means the difference between
> oldmask and the new one would be at the position where the bit is set in
> mask.
> 
> Based on this knowledge, rcu_state.ncpus could be calculated by checking
> whether mask is already set in oldmask.

Nice!!!  Good eyes!

> BTW, the comment at the last of this line is mysterious. Not sure it
> could be removed or not.

The "^^^" in that comment says to look at the comment on the preceding
line.  Memory-ordering functions like smp_store_release() are supposed
to have comments indicating what they are ordering.  ;-)

Could you please do the following things and resubmit?

1.	Forward-port to -rcu branch dev?  This tree lives here:
	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

2.	Given that oldmask is used only to test to see if a new bit
	was set, why not just replace oldmask with a bool variable
	that is set to "!(rnp->expmaskinitnext & mask)" before the
	bit is ORed into rnp->expmaskinitnext?

3.	Put the comment inside the "if" statement with the
	smp_store_release().

4.	In -rcu, you will find a ASSERT_EXCLUSIVE_WRITER() statement
	that should also be placed inside the "if" statement with
	the smp_store_release().

							Thanx, Paul

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  kernel/rcu/tree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d91c9156fab2..f0d9251fa663 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3364,7 +3364,6 @@ void rcu_cpu_starting(unsigned int cpu)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	int nbits;
>  	unsigned long oldmask;
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
> @@ -3381,10 +3380,9 @@ void rcu_cpu_starting(unsigned int cpu)
>  	rnp->qsmaskinitnext |= mask;
>  	oldmask = rnp->expmaskinitnext;
>  	rnp->expmaskinitnext |= mask;
> -	oldmask ^= rnp->expmaskinitnext;
> -	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
>  	/* Allow lockless access for expedited grace periods. */
> -	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
> +	if (!(oldmask & mask))
> +		smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + 1); /* ^^^ */
>  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> -- 
> 2.23.0
> 
