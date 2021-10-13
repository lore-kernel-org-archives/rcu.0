Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070EC433EF
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC68610FB
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 11:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhJMLpl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Oct 2021 07:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhJMLpl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Oct 2021 07:45:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF37060D43;
        Wed, 13 Oct 2021 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634125418;
        bh=09vWFfILMwEPDBCK32FQFM58AuRIt7f2AeIiDsrNZ2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMM+oVS2O/8H+2Z9UfXtrFSJkBjhqU/e3IdpkkCbv7jzJSyWvJS8VrBfmBLjdu9G6
         lPE/jeHjDl/pY9tylEEhUw4UGWpb/Aj8AuAYYMbSzdzlO4mJAo0Z41mW6f6n6medFg
         0skLXFR5hXrujqePLAf4SH6Zalq6KYo5xhrLA52L2CLbq6q6JjrTa+5k2rgWR9vwRw
         2RIV1+zrs7mg1rET6YKBgA/Nm/t5o/KPlV8136D9E/99LYbk6y2NY/+DBKotnufBmx
         HakhqjWLG7f8wMTaD6PT/onh8hPuAfSSLxpWa3XVUhTYQLsf0Kp2+vKa/8aJBtV4Z1
         W0X9v+FMy+0/Q==
Date:   Wed, 13 Oct 2021 13:43:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes v2
Message-ID: <20211013114335.GB377556@lothringen>
References: <20211011145140.359412-1-frederic@kernel.org>
 <20211013003215.GP880162@paulmck-ThinkPad-P17-Gen-1>
 <20211013032832.GQ880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013032832.GQ880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 12, 2021 at 08:28:32PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 12, 2021 at 05:32:15PM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 11, 2021 at 04:51:29PM +0200, Frederic Weisbecker wrote:
> > > Hi,
> > > 
> > > No code change in this v2, only changelogs:
> > > 
> > > * Add tags from Valentin and Sebastian
> > > 
> > > * Remove last reference to SEGCBLIST_SOFTIRQ_ONLY (thanks Valentin)
> > > 
> > > * Rewrite changelog for "rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check"
> > >   after off-list debates with Paul.
> > > 
> > > * Remove the scenario with softirq interrupting rcuc on
> > >   "rcu/nocb: Limit number of softirq callbacks only on softirq" as it's
> > >   probably not possible (thanks Valentin).
> > > 
> > > * Remove the scenario with task spent scheduling out accounted on tlimit
> > >   as it's not possible (thanks Valentin)
> > >   (see "rcu: Apply callbacks processing time limit only on softirq")
> > > 
> > > * Fixed changelog of
> > >   "rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread"
> > >   (thanks Sebastian).
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > 	rcu/rt-v2
> > > 
> > > HEAD: 2c9349986d5f70a555195139665841cd98e9aba4
> > > 
> > > Thanks,
> > > 	Frederic
> > 
> > Nice!
> > 
> > I queued these for further review and testing.  I reworked the commit log
> > of 6/11 to give my idea of the reason, though I freely admit that this
> > reason is not as compelling as it no doubt seemed when I wrote that code.
> 
> But in initial tests TREE04.5, TREE04.6, and TREE04.9 all hit the
> WARN_ON(1) in rcu_torture_barrier(), which indicates rcu_barrier()
> breakage.  My best (but not so good) guess is a five-hour MTBF on a
> dual-socket system.
> 
> I started an automated "git bisect" with each step running 100 hours
> of TREE04, but I would be surprised if anything useful comes of it.
> Pleased, mind you, but surprised.

Ok I can reproduce.

I'm launching a bisect from my side as well.

Thanks.
