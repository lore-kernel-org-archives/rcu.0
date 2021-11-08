Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A5C433EF
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91B561359
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhKHQ4i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhKHQ4i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Nov 2021 11:56:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D519361355;
        Mon,  8 Nov 2021 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636390433;
        bh=HAulVTbxdG1BXDHSGGArQYEUWrHlK6HeI9+mG0uiJkI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S+kXXzOonQEOJ8trNSihJsGYx1lp8t8w0htKNIfc1vqFQv3LoglNkfmGXFo34ko0M
         +alcVpnLV6Qlwyw32oSwWYilW4cPeYTCTiRSHzGrvuhLQoLnQG5sZPSE26x5LgcO+Z
         hsClX76BwccFjCAYfW2a8RKoRmOCIfiJym2xeSMlJoCyKar53mqbBE04tjeWv8SXBM
         egGngKWQFHlzlvWxKGSiLMH6bIKSpxBymyqFGCb/urs6NtjS9A4pe86IlLsCFuogfr
         WUZw+Ee71JDPNHJ7cLKqgf/jrBLVbMx7kBTYN+ZxfiIRwlWdkDPoLkAWqLP5dLbbcT
         3ogMvqfBrmkQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 994435C0C69; Mon,  8 Nov 2021 08:53:53 -0800 (PST)
Date:   Mon, 8 Nov 2021 08:53:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v0 20/42] rcu: Check notifier registration return value
Message-ID: <20211108165353.GS641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-21-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108101157.15189-21-bp@alien8.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 08, 2021 at 11:11:35AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

Or I would be happy to take this as soon as the first patch appears
somewhere that I can base off of.  (I could duplicate it in -rcu, I
suppose.)

							Thanx, Paul

> Cc: rcu@vger.kernel.org
> ---
>  kernel/rcu/tree_stall.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5e2fa6fd97f1..0c1d631214f4 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -101,7 +101,9 @@ static struct notifier_block rcu_panic_block = {
>  
>  static int __init check_cpu_stall_init(void)
>  {
> -	atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block);
> +	if (atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block))
> +		pr_warn("RCU warning suppress notifier already registered\n");
> +
>  	return 0;
>  }
>  early_initcall(check_cpu_stall_init);
> -- 
> 2.29.2
> 
