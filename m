Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616DDC43334
	for <rcu@archiver.kernel.org>; Wed,  1 Jun 2022 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356055AbiFAQSD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356053AbiFAQSD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Jun 2022 12:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC05EDEB
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 09:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F6636159B
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 16:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2646C385A5;
        Wed,  1 Jun 2022 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654100280;
        bh=UgD5Zh9mAQr8px4aNK+d2CDSXsTGwjrjOgMgVGpML0g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CoFaj/uDFt+dAh4fX+XlFAePFQE//K/X0fRZBIlWtgeSQNQdisC85IgYJW+gALUZ7
         4JD1w2lydBTYlY85CiGWdON7EvoV9gYzxBEMCyjyvQsA1JchyHjun89yuqYa/+gE4I
         FjJSaHdzVfRm+N3wPIPknaT7G+vrgWOSj2LBjPmg74g2zvnItwBEAa7NxdHw/RCye7
         ZuwHOCkVmMAmi6MDBWogmYekHMm0AIjGF0mwWQWZkYr8rUpWeWeUwpVaUSDlFiJsjy
         TVT4VEIRxd+9/DaWGFB53NN8YaL36lflePOAsnRTIYegmB4WSn3e2XrJij9EhedoY6
         i79KY2iziS0cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8B45C5C0127; Wed,  1 Jun 2022 09:17:59 -0700 (PDT)
Date:   Wed, 1 Jun 2022 09:17:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220601161759.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220601142454.GB1288128@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601142454.GB1288128@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 01, 2022 at 04:24:54PM +0200, Frederic Weisbecker wrote:
> On Thu, May 12, 2022 at 04:56:03PM -0700, Paul E. McKenney wrote:
> > On Thu, May 12, 2022 at 03:04:29AM +0000, Joel Fernandes (Google) wrote:
> > > +	preempt_enable();
> > > +
> > > +	if (debug_rcu_head_queue((void *)head)) {
> > > +		// Probable double call_rcu(), just leak.
> > > +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > +				__func__, head);
> > > +
> > > +		// Mark as success and leave.
> > > +		return;
> > > +	}
> > > +
> > > +	// Queue to per-cpu llist
> > > +	head->func = func;
> > > +	llist_add(&head->llist_node, &rlp->head);
> > 
> > Suppose that there are a bunch of preemptions between the preempt_enable()
> > above and this point, so that the current CPU's list has lots of
> > callbacks, but zero ->count.  Can that cause a problem?
> > 
> > In the past, this sort of thing has been an issue for rcu_barrier()
> > and friends.
> 
> Speaking of, shouldn't rcu_barrier() flush all the lazy queues? I
> might have missed that somewhere in the patchset though.

It should, but Joel deferred rcu_barrier() handling for this initial
prototype.  So be careful when playing with it.  ;-)

							Thanx, Paul
