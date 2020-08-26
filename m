Return-Path: <SRS0=cYnC=CE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E0C433E1
	for <rcu@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95B1221E2
	for <rcu@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598451635;
	bh=U1WyvVQpTJcvW/3SSoIx+r4B+XBN/pfqdpgz99RoBzM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aTqgRufidPpG7/68H0WD0U/T5yD4aSifzzxgCLlKBW6bYlvpnbKpqv3quclc5O6oO
	 3d67ycXsQayLdrvZ9xcj8u9Rrnjb4VFs11RwbEyF/bXgJn5CDcID06ijj0gb0Nff17
	 cxMk67/JZsmOboCFteDCtPeqYTsKGUhjSp2QdSpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgHZOUf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgHZOUa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Aug 2020 10:20:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E28208E4;
        Wed, 26 Aug 2020 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598451629;
        bh=U1WyvVQpTJcvW/3SSoIx+r4B+XBN/pfqdpgz99RoBzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WcAJP06vBqbso9IrCOqXaB+y/KsHF+wkLVozIWv/Pk8JONWFIgrQc/hG7L+HdvP3T
         +t9EkCSqPUeKIzvxJIjvLBB36nlFIRYvywmAKgCLH+1wbOhLENZNhuIp58eeaXfMo3
         8RIDS5Vt0wjJQ0qHR/irSgzocG4w7hX7e31Uxz4Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ED9DC3522612; Wed, 26 Aug 2020 07:20:28 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:20:28 -0700
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
Message-ID: <20200826142028.GN2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-2-joel@joelfernandes.org>
 <20200825200809.GW2855@paulmck-ThinkPad-P72>
 <20200825224723.GB579506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825224723.GB579506@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 25, 2020 at 06:47:23PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Tue, Aug 25, 2020 at 01:08:09PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 24, 2020 at 10:48:39PM -0400, Joel Fernandes (Google) wrote:
> > > The donecbs's ->len field is used to store the total count of the segmented
> > > callback list's length. This ->len field is then added to the destination segcb
> > > list.
> > > 
> > > However, this presents a problem for per-segment length counting which is added
> > > in a future patch. This future patch sets the rcl->len field as we move
> > > segments of callbacks between source and destination lists, thus becoming
> > > incompatible with the donecb's ->len field.
> > 
> > OK, I will bite.  What is "rcl"?  A placeholder for donecbs and pendcbs?
> > If so, please just name them both.  If not, please explain.
> 
> Ok will fix.
> 
> > > This commit therefore avoids depending on the ->len field in this way. IMHO,
> > > this is also less error-prone and is more accurate - the donecb's ->len field
> > > should be the length of the done segment and not just used as a temporarily
> > > variable.
> > 
> > Please also mention why ->len is handled specially at all, namely
> > interactions between rcu_barrier() and callback invocation.  This is
> > the answer to "why not just make all this work like normal lists?"
> > This might go well in the first paragraph.
> 
> Are you referring to the cblist structures ->len?  I know the segcblist's
> ->len field is what rcu_barrier() samples but I am not changing that behavior
> at all in this patch. This patch is only about the donecb's len (which is a
> cblist structure on the stack).

Yes, we agree.  I am just suggesting that you call this out in the
commit log.  It is probably not obvious to those who have not been
through the code yet.  ;-)

> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/rcu_segcblist.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index 2d2a6b6b9dfb..b70d4154433c 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -513,14 +513,18 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> > >  {
> > >  	struct rcu_cblist donecbs;
> > >  	struct rcu_cblist pendcbs;
> > > +	long src_len;
> > >  
> > >  	rcu_cblist_init(&donecbs);
> > >  	rcu_cblist_init(&pendcbs);
> > > -	rcu_segcblist_extract_count(src_rsclp, &donecbs);
> > > +
> > > +	src_len = rcu_segcblist_xchg_len(src_rsclp, 0);
> > 
> > Given that both rcu_segcblist_xchg_len() and rcu_segcblist_extract_count()
> > have only one callsite each, why not get rid of one of them?
> 
> Good point, I will do that.
> 
> > Or better yet, please see below, which should allow getting rid of both
> > of them.
> > 
> > >  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
> > >  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> > > -	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> > > +
> > > +	rcu_segcblist_add_len(dst_rsclp, src_len);
> > >  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
> > >  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> > 
> > Rather than adding the blank lines, why not have the rcu_cblist structures
> > carry the lengths?  You are already adjusting one of the two call sites
> > that care (rcu_do_batch()), and the other is srcu_invoke_callbacks().
> > That should shorten this function a bit more.  And make callback handling
> > much more approachable, I suspect.
> 
> Sorry, I did not understand. The rcu_cblist structure already has a length
> field. I do modify rcu_segcblist_extract_done_cbs() and
> rcu_segcblist_extract_pend_cbs() to carry the length already, in a later
> patch.
> 
> Just to emphasize, this patch is just a small refactor to avoid an issue in
> later patches. It aims to keep current functionality unchanged.

True enough.  I am just suggesting that an equally small refactor in
a slightly different direction should get to a better place.  The key
point enabling this slightly different direction is that this code is
an exception to the "preserve ->cblist.len" rule because it is invoked
only from the CPU hotplug code.

So you could use the rcu_cblist .len field to update the ->cblist.len
field, thus combining the _cbs and _count updates.  One thing that helps
is that setting th e rcu_cblist .len field doesn't hurt the other use
cases that require careful handling of ->cblist.len.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 
> > There would still be the callback-invocation need to be careful with
> > ->cblist.len due to rcu_barrier() and srcu_barrier().  But both of
> > those should be excluded by this code.  (But don't take my word for it,
> > ask KCSAN.)
> > 
> > 							Thanx, Paul
> > 
> > > +
> > >  	rcu_segcblist_init(src_rsclp);
> > >  }
> > > -- 
> > > 2.28.0.297.g1956fa8f8d-goog
> > > 
