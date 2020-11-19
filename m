Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80BFC2D0E4
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 03:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C579246C0
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 03:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P79BGE06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKSD4P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Nov 2020 22:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKSD4O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Nov 2020 22:56:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB5C246B0;
        Thu, 19 Nov 2020 03:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605758173;
        bh=O1jqm1mU4En+Yq4IQvbC+oEAUUqMUvdf56rbkAebN3Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P79BGE06EkMUPgBsxphK7GKHa2IdWGjW5wmuLJ6jMs0Tk4JvrkMJ7vF/ChJhUdxDc
         hHOfhcOxZWIii5uXxBaFaT9FnglWXD4Dp0SyOSqqTsKHIqKUj5ltHn0bq5ziBWQgkw
         19C24SQ6vH55cpgTCPYp4EQw+cuoJMHLhy4fohTs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1679235227BD; Wed, 18 Nov 2020 19:56:13 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:56:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
Message-ID: <20201119035613.GA18816@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118161541.3844924-1-joel@joelfernandes.org>
 <20201118201335.GR1437@paulmck-ThinkPad-P72>
 <20201119035222.GA18458@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119035222.GA18458@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 18, 2020 at 07:52:23PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 18, 2020 at 12:13:35PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 18, 2020 at 11:15:41AM -0500, Joel Fernandes (Google) wrote:
> > > After rcu_do_batch(), add a check for whether the seglen counts went to
> > > zero if the list was indeed empty.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Queued for testing and further review, thank you!
> 
> FYI, the second of the two checks triggered in all four one-hour runs of
> TREE01, all four one-hour runs of TREE04, and one of the four one-hour
> runs of TREE07.  This one:
> 
> WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> 
> That is, there are callbacks in the list, but the sum of the segment
> counts is nevertheless zero.  The ->nocb_lock is held.
> 
> Thoughts?

FWIW, TREE01 reproduces it very quickly compared to the other two
scenarios, on all four run, within five minutes.

							Thanx, Paul

> > > ---
> > > v1->v2: Added more debug checks.
> > > 
> > >  kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
> > >  kernel/rcu/rcu_segcblist.h |  3 +++
> > >  kernel/rcu/tree.c          |  2 ++
> > >  3 files changed, 17 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index 5059b6102afe..6e98bb3804f0 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> > >  	return READ_ONCE(rsclp->seglen[seg]);
> > >  }
> > >  
> > > +/* Return number of callbacks in segmented callback list by totalling seglen. */
> > > +long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp)
> > > +{
> > > +	long len = 0;
> > > +	int i;
> > > +
> > > +	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
> > > +		len += rcu_segcblist_get_seglen(rsclp, i);
> > > +
> > > +	return len;
> > > +}
> > > +
> > >  /* Set the length of a segment of the rcu_segcblist structure. */
> > >  static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> > >  {
> > > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > > index cd35c9faaf51..46a42d77f7e1 100644
> > > --- a/kernel/rcu/rcu_segcblist.h
> > > +++ b/kernel/rcu/rcu_segcblist.h
> > > @@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
> > >  	return READ_ONCE(rclp->len);
> > >  }
> > >  
> > > +/* Return number of callbacks in segmented callback list by totalling seglen. */
> > > +long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
> > > +
> > >  void rcu_cblist_init(struct rcu_cblist *rclp);
> > >  void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
> > >  void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index f5b61e10f1de..91e35b521e51 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2553,6 +2553,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
> > >  	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
> > >  	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> > >  		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
> > > +	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
> > > +	WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > >  
> > >  	rcu_nocb_unlock_irqrestore(rdp, flags);
> > >  
> > > -- 
> > > 2.29.2.299.gdc1121823c-goog
