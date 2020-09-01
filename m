Return-Path: <SRS0=vVGi=CK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C843C433E2
	for <rcu@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44890208CA
	for <rcu@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977631;
	bh=8JcoG4QfiNvthJaec9Mx24MjKYkSUFTJ0zyQRbwhp34=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SpVDt/tY/V927lkqLLGEWzKO72qUA0J6UygN9BoSqfDr7wlt4rvnjOFo+4FfCRV5K
	 fjQFkCbbOK+pGnlrZRUJ4EmsdIXdfPg1QpsrCuO356Xp6GhK9Pr/mzeQmpb2JpUR3Y
	 XZfXfLFvUDScp87L5T/VYRfG2ib++nv4uo5BBegk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgIAQ1H (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730947AbgIAQ0r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 1 Sep 2020 12:26:47 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F6C20767;
        Tue,  1 Sep 2020 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598977606;
        bh=8JcoG4QfiNvthJaec9Mx24MjKYkSUFTJ0zyQRbwhp34=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XuYPKZidhCCNbTF+lDHtnwjrkm5u6KTr5NsSR1gUQasPDHlSWCUlX1ZCoPYiOHZs9
         sBZRsOj7SiFO7W+eXztO6SYtflJ7Jtz4cr9M9LnHY0dfoqnTqXHMmU9kML5APsAOKj
         0TKDV/2cQkNExSyoBgBGlwiDBKUfRZr/LOb+kPAc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2864D35226A5; Tue,  1 Sep 2020 09:26:46 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:26:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 1/4] rcu/segcblist: Do not depend on rcl->len to
 store the segcb len during merge
Message-ID: <20200901162646.GD29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-2-joel@joelfernandes.org>
 <20200825200809.GW2855@paulmck-ThinkPad-P72>
 <20200825224723.GB579506@google.com>
 <20200826142028.GN2855@paulmck-ThinkPad-P72>
 <20200827225518.GB3821640@google.com>
 <20200828141855.GO2855@paulmck-ThinkPad-P72>
 <20200901150609.GA1506230@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150609.GA1506230@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 01, 2020 at 11:06:09AM -0400, Joel Fernandes wrote:
> Hi,
> Resuming regular activities here, post-LPC :)
> 
> On Fri, Aug 28, 2020 at 07:18:55AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 27, 2020 at 06:55:18PM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 26, 2020 at 07:20:28AM -0700, Paul E. McKenney wrote:
> > > [...]
> > > > > > Or better yet, please see below, which should allow getting rid of both
> > > > > > of them.
> > > > > > 
> > > > > > >  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
> > > > > > >  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> > > > > > > -	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> > > > > > > +
> > > > > > > +	rcu_segcblist_add_len(dst_rsclp, src_len);
> > > > > > >  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
> > > > > > >  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> > > > > > 
> > > > > > Rather than adding the blank lines, why not have the rcu_cblist structures
> > > > > > carry the lengths?  You are already adjusting one of the two call sites
> > > > > > that care (rcu_do_batch()), and the other is srcu_invoke_callbacks().
> > > > > > That should shorten this function a bit more.  And make callback handling
> > > > > > much more approachable, I suspect.
> > > > > 
> > > > > Sorry, I did not understand. The rcu_cblist structure already has a length
> > > > > field. I do modify rcu_segcblist_extract_done_cbs() and
> > > > > rcu_segcblist_extract_pend_cbs() to carry the length already, in a later
> > > > > patch.
> > > > > 
> > > > > Just to emphasize, this patch is just a small refactor to avoid an issue in
> > > > > later patches. It aims to keep current functionality unchanged.
> > > > 
> > > > True enough.  I am just suggesting that an equally small refactor in
> > > > a slightly different direction should get to a better place.  The key
> > > > point enabling this slightly different direction is that this code is
> > > > an exception to the "preserve ->cblist.len" rule because it is invoked
> > > > only from the CPU hotplug code.
> > > > 
> > > > So you could use the rcu_cblist .len field to update the ->cblist.len
> > > > field, thus combining the _cbs and _count updates.  One thing that helps
> > > > is that setting th e rcu_cblist .len field doesn't hurt the other use
> > > > cases that require careful handling of ->cblist.len.
> > > 
> > > Thank you for the ideas. I am trying something like this on top of this
> > > series based on the ideas. One thing I concerned a bit is if getting rid of
> > > the rcu_segcblist_xchg_len() function (which has memory barriers in them)
> > > causes issues in the hotplug path. I am now directly updating the length
> > > without additional memory barriers. I will test it more and try to reason
> > > more about it as well.
> > 
> > In this particular case, the CPU-hotplug locks prevent rcu_barrier()
> > from running concurrently, so it should be OK.  Is there an easy way
> > to make lockdep help us check this?  Does lockdep_assert_cpus_held()
> > suffice, or is it too easily satisfied?
> 
> Just to clarify, the race you mention is rcu_barrier() should not run
> concurrently with CPU hotplug operation.
> 
> The reason is:
> rcu_barrier() checks whether the segmented list's length is 0 before sending
> IPIs for entraining a callback onto the destination CPU. But if it
> misunderstands the length's value due to a lack of memory barriers, it may
> not missing sending an IPI causing the barrier to fail. Please correct me if
> I'm wrong though.

