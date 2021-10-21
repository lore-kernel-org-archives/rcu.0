Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47B1C433F5
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE22A61212
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 14:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJUORl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUORl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Oct 2021 10:17:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE69C0613B9
        for <rcu@vger.kernel.org>; Thu, 21 Oct 2021 07:15:25 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso565824ota.9
        for <rcu@vger.kernel.org>; Thu, 21 Oct 2021 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CSz5t3HhTwWl4Gm5onpDAvzYBUb6ra0H2W2KrsTFQA0=;
        b=Qy9fI5wIPvVbRWlFvINXLu3WZW2whGMAMR/htToFSr9K9bCrdjYrtEXbVPTLFnTEFC
         To2mcUzGpjrxrjDlpBxQh0tuwQDkhrjS08nGCG4gkwbNczNPDz33dYkRw5VT5QjXRS20
         r6VLSzxSLQKrbfL0FPAe+FwJ3A7YNmpWS9SgaF4Gb+87C4qMUUW/jhDGMJqI9zim1Qou
         CZvtWoayX1w6NhkTTCQGbZ+pE+SZoBOBZwgWERqES+rFS+K0CZcAXxXx58d0G4+GidD5
         lN28hBM8HPAjSaSaQuziUPZisr0d6tYmF19aIC1Y3o2HdHcQYad5hH1GTl9a6beG805h
         PPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSz5t3HhTwWl4Gm5onpDAvzYBUb6ra0H2W2KrsTFQA0=;
        b=SH41G7tTXknN0Ict5GLNNUkL5dtYwUpLIMdngC3T1SntFuIovJ5EUVko4/6sU3YHku
         HL5QblOh4sX13ku82PN+KEnX8yj7f21u8HWEF3+JGhEP0vjShN7+mLip8+wmPjDCl0jX
         b7beEaO+5idZ9A1PQqN7h15xSQWNu6YSdQR9L+IPZncy7PoU00+TC82jL06cpP2+aLXi
         vWgOXFhyeM1JDealC/xUs8e2g3zNyrXKYV9XzOzra0oXUrHvzTnTajWZSePy/7kRMNPz
         sNL8Kba5BeCBCiPUl9cNvejQEv7BKB36tnyII+1mIQrMu3aL8Nc9wrZssdfMXCSDVeOw
         IfaQ==
X-Gm-Message-State: AOAM530TIRtDaqKonMhpenhYludkDOzDGaTXu4/ZbkvLGbdLbN8+1SGE
        Av4VIroU8HB2eSWToxYj1EwB7buguDbn7Mdfdqg=
X-Google-Smtp-Source: ABdhPJy2Tn4xbGoYrLG5W4dgY2G/D43mP8OD1dfhbzrNFR1Df95gF45HK44IXosB4LdbEv1DoXVUXg==
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr4901308oth.198.1634825723401;
        Thu, 21 Oct 2021 07:15:23 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:5d30:f90e:35ad:4735])
        by smtp.gmail.com with ESMTPSA id o16sm924682oor.41.2021.10.21.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:15:23 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:15:22 -0500
From:   Seth Forshee <seth@forshee.me>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Improving RCU wait in mini_qdisc_pair_swap()
Message-ID: <YXF1+qMXukbnf3gr@ubuntu-x1>
References: <YXCIrNiLY5kMmcSI@ubuntu-x1>
 <20211020224430.GO880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020224430.GO880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 20, 2021 at 03:44:30PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 20, 2021 at 04:22:52PM -0500, Seth Forshee wrote:
