Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18295C4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiLMUCL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 15:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiLMUCK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 15:02:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E2124F19
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 12:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E0CB6172F
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 20:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8079C433D2;
        Tue, 13 Dec 2022 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670961728;
        bh=13AG+Q1JfEEybWMG5/gWng6erQnio3Z25tkoseOzKIM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ahSStuj0WxuRpVOC15EnTMVCPYh/FeqCloY4p7Y1x2NheJ+RITy55Woa2cTCeKo+G
         t6uTuWolMDAh1/l6aYZGYVUzoYehhjYhQ/WnbY+PXj1NWUQQWjlaUxD9Uj/0PGlOHJ
         yUWLVSXPSWL+mqB5cF3V3DUlyvEHA3oqKk1fBWVSmDERnLwgaPyyECCHjGLZAhyLIV
         r0lLec0IUtUUqWua5tw26WquIJ3+YUSMhtPGg7OFPQ4ZcDh2nn2bG1pmMASQjN+RGx
         Kikb5a+EYZ0l/M7q7FBSTPf0ZPSge0kL5VxWMW4Cz731JCZWVhFXTICEDbzRTGio9n
         Rx29ynjBUBwsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 933165C13B7; Tue, 13 Dec 2022 12:02:07 -0800 (PST)
Date:   Tue, 13 Dec 2022 12:02:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Pingfan Liu <piliu@redhat.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCHv2] srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
Message-ID: <20221213200207.GT4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221128082816.28518-2-kernelfans@gmail.com>
 <20221130033459.16372-1-piliu@redhat.com>
 <20221202221713.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y5h1USSj0lqahJPN@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5h1USSj0lqahJPN@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 08:51:29PM +0800, Pingfan Liu wrote:
> Sorry to reply late. I was interrupted by something else.
> 
> On Fri, Dec 02, 2022 at 02:17:13PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 30, 2022 at 11:34:59AM +0800, Pingfan Liu wrote:
> > > From: Pingfan Liu <kernelfans@gmail.com>
> > > 
> > > The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
> > > And it is not needed. Because counter_wrap_check has guarantee that both
> > > srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
> > > srcu_gp_seq and no false alarm will be raised by the statement in
> > > srcu_gp_start_if_needed()
> > > 
> > >   ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
> > > 
> > > As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
> > > used immediately, not need to wait for another srcu_gp_end() to update
> > > the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.
> > 
> > During the SRCU_SIZE_WAIT_BARRIER state, all callbacks are queued onto
> > the boot CPU's callback list, but the srcu_barrier() function scans all
> > of the CPUs' callback lists.
> 
> So at present, your concern is around how it affects srcu_barrier(), right?

At present, as always, I am concerned about all potential added bugs
and potential added complexity, both in terms of lines of code and in
terms of size and irregularity of state space.

And yes, part of the concern about both correctness and complexity is
the interaction between call_srcu() and srcu_barrier().  Right now, the
design very straightforwardly ensures that rcu_barrier() and the rest of
SRCU is looking at all CPU's callback lists before call_srcu() places any
callbacks on non-boot CPUs.  This is because all the srcu_barrier() calls
that think that the system is still in SRCU_SIZE_SMALL or SRCU_SIZE_ALLOC
mode must have completed before any call_srcu() invocation uses a non-boot
CPU's callback list.

Your change causes rcu_barrier() and call_srcu() to start using non-boot
CPUs' callback lists at the same time.  This change therefore introduces
significant state-space complexity.  And maybe even bugs, if not today
then some later time when someone makes a change that looks obviously
correct on the surface, but which subtly weakens the ordering.

> > So can't this cause srcu_gp_start_if_needed() to rcu_segcblist_advance()
> > and rcu_segcblist_accelerate() a callback list that is guaranteed to be
> > empty?  Without this change, the might-not-be-empty boot CPU's callback
> > list is dealt with.
> 
> Is it a problem that srcu_gp_start_if_needed() asks
> rcu_segcblist_advance() and rcu_segcblist_accelerate() to manipulate an
> not-be-empty callback list ? At SRCU_SIZE_WAIT_BARRIER state,
> srcu_barrier() will take care of all cpus' callback list.

The other way around, please.  My concern is instead that it *fails*
to rcu_segcblist_advance() and rcu_segcblist_accelerate() the
might-not-be-empty callback lists.

> > What am I missing here?  More specifically, what benefits does this
> > change provide?  I am not yet seeing any.
> 
> I am trying to improve the note around SRCU_SIZE_xx, and this is a
> trivial improve from 8 SRCU_SIZE state to 5.

I do understand that you would like to remove SRCU_SIZE_* states.
What I need from you is why it is important to remove these states.
What is being gained by removing them?  Why is that gain so important
that we should (at the very least) make the state space more complex?
And does this change really avoid introducing bugs?

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> 
> > 							Thanx, Paul
> > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > > To: rcu@vger.kernel.org
> > > ---
> > > v1 -> v2:
> > >  rebase onto dev branch
> > >  kernel/rcu/srcutree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index b25f77df9e5e..b0278d1e9c1f 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1165,7 +1165,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > >  	 */
> > >  	idx = __srcu_read_lock_nmisafe(ssp);
> > >  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > > -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> > > +	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
> > >  		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> > >  	else
> > >  		sdp = raw_cpu_ptr(ssp->sda);
> > > -- 
> > > 2.31.1
> > > 
