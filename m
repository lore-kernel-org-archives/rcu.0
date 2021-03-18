Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11D7C433DB
	for <rcu@archiver.kernel.org>; Thu, 18 Mar 2021 17:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF6B64EF2
	for <rcu@archiver.kernel.org>; Thu, 18 Mar 2021 17:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhCRRKA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhCRRJi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Mar 2021 13:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED01464F1C;
        Thu, 18 Mar 2021 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616087378;
        bh=QMq8RJPZzlZps/hFwVNizcpJfBRIfzbtxWv5jpqvOEc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OjnOVmdzRHVCt63wEPujITPWx89i1hO2P/zquCxCAfKzEkOy1OWl+oiLLzpmTJIec
         GCgQAjTL0GyJwM2EoqqFHdDoDMzrQIag1ap1HAcwpP/JAJwguCLU7DgWmcQkXz9sYV
         0Ldm5+OuoPVX7TCALxtYKadYVO/X0JFy/WJa30QoMeskXLiA9CMeCjcr6mfZsFtx8h
         8Unc1RnYj1BbFvydAMPF95NP6kJSS5kCmm4U99UJEjafUzRSOKZTJ+c29vSurn8JOt
         6RxWMaB79XN4lWADNTZVwnPhY5rRqFz6W9AgjbTC24GW98OrhUj9ZNMavbWJIHPzO8
         3QIUD/mr9airA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B16AD3523944; Thu, 18 Mar 2021 10:09:37 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:09:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210318170937.GF2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210316151750.GF639918@lothringen>
 <20210316165101.GW2696@paulmck-ThinkPad-P72>
 <20210318145952.GC805381@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318145952.GC805381@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 18, 2021 at 03:59:52PM +0100, Frederic Weisbecker wrote:
> On Tue, Mar 16, 2021 at 09:51:01AM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 16, 2021 at 04:17:50PM +0100, Frederic Weisbecker wrote:
> > > On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> > > > +/**
> > > > + * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> > > > + *
> > > > + * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> > > > + *
> > > > + * If a full RCU grace period has elapsed since the earlier call from
> > > > + * which oldstate was obtained, return @true, otherwise return @false.
> > > > + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> > > > + *
> > > > + * Yes, this function does not take counter wrap into account.
> > > > + * But counter wrap is harmless.  If the counter wraps, we have waited for
> > > > + * more than 2 billion grace periods (and way more on a 64-bit system!).
> > > > + * Those needing to keep oldstate values for very long time periods
> > > > + * (many hours even on 32-bit systems) should check them occasionally
> > > > + * and either refresh them or set a flag indicating that the grace period
> > > > + * has completed.
> > > > + */
> > > > +bool poll_state_synchronize_rcu(unsigned long oldstate)
> > > > +{
> > > > +	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
> > > > +		smp_mb(); /* Ensure GP ends before subsequent accesses. */
> > > 
> > > Also as usual I'm a bit lost with the reason behind those memory barriers.
> > > So this is ordering the read on rcu_state.gp_seq against something (why not an
> > > smp_rmb() btw?). And what does it pair with?
> > 
> > Because it needs to order subsequent writes as well as reads.
> > 
> > It is ordering whatever the RCU user wishes to put after the call to
> > poll_state_synchronize_rcu() with whatever the RCU user put before
> > whatever started the grace period that just now completed.  Please
> > see the synchronize_rcu() comment header for the statement of the
> > guarantee.  Or that of call_rcu().
> 
> I see. OTOH the update side's CPU had to report a quiescent state for the
> requested grace period to complete. As the quiescent state propagated along
> with full ordering up to the root rnp, everything that happened before
> rcu_seq_done() should appear before and everything that happened after
> rcu_seq_done() should appear after.
> 
> Now in the case the update side's CPU is not the last CPU that reported
> a quiescent state (and thus not the one that propagated every subsequent
> CPUs QS to the final "rcu_state.gp_seq"), the full barrier after rcu_seq_done()
> is necessary to order against all the CPUs that reported a QS after the
> update side's CPU.
> 
> Is that right?

That is the way I see it.  ;-)

> > For more detail on how these guarantees are implemented, please see
> > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > and its many diagrams.
> 
> Indeed, very useful documentation!

Glad you like it!

> > There are a lot of memory barriers that pair and form larger cycles to
> > implement this guarantee.  Pretty much all of the calls to the infamous
> > smp_mb__after_unlock_lock() macro form cycles involving this barrier,
> > for example.
> > 
> > Please do not hesitate to ask more questions.  This underpins RCU.
> 
> Careful what you wish! ;-)

;-) ;-) ;-)

							Thanx, Paul
