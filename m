Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A40C388F9
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCB8238E6
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCcJMFeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgKSTWn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbgKSTWn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 14:22:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8553205F4;
        Thu, 19 Nov 2020 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813761;
        bh=wOSKD6KaekuTL9FaqrJwo8Gx+3gm8XcWsJ/0mjAGK7M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pCcJMFebAGJyWbP1IrcS2R67xjFIkHD+9u0oznjqptnJ7cH2Dp/8nZ/zwYHqsMnCe
         XRrqq7mc9Uk27mvZ1Bb4iMtgRbpkL3qdWlOTiUsNAARAZ8hOszPJ6gS5p6SFCQIdZ0
         nL3BFxZJzAVX/MnCDpwojRCnboSvomP4/IMlcYgg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 40BFB35225CF; Thu, 19 Nov 2020 11:22:41 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:22:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
Message-ID: <20201119192241.GZ1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118161541.3844924-1-joel@joelfernandes.org>
 <20201118201335.GR1437@paulmck-ThinkPad-P72>
 <20201119035222.GA18458@paulmck-ThinkPad-P72>
 <20201119035613.GA18816@paulmck-ThinkPad-P72>
 <20201119183252.GA812262@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119183252.GA812262@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 01:32:52PM -0500, Joel Fernandes wrote:
> On Wed, Nov 18, 2020 at 07:56:13PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 18, 2020 at 07:52:23PM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 18, 2020 at 12:13:35PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Nov 18, 2020 at 11:15:41AM -0500, Joel Fernandes (Google) wrote:
> > > > > After rcu_do_batch(), add a check for whether the seglen counts went to
> > > > > zero if the list was indeed empty.
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > Queued for testing and further review, thank you!
> > > 
> > > FYI, the second of the two checks triggered in all four one-hour runs of
> > > TREE01, all four one-hour runs of TREE04, and one of the four one-hour
> > > runs of TREE07.  This one:
> > > 
> > > WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > > 
> > > That is, there are callbacks in the list, but the sum of the segment
> > > counts is nevertheless zero.  The ->nocb_lock is held.
> > > 
> > > Thoughts?
> > 
> > FWIW, TREE01 reproduces it very quickly compared to the other two
> > scenarios, on all four run, within five minutes.
> 
> So far for TREE01, I traced it down to an rcu_barrier happening so it could
> be related to some interaction with rcu_barrier() (Just a guess).

Well, rcu_barrier() and srcu_barrier() are the only users of
rcu_segcblist_entrain(), if that helps.  Your modification to that
function looks plausible to me, but the system's opinion always overrules
mine.  ;-)

> 'p2' print below is the panic on the second warning. It executes 43 callbacks
> from the segcb list, but the list length still does not appear to be 0.
> 
> I'll debug it more:
> 
> [  191.085702]  rcuop/0-12        0.... 75782125us : rcu_invoke_callback: rcu_preempt rhp=000000006a881152 func=__d_free
> [  191.844028]  rcuop/0-12        0d..1 75796122us : rcu_segcb_stats: SegCbDequeued seglen: (DONE=0, WAIT=43, NEXT_READY=0, NEXT=0) gp_seq: (DONE=0, WAIT=11656, NEXT_READY=11656, NEXT=0)
> [  191.846493]  rcuop/0-12        0.... 75796122us : rcu_invoke_callback: rcu_preempt rhp=00000000017536a2 func=i_callback
> [  191.848160]  rcuop/0-12        0.... 75796123us : rcu_invoke_callback: rcu_preempt rhp=0000000014235c71 func=__d_free
> [  191.849695]  rcuop/0-12        0.... 75796123us : rcu_invoke_callback: rcu_preempt rhp=00000000368c5928 func=i_callback
> [  191.851262]  rcuop/0-12        0.... 75796124us : rcu_invoke_callback: rcu_preempt rhp=00000000bdbea790 func=__d_free
> [  191.852800]  rcuop/0-12        0.... 75796124us : rcu_invoke_callback: rcu_preempt rhp=0000000034b99f3d func=rcu_barrier_callback
> [  192.526784]  rcuop/0-12        0d..1 75809162us : rcu_segcb_stats: SegCbDequeued seglen: (DONE=0, WAIT=0, NEXT_READY=0, NEXT=0) gp_seq: (DONE=0, WAIT=11656, NEXT_READY=11656, NEXT=0)

Quite the coincidence that WAIT and NEXT_READY have exactly the same
number of callbacks, isn't it?  Or am I being too suspicious today?

								Thanx, Paul

