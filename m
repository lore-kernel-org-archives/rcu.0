Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DCAE78499
	for <rcu@archiver.kernel.org>; Sun,  1 Oct 2023 22:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjJAWkD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 1 Oct 2023 18:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJAWkD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 1 Oct 2023 18:40:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE228AB
        for <rcu@vger.kernel.org>; Sun,  1 Oct 2023 15:40:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4123C433C8;
        Sun,  1 Oct 2023 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696200000;
        bh=4SdLgEFGTCiy+axohcPOlQfFzOkRt72s5fDi/JXdRAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joxfkgwyipBrrrsP/BFMHq3Zul0pvKZW5V2YfzdxjoPTlUANxBLdlq2JPyUEIgsPW
         uiASBMoHghw7xt2FSiQWh9FxEWnyk0XrYTkHuHe6k+DygKMUhBtSveZLKaMpcDswrk
         rqtyEHudxBmBo+5k/EKzm/yFBmYcjlSLU99Ko/b92Kj+2XP1EZUR+3z3r/pZyVQr/n
         qKCIXARloGNb4vRZR4Js4M4aT4zEiE8lrfgvxi5oc7BGZIgT9DqDV+vs85ztE1WZGS
         gAkInrb5hqPtMZRQ3M5U14PkKzIwnMlKb7zZWVpOnIW2MC1VhYCvGZUiYedfjcmfZh
         opvRGMdYcTLrg==
Date:   Mon, 2 Oct 2023 00:39:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRn1PU8enLoM8u1T@localhost.localdomain>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRnziciQQLdgYJNx@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Mon, Oct 02, 2023 at 12:32:41AM +0200, Frederic Weisbecker a écrit :
> Le Sun, Oct 01, 2023 at 07:57:14AM +0530, Neeraj upadhyay a écrit :
> > 
> > But "more" only checks for CBs in DONE tail. The callbacks which have been just
> > accelerated are not advanced to DONE tail.
> > 
> > Having said above, I am still trying to figure out, which callbacks
> > are actually being pointed
> > by NEXT tail. Given that __call_srcu() already does a advance and
> > accelerate, all enqueued
> > callbacks would be in either WAIT tail (the callbacks for current
> > active GP) or NEXT_READY
> > tail (the callbacks for next GP after current one completes). So, they
> > should already have
> > GP num assigned and srcu_invoke_callbacks() won't accelerate them.
> > Only case I can
> > think of is, if current GP completes after we sample
> > rcu_seq_current(&ssp->srcu_gp_seq) for
> > rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE tail)
> > and a new GP is started
> > before we take snapshot ('s') of next GP  for
> > rcu_segcblist_accelerate(), then the gp num 's'
> > > gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
> > if my understanding is correct here. Thoughts?
> > 
> > __call_srcu()
> >         rcu_segcblist_advance(&sdp->srcu_cblist,
> >                               rcu_seq_current(&ssp->srcu_gp_seq));
> >         s = rcu_seq_snap(&ssp->srcu_gp_seq);
> >         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> 
> Good point! This looks plausible.
> 
> Does the (buggy) acceleration in srcu_invoke_callbacks() exists solely
> to handle that case? Because then the acceleration could be moved before
> the advance on callbacks handling, something like:
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..af9d8af1d321 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1245,6 +1245,11 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	rcu_segcblist_advance(&sdp->srcu_cblist,
>  			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
>  	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> +	/*
> +	 * Acceleration might fail if the preceding call to
> +	 * rcu_segcblist_advance() also failed due to a prior incomplete grace
> +	 * period. This should be later fixed in srcu_invoke_callbacks().
> +	 */
>  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
>  	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
>  		sdp->srcu_gp_seq_needed = s;
> @@ -1692,6 +1697,13 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	ssp = sdp->ssp;
>  	rcu_cblist_init(&ready_cbs);
>  	spin_lock_irq_rcu_node(sdp);
> +	/*
> +	 * Acceleration might have failed in srcu_gp_start_if_needed() if
> +	 * the preceding call to rcu_segcblist_advance() also failed due to
> +	 * a prior incomplete grace period.
> +	 */
> +	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> +				       sdp->srcu_gp_seq_needed);
>  	rcu_segcblist_advance(&sdp->srcu_cblist,
>  			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
>  	if (sdp->srcu_cblist_invoking ||
> @@ -1720,8 +1732,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	 */
>  	spin_lock_irq_rcu_node(sdp);
>  	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
>  	sdp->srcu_cblist_invoking = false;
>  	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
>  	spin_unlock_irq_rcu_node(sdp);

And if this works, can we then remove srcu_invoke_callbacks() self-requeue?
If queued several times before it actually fires, it will catch the latest
grace period's end. And if queued while the callback runs, it will re-run.

Also why do we have sdp->srcu_invoke_callbacks ? Is that workqueue re-entrant?

Thanks.
