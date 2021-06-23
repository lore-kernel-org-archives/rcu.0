Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE0C4743C
	for <rcu@archiver.kernel.org>; Wed, 23 Jun 2021 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BA5611C1
	for <rcu@archiver.kernel.org>; Wed, 23 Jun 2021 15:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFWPlX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWPlX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Jun 2021 11:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7750611AC;
        Wed, 23 Jun 2021 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624462746;
        bh=Mm8FVZvOFHbYQOMrLA21ILjK4OC7KMRGPY0oHQSNWF8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XiKwg4CHdsJk1NqhKjhAgIZYRSEexp5RNIwo4X8qeFcv+ykiUG5OgrFWZdxTuBIxn
         8g5NLg8QmWsCKlcxcofi2EVzisj1Rxj6GucRS//CcUF/oEniWmroGeeKZMHKDDakGP
         LwCZlGXDPTDGzThlEvL8/1CQa9DG+kqjnxucEvlAOWwEjtodN4L9/8us/VVluXJ6rT
         ynghZE8r8OFNc70cCUMQLK2SReVJPw3r2b7Ht5W2odblTLfe9JoamvUdDjxxCZrzgR
         1pccMoGwoiTgjXia4Ut4pNbD1c5hGrg8K1S9pUxrzd23e7e00AxJao1mS8x5Y3Rshe
         RDU9jjscxgv5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF3635C06CA; Wed, 23 Jun 2021 08:39:05 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:39:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com, frederic@kernel.org
Subject: Re: [PATCH] rcu: update: Check rcu_bh_lock_map state in
 rcu_read_lock_bh_held
Message-ID: <20210623153905.GO4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1624363521-19702-1-git-send-email-neeraju@codeaurora.org>
 <20210622175855.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <61bed875-5ebf-03d8-58ea-e9263c534201@codeaurora.org>
 <20210622234652.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <b37e3232-4151-e948-3987-b19c88f0e217@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37e3232-4151-e948-3987-b19c88f0e217@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 23, 2021 at 09:27:11AM +0530, Neeraj Upadhyay wrote:
> On 6/23/2021 5:16 AM, Paul E. McKenney wrote:
> > On Wed, Jun 23, 2021 at 12:38:09AM +0530, Neeraj Upadhyay wrote:
> > > On 6/22/2021 11:28 PM, Paul E. McKenney wrote:
> > > > On Tue, Jun 22, 2021 at 05:35:21PM +0530, Neeraj Upadhyay wrote:
> > > > > In addition to irq and softirq state, check rcu_bh_lock_map
> > > > > state, to decide whether RCU bh lock is held.
> > > > > 
> > > > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > 
> > > > My initial reaction was that "in_softirq() || irqs_disabled()" covers
> > > > it because rcu_read_lock_bh() disables BH.  But you are right that it
> > > > does seem a bit silly to ignore lockdep.
> > > > 
> > > > So would it also make sense to have a WARN_ON_ONCE() if lockdep claims
> > > > we are under rcu_read_lock_bh() protection, but "in_softirq() ||
> > > > irqs_disabled()" think otherwise?
> > > 
> > > After thinking more on this, looks like one intention of not
> > > having lockdep check here was to catch scenarios where some code enables bh
> > > after doing rcu_read_lock_bh(), as is mentioned in the comment above
> > > rcu_read_lock_bh_held():
> > > 
> > >    Note that if someone uses
> > >    rcu_read_lock_bh(), but then later enables BH, lockdep (if enabled)
> > >    will show the situation.  This is useful for debug checks in functions
> > >    that require that they be called within an RCU read-side critical
> > >    section.
> > > 
> > > Client users seem to be doing lockdep checks on returned value:
> > > drivers/net/wireguard/peer.c
> > >     RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held(),
> > > 
> > > Similarly, any rcu_dereference_check(..., rcu_read_lock_bh_held()) usage
> > > also triggers warning, if bh is enabled, inside rcu_read_lock_bh()
> > > section.
> > > 
> > > So, using 'in_softirq() || irqs_disabled()' condition looks to be sufficient
> > > condition, to mark all read lock bh regions and adding '||
> > > lock_is_held(&rcu_bh_lock_map)' to this condition does not seem to fit
> > > well with the RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held()) and
> > > rcu_dereference_check(..., rcu_read_lock_bh_held()) calls, if we hit
> > > the scenario, where bh lockmap state (shows bh lock acquired) conflicts with
> > > the softirq/irq state .
> > 
> > That makes sense to me!
> > 
> > But should there be checks somewhere for something like
> > "lock_is_held(&rcu_bh_lock_map) && !in_softirq() && !irqs_disabled()"?
> > 
> > 							Thanx, Paul
> > 
> 
> I think this check is good to have inside rcu_read_lock_bh_held(), to
> highlight this scenario explicitly; I am thinking, if it makes sense to
> have lock_is_held(&rcu_bh_lock_map) check in rcu_softirq_qs() ?
> 
> Also, I think this check is more important for rcu_read_lock_sched_held(),
> where lockdep state is used as a sufficient condition, for marking a RCU
> sched region. One more api is rcu_read_lock_any_held(), where we can
> warn on conflicting cases.
> 
>   int rcu_read_lock_sched_held(void)
>   {
>         bool ret;
> 
>         if (rcu_read_lock_held_common(&ret))
>                 return ret;
>         return lock_is_held(&rcu_sched_lock_map) || !preemptible();
>   }

Another option would be to check lock_is_held(&rcu_sched_lock_map)
anywhere preemption is enabled and lock_is_held(&rcu_bh_lock_map)
anywhere BH is enabled.  This would (in theory, anyway) catch more bugs.

But it is necessary to be careful because these checks must be suppressed
if lockdep has been disabled due to a prior lockdep splat.  Otherwise,
the first lockdep splat is followed by an inundation of false-positive
complaints.

But the real question is "Which important bugs are missed today, and
what change would catch them more reliably?"

Thoughts?

						Thanx, Paul

> Thanks
> Neeraj
> 
> > > Thanks
> > > Neeraj
> > > 
> > > > > ---
> > > > >    kernel/rcu/update.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > > index c21b38c..d416f1c 100644
> > > > > --- a/kernel/rcu/update.c
> > > > > +++ b/kernel/rcu/update.c
> > > > > @@ -333,7 +333,7 @@ int rcu_read_lock_bh_held(void)
> > > > >    	if (rcu_read_lock_held_common(&ret))
> > > > >    		return ret;
> > > > > -	return in_softirq() || irqs_disabled();
> > > > > +	return lock_is_held(&rcu_bh_lock_map) || in_softirq() || irqs_disabled();
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> > > > > -- 
> > > > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > > > hosted by The Linux Foundation
> > > > > 
> > > 
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> > > the Code Aurora Forum, hosted by The Linux Foundation
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
