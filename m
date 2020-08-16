Return-Path: <SRS0=FxgN=B2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC46C433E1
	for <rcu@archiver.kernel.org>; Sun, 16 Aug 2020 18:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AEC20829
	for <rcu@archiver.kernel.org>; Sun, 16 Aug 2020 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597600899;
	bh=/9r6IbF8e59Xv39Uoi0I+/R+320IQ9PbohZJBZC6N18=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j/V6iPLIYkXFmHIEaSlqJ5jEvP2Xz1/sdbb+RaJywcuJxUz4esUho+MX0KhX9uJaf
	 fwqDubhFU/Q+gG0VKKxSd3qiVLOjcRYBVcPAd6frLS95mAbTT6S+U5wodTEoxDRw/4
	 dhXcOpBa3+iCcfhPXUd2798RU7ImPqrY2KSpGzO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHPSBj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Aug 2020 14:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgHPSBi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Aug 2020 14:01:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB9220829;
        Sun, 16 Aug 2020 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597600897;
        bh=/9r6IbF8e59Xv39Uoi0I+/R+320IQ9PbohZJBZC6N18=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ULRx2uIC7t1znyRP8JrVQfG1e+FEezBXa4pQlOjdyeNcg6UHib5irtk993CiF04p0
         R27t0r+blZu/QPnDqHfAAewJh4ZEnMOmgJPGGEia0z0X1DQEowJd91PgmJuqUY2yCN
         35qylvcmifbEFOH9otAZR9DDJzylz2jc2KAjDiW4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9464635226F6; Sun, 16 Aug 2020 11:01:37 -0700 (PDT)
Date:   Sun, 16 Aug 2020 11:01:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chao Zhou <chaozhou1018@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Allow multiple GP misses before Panic
Message-ID: <20200816180137.GA23602@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
 <20200813181941.GD4295@paulmck-ThinkPad-P72>
 <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
 <CAJdzfEdfCFqF4t8kNL4UriBW8xTMtsgx7FNjQZwPHzTFQaATiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJdzfEdfCFqF4t8kNL4UriBW8xTMtsgx7FNjQZwPHzTFQaATiA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 12:00:07PM -0700, Chao Zhou wrote:
> Hi Paul,
> 
> Because sysctl panic_on_rcu_stall is public interface, it might have
> already been used by adopters, will the change break them? Will a new
> sysctl max_rcu_stall_to_panic be more un-interruptive? Appreciate your
> insights about this .

It is a public interface, but using the previously forbidden values
other than zero and one is fine.

							Thanx, Paul

> On Thu, Aug 13, 2020 at 11:50 AM Chao Zhou <chaozhou1018@gmail.com> wrote:
> >
> > Thanks Paul for the insights!
> >
> > I studied the 3 options and think that #1+#3 offers both flexibility
> > to users and coverage of boundary user cases.
> >
> > For example, as an user of RCU, we want the warnings to be spilled at
> > the default 21 seconds so that we know such events are happening. At
> > the same time, we want Panic to happen if the stall is long enough to
> > significantly affect available system memory on our system.
> >
> > Here is the plan based on our discussion, please advise if not inline
> > with the idea:
> > 1. modify panic_on_rcu_stall to be the maximum number of consecutive
> > warnings to trigger Panic.
> >     1) change its name to max_rcu_stall_to_panic,
> >     2) default value to 1, which is the same behavior as today's.
> > 2. use ((struct rcu_state *)->gpnum - (struct rcu_data *)->gpnum) >=
> > max_rcu_stall_to_panic as condition to trigger Panic;
> > 3. reset (struct rcu_data *)->gpnum to (struct rcu_state *)->gpnum
> > every time a new grace period starts;
> > 4. add a new member (struct rcu_data *)->gpmiss that is incremented at
> > each miss to track how many misses so far for statistics/debug
> > purpose.
> >
> > Your insights and advice are highly appreciated.
> >
> > Thanks!
> >
> > Chao
> >
> > On Thu, Aug 13, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> > > > Hi,
> > > >
> > > > Some RCU stalls are transient and a system is fully capable to recover
> > > > after that, but we do want Panic after certain amount of GP misses.
> > > >
> > > > Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> > > > and 1 GP miss will trigger Panic when it is enabled.
> > > >
> > > > Plan to add a module parameter for users to fine-tune how many GP
> > > > misses are allowed before Panic.
> > > >
> > > > To save our precious time, a diff has been tested on our systems and
> > > > it works and solves our problem in transient RCU stall events.
> > > >
> > > > Your insights and guidance is highly appreciated.
> > >
> > > Please feel free to post a patch.  I could imagine a number of things
> > > you might be doing from your description above:
> > >
> > > 1.      Having a different time for panic, so that (for example) an
> > >         RCU CPU stall warning appears at 21 seconds (in mainline), and
> > >         if the grace period still has not ended at some time specified
> > >         by some kernel parameter.  For example, one approach would be
> > >         to make the existing panic_on_rcu_stall sysctl take an integer
> > >         instead of a boolean, and to make that integer specify how old
> > >         the stall-warned grace period must be before panic() is invoked.
> > >
> > > 2.      Instead use the number of RCU CPU stall warning messages to
> > >         trigger the panic, so that (for example), the panic would happen
> > >         on the tenth message.  Again, the panic_on_rcu_stall sysctl
> > >         might be used for this.
> > >
> > > 3.      Like #2, but reset the count every time a new grace period
> > >         starts.  So if the panic_on_rcu_stall sysctl was set to
> > >         ten, there would need to be ten RCU CPU stall warnings for
> > >         the same grace period before panic() was invoked.
> > >
> > > Of the above three, #1 and #3 seem the most attractive, with a slight
> > > preference for #1.
> > >
> > > Or did you have something else in mind?
> > >
> > >                                                         Thanx, Paul
