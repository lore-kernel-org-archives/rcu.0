Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EDC433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 00:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiEMAC5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 20:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiEMAC4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 20:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5111991C
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 17:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4B2BB82AE9
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 00:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7563CC385B8;
        Fri, 13 May 2022 00:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400173;
        bh=UXGR5DEaJsCYu6xrAezLftXzvOIUYPMpQWWHiIx8j+c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tmP0+05taLIIhxfZIId2ANDAxI8wHw4sRtHweFFzHaX9eKYGleL/PAyaWNBusiHRM
         0KDSCoTKjJ6sI8/AazpYgG9Jgxxu1XrBYta7Gx19lrC74O/gEGKtuyeOWaSm3EUo7L
         J/gam4KUtvRfFXHFHi/Scj4AKkRDYvVAuGAy6SOMQH2dWJ1SYqBJJLpnqmDSmmjRNY
         oLSmRV45LyUXidaq6F/wzukHMmBcama/Epp3TEZmwHp27QZONvvXTeVFQyWBotZrbx
         X7Pj9Qh+f9/qomO2ur16q14In5xXcf66DyebtUaM3I5ABQYMMViUpHd0C7NNukk6Rt
         qOhumyQqHaVPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 099C85C051B; Thu, 12 May 2022 17:02:53 -0700 (PDT)
Date:   Thu, 12 May 2022 17:02:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 04/14] cred: Move call_rcu() to call_rcu_lazy()
Message-ID: <20220513000253.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-5-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:32AM +0000, Joel Fernandes (Google) wrote:
> This is required to prevent callbacks triggering RCU machinery too
> quickly and too often, which adds more power to the system.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

The put_cred_rcu() does some debugging that would be less effective
with a 10-second delay.  Which is probably OK assuming that significant
testing happens on CONFIG_RCU_LAZY=n kernels.

							Thanx, Paul

> ---
>  kernel/cred.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 933155c96922..f4d69d7f2763 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -150,7 +150,7 @@ void __put_cred(struct cred *cred)
>  	if (cred->non_rcu)
>  		put_cred_rcu(&cred->rcu);
>  	else
> -		call_rcu(&cred->rcu, put_cred_rcu);
> +		call_rcu_lazy(&cred->rcu, put_cred_rcu);
>  }
>  EXPORT_SYMBOL(__put_cred);
>  
> -- 
> 2.36.0.550.gb090851708-goog
> 
