Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB52C4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 03:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLODhw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Dec 2022 22:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLODhv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Dec 2022 22:37:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B955A99
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 19:37:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so5492352plr.10
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 19:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SW14SpvUJcnj2eB3uZ/5R2LPDmLcvhMOoPJwyTr3Tko=;
        b=GXLqa6rEb+cgMIsaLJ70my8yXZpIHb5xMdsqDNZh8QVbQ4LCav1nciPWJika5rakDb
         k95ufqEKUAl57EYcGqYjDJg6ySLPDdMncgtZ8OJ2f4LUynb+GN170fLOq6aqNOQonEgx
         IXhs8JCz9KHroJ6FQ6Dbb5NlP3J4LGWGwQdeDDqPfsqcRJiF+mC+zbbL105oAhlbQ2gt
         iDkFCc1Lc3T+9vgsYVjz/s7UIfuA3IGZivpbYZ+imUBRfq1kX8vs7OVVh/LmB+P0B/Mb
         erIXxwvbgQNOWnqPwpdBQC55d+WdLHJJ5eKn+BscFp9nPvrIJH7q/J6W9kycHUa+xzkt
         QMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW14SpvUJcnj2eB3uZ/5R2LPDmLcvhMOoPJwyTr3Tko=;
        b=k+zJk1qnIi3gblvHLh/bGGJ05XbEt6DyiC4y4woSqWtlcSZCD+F8jN6hgVm6DPFula
         F8PLS8Ymt/wbuF4VaQFEViluRc8GrnDVedhAAVNOMaQjzgxozVrl1hOswk+b4rM4j6lE
         MfQfh/evjGQS1r+dLmgt5/CHnw71Q63CMcGrTVM4AUmxsAYdcR50Bo/8R+k3JImXOAh5
         i8PkHT8nT3JaNV3z4OXtx9nGpkNSw/bB6Nllp306TjtqYTRPUOWmwTW8I+G7COsPylrd
         BBNNfs0AAh3xO2TcR9T80zdFm0QyGvCSKUkaOS6elNzyGnzHttFz5Th0n91+tA5fzVID
         7XKg==
X-Gm-Message-State: AFqh2koD39pQnPKinQYwqwfzDGdfL9LpGJPxTlRiXVwdlov1KfBoiHRj
        qsb3lbUhCOtAPnIaJdnuuOHKZT153Q==
X-Google-Smtp-Source: AMrXdXtt1yYqSYAb6kpBDGjW5BrYV6hreciambdEulre2o6/Vvclnl04Agk0/bN/wHKCj0aUy6mhFQ==
X-Received: by 2002:a05:6a20:b723:b0:af:8e92:3eeb with SMTP id fg35-20020a056a20b72300b000af8e923eebmr1465788pzb.9.1671075470021;
        Wed, 14 Dec 2022 19:37:50 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a14-20020aa78e8e000000b005777fe7681esm590869pfr.20.2022.12.14.19.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 19:37:49 -0800 (PST)
Date:   Thu, 15 Dec 2022 11:37:41 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pingfan Liu <piliu@redhat.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCHv2] srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
Message-ID: <Y5qWhWMPMfdrs7kC@piliu.users.ipa.redhat.com>
References: <20221128082816.28518-2-kernelfans@gmail.com>
 <20221130033459.16372-1-piliu@redhat.com>
 <20221202221713.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y5h1USSj0lqahJPN@piliu.users.ipa.redhat.com>
 <20221213200207.GT4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213200207.GT4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 12:02:07PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 13, 2022 at 08:51:29PM +0800, Pingfan Liu wrote:
