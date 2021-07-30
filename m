Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC3C4338F
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 03:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7D560F59
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 03:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhG3D1B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jul 2021 23:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhG3D1B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jul 2021 23:27:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F28AE60F0F;
        Fri, 30 Jul 2021 03:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627615617;
        bh=t3gb1iTHgyqw8X0kGVClqBw/KXrcgZHaOoVKEwHFQaI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HzPVwbUk5Kq4QIK6Xk9l54SXMmSFRTtyXDI5xKavQ9SYBP2rWEojNiSI9yKVD3AKl
         Y70yoRPIO72zRcZ4IDFH2ohdyOI832XpONuVIrv/sLD+dVLfvY6OkaYh+YHZ4mXnyv
         DT+hpj8sUkW9t3zQwhzsM+9QpldEMhMSGez5UpmPOKSEGT7p8udYt6pdbhvClc1i7R
         8cgbc5DUldAZpzitJe6BBstxhj9hPw7QY7G5EOEz6opiwyX8iolWbZyXb8oqaqup5L
         ldK3Hi4qwlQ470zjmUvF/UjU9zcRLQFSQSiacyQJDa6+O2UhTYQgtyejt9Xpho7zcA
         Z2Tc9pP+3MtMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C50F25C051B; Thu, 29 Jul 2021 20:26:56 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:26:56 -0700
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
Message-ID: <20210730032656.GF4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-11-paulmck@kernel.org>
 <YQJsxtypw7M/3XBD@boqun-archlinux>
 <20210729140317.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <YQNj6v2o5hG/MoXZ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQNj6v2o5hG/MoXZ@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 30, 2021 at 10:28:58AM +0800, Boqun Feng wrote:
> On Thu, Jul 29, 2021 at 07:03:17AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 29, 2021 at 04:54:30PM +0800, Boqun Feng wrote:
> > > On Wed, Jul 21, 2021 at 01:21:19PM -0700, Paul E. McKenney wrote:
> > > > Accesses to ->qsmask are normally protected by ->lock, but there is an
> > > > exception in the diagnostic code in rcu_check_boost_fail().  This commit
> > > > therefore applies data_race() to this access to avoid KCSAN complaining
> > > > about the C-language writes protected by ->lock.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_stall.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > index 42847caa3909b..6dd6c9aa3f757 100644
> > > > --- a/kernel/rcu/tree_stall.h
> > > > +++ b/kernel/rcu/tree_stall.h
> > > > @@ -766,7 +766,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
> > > >  
> > > >  	rcu_for_each_leaf_node(rnp) {
> > > >  		if (!cpup) {
> > > > -			if (READ_ONCE(rnp->qsmask)) {
> > > > +			if (data_race(READ_ONCE(rnp->qsmask))) {
> > > 
> > > If the write sides allow normal writes, i.e. allowing store tearing, the
> > > READ_ONCE() here could read incomplete writes, which could be anything
> > > basically? And we get the same result if we remove the READ_ONCE(),
> > > don't we? Yes, I know, without the READ_ONCE(), compilers can do
> > > anything to optimize on rnp->qsmask, but the end result is same or
> > > similar to reading incomplete writes (which is also a result by compiler
> > > optimization). So if we mark something as data_race(), **in theory**, it
> > > makes no difference with or without the READ_ONCE(), so I think maybe we
> > > can remove the READ_ONCE() here?
> > 
> > In this particular case, perhaps.  But there is also the possibility
> > of ASSERT_EXCLUSIVE_WRITER() in conjunction with WRITE_ONCE(), and
> > data_race(READ_ONCE(()) handles all such cases properly.
> > 
> > Again, the point here is to prevent the compiler from messing with
> > the load in strange and unpredictable ways while also telling KCSAN
> > that this particular read should not be considered to be part of the
> > concurrent algorithm.
> 
> Thanks for explaining this ;-)
> 
> I guess I'm just a little concerned that things may end up with using
> data_race(READ_ONCE()) everywhere instead of data_race(), because who
> doesn't want his/her racy code to be 1) not reported by KCSan (using
> data_race()), and 2) less racy (using READ_ONCE())? ;-)

There always is the risk of a too-attractive "easy way out",
isn't there?  Just make sure to understand exactly where
the "out" leads to longer term.  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > 							Thanx, Paul
> > 
> > > Regards,
> > > Boqun
> > > 
> > > >  				return false;
> > > >  			} else {
> > > >  				if (READ_ONCE(rnp->gp_tasks))
> > > > -- 
> > > > 2.31.1.189.g2e36527f23
> > > > 
