Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645C3C4363A
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 21:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF362417D
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603317188;
	bh=RO7qplhzXpq4aft0tyU5ptA9YB6dGOGm8R6A3toExu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DXYPwafzKyL0s6TAO+T5l843HUBNp7FjtG/PEyvESLH87NUAFdVjh+NJCS67VRU85
	 dk2p4XSToRhKwwk+x61TudAX8GaqhGccTaY6jFLq9bFgct7n2NIG/EzCiHKUauBVzP
	 WvQ0dCmBA8ZNwuSnkgrG2nBHQG4xr/SJo1ew7Xdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409563AbgJUVxH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409453AbgJUVxH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 17:53:07 -0400
Received: from localhost (cha74-h07-176-172-165-167.dsl.sta.abo.bbox.fr [176.172.165.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA4F24178;
        Wed, 21 Oct 2020 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603317187;
        bh=RO7qplhzXpq4aft0tyU5ptA9YB6dGOGm8R6A3toExu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jciVwd5BoGiyb+REu47mAAuRFB0SXa8PHq3hn6CbLsAnnsU4bg/jgapMvMZuxhV5o
         CbY+ZAuAyvVdARrBQfwg6o/5bQY5kB/s8tqXje3RLK+eCkgokSAEwM8Gw7fO7ZaSY3
         /6IuFdFjrB7qukWm1/rrVcqPPoHqkPgLuZ/24Ruc=
Date:   Wed, 21 Oct 2020 23:53:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v7 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201021215304.GB78735@lothringen>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-3-joel@joelfernandes.org>
 <20201015122158.GA127222@lothringen>
 <20201021153314.GB2828884@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021153314.GB2828884@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 21, 2020 at 11:33:14AM -0400, joel@joelfernandes.org wrote:
> On Thu, Oct 15, 2020 at 02:21:58PM +0200, Frederic Weisbecker wrote:
> > On Wed, Oct 14, 2020 at 08:22:57PM -0400, Joel Fernandes (Google) wrote:
> > > Add counting of segment lengths of segmented callback list.
> > > 
> > > This will be useful for a number of things such as knowing how big the
> > > ready-to-execute segment have gotten. The immediate benefit is ability
> > > to trace how the callbacks in the segmented callback list change.
> > > 
> > > Also this patch remove hacks related to using donecbs's ->len field as a
> > > temporary variable to save the segmented callback list's length. This cannot be
> > > done anymore and is not needed.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  include/linux/rcu_segcblist.h |   2 +
> > >  kernel/rcu/rcu_segcblist.c    | 133 +++++++++++++++++++++++-----------
> > >  kernel/rcu/rcu_segcblist.h    |   2 -
> > >  3 files changed, 92 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > > index b36afe7b22c9..d462ae5e340a 100644
> > > --- a/include/linux/rcu_segcblist.h
> > > +++ b/include/linux/rcu_segcblist.h
> > > @@ -69,8 +69,10 @@ struct rcu_segcblist {
> > >  	unsigned long gp_seq[RCU_CBLIST_NSEGS];
> > >  #ifdef CONFIG_RCU_NOCB_CPU
> > >  	atomic_long_t len;
> > > +	atomic_long_t seglen[RCU_CBLIST_NSEGS];
> > 
> > Also does it really need to be atomic?
> 
> Yes, it need not be. I will make the change for ->seglen.
> 
> BTW, for the existing ->len field, doesn't the following need to acquire nocb
> lock?
> rcu_nocb_try_bypass -> rcu_segcblist_inc_len
> 
> It seems that will do a lock-less non-atomic RMW on a nocb offloaded list,
> otherwise.

I believe it shouldn't be necessary. That's an atomic add and the kthreads
manipulating it shouldn't have any trouble concurrently. None that I can
imagine tonight at least...

> Certainly rcu_nocb_do_flush_bypass() does do it so maybe it was missed?

I believe it increments under the lock here because the inc happens to be on the way
to the insertion of the callbacks :o)
