Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A61C54EE9
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 11:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiIPLLX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiIPLLG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 07:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997DFEB;
        Fri, 16 Sep 2022 04:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF8862ADB;
        Fri, 16 Sep 2022 11:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ACBC433D6;
        Fri, 16 Sep 2022 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663326593;
        bh=9VS/3wMkl587CsdJR8VIgh2oPhWdCpR7xhEubqM7rAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dl5ZPEbM7/iEGoNbiiUTZi6mnLeEtiiF9eA9N+ZVp7HiyjrM0xM57phE5UACB68K8
         BKW6LA1PcvuG6rFWOZcjoi+Og4S/1Kb5m0Ascqg3cf0U0A1+Y+AXlefoppgI225+6o
         alr1BzcAucGPitgRgT51sf+cWMW83RvqLZROkLacT2UdN/lnmNRvzFZxP5EcxdJV3h
         H6YSXkTmJnUtnBNUjr2Ouq8OmQ+nJJNUZoPAHSx+vsLwF7klsydwFiFRNvAdmImTOp
         NrcTr6J4EN0qwjLUIltOe6HgN80cQMeChU1OXuInsYdrRVifHIQF8in/07N63xK5hD
         L9nPgXqDNkS3w==
Date:   Fri, 16 Sep 2022 13:09:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before
 bypassing
Message-ID: <20220916110949.GB25456@lothringen>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915001419.55617-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 15, 2022 at 12:14:18AM +0000, Joel Fernandes (Google) wrote:
> If any CB is queued into the bypass list, then trace_rcu_callback() does
> not show it. This makes it not clear when a callback was actually
> queued, as you only end up getting a trace_rcu_invoke_callback() trace.
> Fix it by moving trace_rcu_callback() before
> trace_rcu_nocb_try_bypass().
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..9fe581be8696 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2809,10 +2809,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  
>  	check_cb_ovld(rdp);
> -	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> -		return; // Enqueued onto ->nocb_bypass, so just leave.
> -	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> -	rcu_segcblist_enqueue(&rdp->cblist, head);
> +
>  	if (__is_kvfree_rcu_offset((unsigned long)func))
>  		trace_rcu_kvfree_callback(rcu_state.name, head,
>  					 (unsigned long)func,
> @@ -2821,6 +2818,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		trace_rcu_callback(rcu_state.name, head,
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> +		return; // Enqueued onto ->nocb_bypass, so just leave.
> +	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> +	rcu_segcblist_enqueue(&rdp->cblist, head);
> +
>  	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
>  
>  	/* Go handle any RCU core processing required. */

Two subtle changes induced here:

* rcu_segcblist_n_cbs() is now read lockless. It's just tracing so no huge deal
  but still, if this races with callbacks invocation, we may on some rare occasion
  read stale numbers on traces while enqueuing (think about rcu_top for example)

* trace_rcu_callback() will now show the number of callbacks _before_ enqueuing
  instead of _after_. Not sure if it matters, but sometimes tools rely on trace
  events.

To avoid all that, how about a new trace_rcu_nocb_bypass() instead?

Thanks.
  
