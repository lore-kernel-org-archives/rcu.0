Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6187AC433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 13:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B664F11
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 13:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSN7P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhCSN66 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Mar 2021 09:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3E6264EF6;
        Fri, 19 Mar 2021 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616162337;
        bh=5AQG+kiA2GlRp3+0pXhhhe2SglUgXDnrTeLb68Cztss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RR0P2Fkws4o9YUsksXzoLAjCP/jPaP3W6mR3oAN/MgJrWET8H/YsjUnIAEbypnExG
         5qXN3gG8zZwFHetPpO/8aAx8LF69Il51kELBNijYPVpYEOcG/dSQKEHQR7XQdK+rdk
         el9fdK2ds2T0A/g4vb1Xbl9IrJLapLXksf5M9BWgudFCqaPy7o4sgvqZFeVp95vywd
         WTqtA2T1JZzLKRtqnkdweXxP4FGUT+lum6HiF48XNJzjHwIxTlxGIq4rLYqqsRUsjp
         D1tRdRhBrwpwJtv8yTZZQ/G7Rkpaw311aBiCM1oWr4UozGaTa9ji0ae0qg89zuOoTb
         qu5rlNk7CxM8w==
Date:   Fri, 19 Mar 2021 14:58:54 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210319135854.GA814853@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304002632.23870-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a non-blocking polling interface for RCU grace
> periods, so this commit supplies start_poll_synchronize_rcu() and
> poll_state_synchronize_rcu() for this purpose.  Note that the existing
> get_state_synchronize_rcu() may be used if future grace periods are
> inevitable (perhaps due to a later call_rcu() invocation).  The new
> start_poll_synchronize_rcu() is to be used if future grace periods
> might not otherwise happen.  Finally, poll_state_synchronize_rcu()
> provides a lockless check for a grace period having elapsed since
> the corresponding call to either of the get_state_synchronize_rcu()
> or start_poll_synchronize_rcu().
> 
> As with get_state_synchronize_rcu(), the return value from either
> get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
> to a later call to either poll_state_synchronize_rcu() or the existing
> (might_sleep) cond_synchronize_rcu().

It's all a matter of personal taste but if I may suggest some namespace
modifications:

get_state_synchronize_rcu() -> synchronize_rcu_poll_start_raw()
start_poll_synchronize_rcu() -> synchronize_rcu_poll_start()
poll_state_synchronize_rcu() -> synchronize_rcu_poll()
cond_synchronize_rcu() -> synchronize_rcu_cond()

But it's up to you really.

>  /**
> + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> + *
> + * Returns a cookie that is used by a later call to cond_synchronize_rcu()

It may be worth noting that calling start_poll_synchronize_rcu() and then
pass the cookie to cond_synchronize_rcu() soon after may end up waiting for
one more grace period.

> + * or poll_state_synchronize_rcu() to determine whether or not a full
> + * grace period has elapsed in the meantime.  If the needed grace period
> + * is not already slated to start, notifies RCU core of the need for that
> + * grace period.
> + *
> + * Interrupts must be enabled for the case where it is necessary to awaken
> + * the grace-period kthread.
> + */
> +unsigned long start_poll_synchronize_rcu(void)
> +{
> +	unsigned long flags;
> +	unsigned long gp_seq = get_state_synchronize_rcu();
> +	bool needwake;
> +	struct rcu_data *rdp;
> +	struct rcu_node *rnp;
[...]
> +
> +/**
> + * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> + *
> + * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> + *
> + * If a full RCU grace period has elapsed since the earlier call from
> + * which oldstate was obtained, return @true, otherwise return @false.
> + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.

Rephrase suggestion for the last sentence:

"In case of failure, it's up to the caller to try polling again later or
invoke synchronize_rcu() to wait for a new full grace period to complete."


In any case: Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
