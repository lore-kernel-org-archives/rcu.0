Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164FC433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Oct 2021 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D834760FD7
	for <rcu@archiver.kernel.org>; Fri,  8 Oct 2021 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbhJHPvs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Oct 2021 11:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243027AbhJHPvp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Oct 2021 11:51:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 245AE60F6F;
        Fri,  8 Oct 2021 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633708190;
        bh=JwrcRjJJdJytp6KMBRFuWFHxkJ4MwWSom/YHngd3OBo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IFXz+969ie11cbjyEQYnqRoCI8vZB/T5rQENTrueNOX+L46rJI6D9kCsSnUITLjfH
         LUFitPKSHsDKmeRhjJP5zL4IKR74BIbCgeUrQWwFj4BIci156QEc/5tZdG309HjsZq
         0ve/rhAMNIBia1Tlx042zc0CZIEVIGERPAUJlXJXhvBZ5rei/8xhBsunATAdWnqitW
         evoGVK5IKGk/zQQo/QdUaUpa23cYpFtRzMIDBPpTnBFEybriiBBYbPeYRc5vljQkTO
         4+cSbDOVTCajPR65W03Elavd0QshP9nATDEo9/LX0BmCK61W3a3uhDaLYBZ2rdhL0l
         RYmsBJWK+GWZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE5CC5C0887; Fri,  8 Oct 2021 08:49:49 -0700 (PDT)
Date:   Fri, 8 Oct 2021 08:49:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes
Message-ID: <20211008154949.GQ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210929221012.228270-1-frederic@kernel.org>
 <87fstkmybc.mognet@arm.com>
 <87ee8vlill.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee8vlill.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 08, 2021 at 03:03:02PM +0100, Valentin Schneider wrote:
> On 01/10/21 18:47, Valentin Schneider wrote:
> > On 30/09/21 00:10, Frederic Weisbecker wrote:
> >> PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
> >> concurrent NOCB (de-)offloading.
> >>
> >> Thomas suggested to drop the local_lock() based solution and simply
> >> check the offloaded state while context looks safe but that's not
> >> enough. Here is a bit of rework.
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> >>       rcu/rt
> >>
> >> HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad
> >>
> >> Thanks,
> >>       Frederic
> >
> > FWIW I've had RCU torture with NOCB toggling running for half a day on my
> > Arm Juno and nothing to report. I still need to rebase this on an -rt tree
> > and give it a spin with CONFIG_PREEMPT_RT.
> 
> Rebased on top of v5.15-rc4-rt7-rebase with Thomas' patch reverted and ran
> the same thing under CONFIG_PREEMPT_RT, nothing seems to catch on fire, so:
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thank you!!!

							Thanx, Paul
