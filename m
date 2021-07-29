Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1CC432BE
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 14:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D436054F
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 14:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhG2OKM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbhG2ODU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jul 2021 10:03:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A32860F46;
        Thu, 29 Jul 2021 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567397;
        bh=X4sEiDfkDpXkQx7JEk+KmwG56WVDr7UNS8u2jAOMbNA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SME/CV4vj5SVO/nLDMVi2tNTXB7NM7nF4Z7J0vdMVuuCvpZHQR6BQ8zXoqCbnbwmm
         J2cEjJx+yC6F9HoKUeOmNQ32sKEO7g9TpccK0KAcfidXPxvsGrw34DitAoxPddi32b
         p65BDwV/dMuDGhygH5fnkLgXA4yyyZsFowUWtG4T9HoPIk3+tF/EwbaKe0DtHmEJtR
         lyBANN+TMs4+v+0JzI1f79SZ81EggGOZZj+JHNIKOz/Wan9H7sA5895Ayq3M4tnKix
         aRLzNJoNBiEhbj6ZUv5O6dVvg6Xg6UjUzGG0nM2N8IASTlMt7u98yoStAm0dEU6a/g
         7JzWOaxvswdUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 380435C04E6; Thu, 29 Jul 2021 07:03:17 -0700 (PDT)
Date:   Thu, 29 Jul 2021 07:03:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 11/18] rcu: Mark lockless ->qsmask read in
 rcu_check_boost_fail()
Message-ID: <20210729140317.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-11-paulmck@kernel.org>
 <YQJsxtypw7M/3XBD@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQJsxtypw7M/3XBD@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 29, 2021 at 04:54:30PM +0800, Boqun Feng wrote:
> On Wed, Jul 21, 2021 at 01:21:19PM -0700, Paul E. McKenney wrote:
> > Accesses to ->qsmask are normally protected by ->lock, but there is an
> > exception in the diagnostic code in rcu_check_boost_fail().  This commit
> > therefore applies data_race() to this access to avoid KCSAN complaining
> > about the C-language writes protected by ->lock.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_stall.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 42847caa3909b..6dd6c9aa3f757 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -766,7 +766,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
> >  
> >  	rcu_for_each_leaf_node(rnp) {
> >  		if (!cpup) {
> > -			if (READ_ONCE(rnp->qsmask)) {
> > +			if (data_race(READ_ONCE(rnp->qsmask))) {
> 
> If the write sides allow normal writes, i.e. allowing store tearing, the
> READ_ONCE() here could read incomplete writes, which could be anything
> basically? And we get the same result if we remove the READ_ONCE(),
> don't we? Yes, I know, without the READ_ONCE(), compilers can do
> anything to optimize on rnp->qsmask, but the end result is same or
> similar to reading incomplete writes (which is also a result by compiler
> optimization). So if we mark something as data_race(), **in theory**, it
> makes no difference with or without the READ_ONCE(), so I think maybe we
> can remove the READ_ONCE() here?

In this particular case, perhaps.  But there is also the possibility
of ASSERT_EXCLUSIVE_WRITER() in conjunction with WRITE_ONCE(), and
data_race(READ_ONCE(()) handles all such cases properly.

Again, the point here is to prevent the compiler from messing with
the load in strange and unpredictable ways while also telling KCSAN
that this particular read should not be considered to be part of the
concurrent algorithm.

							Thanx, Paul

> Regards,
> Boqun
> 
> >  				return false;
> >  			} else {
> >  				if (READ_ONCE(rnp->gp_tasks))
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
