Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DDCC433F5
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 10:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C2F61077
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 10:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhJMKDf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhJMKDe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Oct 2021 06:03:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1727E60E74;
        Wed, 13 Oct 2021 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634119291;
        bh=VexVs8YcPOAfCyHkd1Wd9WYaHCuP7W/gGp8boKTDsL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTuGhUXMT2UASStrRSKBBoTRjqq2rO8TAtY4dm4od93Vg8fvxmxUk2t7/JEB5YWTg
         OVFyW/T7K1bsxbK1rbyNiDJEXx/cAvCXF6HLhPQYG9gfFB1lSqwistN4nsWyBJoXzs
         +ndUZQ75jI1Mtejo9PGedHM3XfUEvarDTeQCpEh5cN6yBggxJ4hScBrk3UeZL0yRSh
         7Ei6DOt7d354vdRsqYDiOt1eyz9Q3sgt85XKXVf9DjPKGPXmeJTjvExeUxjhXHi1p5
         ZVnhNRu9lfDmdt0MWAKhNSqT0gxpCINsSSy0spY86EwbW+77K6Q6LkilOHSIO5MBZu
         aWugk/U8lB3kw==
Date:   Wed, 13 Oct 2021 12:01:29 +0200
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
Message-ID: <20211013100129.GA377556@lothringen>
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

Oops, trying those scenario on my side as well.

Thanks!
