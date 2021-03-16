Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA1C433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D976510E
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 16:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCPQvf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhCPQvB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Mar 2021 12:51:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F0016510B;
        Tue, 16 Mar 2021 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615913461;
        bh=IKFMV8fviKwPLGWckodOfPixXKUDsMbn5f1reP5b6r8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D7cGiauMFZGwXfMvEKjiSV33U3YDdcfwGa3KwyA7olp+MYFdMFZrdmM8sK7bp7286
         vT304XWBztqZpRYeIUFfhuXsoHcTa3DVI7J6zhUaiQFOZA9EX6LSUhbjQIpE8oDgSn
         w/4rE2QHm0gTB2hsfAg/6Qx1OFD+T1KxasEDqjvlf0kqY4tM9Kp8aXMQrYsVpL0zxk
         k7gDaoPi9yq8bzZvw2AifLe3UnfocgU2p0NPeJGs8Xect2kZFFt9mvvlQGtiw/h/WW
         tJzQLAr3BSL+eBoi9D/wrvFIcqo5QdLY3oATJynLcZI8LjasS63CnQq2eUd17RBaeY
         Qcn34rcI0G3bQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4868A352262D; Tue, 16 Mar 2021 09:51:01 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:51:01 -0700
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
Message-ID: <20210316165101.GW2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210316151750.GF639918@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151750.GF639918@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 16, 2021 at 04:17:50PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> > +/**
> > + * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> > + *
> > + * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> > + *
> > + * If a full RCU grace period has elapsed since the earlier call from
> > + * which oldstate was obtained, return @true, otherwise return @false.
> > + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> > + *
> > + * Yes, this function does not take counter wrap into account.
> > + * But counter wrap is harmless.  If the counter wraps, we have waited for
> > + * more than 2 billion grace periods (and way more on a 64-bit system!).
> > + * Those needing to keep oldstate values for very long time periods
> > + * (many hours even on 32-bit systems) should check them occasionally
> > + * and either refresh them or set a flag indicating that the grace period
> > + * has completed.
> > + */
> > +bool poll_state_synchronize_rcu(unsigned long oldstate)
> > +{
> > +	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
> > +		smp_mb(); /* Ensure GP ends before subsequent accesses. */
> 
> Also as usual I'm a bit lost with the reason behind those memory barriers.
> So this is ordering the read on rcu_state.gp_seq against something (why not an
> smp_rmb() btw?). And what does it pair with?

Because it needs to order subsequent writes as well as reads.

It is ordering whatever the RCU user wishes to put after the call to
poll_state_synchronize_rcu() with whatever the RCU user put before
whatever started the grace period that just now completed.  Please
see the synchronize_rcu() comment header for the statement of the
guarantee.  Or that of call_rcu().

For more detail on how these guarantees are implemented, please see
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
and its many diagrams.

There are a lot of memory barriers that pair and form larger cycles to
implement this guarantee.  Pretty much all of the calls to the infamous
smp_mb__after_unlock_lock() macro form cycles involving this barrier,
for example.

Please do not hesitate to ask more questions.  This underpins RCU.

							Thanx, Paul
