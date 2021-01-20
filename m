Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6522DC43381
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2013D2388A
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbhAUAZX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732055AbhATVnk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 16:43:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE9723602;
        Wed, 20 Jan 2021 21:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611178974;
        bh=c3FM+ZZmc4UR2vPDjGgU6qQJutzBI+6kW7HRIRJxn4g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J0c8IkOYzbRbFxFtEncJO9IPywVbBbx+D5spX5RBlli0UAKvzHOT282dBXyPjAHwe
         4y1/UH/g2Ru6AZVHdZJl2iFSNZ7D3wiz29sMzCwlBuil6BiJKMfRTJBoInjRoJA7tS
         CZWT30bzXZjcQyxXUcYpFMBUH6/TlEt2HMjZTbxQKcyXysrei1bnO24gkk3/M70MZu
         fx8Wf39hjtCdC4+k7GYHIGptIulKyrTqtyYz/uz8PS8B9qhDPZQCPG+Dgbhx5MKuRd
         poCdso69RMuW5UPcj17qfNiixP6+oII83d0VexUuGHMbOnaVRaQTweqi0jRADNNk0R
         tPg4DPdaclMmQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DA7263522B82; Wed, 20 Jan 2021 13:42:53 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:42:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
Message-ID: <20210120214253.GG2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <20210120194554.34dby47iipmyplts@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120194554.34dby47iipmyplts@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 20, 2021 at 08:45:54PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-20 17:21:48 [+0100], Uladzislau Rezki (Sony) wrote:
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3489,10 +3489,12 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> >  			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> >  		bnode = get_cached_bnode(*krcp);
> >  		if (!bnode && can_alloc) {
> > +			migrate_disable();
> >  			krc_this_cpu_unlock(*krcp, *flags);
> 
> Why is krc_this_cpu_unlock() defined as
> | static inline void
> | krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> | {
> |         raw_spin_unlock(&krcp->lock);
> |         local_irq_restore(flags);
> | }
> 
> instead of raw_spin_unlock_irqrestore()?
> Should something with the locked section trigger a scheduling event by
> setting TIF_NEED_RESCHED then there will be no scheduling event on
> unlock. It will be delayed until a later "random" preempt_enable().
> 
> raw_spin_unlock_irqrestore() will reschedule if the flag is set,
> local_irq_restore() will not.

Good catch, thank you!  This one is already in mainline, so I queued
the following patch.

							Thanx, Paul

------------------------------------------------------------------------

commit 6c1d51e012c5b474cda77d4fa644d76e041c1e05
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jan 20 13:38:08 2021 -0800

    kvfree_rcu: Make krc_this_cpu_unlock() use raw_spin_unlock_irqrestore()
    
    The krc_this_cpu_unlock() function does a raw_spin_unlock() immediately
    followed by a local_irq_restore().  This commit saves a line of code by
    merging them into a raw_spin_unlock_irqrestore().  This transformation
    also reduces scheduling latency because raw_spin_unlock_irqrestore()
    responds immediately to a reschedule request.  In contrast,
    local_irq_restore() does a scheduling-oblivious enabling of interrupts.
    
    Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cad3607..e7a226a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3201,8 +3201,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static inline struct kvfree_rcu_bulk_data *
