Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF2AC433EF
	for <rcu@archiver.kernel.org>; Wed, 20 Oct 2021 22:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572586115B
	for <rcu@archiver.kernel.org>; Wed, 20 Oct 2021 22:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhJTWqt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhJTWqp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Oct 2021 18:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A33DC60EE9;
        Wed, 20 Oct 2021 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634769870;
        bh=xIF4vjawlzI3qkZU/SVBCVdbI0HaWhr0IQLBAjn+Ntg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nFfWH5Qa+5pKp7jZyDyGX+24OTA8uiE3nBq0mwajwA3ptUksrIcnHB2qGKMTTIfFz
         HxbDSd/8PXVdyO5j1v5ugL3U3gWmkK0X9Y80/Hkw1U0NDhmIm60jju5fQc8Ip4emAs
         cTVfk+F/Zgu9cvLDUiw/Cban80EuJSnlxCjUOnCS2q0sTyrs5I+3HJiBz83mgAX+Ao
         1EcXffsv0JPcYHyhlqeXrp3CgOaSfERXheSbJqXB36PFdQ0pVSZS0hz/Pr9cUnBmq4
         vmZbBBUvjVxc8QxRpPs1ipqKvV83hiQv+CaaKHtyVkLTZ9LCMh8+be4O0Dd1+Tpn87
         D5Z37w4/maNgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 695DD5C0BF4; Wed, 20 Oct 2021 15:44:30 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:44:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Seth Forshee <seth@forshee.me>
Cc:     rcu@vger.kernel.org
Subject: Re: Improving RCU wait in mini_qdisc_pair_swap()
Message-ID: <20211020224430.GO880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YXCIrNiLY5kMmcSI@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXCIrNiLY5kMmcSI@ubuntu-x1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 20, 2021 at 04:22:52PM -0500, Seth Forshee wrote:
> Hi Paul,

Hello, Seth!

Adding the rcu list on CC in case others are seeing similar issues.

> You got some questions the other day from (I believe) Mathieu Desnoyers,
> who a colleague of mine had reached out to about this problem. Thanks a
> lot for your suggestions! I was headed in the right direction, but I
> wouldn't have got there as quickly, and I'm not sure I would have known
> to use start_poll_syncronize_rcu(). I do have a question though, so I
> thought I'd reach out to you about it while I continue to test the
> patch.
> 
> To refresh your memory, or fill in bits that might not have made it to
> you: we're seeing a lot of time spent in rcu_barrier() from
> mini_qdisc_pair_swap() when we are trying to (quickly) restore a bunch
> of network connections for VMs. I'm trying to make this go faster.
> 
> My patch is pasted below, which speeds things up drastically, by a
> factor of 10,000 or so in most cases. My question is about initializing
> mini_Qdisc.rcu_state. On my first pass I took a cautious approach and
> initialized it from get_state_synchronize_rcu() when the structure is
> first initialized. That patch didn't really help. I suspected this was
> because the time between init and calling mini_qdisc_pair_swap() was
> short enough that a grace period had not elapsed, so in the patch below
> rcu_state is initialized to 0 (due to the fact that the memory is
> kzalloc-ed). I think this should be safe, based on my understanding of
> how the cookie works and the fact that no other task yet has a reference
> to either buffer. Is this correct?

Let me see if I understand your reasoning.  Right after creating the
mini Qdisc, someone might be accessing the current buffer, but no one
ever was accessing the non-current buffer.  So on the initial swap
(and -only- on the initial swap), there are no readers to wait for.
Is that your line of reasoning?  If so, sort-of OK, but let's talk about
more organized ways of handling this.

However, another approach is something like this:

	oldstate = start_poll_synchronize_rcu();

	// do something.

	if (!poll_state_synchronize_rcu(oldstate))
		synchronize_rcu_expedited();

This will be roughly an order of magnitude faster than you would see with
your current cond_synchronize_rcu().  And it will speed up all swaps,
not just the first one.  On the other hand, synchronize_rcu_expedited()
sends IPIs to all non-idle CPUs, which is often OK, but not so much for
heavy real-time workloads.  So you can let the heavy real-time workloads
have slowish Qdisc switching and IPI the IPI-insensitive workloads:

	oldstate = start_poll_synchronize_rcu();

	// do something.

	if (IS_ENABLED(CONFIG_PREEMPT_RT))
		cond_synchronize_rcu(oldstate);
	else if (!poll_state_synchronize_rcu(oldstate))
		synchronize_rcu_expedited();

Yet another approach is this:

	oldstate = start_poll_synchronize_rcu();

	// do something.

	while (!poll_state_synchronize_rcu(oldstate))
		schedule_timeout_idle(1);

The advantage of this one is that you get credit for partial progress
through grace periods, but it won't be anywhere near as fast as
synchronize_rcu_expedited().

							Thanx, Paul
