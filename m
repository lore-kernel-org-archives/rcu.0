Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E229C433FE
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 14:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKVOpx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKVOpw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Nov 2022 09:45:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537F53EE8
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 06:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A7161740
        for <rcu@vger.kernel.org>; Tue, 22 Nov 2022 14:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48943C433D6;
        Tue, 22 Nov 2022 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669128350;
        bh=Y1hHx/Rz/AIeI60XssUvFFeXf48Y55A63MG8Z9fZiho=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DeVhIt22app3UK8zZ9nGQ3xL4TuNCvxkdy20iWu/JPzxfriJzdv5ddprX10yNdd5a
         CvXjaXYFZzfDVrZXdvzzzWaJg9S1XckOV0Y91dyGAvAEgRjlCRX06COD2+9oj3yENo
         U7fhXPaLMUe6AA2s49qEII8s1uBPDZdAHzTg4g7sxlBscdRKZjTrEjTxFudTVHItFK
         bkcX0HdT3++2Di2u5Pcypv01PxYueETZc0VC4ZI+onzX/y6mwccACmXAk74I1NnaWa
         PLCFVI3fxmDrSsjUEQF2iNJ9Y3bkx6t+LKWp6wI13lK3HpIqRKw5TyAqL1waRXGA5f
         dz0R/gQT+13zA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E607F5C09C9; Tue, 22 Nov 2022 06:45:49 -0800 (PST)
Date:   Tue, 22 Nov 2022 06:45:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] srcu: Remove needless updating of srcu_have_cbs in
 srcu_gp_end()
Message-ID: <20221122144549.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-3-kernelfans@gmail.com>
 <20221122011916.GT4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3ydcMAkqpCGNosw@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ydcMAkqpCGNosw@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 22, 2022 at 05:59:12PM +0800, Pingfan Liu wrote:
> On Mon, Nov 21, 2022 at 05:19:16PM -0800, Paul E. McKenney wrote:
> > On Sun, Nov 20, 2022 at 11:40:14AM +0800, Pingfan Liu wrote:
> > > At present, snp->srcu_have_cbs[idx] is updated by either
> > > srcu_funnel_gp_start() or srcu_gp_end().
> > > 
> > > But as the code changes, now, srcu_funnel_gp_start() is called with srcu
> > > read lock held. And its input parameter s, s = rcu_seq_snap(&ssp->srcu_gp_seq),
> > > whose counter field always proceeds that of the srcu_gp_seq by one or two.
> > > 
> > > If the seq snap only proceeds by one, the state machine should be in
> > > state SRCU_STATE_IDLE, the held srcu read lock will prevent the state
> > > machine from moving ahead. So when srcu_gp_end() updates
> > > snp->srcu_have_cbs[idx], the idx must be the past idx for
> > > srcu_funnel_gp_start() that is cared by nobody.
> > > 
> > > So removing the unnecessary updating in srcu_gp_end().
> > 
> > This looks plausible, good eyes!
> > 
> > But is there a debug check that could verify that this is unnecessary?
> > Logical reasoning is all well and good, but the actual system always
> > wins arguments.  ;-)
> > 
> 
> Agree. Reasoning may miss some ground and render a wrong result.
> 
> But it is a little hard to demonstrate the past idx is not accessed. I
> will go on to figure a way out.

On a 64-bit system especially, it should be easy to generate a pattern
that never actually occurs.  Even on a 32-bit system, aren't there bit
patterns in the low-order bits that never occur?

Wouldn't it be possible to check for those?

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> 
> > 							Thanx, Paul
> > 
> > > Test info:
> > >   Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> > > without any failure.
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > To: rcu@vger.kernel.org
> > > ---
> > >  kernel/rcu/srcutree.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 7df59fc8073e..c54d6c04751f 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -783,8 +783,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > >  			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
> > >  			if (last_lvl)
> > >  				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
> > > -			snp->srcu_have_cbs[idx] = gpseq;
> > > -			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> > >  			sgsne = snp->srcu_gp_seq_needed_exp;
> > >  			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
> > >  				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> > > -- 
> > > 2.31.1
> > > 
