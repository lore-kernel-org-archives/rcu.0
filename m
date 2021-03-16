Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4199C433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25CF650DF
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhCPPST (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235966AbhCPPRx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Mar 2021 11:17:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 798F065095;
        Tue, 16 Mar 2021 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615907873;
        bh=IqNjw5OS5jsCFW8fnWpfOQWhT1YkR4zpIX9U7YlL3zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haNLULuBUIKgpX0ls5CtJk7LNzFkCawRlb9zGxfW06zeRm5dhEB4jSGD+ahZhkj8o
         l+R06v6Nj0mWZfyQs+BMi4zuAGOaZjmXeRFeJOtEY1Xxd59kU/OGek1CD8NC1dTZXC
         nMJ5Rv71X1dBncmQ/GFulJ/yrC99hpphCExZLB4J97MVhMgsjzm0uHrIkj+hPRtSJ1
         WVpktjCvks2O1VBaFLQX0XifIL4qDL1gkYBr/GgEnL9AVE9acj97ie71OLlHgCHM4e
         RdbgZewbErb8cyS6C5pn3DNTf1EVG2glq2r52PRG2OzRFYrXdgp+TDdG3ku2Iou56L
         70DIuVobeEHPg==
Date:   Tue, 16 Mar 2021 16:17:50 +0100
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
Message-ID: <20210316151750.GF639918@lothringen>
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
> +/**
> + * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> + *
> + * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> + *
> + * If a full RCU grace period has elapsed since the earlier call from
> + * which oldstate was obtained, return @true, otherwise return @false.
> + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> + *
> + * Yes, this function does not take counter wrap into account.
> + * But counter wrap is harmless.  If the counter wraps, we have waited for
> + * more than 2 billion grace periods (and way more on a 64-bit system!).
> + * Those needing to keep oldstate values for very long time periods
> + * (many hours even on 32-bit systems) should check them occasionally
> + * and either refresh them or set a flag indicating that the grace period
> + * has completed.
> + */
> +bool poll_state_synchronize_rcu(unsigned long oldstate)
> +{
> +	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
> +		smp_mb(); /* Ensure GP ends before subsequent accesses. */

Also as usual I'm a bit lost with the reason behind those memory barriers.
So this is ordering the read on rcu_state.gp_seq against something (why not an
smp_rmb() btw?). And what does it pair with?

Thanks.