That is the concern for code that is not part of a CPU-hotplug operation.

> Due to CPU hotplug locking, such race is impossible because both
> rcu_barrier() and the CPU migrating the callbacks holds it.

Exactly.

> I think the lockdep_assert_cpus_held() may suffice. I can add it to the
> rcu_segcblist_merge() function.

The main thing to check is that the following results in a lockdep splat:

	cpus_read_lock();
	lockdep_assert_cpus_held();

> BTW, I think we can simplify rcu_barrier() a bit and combine the tracepoint
> and rid one outer if clause (diff at end of email).

If you were already changing this function for some reason, OK.  But you
are trading a pair of lines for a long line (though still less than the
new 100-character limit), so as a standalone patch I am left uninspired.

> > >  }
> > >  
> > >  /*
> > > @@ -448,6 +419,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
> > >  			break;
> > >  	rclp->head = NULL;
> > >  	rclp->tail = &rclp->head;
> > > +	rcu_segcblist_add_len(rsclp, rclp->len);
> > 
> > Does there need to be a compensating action in rcu_do_batch(), or is
> > this the point of the "rcu_segcblist_add_len(rsclp, -(rclp->len));"
> > added to rcu_segcblist_extract_done_cbs() above?
> > 
> > If so, a comment would be good.
> 
> I think external compensation by rcu_do_batch is not needed, its best to
> handle all cblist.len modifications internally in the segcblist API
> where possible.

At the very least, the segcblist function providing a negative-length
list needs to very carefully explain itself!!!  ;-)

> > >  /*
> > > @@ -463,6 +435,7 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
> > >  	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
> > >  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
> > >  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
> > > +	rcu_segcblist_add_len(rsclp, rclp->len);
> > >  }
> > >  
> > >  /*
> > > @@ -601,16 +574,13 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> > >  {
> > >  	struct rcu_cblist donecbs;
> > >  	struct rcu_cblist pendcbs;
> > > -	long src_len;
> > >  
> > >  	rcu_cblist_init(&donecbs);
> > >  	rcu_cblist_init(&pendcbs);
> > >  
> > > -	src_len = rcu_segcblist_xchg_len(src_rsclp, 0);
> > >  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
> > >  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> > >  
> > > -	rcu_segcblist_add_len(dst_rsclp, src_len);
> > >  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
> > >  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> > 
> > Can we now pair the corresponding _extract_ and _insert_ calls, thus
> > requiring only one rcu_cblist structure?  This would drop two more lines
> > of code.  Or would that break something?
> 
> That could work as well, yes. But may not be worth adding another function to
> combine extract/insert operation, since the extract and insert operations are
> needed by rcutree and srcutree as well (other than hotplug).

I was thinking in terms of just reordering the calls to the existing
functions, though I clearly was having trouble counting.  Like this:

 	struct rcu_cblist cbs;
 
 	rcu_cblist_init(&cbs);
 	rcu_segcblist_extract_done_cbs(src_rsclp, &cbs);
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &cbs);
 	rcu_cblist_init(&cbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &cbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &cbs);

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 16ad99a9ebba..274a1845ad38 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3856,17 +3856,16 @@ void rcu_barrier(void)
>  		if (cpu_is_offline(cpu) &&
>  		    !rcu_segcblist_is_offloaded(&rdp->cblist))
>  			continue;
> -		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
> -			rcu_barrier_trace(TPS("OnlineQ"), cpu,
> -					  rcu_state.barrier_sequence);
> -			smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
> -		} else if (rcu_segcblist_n_cbs(&rdp->cblist) &&
> -			   cpu_is_offline(cpu)) {
> -			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu,
> -					  rcu_state.barrier_sequence);
> -			local_irq_disable();
> -			rcu_barrier_func((void *)cpu);
> -			local_irq_enable();
> +		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
> +			rcu_barrier_trace(cpu_online(cpu) ? TPS("OnlineQ") : TPS("OfflineNoCBQ"),
> +					  cpu, rcu_state.barrier_sequence);
> +			if (cpu_online(cpu)) {
> +				smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
> +			} else {
> +				local_irq_disable();
> +				rcu_barrier_func((void *)cpu);
> +				local_irq_enable();
> +			}
>  		} else if (cpu_is_offline(cpu)) {
>  			rcu_barrier_trace(TPS("OfflineNoCBNoQ"), cpu,
>  					  rcu_state.barrier_sequence);
