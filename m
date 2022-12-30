Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B76C3DA7C
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiL3XZR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 18:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiL3XY7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 18:24:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552E1EC46
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 15:24:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38452B81DAD
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 23:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A36C433EF;
        Fri, 30 Dec 2022 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672442667;
        bh=ZgEg3PP7WRXKFijQsNf+vWjIfFHrQt5bz2TLXuHlKX0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jsfG1dF99F5NqopW3yowGuQogjBn/x/bBVYU/+8Wb+2/qnLAPj6SX4uX0bFGfMe9e
         twZ2JRG4M5udhTTjKYGLjvC2gvfk1mBiNqGiBF0RtC15sCk9hZS+gnoeerKNxin1Nf
         fvvF97pk7t3U1uzuMR7siu4xQtxKPqsWkRWS0RT80zfBXnqv5smsxWHj91DVPPS3Ks
         bxE/KNfsAW1baJUL5ZktIBBtlfEBXewW68BHkFMRLvSZosraxIf3aoyu/exoZFLbkY
         xvy7EnUKkP7N+MJhj+bqB7Rg0YgtAgrx9zCN9sDDicencGp/DL49QDTgB+XUVAyfoL
         tOLm7iceiUQwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 944B45C097E; Fri, 30 Dec 2022 15:24:26 -0800 (PST)
Date:   Fri, 30 Dec 2022 15:24:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Catch dwmw2's deadlock
Message-ID: <20221230232426.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y67NrWVLaL7B/EuO@casper.infradead.org>
 <20221230203012.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <Y69e/1h+xZbS7hlg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y69e/1h+xZbS7hlg@casper.infradead.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 09:58:23PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 30, 2022 at 12:30:12PM -0800, Paul E. McKenney wrote:
> > On Fri, Dec 30, 2022 at 11:38:21AM +0000, Matthew Wilcox wrote:
> > > 
> > > <dwmw2> why doesn't lockdep catch us calling synchronize_srcu() with
> > >    a lock held, and elsewhere obtaining that lock within an srcu critical
> > >    region ("read lock") ?
> > > 
> > > Because synchronize_srcu() doesn't acquire the lock, merely checks that
> > > it isn't held.
> > > 
> > > Would this work?  Not even compile tested.
> > > 
> > > You can put my SoB on this if it works.
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index ca4b5dcec675..e9c2ab8369c0 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1267,11 +1267,11 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
> > >  {
> > >  	struct rcu_synchronize rcu;
> > >  
> > > -	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > > -			 lock_is_held(&rcu_bh_lock_map) ||
> > > +	rcu_lock_acquire(&ssp->dep_map);
> > 
> > If this does do anything, why doesn't lockdep complain about things
> > like this?
> > 
> > 	i1 = srcu_read_lock(&my_srcu);
> > 	i2 = srcu_read_lock(&my_srcu);
> > 	srcu_read_unlock(&my_srcu, i2);
> > 	srcu_read_unlock(&my_srcu, i1);
> > 
> > Or does it in fact complain and I have somehow managed to confuse things
> > such that rcutorture does not detect such complaints?  I would expect
> > rcutorture_extend_mask_max() to make this happen, but then again, RCU
> > has confused me in the past.
> 
> static inline void rcu_lock_acquire(struct lockdep_map *map)
> {
>         lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
> }
> 
> That's clear as mud, of course.  The fourth argument, which has value
> '2' is documented as 'int read', and that has the meaning:
> 
>  * Values for "read":
>  *
>  *   0: exclusive (write) acquire
>  *   1: read-acquire (no recursion allowed)
>  *   2: read-acquire with same-instance recursion allowed
> 
> But that's enough to establish the locking hierarchy.  ie if you do:
> 
> read-lock-A
> write-lock-B
> 
> in one thread and in the other thread do:
> 
> write-lock-B
> read-lock-A
> 
> lockdep is still going to detect that as a deadly embrace.  Isn't it?

Maybe?

> In any case, I was just trying to point out the general outlines of
> something I saw as a potential solution.  If we need to turn that into
> lock_acquire(map, 0, 0, 0, 0, NULL, _THIS_IP), that's fine.  And Joel
> is right, there needs to be a release in that other path.
> 
> But I am not an expert in RCU, lockdep, or working while travelling,
> so I was rather hoping someone like dwmw2 would pick up the sketch,
> make it compile, and then test it.

Sounds like a plan to me!

							Thanx, Paul
