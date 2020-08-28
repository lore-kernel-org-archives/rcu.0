Return-Path: <SRS0=EKFO=CG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3659C433E6
	for <rcu@archiver.kernel.org>; Fri, 28 Aug 2020 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD59208C9
	for <rcu@archiver.kernel.org>; Fri, 28 Aug 2020 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598624339;
	bh=HfZz+xtTrt5QVush0A2tAYGofQihbn5nJWHYOS6GXZk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zqfVLaQffC0+jNOuQAoIdo8pTn+1j//iKDN7k4x6VvcYHlQy7VTF+bxtiAt5jnIaC
	 /n8VFK2f4TeugK+1RgvdqOfugndLXwczirbrzvKvf9TueZgzJDm8rQbbXba6nL5JW+
	 ev6u2zA8SlBjTaALqzdfBIGT6DA3mow9aY+xuKB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgH1OS7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1OS5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 28 Aug 2020 10:18:57 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2952B20872;
        Fri, 28 Aug 2020 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598624336;
        bh=HfZz+xtTrt5QVush0A2tAYGofQihbn5nJWHYOS6GXZk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=arfN5bhon4muxjyRb65RwWzeffZvpmP2r/NuNWnOZipcH+G7xRtTpzcAAqgnluSya
         XIkfuEPH1w/DaA97Zx/BwWfoJl+VwarnWI30b+TzwNaVKv1d6uAx6TRq3L6P5FkCWv
         oSsbLr5i9tzG/H+OKt9VBG9o5b2EhXK1GZqLvMRc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ED0373522679; Fri, 28 Aug 2020 07:18:55 -0700 (PDT)
Date:   Fri, 28 Aug 2020 07:18:55 -0700
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
Message-ID: <20200828141855.GO2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-2-joel@joelfernandes.org>
 <20200825200809.GW2855@paulmck-ThinkPad-P72>
 <20200825224723.GB579506@google.com>
 <20200826142028.GN2855@paulmck-ThinkPad-P72>
 <20200827225518.GB3821640@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827225518.GB3821640@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 27, 2020 at 06:55:18PM -0400, Joel Fernandes wrote:
> On Wed, Aug 26, 2020 at 07:20:28AM -0700, Paul E. McKenney wrote:
> [...]
> > > > Or better yet, please see below, which should allow getting rid of both
> > > > of them.
> > > > 
> > > > >  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
> > > > >  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> > > > > -	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> > > > > +
> > > > > +	rcu_segcblist_add_len(dst_rsclp, src_len);
> > > > >  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
> > > > >  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> > > > 
> > > > Rather than adding the blank lines, why not have the rcu_cblist structures
> > > > carry the lengths?  You are already adjusting one of the two call sites
> > > > that care (rcu_do_batch()), and the other is srcu_invoke_callbacks().
> > > > That should shorten this function a bit more.  And make callback handling
> > > > much more approachable, I suspect.
> > > 
> > > Sorry, I did not understand. The rcu_cblist structure already has a length
> > > field. I do modify rcu_segcblist_extract_done_cbs() and
> > > rcu_segcblist_extract_pend_cbs() to carry the length already, in a later
> > > patch.
> > > 
> > > Just to emphasize, this patch is just a small refactor to avoid an issue in
> > > later patches. It aims to keep current functionality unchanged.
> > 
> > True enough.  I am just suggesting that an equally small refactor in
> > a slightly different direction should get to a better place.  The key
> > point enabling this slightly different direction is that this code is
> > an exception to the "preserve ->cblist.len" rule because it is invoked
> > only from the CPU hotplug code.
> > 
> > So you could use the rcu_cblist .len field to update the ->cblist.len
> > field, thus combining the _cbs and _count updates.  One thing that helps
> > is that setting th e rcu_cblist .len field doesn't hurt the other use
> > cases that require careful handling of ->cblist.len.
> 
> Thank you for the ideas. I am trying something like this on top of this
> series based on the ideas. One thing I concerned a bit is if getting rid of
> the rcu_segcblist_xchg_len() function (which has memory barriers in them)
> causes issues in the hotplug path. I am now directly updating the length
> without additional memory barriers. I will test it more and try to reason
> more about it as well.

