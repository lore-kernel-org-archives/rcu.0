Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23FC433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 16:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiENQVi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiENQVh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 12:21:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D124959
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 09:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C090B8069E
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 16:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31B3C340EE;
        Sat, 14 May 2022 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652545293;
        bh=UCaUYQs8jLQ00kt3DGsgpstKs5NflFPjwg/DQzwzf9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZzjlCIl8FpvDIJLUAfzeeIYWNsfyg3Ht7ju19u0WZlYbC6uWsr4Cz23YouazeB2D/
         x5eWaMbT4dOyrAI2I/xcxUM/uppYQx/yjroZ59x0zi+Q5F/m4CzqJY/Nmf8EjBoUlr
         GDl2H8IuZYqx4TVguyrR7tyVVlPsPwNo5oR7P9HaWW+MIANuBvMsA2fOWxwZE8rakV
         rtNG2vjytw0WNTf1hfbdDKhy437YjwqtAeoyd2PdE2Hs6Mtvz/S+bqSdpL0lYlLFSZ
         JoBop1e6S3KXbRzoFU3eaO0FFvSEbsZlzvOgBrg9OfDdlsgOtBeszvrlCUMZ/W8Inf
         OlJSw8NC2zMYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 820015C033A; Sat, 14 May 2022 09:21:32 -0700 (PDT)
Date:   Sat, 14 May 2022 09:21:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 14/14] DEBUG: Toggle rcu_lazy and tune at runtime
Message-ID: <20220514162132.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-15-joel@joelfernandes.org>
 <20220513001622.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn++/Rx89qZGeuI6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn++/Rx89qZGeuI6@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 14, 2022 at 02:38:53PM +0000, Joel Fernandes wrote:
> On Thu, May 12, 2022 at 05:16:22PM -0700, Paul E. McKenney wrote:
> > On Thu, May 12, 2022 at 03:04:42AM +0000, Joel Fernandes (Google) wrote:
> > > Add sysctl knobs just for easier debugging/testing, to tune the maximum
> > > batch size, maximum time to wait before flush, and turning off the
> > > feature entirely.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > This is good, and might also be needed longer term.
> > 
> > One thought below.
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  include/linux/sched/sysctl.h |  4 ++++
> > >  kernel/rcu/lazy.c            | 12 ++++++++++--
> > >  kernel/sysctl.c              | 23 +++++++++++++++++++++++
> > >  3 files changed, 37 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> > > index c19dd5a2c05c..55ffc61beed1 100644
> > > --- a/include/linux/sched/sysctl.h
> > > +++ b/include/linux/sched/sysctl.h
> > > @@ -16,6 +16,10 @@ enum { sysctl_hung_task_timeout_secs = 0 };
> > >  
> > >  extern unsigned int sysctl_sched_child_runs_first;
> > >  
> > > +extern unsigned int sysctl_rcu_lazy;
> > > +extern unsigned int sysctl_rcu_lazy_batch;
> > > +extern unsigned int sysctl_rcu_lazy_jiffies;
> > > +
> > >  enum sched_tunable_scaling {
> > >  	SCHED_TUNABLESCALING_NONE,
> > >  	SCHED_TUNABLESCALING_LOG,
> > > diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
> > > index 55e406cfc528..0af9fb67c92b 100644
> > > --- a/kernel/rcu/lazy.c
> > > +++ b/kernel/rcu/lazy.c
> > > @@ -12,6 +12,10 @@
> > >  // How much to wait before flushing?
> > >  #define MAX_LAZY_JIFFIES	10000
> > >  
> > > +unsigned int sysctl_rcu_lazy_batch = MAX_LAZY_BATCH;
> > > +unsigned int sysctl_rcu_lazy_jiffies = MAX_LAZY_JIFFIES;
> > > +unsigned int sysctl_rcu_lazy = 1;
> > > +
> > >  // We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
> > >  // allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
> > >  // later to ensure that rcu_head and lazy_rcu_head are of the same size.
> > > @@ -49,6 +53,10 @@ void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
> > >  	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
> > >  	struct rcu_lazy_pcp *rlp;
> > >  
> > > +	if (!sysctl_rcu_lazy) {
> > 
> > This is the place to check for early boot use.  Or, alternatively,
> > initialize sysctl_rcu_lazy to zero and set it to one once boot is far
> > enough along to allow all the pieces to work reasonably.
> 
> Sure, I was also thinking perhaps to set this to a static branch. That way we
> don't have to pay the cost of the branch after it is setup on boot.

A static branch would be fine, though it would be good to demostrate
whether or not it actually provided visble benefits.  Also, please see
below.

> But I think as you mentioned on IRC, if we were to promote this to a
> non-DEBUG patch, we would need to handle conditions similar to Frederick's
> work on toggling offloading.

There are several ways to approach this:

o	Make call_rcu_lazy() also work for non-offloaded CPUs.
	It would clearly need to be default-disabled for this case,
	and careful thought would be required on the distro situation,
	some of which build with CONFIG_NO_HZ_FULL=y, but whose users
	almost all refrain from providing a nohz_full boot parameter.

	In short, adding significant risk to the common case for the
	benefit of an uncommon case is not usually a particularly
	good idea.  ;-)

	And yes, proper segmentation of the cases is important.  As in
	the proper question here is "What happens to users not on ChromeOS
	or Android?"  So the fact that the common case probably is
	Android is not relevant to this line of thought.

o	Make call_rcu_lazy() work on a per-CPU basis, so that a lazy
	CPU cannot be de-offloaded.

o	Make call_rcu_lazy() work on a per-CPU basis, but make flushing
	the lazy queue would be part of the de-offloading process.
	Careful with the static branch in this case, since different
	CPUs might have different reacttions to call_rcu_lazy().

o	Others' ideas here!

							Thanx, Paul
