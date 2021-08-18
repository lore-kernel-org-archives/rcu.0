Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D31C4338F
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF026101A
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 15:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhHRPw0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236531AbhHRPw0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Aug 2021 11:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D4956103E;
        Wed, 18 Aug 2021 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629301911;
        bh=BAmGz1uFq1O5htdq/0PxM71byGjZgrBxejf6T6x6yuU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mbf7nBgy6uJv9R/g0dqvgNwL5Hg7p32J2PedVgRlXBsu4NiytgqCpmBJkkV4Eo3aX
         1pGVGlZhWcYXgdEi2buOrzD3FdgDg3HLoa7qsfkLbOUDIEly1XcoaIi0P9XYs4ViS3
         75SDoQU62cI6kAIszLLMSj2++8oldSBnq5UpGjh07FyDlipKHTXteeAHquIjaiPluF
         d4YMhz1W394yEvc1/VZuIR2Dryso8ktd17ek78+AvuJcAfklBxU8/upjHb9BrBN6My
         uHM16CyQGsVuIx1JwIiOMtBz59CyYLQQgtJGYyyBn2DH+WkrkqHdiVDEWySvLTkFvR
         iibMWlXTHvpwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1CD195C04B1; Wed, 18 Aug 2021 08:51:51 -0700 (PDT)
Date:   Wed, 18 Aug 2021 08:51:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] rcu: Fix existing exp request check in
 sync_sched_exp_online_cleanup()
Message-ID: <20210818155151.GV4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1629273840-729-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629273840-729-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 18, 2021 at 01:34:00PM +0530, Neeraj Upadhyay wrote:
> The sync_sched_exp_online_cleanup() checks to see if RCU needs
> an expedited quiescent state from the incoming CPU, sending it
> an IPI if so. Before sending IPI, it checks whether expedited
> qs need has been already requested for the incoming CPU, by
> checking rcu_data.cpu_no_qs.b.exp for the current cpu, on which
> sync_sched_exp_online_cleanup() is running. This works for the
> case where incoming CPU is same as self. However, for the case
> where incoming CPU is different from self, expedited request
> won't get marked, which can potentially delay reporting of
> expedited quiescent state for the incoming CPU.
> 
> Fixes: e015a3411220 ("rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Good catch!!!  I have queued this for further review and testing, thank
you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index d9e4f8e..f3947c4 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -759,7 +759,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
>  	my_cpu = get_cpu();
>  	/* Quiescent state either not needed or already requested, leave. */
>  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> -	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp)) {
> +	    rdp->cpu_no_qs.b.exp) {
>  		put_cpu();
>  		return;
>  	}
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> hosted by The Linux Foundation
> 
