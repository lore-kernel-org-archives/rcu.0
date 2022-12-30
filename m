Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB91C4167B
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 20:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiL3UaP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 15:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3UaO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 15:30:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59212D34
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 12:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8935B615C7
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 20:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA3FC433EF;
        Fri, 30 Dec 2022 20:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672432212;
        bh=9shUjWLqK9SeENnyubgiNa2dhjsd4apuz2S5bRGcRKM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tmR9EqGTgoKJ9R8TwnPUMxrlyj23SLyvGKRJy8yTjGU9PwiHuueHgEoKWQmHra9ZB
         TPPr00vNeXLnOfDVTkJTnEsSLimvarWhZx5vuFm/z1pUh0cgkM7Uw6CHgWz0cyqqzk
         BP+CTO9GBLs9U6taXrVrmxUaBBmRpE77Q7j1zFEL5GtF8iKJAO0dICIuIFU8Q1A+7Q
         m//QX3DIUAhBgkYVNS3shloomQ9kXpokPHvP5KUsZ6dXWqr3gxvRIeSdC+0fVaOzA8
         3prkyW+okxogJhlKzW+wot54mN/23MM8WaZ90fuzoBGdh2T2YmPisOIVyTuARFJQR6
         9sZyeU6VzUrBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 751A05C097E; Fri, 30 Dec 2022 12:30:12 -0800 (PST)
Date:   Fri, 30 Dec 2022 12:30:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Catch dwmw2's deadlock
Message-ID: <20221230203012.GN4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y67NrWVLaL7B/EuO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y67NrWVLaL7B/EuO@casper.infradead.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 11:38:21AM +0000, Matthew Wilcox wrote:
> 
> <dwmw2> why doesn't lockdep catch us calling synchronize_srcu() with
>    a lock held, and elsewhere obtaining that lock within an srcu critical
>    region ("read lock") ?
> 
> Because synchronize_srcu() doesn't acquire the lock, merely checks that
> it isn't held.
> 
> Would this work?  Not even compile tested.
> 
> You can put my SoB on this if it works.
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ca4b5dcec675..e9c2ab8369c0 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1267,11 +1267,11 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
>  {
>  	struct rcu_synchronize rcu;
>  
> -	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> -			 lock_is_held(&rcu_bh_lock_map) ||
> +	rcu_lock_acquire(&ssp->dep_map);

If this does do anything, why doesn't lockdep complain about things
like this?

	i1 = srcu_read_lock(&my_srcu);
	i2 = srcu_read_lock(&my_srcu);
	srcu_read_unlock(&my_srcu, i2);
	srcu_read_unlock(&my_srcu, i1);

Or does it in fact complain and I have somehow managed to confuse things
such that rcutorture does not detect such complaints?  I would expect
rcutorture_extend_mask_max() to make this happen, but then again, RCU
has confused me in the past.

							Thanx, Paul

> +	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
>  			 lock_is_held(&rcu_lock_map) ||
>  			 lock_is_held(&rcu_sched_lock_map),
> -			 "Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
> +			 "Illegal synchronize_srcu() in RCU read-side critical section");
>  
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return;
> @@ -1282,6 +1282,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
>  	__call_srcu(ssp, &rcu.head, wakeme_after_rcu, do_norm);
>  	wait_for_completion(&rcu.completion);
>  	destroy_rcu_head_on_stack(&rcu.head);
> +	rcu_lock_release(&ssp->dep_map);
>  
>  	/*
>  	 * Make sure that later code is ordered after the SRCU grace
