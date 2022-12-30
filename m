Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF8C4332F
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 21:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiL3V6X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 16:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiL3V6W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 16:58:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFD1CFE1
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qsN+PJYH2Mds/zjz0kWfqDXZlS40Y0woEuP6UuTvzNg=; b=Ew/A8krnN/cBfEq978DDDyVrV5
        h7IbqrZTh5+kJoXubfNkRABiwOigg2gdtrwRsUZQiDp2HuYHRtZfiHib9tnvXTcmHdpeEPbfhjHG1
        GMPm4p217vvkdpdWG1FNvsPWo9MKMzmQdbRbXricTJotr5GzloW1zLTlswJDsHU4BrGvum4rgrK93
        l7i5NgBgXRSJFaw1x6Hk75uL+pikiqCUE3bteXgCYQ3mZ+XdMd8Mjtw157ohOXF7YYHhj54+7Eqsh
        PlqyV+tz7F3GZA66O7WLR/sJDkROTE+t5XLohfVfs3SAcLkEumv5YDUGldl3xmrTUtKGHKNXWFr/1
        95qYUChg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pBNOR-00B0xR-Hh; Fri, 30 Dec 2022 21:58:23 +0000
Date:   Fri, 30 Dec 2022 21:58:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Catch dwmw2's deadlock
Message-ID: <Y69e/1h+xZbS7hlg@casper.infradead.org>
References: <Y67NrWVLaL7B/EuO@casper.infradead.org>
 <20221230203012.GN4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230203012.GN4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 12:30:12PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 30, 2022 at 11:38:21AM +0000, Matthew Wilcox wrote:
> > 
> > <dwmw2> why doesn't lockdep catch us calling synchronize_srcu() with
> >    a lock held, and elsewhere obtaining that lock within an srcu critical
> >    region ("read lock") ?
> > 
> > Because synchronize_srcu() doesn't acquire the lock, merely checks that
> > it isn't held.
> > 
> > Would this work?  Not even compile tested.
> > 
> > You can put my SoB on this if it works.
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index ca4b5dcec675..e9c2ab8369c0 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1267,11 +1267,11 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
> >  {
> >  	struct rcu_synchronize rcu;
> >  
> > -	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> > -			 lock_is_held(&rcu_bh_lock_map) ||
> > +	rcu_lock_acquire(&ssp->dep_map);
> 
> If this does do anything, why doesn't lockdep complain about things
> like this?
> 
> 	i1 = srcu_read_lock(&my_srcu);
> 	i2 = srcu_read_lock(&my_srcu);
> 	srcu_read_unlock(&my_srcu, i2);
> 	srcu_read_unlock(&my_srcu, i1);
> 
> Or does it in fact complain and I have somehow managed to confuse things
> such that rcutorture does not detect such complaints?  I would expect
> rcutorture_extend_mask_max() to make this happen, but then again, RCU
> has confused me in the past.

static inline void rcu_lock_acquire(struct lockdep_map *map)
{
        lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
}

That's clear as mud, of course.  The fourth argument, which has value
'2' is documented as 'int read', and that has the meaning:

 * Values for "read":
 *
 *   0: exclusive (write) acquire
 *   1: read-acquire (no recursion allowed)
 *   2: read-acquire with same-instance recursion allowed

But that's enough to establish the locking hierarchy.  ie if you do:

read-lock-A
write-lock-B

in one thread and in the other thread do:

write-lock-B
read-lock-A

lockdep is still going to detect that as a deadly embrace.  Isn't it?

In any case, I was just trying to point out the general outlines of
something I saw as a potential solution.  If we need to turn that into
lock_acquire(map, 0, 0, 0, 0, NULL, _THIS_IP), that's fine.  And Joel
is right, there needs to be a release in that other path.

But I am not an expert in RCU, lockdep, or working while travelling,
so I was rather hoping someone like dwmw2 would pick up the sketch,
make it compile, and then test it.
