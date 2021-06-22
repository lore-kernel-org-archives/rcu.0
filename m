Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71FC2B9F4
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E276C61358
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 17:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhFVSBe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhFVSBL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Jun 2021 14:01:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB4D661353;
        Tue, 22 Jun 2021 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624384735;
        bh=vdrPMnp/iIVQhBtkcTScu+ywzge+3KGRwOOPAau0ccQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gOtiVLupuh/6NWQEIyLPA36eJCRBlcezlmGcJ1v4r/ltZceSwLCnVV9BUupxKuZiR
         EoaoC4GgIOSCmg0/P0oGHLYVbYf93SlXZVInl9JEeXWkmukr+5JnFXfHhUhXrGK3ll
         3O6038q8s2z0oLx7ILaWnUZdu3PjZzSEUZYFgBIKwrO5vIuvhCAHsTgTO5H6ZETUyA
         JK1iKuuN/0QiCVsXATpb1vPylZOqKIMNvjlryXcjZTznXJK/FFac4T6ov/S6DyPNs1
         KoZFj4HrZJyr65O/0qLOVXbxhkLbmOY8oHQsM7rp5KjMyrs3U7P4BLBrBZ+YatxnOn
         eXx6OK+FNQ/vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 89AF15C0168; Tue, 22 Jun 2021 10:58:55 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:58:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com, frederic@kernel.org
Subject: Re: [PATCH] rcu: update: Check rcu_bh_lock_map state in
 rcu_read_lock_bh_held
Message-ID: <20210622175855.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1624363521-19702-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624363521-19702-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 22, 2021 at 05:35:21PM +0530, Neeraj Upadhyay wrote:
> In addition to irq and softirq state, check rcu_bh_lock_map
> state, to decide whether RCU bh lock is held.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

My initial reaction was that "in_softirq() || irqs_disabled()" covers
it because rcu_read_lock_bh() disables BH.  But you are right that it
does seem a bit silly to ignore lockdep.

So would it also make sense to have a WARN_ON_ONCE() if lockdep claims
we are under rcu_read_lock_bh() protection, but "in_softirq() ||
irqs_disabled()" think otherwise?

							Thanx, Paul

> ---
>  kernel/rcu/update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index c21b38c..d416f1c 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -333,7 +333,7 @@ int rcu_read_lock_bh_held(void)
>  
>  	if (rcu_read_lock_held_common(&ret))
>  		return ret;
> -	return in_softirq() || irqs_disabled();
> +	return lock_is_held(&rcu_bh_lock_map) || in_softirq() || irqs_disabled();
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> hosted by The Linux Foundation
> 
