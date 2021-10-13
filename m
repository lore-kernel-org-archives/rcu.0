Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC65C433F5
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3E461053
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJMQ3r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237782AbhJMQ3g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Oct 2021 12:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D48D60D42;
        Wed, 13 Oct 2021 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634142453;
        bh=jP0eqxF1igtQ3ufSDFjm8C/4Rcpfx8W2dx1pWBhPigg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HPwpCP0y6vDRDhO/IYa9jmvJqkjIU6ObWhymvSqEDOIanIque9ZhA/wAi+LpKydTS
         DaI2xuCX3+K2OBhq1BaJeVWqTvp2Ta70o32OI9TibjE+nUKSgMttgyc0GrKhSIlQT3
         XXaMATDvKw/stWgSnOg+pOVx19PqwF1SbiV14kbQm5+FX62G5mvisRCOQnRml5ebJ7
         BISVQj5DcLT+ga56f3hoH54KsjgZc6lihe+RDvLflZxBE+VINCatGADKdXfaIebTDF
         YyM1XhUNxkqFcmARzgMlWtCqLWD+tnv1TJfZS+uA3Jx0kTECXdIE9S+fGumIlqXHtb
         Hj/LtNExzfsfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 31AC95C0687; Wed, 13 Oct 2021 09:27:33 -0700 (PDT)
Date:   Wed, 13 Oct 2021 09:27:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20211013162733.GS880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211011145140.359412-1-frederic@kernel.org>
 <20211013003215.GP880162@paulmck-ThinkPad-P17-Gen-1>
 <20211013032832.GQ880162@paulmck-ThinkPad-P17-Gen-1>
 <20211013114335.GB377556@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013114335.GB377556@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 13, 2021 at 01:43:35PM +0200, Frederic Weisbecker wrote:
> On Tue, Oct 12, 2021 at 08:28:32PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 12, 2021 at 05:32:15PM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 11, 2021 at 04:51:29PM +0200, Frederic Weisbecker wrote:
> > > > Hi,
> > > > 
> > > > No code change in this v2, only changelogs:
> > > > 
> > > > * Add tags from Valentin and Sebastian
> > > > 
> > > > * Remove last reference to SEGCBLIST_SOFTIRQ_ONLY (thanks Valentin)
> > > > 
> > > > * Rewrite changelog for "rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check"
> > > >   after off-list debates with Paul.
> > > > 
> > > > * Remove the scenario with softirq interrupting rcuc on
> > > >   "rcu/nocb: Limit number of softirq callbacks only on softirq" as it's
> > > >   probably not possible (thanks Valentin).
> > > > 
> > > > * Remove the scenario with task spent scheduling out accounted on tlimit
> > > >   as it's not possible (thanks Valentin)
> > > >   (see "rcu: Apply callbacks processing time limit only on softirq")
> > > > 
> > > > * Fixed changelog of
> > > >   "rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread"
> > > >   (thanks Sebastian).
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > > 	rcu/rt-v2
> > > > 
> > > > HEAD: 2c9349986d5f70a555195139665841cd98e9aba4
> > > > 
> > > > Thanks,
> > > > 	Frederic
> > > 
> > > Nice!
> > > 
> > > I queued these for further review and testing.  I reworked the commit log
> > > of 6/11 to give my idea of the reason, though I freely admit that this
> > > reason is not as compelling as it no doubt seemed when I wrote that code.
> > 
> > But in initial tests TREE04.5, TREE04.6, and TREE04.9 all hit the
> > WARN_ON(1) in rcu_torture_barrier(), which indicates rcu_barrier()
> > breakage.  My best (but not so good) guess is a five-hour MTBF on a
> > dual-socket system.
> > 
> > I started an automated "git bisect" with each step running 100 hours
> > of TREE04, but I would be surprised if anything useful comes of it.
> > Pleased, mind you, but surprised.
> 
> Ok I can reproduce.
> 
> I'm launching a bisect from my side as well.

Mine converged on 2a4200944750 ("rcu/nocb: Prepare state machine for
a new step").  The surprise is that I was running "git bisect run"
on a script wrappering kvm-remote.sh, which means that it managed to
repeatedly request 10 systems, download to them, run the test, collect
the results, and finally return the systems.

Huh.  I should probably refactor my local script to avoid the pointless
repeated request/return work.

But which commit did your bisect find?  ;-)

Anyway, I am keeping the first commit 4b246eab4750 ("rcu/nocb: Make
local rcu_nocb_lock_irqsave() safe against concurrent deoffloading"),
but dropping the others for the time being.

							Thanx, Paul
