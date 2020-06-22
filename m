Return-Path: <SRS0=LAXB=AD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852BEC433DF
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626832075A
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592867910;
	bh=qrPL5d2iYUD1itT6bvhEQkLqCSiVF7lYvZUIsUzbulw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=f2NW9DpnpISO+F5JcRmOXXSCL4pkG6hy0td3ZkBQnUZVmJZxZ3DoU8hS6U4SRIRXm
	 qITsRzYNWECeLLYg79eYow4AlGzeI4eVYcUWut+6cZrtPeMRXm0ijuqgvMMcoawWbG
	 DUJxHwArTuJ6oS+10lKDdPxEf8f4cAob8wB96V2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgFVXSa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbgFVXSa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 19:18:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7974920708;
        Mon, 22 Jun 2020 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592867909;
        bh=qrPL5d2iYUD1itT6bvhEQkLqCSiVF7lYvZUIsUzbulw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RGFavDXEG1Py/6q8N34d5OzaZhXcJX5M1yCBVU4PGeNdfnuyZXjJV1evhkgBZsqeI
         P6uXelS9+2wApozuN49MUWNmkrXgSTp69qz+kJfvmRseOXMDk1vbCmKz4aKXHFadU/
         hJ7l8oHjCKqg3bDN5QMC8JOET4i12WShMv4AquxU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 62A1B352306A; Mon, 22 Jun 2020 16:18:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:18:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp
Message-ID: <20200622231829.GV9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1592849223-17774-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592849223-17774-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 11:37:03PM +0530, Neeraj Upadhyay wrote:
> Remove CONFIG_PREMPT_RCU check in force_qs_rnp(). Originally,
> this check was required to skip executing fqs failsafe
> for rcu-sched, which was added in commit a77da14ce9af ("rcu:
> Yet another fix for preemption and CPU hotplug"). However,
> this failsafe has been removed, since then. So, cleanup the
> code to avoid any confusion around the need for boosting,
> for !CONFIG_PREMPT_RCU.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Good point, there is a !PREEMPT definition of the function
rcu_preempt_blocked_readers_cgp() that unconditionally returns zero.
And if !PREEMPT kernels, the same things happens in the "if"
body as after it, so behavior is not changed.

I have queued and pushed this with an upgraded commit log as
shown below.

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6226bfb..57c904b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2514,8 +2514,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		rcu_state.cbovldnext |= !!rnp->cbovldmask;
>  		if (rnp->qsmask == 0) {
> -			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
> -			    rcu_preempt_blocked_readers_cgp(rnp)) {
> +			if (rcu_preempt_blocked_readers_cgp(rnp)) {
>  				/*
>  				 * No point in scanning bits because they
>  				 * are all zero.  But we might need to
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

------------------------------------------------------------------------

commit a4600389c35010aef414b89e2817d4a527e751b5
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Mon Jun 22 23:37:03 2020 +0530

    rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()
    
    Originally, the call to rcu_preempt_blocked_readers_cgp() from
    force_qs_rnp() had to be conditioned on CONFIG_PREEMPT_RCU=y, as in
    commit a77da14ce9af ("rcu: Yet another fix for preemption and CPU
    hotplug").  However, there is now a CONFIG_PREEMPT_RCU=n definition of
    rcu_preempt_blocked_readers_cgp() that unconditionally returns zero, so
    invoking it is now safe.  In addition, the CONFIG_PREEMPT_RCU=n definition
    of rcu_initiate_boost() simply releases the rcu_node structure's ->lock,
    which is what happens when the "if" condition evaluates to false.
    
    This commit therefore drops the IS_ENABLED(CONFIG_PREEMPT_RCU) check,
    so that rcu_initiate_boost() is called only in CONFIG_PREEMPT_RCU=y
    kernels when there are readers blocking the current grace period.
    This does not change the behavior, but reduces code-reader confusion by
    eliminating non-CONFIG_PREEMPT_RCU=y calls to rcu_initiate_boost().
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6226bfb..57c904b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2514,8 +2514,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
-			    rcu_preempt_blocked_readers_cgp(rnp)) {
+			if (rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
 				 * are all zero.  But we might need to
