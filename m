Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E3C433E9
	for <rcu@archiver.kernel.org>; Mon, 15 Mar 2021 23:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09F764F5F
	for <rcu@archiver.kernel.org>; Mon, 15 Mar 2021 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhCOXMI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhCOXLj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Mar 2021 19:11:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 754D264F5C;
        Mon, 15 Mar 2021 23:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615849899;
        bh=st1iWLGdtXK2Oo6E/DD9DSjRM78bjJeXA0kGnHIQKXo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a3z8ssq5jF0WxmIUB15cgxPCBC4PvDfCOZWYtnCxg19fUkOOfyQX0iN0DG8v5Q3nI
         7R710iVB7qo+dGYZbaVAtHtSXlwYORwSwzKsJM9WCIU7bmkHGV6A4i8o+jEuqGzY25
         gQmucgsLdXCnFwXRDea/+VScRPlot8ka/lyUF6YgUG7QJmgyHS6BRmYpRy8R1Pu1Bg
         ugqpFYe/PFZyphwRL0r8JeIYrAVpfnqK4LyqhAYoaEN28ZAvJM8rk2Ndw7fedbbjX2
         ImwgF9s09S4St+x71jbjMIEKhW13k+22NN/aBjcoc9/wewPJ7c2VU8sUeeR1LmWwxZ
         sxoG45pB1cW8w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 400F635239EE; Mon, 15 Mar 2021 16:11:39 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:11:39 -0700
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
Message-ID: <20210315231139.GQ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210312122647.GC3646@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312122647.GC3646@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 12, 2021 at 01:26:47PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> >  /**
> > + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> > + *
> > + * Returns a cookie that is used by a later call to cond_synchronize_rcu()
> > + * or poll_state_synchronize_rcu() to determine whether or not a full
> > + * grace period has elapsed in the meantime.  If the needed grace period
> > + * is not already slated to start, notifies RCU core of the need for that
> > + * grace period.
> > + *
> > + * Interrupts must be enabled for the case where it is necessary to awaken
> > + * the grace-period kthread.
> > + */
> > +unsigned long start_poll_synchronize_rcu(void)
> > +{
> > +	unsigned long flags;
> > +	unsigned long gp_seq = get_state_synchronize_rcu();
> 
> Ah! It's using rcu_seq_snap() and not rcu_seq_current() and therefore it's
> waiting for a safe future grace period, right?

Exactly!  ;-)

							Thanx, Paul

> If so, please discard my previous email.
> 
> Thanks.
