Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454DDC32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 22:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16806246A8
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579386601;
	bh=psLBQF1xjiKnQTyWtfwKO5sGfbPlgtYAWcQ6yLTlo5w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KEQQLZcuz15bHWJxEPG91V/vs+NWch6Eq4PIr0+O4SfMoaFhHAk521nCd0rjJvF9q
	 6Aup4TIxAniALPfzNXPPMeDnmKiirGGDjqoNgoFRB/xPoK5MtpXsgpdzQg1QZ922bU
	 pQeQPO0lv/h3z6iMefwDkWCxNIXRM59CAZ6THD7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgARWaA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 17:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgARWaA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 17:30:00 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC0E2468D;
        Sat, 18 Jan 2020 22:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579386599;
        bh=psLBQF1xjiKnQTyWtfwKO5sGfbPlgtYAWcQ6yLTlo5w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mMaFIllO2aSZd1ZwzCqLkbjdEQQ/Y0rR2SnQ23/YaoDdPJbZ45GBUa2Z0ubMkFnLo
         9Y9a+FVrZd3HsuT3JElVdhqm3Hvx3X8xbRMKIqbqA+5sCeJTwuxNJygl2x5Meogmmd
         Ab3RahCEbjFOGaH4eU/7JG2QyZR36fyLLNWC6CQM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 84CF635227D6; Sat, 18 Jan 2020 14:29:59 -0800 (PST)
Date:   Sat, 18 Jan 2020 14:29:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118222959.GW2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
 <20200118043458.GT2935@paulmck-ThinkPad-P72>
 <20200118045436.GU2935@paulmck-ThinkPad-P72>
 <20200118202131.GE244899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118202131.GE244899@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 18, 2020 at 03:21:31PM -0500, Joel Fernandes wrote:
> On Fri, Jan 17, 2020 at 08:54:36PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 17, 2020 at 08:34:58PM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> > > > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > > [...] 
> > > > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > > > failing in some way?
> > > > 
> > > > Yes there are tests, but I thought of just a simple experiment to study this.
> > > > Purely since it is existing RCU kernel code that I'd like to understand. And
> > > > me/Daniel are also looking into possibly using run-time / trace-based
> > > > verification some of these behaviors.
> > > 
> > > The functionality of rcu_state.cbovld should make that more entertaining.
> > > 
> > > But I would guess that the initial model would ignore memory footprint
> > > and just model RCU priority boosting as kicking in a fixed time after
> > > the beginning of the grace period.
> > > 
> > > Or do you guys have something else in mind?
> > > 
> > > 							Thanx, Paul
> > > 
> > > PS.  Steve, yes, I do well remember our earlier discussions about readers
> > >      inheriting priority from the highest-priority synchronize_rcu().  ;-)
> > 
> > To see the reason why RCU priority boosting does not work like that,
> > consider a (stupid but legal) situation with way more tasks like this
> > than the system can handle:
> > 
> > 	for (;;) {
> > 		cond_resched();
> > 		p = kmalloc(sizeof(*p), GFP_ATOMIC);
> > 		if (!p)
> > 			continue;
> > 		rcu_read_lock();
> > 		kfree(&p->rh, my_func);
> > 		rcu_read_unlock(;
> > 	}
> > 
> > Nothing is ever waiting on the RCU grace period, so there is no natural
> > place for priority to be inherited from.
> > 
> > But the current RCU priority boosting works just fine in this situation,
> > at least assuming rcutree.kthread_prio is set suitably.  And if it is
> > not working fine in some other situation, it would be good for someone
> > to let me in on the secret.  ;-)
> 
> But in this example, you don't have anyone starting a grace period. So how
> would the boosting be done? Somebody has to kick boosting into action?

Gah!

Right you are.  Please s/kfree/kfree_rcu/.

It was late and I was tired.  ;-)

							Thanx, Paul
