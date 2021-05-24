Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069EDC04FF3
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 03:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70D961132
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 03:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhEXDsN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 May 2021 23:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhEXDsM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 23 May 2021 23:48:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 432E16024A;
        Mon, 24 May 2021 03:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621828005;
        bh=tXCue5oDtxJNXtmLKNCXMQAsllqKJeAEtXjQYVXtDwo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VGvQZSWbMSudiLyCLjUtXFSZtADyeG5dOomugWnfHrwoqAbcgqd+b27U99kCzC9Y2
         Tc7AwFJq/zI4rh/dI2RK2vK0SGc6K+ue9cJruIAGxJOzBrw6Zk8Vp+LyglNViyY7Ky
         6p/T23Vw8jeh05a/XTxtfOp0QW1DSB7/xrjv/KvpraCs1unQSAX/qBxl8zMEPhtlCU
         PmAwr16fk3Atm0OosRFKGZ41lfne3Bv2j54d3faEXfL0IdqfXx8NcZ5UP0UaXWMcZF
         53QeFe/jl7749NUuN2tsJ3jqb3Ub+gd3RWf5aGheY/g/vWFMSS/niWBcn/cerKd/i5
         zLQ8d8S+hHe2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0A56A5C018D; Sun, 23 May 2021 20:46:45 -0700 (PDT)
Date:   Sun, 23 May 2021 20:46:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <20210524034645.GH4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521155624.174524-1-senozhatsky@chromium.org>
 <20210521180127.GD4441@paulmck-ThinkPad-P17-Gen-1>
 <20210521213855.GA3437356@paulmck-ThinkPad-P17-Gen-1>
 <YKsH3GrEoxcMf4j0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKsH3GrEoxcMf4j0@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 24, 2021 at 10:56:44AM +0900, Sergey Senozhatsky wrote:
> On (21/05/21 14:38), Paul E. McKenney wrote:
> > 
> > And on that otherwise inexplicable refetch of the jiffies counter within
> > check_cpu_stall(), the commit below makes it more effective.
> > 
> > If check_cpu_stall() is delayed before or while printing the stall
> > warning, we really want to wait the full time duration between the
> > end of that stall warning and the start of the next one.
> >
> 
> Nice improvement!

Thank you, glad you like it!

> > Of course, if there is some way to learn whether printk() is overloaded,
> > even more effective approaches could be taken.
> 
> There is no better to do this.

I was afraid of that.  ;-)

> > commit b9c5dc2856c1538ccf2d09246df2b58bede72cca
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri May 21 14:23:03 2021 -0700
> > 
> >     rcu: Start timing stall repetitions after warning complete
> >     
> >     Systems with low-bandwidth consoles can have very large printk()
> >     latencies, and on such systems it makes no sense to have the next RCU CPU
> >     stall warning message start output before the prior message completed.
> >     This commit therefore sets the time of the next stall only after the
> >     prints have completed.  While printing, the time of the next stall
> >     message is set to ULONG_MAX/2 jiffies into the future.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> FWIW,
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thank you again, I will apply this on my next rebase.

> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 05012a8081a1..ff239189a627 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -648,6 +648,7 @@ static void print_cpu_stall(unsigned long gps)
> >  
> >  static void check_cpu_stall(struct rcu_data *rdp)
> >  {
> > +	bool didstall = false;
> >  	unsigned long gs1;
> >  	unsigned long gs2;
> >  	unsigned long gps;
> > @@ -693,7 +694,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >  	    ULONG_CMP_GE(gps, js))
> >  		return; /* No stall or GP completed since entering function. */
> >  	rnp = rdp->mynode;
> > -	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> > +	jn = jiffies + ULONG_MAX / 2;
> >  	if (rcu_gp_in_progress() &&
> >  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> >  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> > @@ -710,6 +711,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >  		print_cpu_stall(gps);
> >  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> >  			rcu_ftrace_dump(DUMP_ALL);
> > +		didstall = true;
> >  
> >  	} else if (rcu_gp_in_progress() &&
> >  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> > @@ -727,6 +729,11 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >  		print_other_cpu_stall(gs2, gps);
> >  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> >  			rcu_ftrace_dump(DUMP_ALL);
> > +		didstall = true;
> > +	}
> > +	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
> 
> Can `rcu_state.jiffies_stall` change here?

In theory, yes, sort of, anyway.  In practice, highly unlikely.
The most plausible way for this to happen is for this code path to be
delayed for a long time on a 32-bit system, so that jiffies+ULONG_MAX/2
actually arrives.  But in that case, all sorts of other complaints
would happen first.

But I could make this a cmpxchg(), if that is what you are getting at.

							Thanx, Paul

> > +		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> > +		WRITE_ONCE(rcu_state.jiffies_stall, jn);
> >  	}
> >  }
