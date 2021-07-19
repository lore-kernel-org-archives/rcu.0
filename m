Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE9C07E9D
	for <rcu@archiver.kernel.org>; Mon, 19 Jul 2021 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5EB6113C
	for <rcu@archiver.kernel.org>; Mon, 19 Jul 2021 18:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351707AbhGSRaD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378667AbhGSR0F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Jul 2021 13:26:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C3866113C;
        Mon, 19 Jul 2021 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626718004;
        bh=pHQxmcygNmG+crwL0sJCfS38nnVLJrecVIEUMUDtrNI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IcnS3l68eWKxN+cZ/ZIcPywpx42txFi6tEtHBx2xX6Wql+CEzdUN3QKzMe/WgFSJu
         m63TyMJmQBCwUG0OBo2+YEmJ8Duajfm/OEM6LruN3V0UMum1g06rnPbI9BU0h3AqVX
         AVZork8HAyqPW8/UHKXIqDLdERJeoKFbsR80JI2M1kjDr+5ojhMmbnJBvFvJN3xdJs
         0smAU86KLxKyyjDflthz2TuUCobYOHwIJGYuyEbiZb2s/mY0YRko9vchuP1gMbnfcz
         1Cl7tKNLWUre7exXi2jZHV7T6OuTnw2Aq69xGKtCLldU+1qpOwqeiSMzhmbXd3P1Wz
         l+09uoz1qOOBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 17C225C2BE5; Mon, 19 Jul 2021 11:06:44 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:06:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] rcu: call kvm_check_and_clear_guest_paused
 unconditionally
Message-ID: <20210719180644.GY4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210716054113.1244529-1-senozhatsky@chromium.org>
 <YPEly3zNxNUjuc5i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPEly3zNxNUjuc5i@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 16, 2021 at 03:23:07PM +0900, Sergey Senozhatsky wrote:
> On (21/07/16 14:41), Sergey Senozhatsky wrote:
> > @@ -657,6 +657,13 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >  	unsigned long js;
> >  	struct rcu_node *rnp;
> >  
> > +	/*
> > +	 * If a virtual machine is stopped by the host it can look to
> > +	 * the watchdog like an RCU stall. Check to see if the host
> > +	 * stopped the vm.
> > +	 */
> > +	kvm_check_and_clear_guest_paused();
> > +
> >  	lockdep_assert_irqs_disabled();
> >  	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
> >  	    !rcu_gp_in_progress())
> > @@ -699,14 +706,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> >  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> >  
> > -		/*
> > -		 * If a virtual machine is stopped by the host it can look to
> > -		 * the watchdog like an RCU stall. Check to see if the host
> > -		 * stopped the vm.
> > -		 */
> > -		if (kvm_check_and_clear_guest_paused())
> > -			return;
> > -
> >  		/* We haven't checked in, so go dump stack. */
> >  		print_cpu_stall(gps);
> >  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> > @@ -717,14 +716,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> >  		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> >  
> > -		/*
> > -		 * If a virtual machine is stopped by the host it can look to
> > -		 * the watchdog like an RCU stall. Check to see if the host
> > -		 * stopped the vm.
> > -		 */
> > -		if (kvm_check_and_clear_guest_paused())
> > -			return;
> > -
> >  		/* They had a few time units to dump stack, so complain. */
> >  		print_other_cpu_stall(gs2, gps);
> >  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> 
> This patch depends on
> https://lore.kernel.org/lkml/20210716053405.1243239-1-senozhatsky@chromium.org/
> 
> If that x86/kvm patch lands, then we need to handle
> PVCLOCK_GUEST_STOPPED in watchdogs.

OK, please let me know how and when you would like to proceed.

> In theory, this patch opens a small race window, if the VCPU gets preempted
> after kvm_check_and_clear_guest_paused() (external interrupt, etc.)
> But it's hard to tell how likely the problem is.

There is always attempting to provoke it, possibly accompanied by
artificially widening the race window.

							Thanx, Paul
