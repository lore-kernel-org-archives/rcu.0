Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67260C77B73
	for <rcu@archiver.kernel.org>; Tue,  2 May 2023 13:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjEBNmP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 May 2023 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjEBNl6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 May 2023 09:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250A6E94;
        Tue,  2 May 2023 06:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3211624B0;
        Tue,  2 May 2023 13:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A7AC433D2;
        Tue,  2 May 2023 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683034819;
        bh=kkOAvtB147zyYeIk9DHSpxKkoZSq/1ixzv0pWWTPA0A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JgZBjw47jwJCQ3q1712ittRHOs1GJnaJKnNUYnrxe9KkqhHw7avOmZ18wctzrZ3nY
         /AWbfuptRm+xJb30elet85pEX9EGaWBZvutGMWgVDnp2YfSRupOiQcQBAanmBekO3M
         el+2plAKDxP4+wXTJ78t1wEd5fr1bQ1DNMAIVDTCbUFgrCK2K+44nkpv8G1qbenVvz
         Xx1iaShLQ/sfCj7QJtZdbEGxdFLQQaoEjcsHd5hNviUUTzHjBy5ThXatBCPDqAnzky
         rC7jrfqf6Uth4UIEpexuqvbToxoQqM1bHNd+XjpDQYkBk5R3j+q5ku7Qoa6WsfLWA3
         B1tSLGkWw3+8g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3F3B15405AD; Tue,  2 May 2023 06:40:18 -0700 (PDT)
Date:   Tue, 2 May 2023 06:40:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     zhouzhouyi@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
Message-ID: <783a1e86-d625-4d8b-9b7c-0531b11b9290@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1682985701-19914-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682985701-19914-1-git-send-email-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 02, 2023 at 08:01:41AM +0800, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
> if kfree_loops is too big. Replace wait_event with wait_event_idle
> to avoid false positive.
> 
> Tested in the PPC VM of Open Source Lab of Oregon State University.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>    
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                    

Good catch, thank you!

However, this commit beat you to it:

ef1ef3d47677 ("rcuscale: Move shutdown from wait_event() to wait_event_idle()")

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 91fb5905a008..d99c586939d1 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
>  static int
>  kfree_scale_shutdown(void *arg)
>  {
> -	wait_event(shutdown_wq,
> +	wait_event_idle(shutdown_wq,
>  		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
>  
>  	smp_mb(); /* Wake before output. */
> -- 
> 2.34.1
> 