> > Sorry to reply late. I was interrupted by something else.
> > 
> > On Fri, Dec 02, 2022 at 02:17:13PM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 30, 2022 at 11:34:59AM +0800, Pingfan Liu wrote:
> > > > From: Pingfan Liu <kernelfans@gmail.com>
> > > > 
> > > > The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
> > > > And it is not needed. Because counter_wrap_check has guarantee that both
> > > > srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
> > > > srcu_gp_seq and no false alarm will be raised by the statement in
> > > > srcu_gp_start_if_needed()
> > > > 
> > > >   ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
> > > > 
> > > > As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
> > > > used immediately, not need to wait for another srcu_gp_end() to update
> > > > the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.
> > > 
> > > During the SRCU_SIZE_WAIT_BARRIER state, all callbacks are queued onto
> > > the boot CPU's callback list, but the srcu_barrier() function scans all
> > > of the CPUs' callback lists.
> > 
> > So at present, your concern is around how it affects srcu_barrier(), right?
> 
> At present, as always, I am concerned about all potential added bugs
> and potential added complexity, both in terms of lines of code and in
> terms of size and irregularity of state space.
> 
> And yes, part of the concern about both correctness and complexity is
> the interaction between call_srcu() and srcu_barrier().  Right now, the
> design very straightforwardly ensures that rcu_barrier() and the rest of
> SRCU is looking at all CPU's callback lists before call_srcu() places any
> callbacks on non-boot CPUs.  This is because all the srcu_barrier() calls
> that think that the system is still in SRCU_SIZE_SMALL or SRCU_SIZE_ALLOC
> mode must have completed before any call_srcu() invocation uses a non-boot
> CPU's callback list.
> 

Catch your point. Thanks for patient explanation. And indeed this does
not rely on anything like memory order to build a total order, and more
reliable.

> Your change causes rcu_barrier() and call_srcu() to start using non-boot
> CPUs' callback lists at the same time.  This change therefore introduces
> significant state-space complexity.  And maybe even bugs, if not today
> then some later time when someone makes a change that looks obviously
> correct on the surface, but which subtly weakens the ordering.
> 

Yes, that is true.

> > > So can't this cause srcu_gp_start_if_needed() to rcu_segcblist_advance()
> > > and rcu_segcblist_accelerate() a callback list that is guaranteed to be
> > > empty?  Without this change, the might-not-be-empty boot CPU's callback
> > > list is dealt with.
> > 
> > Is it a problem that srcu_gp_start_if_needed() asks
> > rcu_segcblist_advance() and rcu_segcblist_accelerate() to manipulate an
> > not-be-empty callback list ? At SRCU_SIZE_WAIT_BARRIER state,
> > srcu_barrier() will take care of all cpus' callback list.
> 
> The other way around, please.  My concern is instead that it *fails*
> to rcu_segcblist_advance() and rcu_segcblist_accelerate() the
> might-not-be-empty callback lists.
> 
> > > What am I missing here?  More specifically, what benefits does this
> > > change provide?  I am not yet seeing any.
> > 
> > I am trying to improve the note around SRCU_SIZE_xx, and this is a
> > trivial improve from 8 SRCU_SIZE state to 5.
> 
> I do understand that you would like to remove SRCU_SIZE_* states.
> What I need from you is why it is important to remove these states.
> What is being gained by removing them?  Why is that gain so important
> that we should (at the very least) make the state space more complex?
> And does this change really avoid introducing bugs?
> 

I am driven by the curiosity about the size state machine, and try to
document it as Frederic asked [1].

And yes as you demand, it should not introduce any complexity without
gains.

Again, appreciate for your detailed explanation. I have a better
understainding of the design. Later I will try to document it with a
patch.

[1]: https://lore.kernel.org/rcu/20221117142025.GE839309@lothringen/

> 							Thanx, Paul
> 
> > Thanks,
> > 
> > 	Pingfan
> > 
> > > 							Thanx, Paul
> > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > > v1 -> v2:
> > > >  rebase onto dev branch
> > > >  kernel/rcu/srcutree.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index b25f77df9e5e..b0278d1e9c1f 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1165,7 +1165,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > >  	 */
> > > >  	idx = __srcu_read_lock_nmisafe(ssp);
> > > >  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> > > > -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> > > > +	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
> > > >  		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> > > >  	else
> > > >  		sdp = raw_cpu_ptr(ssp->sda);
> > > > -- 
> > > > 2.31.1
> > > > 