> > Hi Paul,
> 
> Hello, Seth!
> 
> Adding the rcu list on CC in case others are seeing similar issues.
> 
> > You got some questions the other day from (I believe) Mathieu Desnoyers,
> > who a colleague of mine had reached out to about this problem. Thanks a
> > lot for your suggestions! I was headed in the right direction, but I
> > wouldn't have got there as quickly, and I'm not sure I would have known
> > to use start_poll_syncronize_rcu(). I do have a question though, so I
> > thought I'd reach out to you about it while I continue to test the
> > patch.
> > 
> > To refresh your memory, or fill in bits that might not have made it to
> > you: we're seeing a lot of time spent in rcu_barrier() from
> > mini_qdisc_pair_swap() when we are trying to (quickly) restore a bunch
> > of network connections for VMs. I'm trying to make this go faster.
> > 
> > My patch is pasted below, which speeds things up drastically, by a
> > factor of 10,000 or so in most cases. My question is about initializing
> > mini_Qdisc.rcu_state. On my first pass I took a cautious approach and
> > initialized it from get_state_synchronize_rcu() when the structure is
> > first initialized. That patch didn't really help. I suspected this was
> > because the time between init and calling mini_qdisc_pair_swap() was
> > short enough that a grace period had not elapsed, so in the patch below
> > rcu_state is initialized to 0 (due to the fact that the memory is
> > kzalloc-ed). I think this should be safe, based on my understanding of
> > how the cookie works and the fact that no other task yet has a reference
> > to either buffer. Is this correct?
> 
> Let me see if I understand your reasoning.  Right after creating the
> mini Qdisc, someone might be accessing the current buffer, but no one
> ever was accessing the non-current buffer.  So on the initial swap
> (and -only- on the initial swap), there are no readers to wait for.
> Is that your line of reasoning?  If so, sort-of OK, but let's talk about
> more organized ways of handling this.

That's almost right, just missing a couple of details. Initially neither
buffer (let's call them miniq1 and miniq2 for clarity) is active, and
*p_miniq is NULL until the first mini_qdisc_pair_swap() call, so there
can be no readers for either. On the first swap miniq1 becomes active,
and there are no readers to wait for. On the second swap there are no
readers of miniq2 to wait for, and at this time miniq1->rcu_state will
be set. On the third swap we might finally have readers of miniq1 to
wait for.

Also, this function is a little different from the way your examples are
structured in that oldstate is saved at the end of the function, and the
wait on oldstate happens in a subsequent call to the function. So it's
more like:

        oldstate = start_poll_synchronize_rcu();
        return;

        // Some unknown amount of time passes ...

        cond_synchronize_rcu(oldstate);

So I suspect that it wouldn't be uncommon for enough time to have passed
that there are no readers to wait for.

But that brings us to an important point. I'm not a networking expert, I
don't know what common patterns are for these swaps, so I'm probably
ill-equipped to say what makes the most sense beyond the specific
scenario I'm trying to improve. These swaps will happen when setting up
QoS on a network interface, so if I had to guess I'd think the most
common pattern would be short bursts of activity when interfaces are
set up. I know the pattern in the use case I've been debugging, which
sees a lot of "first swaps" for different instances of mini_Qdisc_pair,
and a smaller number of "second swaps" about 200 ms after the first,
which means we're paying a high price for the rcu_barrier() when there
can be no readers. Other scenaios might result in multiple swaps on the
same instance within a short time period, but I can't say for sure.

> However, another approach is something like this:
> 
> 	oldstate = start_poll_synchronize_rcu();
> 
> 	// do something.
> 
> 	if (!poll_state_synchronize_rcu(oldstate))
> 		synchronize_rcu_expedited();
> 
> This will be roughly an order of magnitude faster than you would see with
> your current cond_synchronize_rcu().  And it will speed up all swaps,
> not just the first one.  On the other hand, synchronize_rcu_expedited()
> sends IPIs to all non-idle CPUs, which is often OK, but not so much for
> heavy real-time workloads.
> 
> So you can let the heavy real-time workloads
> have slowish Qdisc switching and IPI the IPI-insensitive workloads:
> 
> 	oldstate = start_poll_synchronize_rcu();
> 
> 	// do something.
> 
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> 		cond_synchronize_rcu(oldstate);
> 	else if (!poll_state_synchronize_rcu(oldstate))
> 		synchronize_rcu_expedited();

I was concerned about the system-wide impact synchronize_rcu_expedited()
has, but this at least avoids doing it if it's unnecessary. If it's bad
form to leave mini_Qdisc.rcu_state initialized to 0, this option is
preferable from my perspective.

> 
> Yet another approach is this:
> 
> 	oldstate = start_poll_synchronize_rcu();
> 
> 	// do something.
> 
> 	while (!poll_state_synchronize_rcu(oldstate))
> 		schedule_timeout_idle(1);
> 
> The advantage of this one is that you get credit for partial progress
> through grace periods, but it won't be anywhere near as fast as
> synchronize_rcu_expedited().

If we need to initialize mini_Qdisc.rcu_state up front this approach
probably won't improve things much for my problem.

Thanks,
Seth