In this particular case, the CPU-hotplug locks prevent rcu_barrier()
from running concurrently, so it should be OK.  Is there an easy way
to make lockdep help us check this?  Does lockdep_assert_cpus_held()
suffice, or is it too easily satisfied?

> ---8<-----------------------
> 
> From: Joel Fernandes <joelaf@google.com>
> Date: Thu, 27 Aug 2020 18:30:25 -0400
> Subject: [PATCH] fixup! rcu/segcblist: Do not depend on donecbs ->len to store
>  the segcb len during merge
> 
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/rcu/rcu_segcblist.c | 38 ++++----------------------------------
>  1 file changed, 4 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 79c2cbe388c5..c33abbc97a07 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -175,26 +175,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
>  	rcu_segcblist_add_len(rsclp, 1);
>  }
>  
> -/*
> - * Exchange the numeric length of the specified rcu_segcblist structure
> - * with the specified value.  This can cause the ->len field to disagree
> - * with the actual number of callbacks on the structure.  This exchange is
> - * fully ordered with respect to the callers accesses both before and after.
> - */
> -static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> -{
> -#ifdef CONFIG_RCU_NOCB_CPU
> -	return atomic_long_xchg(&rsclp->len, v);
> -#else
> -	long ret = rsclp->len;
> -
> -	smp_mb(); /* Up to the caller! */
> -	WRITE_ONCE(rsclp->len, v);
> -	smp_mb(); /* Up to the caller! */
> -	return ret;
> -#endif
> -}
> -

This looks nice!

>  /*
>   * Initialize an rcu_segcblist structure.
>   */
> @@ -361,6 +341,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
>  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
>  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> +	rcu_segcblist_add_len(rsclp, -(rclp->len));
>  }
>  
>  /*
> @@ -414,17 +395,7 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
>  		rcu_segcblist_set_seglen(rsclp, i, 0);
>  	}
> -}
> -
> -/*
> - * Insert counts from the specified rcu_cblist structure in the
> - * specified rcu_segcblist structure.
> - */
> -void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
> -				struct rcu_cblist *rclp)
> -{
> -	rcu_segcblist_add_len(rsclp, rclp->len);
> -	rclp->len = 0;
> +	rcu_segcblist_add_len(rsclp, -(rclp->len));

As does this.  ;-)

>  }
>  
>  /*
> @@ -448,6 +419,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
>  			break;
>  	rclp->head = NULL;
>  	rclp->tail = &rclp->head;
> +	rcu_segcblist_add_len(rsclp, rclp->len);

Does there need to be a compensating action in rcu_do_batch(), or is
this the point of the "rcu_segcblist_add_len(rsclp, -(rclp->len));"
added to rcu_segcblist_extract_done_cbs() above?

If so, a comment would be good.

>  }
>  
>  /*
> @@ -463,6 +435,7 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
>  	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
>  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
> +	rcu_segcblist_add_len(rsclp, rclp->len);
>  }
>  
>  /*
> @@ -601,16 +574,13 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>  {
>  	struct rcu_cblist donecbs;
>  	struct rcu_cblist pendcbs;
> -	long src_len;
>  
>  	rcu_cblist_init(&donecbs);
>  	rcu_cblist_init(&pendcbs);
>  
> -	src_len = rcu_segcblist_xchg_len(src_rsclp, 0);
>  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
>  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
>  
> -	rcu_segcblist_add_len(dst_rsclp, src_len);
>  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
>  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);

Can we now pair the corresponding _extract_ and _insert_ calls, thus
requiring only one rcu_cblist structure?  This would drop two more lines
of code.  Or would that break something?

							Thanx, Paul
