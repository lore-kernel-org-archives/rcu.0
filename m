Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2CDC433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 16:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41A76510B
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 16:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhCPQnD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238942AbhCPQma (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Mar 2021 12:42:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 372076510A;
        Tue, 16 Mar 2021 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615912950;
        bh=/863Z1+ljo3+rGSfJ8SjAnwzBa1+q6TEJ2XTFDHatEo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bIfDg4gED+84DSoSUeRgX+maiFn75KO4sWs/NewKOY1AlSmTkXaVGYdkYlTdhz3N1
         hyE9InoitNZ3PK5gVI6BTYfGHjiNT2c8LkaFiPER97f3U/3J125QM9I0DS5cv9NpWT
         9/T3wRr/fY8imZY9XpvPutl128vfrYxuANaTb3MfUEOp5DTrXIADcUNcCZm9cjemtO
         SO90Xn9yY1r81fGsFzNzc+OzB4lBHYrOMzGDohdIE8fvScspDrB0LIhgcy+jDuap27
         l8XiWRVFqYvjQgyL4YY1nUtF3YnDjtURC2QXxVhDPBaQqk4woU/qI7uc6aSbhKHhvI
         ObQqll4kSW4Xw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ECB2B352262D; Tue, 16 Mar 2021 09:42:29 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:42:29 -0700
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
Message-ID: <20210316164229.GV2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210316144722.GD639918@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316144722.GD639918@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 16, 2021 at 03:47:22PM +0100, Frederic Weisbecker wrote:
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
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
> > +
> > +/**
> >   * cond_synchronize_rcu - Conditionally wait for an RCU grace period
> >   *
> >   * @oldstate: return value from earlier call to get_state_synchronize_rcu()
> >   *
> >   * If a full RCU grace period has elapsed since the earlier call to
> > - * get_state_synchronize_rcu(), just return.  Otherwise, invoke
> > - * synchronize_rcu() to wait for a full grace period.
> > + * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
> > + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> >   *
> >   * Yes, this function does not take counter wrap into account.  But
> >   * counter wrap is harmless.  If the counter wraps, we have waited for
> > @@ -3804,7 +3864,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
> >   */
> >  void cond_synchronize_rcu(unsigned long oldstate)
> >  {
> > -	if (!rcu_seq_done(&rcu_state.gp_seq, oldstate))
> > +	if (!poll_state_synchronize_rcu(oldstate))
> >  		synchronize_rcu();
> >  	else
> >  		smp_mb(); /* Ensure GP ends before subsequent accesses. */
> 
> poll_state_synchronize_rcu() already does the full barrier.

Right you are!  Good catch, thank you!!!

I will fold removing this smp_mb() in with attribution.

							Thanx, Paul
