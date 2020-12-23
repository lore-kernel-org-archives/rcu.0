Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D493EC433E0
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2DD2332A
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 15:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgLWPNM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgLWPNM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Dec 2020 10:13:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B437207A4;
        Wed, 23 Dec 2020 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608736351;
        bh=pz2Re5xo44DPDdBhDK63TN4XpXRsjcKbP7FVCoytPJI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uORjBEwJHVLI0gWdeiYYQFsYUWqn0HJGxFq1f7qojY0ywmWa8ka73dTs3+NbWksqY
         pmhGZN0Xg3KM2ZhNyMpA1GabCfSP3pmhAhWawsAbuGref6stg9qAKZoupbAFlLIz4+
         mQvm+l8yH1lvJ+KYYs0BBrsQ//LI7U8DC+KssqjQkrD/C9iHGlmrkn/gHkqvwuTPIo
         It+BR+w/o9gqtf2xbw1oxb3uyAjNeVAxv5g4N65Kd1GVC/s1zOMuo7CJSsLELYBOxo
         NSJuRhYU3ZJWWa9qHTtlO7vet3yBZkTHbIXxvfIB6wFD68g/iCZSmlvQQwISLgiZJU
         kcHXG7/WYxSjA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 23531352264C; Wed, 23 Dec 2020 07:12:31 -0800 (PST)
Date:   Wed, 23 Dec 2020 07:12:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, peterz@infradead.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix dynticks_nmi_nesting underflow check in
 rcu_is_cpu_rrupt_from_idle
Message-ID: <20201223151231.GC2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1608712777-1769-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608712777-1769-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 23, 2020 at 02:09:37PM +0530, Neeraj Upadhyay wrote:
> For the smp_call_function() optimization, where callbacks can run from
> idle context, in commit 806f04e9fd2c ("rcu: Allow for smp_call_function()
> running callbacks from idle"), an additional check is added in
> rcu_is_cpu_rrupt_from_idle(), for dynticks_nmi_nesting value being 0,
> for these smp_call_function() callbacks running from idle loop.
> However, this commit missed updating a preexisting underflow check
> of dynticks_nmi_nesting, which checks for a non zero positive value.
> Fix this warning and while at it, read the counter only once.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
> 
> Hi,
> 
> I was not able to get this warning, with scftorture.
> 
>   RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
>     "RCU dynticks_nmi_nesting counter underflow/zero!");
> 
> Not sure if idle loop smp_call_function() optimization is already present
> in mainline?

Now that you mention it, I don't see it.  But x86 has a number of idle
functions, and I might be missing it.  The "idle" kernel boot parameter
allows some ability to select them, and of course more profound (and maybe
more dangerous) changes can be made by changing select_idle_routine().

> Another thing, which I am not sure of is, maybe lockdep gets disabled
> in the idle loop contexts, where rcu_is_cpu_rrupt_from_idle() is called?
> Was this the original intention, to keep the lockdep based
> RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0
> check separate from idle task context nesting value
> WARN_ON_ONCE(!nesting && !is_idle_task(current)) check?

An easy way to test lockdep is to create a pair of locks, acquire them
in one order then release them both, and finally acquire them in the
other order and then release them both.  If lockdep is configured and
enabled, it will complain.

The only reason I used RCU_LOCKDEP_WARN() was that people were complaining
to me about idle-entry overhead back at that time.  So without lockdep,
there is zero overhead.  Maybe people have become more tolerant of idle
delays, or perhaps they are not so worried about an extra check of a
cache-hot quantity.

And another thing to try is to make the RCU_LOCKDEP_WARN() be WARN_ONCE()
or similar.  Can't hurt for testing purposes!

Of course, once Peter Zijlstra comes back from vacation, we should ask him.

And thank you for trying this out!

I am tempted to pull this in as is, given the current logical
inconsistency in the checks.  Thoughts?

							Thanx, Paul

> Thanks
> Neeraj
> 
>  kernel/rcu/tree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bc8b489..c3037cf 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -457,11 +457,10 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	/* Check for counter underflows */
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
>  			 "RCU dynticks_nesting counter underflow!");
> -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> -			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> +	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> +	RCU_LOCKDEP_WARN(nesting < 0, "RCU dynticks_nmi_nesting counter underflow!");
>  
>  	/* Are we at first interrupt nesting level? */
> -	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
>  	if (nesting > 1)
>  		return false;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
