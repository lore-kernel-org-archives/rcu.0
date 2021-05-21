Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F7C433ED
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 00:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7DB60FE7
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 00:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhEUAQH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 20:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhEUAQG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 20:16:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B4C6109F;
        Fri, 21 May 2021 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621556084;
        bh=pI/24+vcMdDAJcj/OqlW3yJSu4NirsfO/x+3+RAfGuY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Eky6o0hs8l8/ckrhHTmOD/wRx1IP9IuTzsGRbY5p5j1wuVfBKq6PjJuYwbvu9tG1t
         /3QLZgvbgO26Jibb1ed8dQs6qHB57N9YWh93maI5N7J5sBlReYkEBJAbKnI2Li95na
         FzkhiHMwhx99Z8zwoHbLQRUeRkWSHw8halIWS/jPz7DkMstjRhdZAVlpvHf+aSVESk
         ezpyE982Tiri+X4KW5fB1i5TwOQCykRW/Q5ZvjilC6I3niVBbbJ2Sllp2rYJgti58B
         49ZT6stnxPidp0cGWOA10TccU0gEuJkHpa7BQESLDrbydrENccKl/jbJSaCjjkuG8L
         DdMX45UAbCjYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC7025C023D; Thu, 20 May 2021 17:14:43 -0700 (PDT)
Date:   Thu, 20 May 2021 17:14:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210521001443.GR4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX/H0EwRRLM+cAa@google.com>
 <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
 <YKbhg30Q6YlerCoz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKbhg30Q6YlerCoz@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 21, 2021 at 07:24:03AM +0900, Sergey Senozhatsky wrote:
> On (21/05/20 07:53), Paul E. McKenney wrote:
> > On Thu, May 20, 2021 at 03:18:07PM +0900, Sergey Senozhatsky wrote:
> > > On (21/05/18 16:15), Paul E. McKenney wrote:
> > > > 
> > > > In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
> > > > guest migration and debugger breakpoints, correct?  Either way, I am
> > > > wondering if rcu_cpu_stall_reset() should take a lighter touch.  Right
> > > > now, it effectively disables all stalls for the current grace period.
> > > > Why not make it restart the stall timeout when the stoppage is detected?
> > > 
> > > rcu_cpu_stall_reset() is used in many other places, not sure if we can
> > > change its behaviour rcu_cpu_stall_reset().
> > 
> > There was some use case back in the day where they wanted an indefinite
> > suppression of RCU CPU stall warnings for the current grace period, but
> > all the current use cases look fine with restarting the stall timeout.
> > 
> > However, please see below.
> > 
> > > Maybe it'll be possible to just stop calling it from PV-clock and do
> > > something like this
> > 
> > This was in fact one of the things I was considering, at least until
> > I convinced myself that I needed to ask some questions.
> > 
> > One point of possibly unnecessary nervousness on my part is resetting
> > the start of the grace period, which might confuse diagnostics.
> > 
> > But how about something like this?
> > 
> > void rcu_cpu_stall_reset(void)
> > {
> > 	WRITE_ONCE(rcu_state.jiffies_stall,
> > 		   jiffies + rcu_jiffies_till_stall_check());
> > }
> > 
> > Would something like that work?
> 
> This should work.
> 
> On a side note.
> 
> I wish we didn't have to put kvm_check_and_clear_guest_paused() all
> over the place.
> 
> We do load jiffies at the start of check_cpu_stall(). So, in theory,
> we can just use that captured jiffies (which can become obsolete but
> so will grace period timestamps) value and never read current system
> jiffies because they can jump way forward. IOW
> 
> 	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;
> 
> instead of
> 
> 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> 
> Then we probably can remove kvm_check_and_clear_guest_paused().
> 
> But that "don't load current jiffies" is rather fragile.
> 
> kvm_check_and_clear_guest_paused() is not pretty, but at least it's
> explicit.

If this works for you, I am very much in favor!

							Thanx, Paul

> ---
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 49dda86a0e84..24f749bc1f90 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -695,19 +695,11 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	    ULONG_CMP_GE(gps, js))
>  		return; /* No stall or GP completed since entering function. */
>  	rnp = rdp->mynode;
> -	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> +	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;
>  	if (rcu_gp_in_progress() &&
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> -
>  		/* We haven't checked in, so go dump stack. */
>  		print_cpu_stall(gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> @@ -717,14 +709,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>  		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> -
>  		/* They had a few time units to dump stack, so complain. */
>  		print_other_cpu_stall(gs2, gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