> [  192.529132]  rcuop/0-12        0.... 75809163us : rcu_invoke_callback: rcu_preempt rhp=000000002d6a3fce func=rcu_sync_func
> [  192.530807]  rcuop/0-12        0.... 75809165us : rcu_invoke_callback: rcu_preempt rhp=000000009aa91c97 func=destroy_sched_domains_rcu
> [  192.532556]  rcuop/0-12        0.... 75809170us : rcu_invoke_callback: rcu_preempt rhp=000000002bb5a998 func=destroy_sched_domains_rcu
> [  192.534303]  rcuop/0-12        0.... 75809172us : rcu_invoke_callback: rcu_preempt rhp=00000000bcc2369a func=destroy_sched_domains_rcu
> [  192.536053]  rcuop/0-12        0.... 75809174us : rcu_invoke_callback: rcu_preempt rhp=000000004dcec39b func=destroy_sched_domains_rcu
> [  192.537802]  rcuop/0-12        0.... 75809176us : rcu_invoke_callback: rcu_preempt rhp=00000000dedb509d func=destroy_sched_domains_rcu
> [  192.539553]  rcuop/0-12        0.... 75809178us : rcu_invoke_callback: rcu_preempt rhp=000000006fe7dd9e func=destroy_sched_domains_rcu
> [  192.541299]  rcuop/0-12        0.... 75809180us : rcu_invoke_callback: rcu_preempt rhp=000000005a212061 func=destroy_sched_domains_rcu
> [  192.543043]  rcuop/0-12        0.... 75809182us : rcu_invoke_callback: rcu_preempt rhp=00000000c914935f func=destroy_sched_domains_rcu
> [  192.544792]  rcuop/0-12        0.... 75809184us : rcu_invoke_callback: rcu_preempt rhp=0000000019fa3368 func=destroy_sched_domains_rcu
> [  192.546539]  rcuop/0-12        0.... 75809186us : rcu_invoke_callback: rcu_preempt rhp=00000000ab06c069 func=destroy_sched_domains_rcu
> [  192.548289]  rcuop/0-12        0.... 75809188us : rcu_invoke_callback: rcu_preempt rhp=000000003c134d6b func=destroy_sched_domains_rcu
> [  192.550037]  rcuop/0-12        0.... 75809190us : rcu_invoke_callback: rcu_preempt rhp=00000000cd1fda6c func=destroy_sched_domains_rcu
> [  192.551790]  rcuop/0-12        0.... 75809192us : rcu_invoke_callback: rcu_preempt rhp=000000005e2c676e func=destroy_sched_domains_rcu
> [  192.553576]  rcuop/0-12        0.... 75809194us : rcu_invoke_callback: rcu_preempt rhp=00000000ef38f46f func=destroy_sched_domains_rcu
> [  192.555314]  rcuop/0-12        0.... 75809196us : rcu_invoke_callback: rcu_preempt rhp=0000000080458170 func=destroy_sched_domains_rcu
> [  192.557054]  rcuop/0-12        0.... 75809198us : rcu_invoke_callback: rcu_preempt rhp=0000000009316351 func=destroy_sched_domains_rcu
> [  192.558793]  rcuop/0-12        0.... 75809200us : rcu_invoke_callback: rcu_preempt rhp=0000000022a2585e func=destroy_sched_domains_rcu
> [  192.560539]  rcuop/0-12        0.... 75809202us : rcu_invoke_callback: rcu_preempt rhp=00000000b3aee55f func=destroy_sched_domains_rcu
> [  192.562282]  rcuop/0-12        0.... 75809204us : rcu_invoke_callback: rcu_preempt rhp=0000000044bb7261 func=destroy_sched_domains_rcu
> [  192.564028]  rcuop/0-12        0.... 75809206us : rcu_invoke_callback: rcu_preempt rhp=00000000d5c7ff62 func=destroy_sched_domains_rcu
> [  192.565777]  rcuop/0-12        0.... 75809208us : rcu_invoke_callback: rcu_preempt rhp=00000000bc570a55 func=destroy_sched_domains_rcu
> [  192.567568]  rcuop/0-12        0.... 75809210us : rcu_invoke_callback: rcu_preempt rhp=000000004d639757 func=destroy_sched_domains_rcu
> [  192.569315]  rcuop/0-12        0.... 75809212us : rcu_invoke_callback: rcu_preempt rhp=00000000de702458 func=destroy_sched_domains_rcu
> [  192.571111]  rcuop/0-12        0.... 75809214us : rcu_invoke_callback: rcu_preempt rhp=000000006f7cb15a func=destroy_sched_domains_rcu
> [  192.572855]  rcuop/0-12        0.... 75809216us : rcu_invoke_callback: rcu_preempt rhp=0000000000893e5b func=destroy_sched_domains_rcu
> [  192.574595]  rcuop/0-12        0.... 75809218us : rcu_invoke_callback: rcu_preempt rhp=0000000066d48c64 func=destroy_sched_domains_rcu
> [  192.576435]  rcuop/0-12        0.... 75809220us : rcu_invoke_callback: rcu_preempt rhp=000000009a3df053 func=destroy_sched_domains_rcu
> [  192.578182]  rcuop/0-12        0.... 75809221us : rcu_invoke_callback: rcu_preempt rhp=000000002b4a7d54 func=destroy_sched_domains_rcu
> [  192.579981]  rcuop/0-12        0.... 75809223us : rcu_invoke_callback: rcu_preempt rhp=000000009cf78b8b func=destroy_sched_domains_rcu
> [  192.581773]  rcuop/0-12        0.... 75809225us : rcu_invoke_callback: rcu_preempt rhp=000000000beafe8a func=destroy_sched_domains_rcu
> [  192.583547]  rcuop/0-12        0.... 75809227us : rcu_invoke_callback: rcu_preempt rhp=000000007ade7189 func=destroy_sched_domains_rcu
> [  192.585373]  rcuop/0-12        0.... 75809229us : rcu_invoke_callback: rcu_preempt rhp=00000000e9d1e487 func=destroy_sched_domains_rcu
> [  192.587139]  rcuop/0-12        0.... 75809231us : rcu_invoke_callback: rcu_preempt rhp=000000002e04188d func=destroy_sched_domains_rcu
> [  192.588984]  rcuop/0-12        0.... 75809233us : rcu_invoke_callback: rcu_preempt rhp=00000000bf10a58e func=destroy_sched_domains_rcu
> [  192.590732]  rcuop/0-12        0.... 75809235us : rcu_invoke_callback: rcu_preempt rhp=00000000501d3290 func=destroy_sched_domains_rcu
> [  192.592562]  rcuop/0-12        0.... 75809237us : rcu_invoke_callback: rcu_preempt rhp=00000000e129bf91 func=destroy_sched_domains_rcu
> [  192.594309]  rcuop/0-12        0.... 75809239us : rcu_invoke_callback: rcu_preempt rhp=0000000072364c93 func=destroy_sched_domains_rcu
> [  192.596063]  rcuop/0-12        0.... 75809241us : rcu_invoke_callback: rcu_preempt rhp=000000000342d994 func=destroy_sched_domains_rcu
> [  192.597807]  rcuop/0-12        0.... 75809243us : rcu_invoke_callback: rcu_preempt rhp=00000000944f6695 func=destroy_sched_domains_rcu
> [  192.599608]  rcuop/0-12        0.... 75809245us : rcu_invoke_callback: rcu_preempt rhp=00000000255bf397 func=destroy_sched_domains_rcu
> [  192.601341]  rcuop/0-12        0.... 75809247us : rcu_invoke_callback: rcu_preempt rhp=00000000d4a4767b func=free_rootdomain
> [  192.602958]  rcuop/0-12        0.... 75809251us : rcu_invoke_callback: rcu_preempt rhp=00000000b6688098 func=destroy_sched_domains_rcu
> [  192.604779]  rcuop/0-12        0.... 75809269us : rcu_invoke_callback: rcu_preempt rhp=0000000034b99f3d func=rcu_barrier_callback
> [  193.894910]  rcuop/0-12        0d..1 75873331us : rcu_do_batch: p2
> 
> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > > > ---
> > > > > v1->v2: Added more debug checks.
> > > > > 
> > > > >  kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
> > > > >  kernel/rcu/rcu_segcblist.h |  3 +++
> > > > >  kernel/rcu/tree.c          |  2 ++
> > > > >  3 files changed, 17 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > > > index 5059b6102afe..6e98bb3804f0 100644
> > > > > --- a/kernel/rcu/rcu_segcblist.c
> > > > > +++ b/kernel/rcu/rcu_segcblist.c
> > > > > @@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> > > > >  	return READ_ONCE(rsclp->seglen[seg]);
> > > > >  }
> > > > >  
> > > > > +/* Return number of callbacks in segmented callback list by totalling seglen. */
> > > > > +long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp)
> > > > > +{
> > > > > +	long len = 0;
> > > > > +	int i;
> > > > > +
> > > > > +	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
> > > > > +		len += rcu_segcblist_get_seglen(rsclp, i);
> > > > > +
> > > > > +	return len;
> > > > > +}
> > > > > +
> > > > >  /* Set the length of a segment of the rcu_segcblist structure. */
> > > > >  static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> > > > >  {
> > > > > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > > > > index cd35c9faaf51..46a42d77f7e1 100644
> > > > > --- a/kernel/rcu/rcu_segcblist.h
> > > > > +++ b/kernel/rcu/rcu_segcblist.h
> > > > > @@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
> > > > >  	return READ_ONCE(rclp->len);
> > > > >  }
> > > > >  
> > > > > +/* Return number of callbacks in segmented callback list by totalling seglen. */
> > > > > +long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
> > > > > +
> > > > >  void rcu_cblist_init(struct rcu_cblist *rclp);
> > > > >  void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
> > > > >  void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index f5b61e10f1de..91e35b521e51 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2553,6 +2553,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
> > > > >  	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
> > > > >  	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> > > > >  		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
> > > > > +	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
> > > > > +	WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > > > >  
> > > > >  	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > >  
> > > > > -- 
> > > > > 2.29.2.299.gdc1121823c-goog
