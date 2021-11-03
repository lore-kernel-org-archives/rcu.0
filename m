Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070FC433F5
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9087760E52
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhKCSIc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhKCSIc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Nov 2021 14:08:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82A296112E;
        Wed,  3 Nov 2021 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635962755;
        bh=kmObaSbjG9sNh6Y8UW1jWNYyZ6YmvNRo7BZlwtkUTRU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mfb09zw/caTJgWLD7Aj2Lk5qfdAV/F29qTCm0DshyMgpVZQlfJDbQ2q84GcvnAgfU
         j5klEjK5gdLogKfWzmhW7C48OOeJhtzAmJAbA6rN6ugGo6CvPGo4SFbKGNAXtkEi6F
         zzIvvCX7Gkx7C8AS9ue+CjW6lwoH8uxJnQchEb9Nl56Mb2ecVccJTpZieOwzUQKt2m
         DOdk05T9L/VvQJpUMrjSV9MkclE2QRActALG6gSCnZEwelKYDREH7u87N3MhUi3f+b
         ynfF9l8fqjk6I05FUwgXusHwvz1x4MC5tFQEUTY+A5PnENz7UT8f1LQfduo4vMKws2
         +7irJWGxPu5IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4FCD85C0848; Wed,  3 Nov 2021 11:05:55 -0700 (PDT)
Date:   Wed, 3 Nov 2021 11:05:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhijian@cn.fujitsu.com, philip.li@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2 1/2] scftorture: Always log error message
Message-ID: <20211103180555.GR880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211103083028.26504-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103083028.26504-1-zhijianx.li@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 03, 2021 at 04:30:27PM +0800, Li Zhijian wrote:
> Unconditionally log messages corresponding to errors.
> 
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

I have queued both for the v5.17 (not current, but next) merge window.
Thank you!

							Thanx, Paul

> ---
> V2: rebase against rcu tree
> ---
>  kernel/scftorture.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index a0df767897a1..dcb0410950e4 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -41,8 +41,7 @@
>  #define VERBOSE_SCFTORTOUT(s, x...) \
>  	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
>  
> -#define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
> -	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x); } while (0)
> +#define SCFTORTOUT_ERRSTRING(s, x...) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x)
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
> @@ -584,14 +583,14 @@ static int __init scf_torture_init(void)
>  	if (weight_resched1 == 0 && weight_single1 == 0 && weight_single_rpc1 == 0 &&
>  	    weight_single_wait1 == 0 && weight_many1 == 0 && weight_many_wait1 == 0 &&
>  	    weight_all1 == 0 && weight_all_wait1 == 0) {
> -		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
> +		SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
>  		firsterr = -EINVAL;
>  		goto unwind;
>  	}
>  	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
>  		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
>  	else if (weight_resched1)
> -		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
> +		SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
>  	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
>  	scf_sel_add(weight_single_rpc1, SCF_PRIM_SINGLE_RPC, true);
>  	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
> @@ -622,7 +621,7 @@ static int __init scf_torture_init(void)
>  		nthreads = num_online_cpus();
>  	scf_stats_p = kcalloc(nthreads, sizeof(scf_stats_p[0]), GFP_KERNEL);
>  	if (!scf_stats_p) {
> -		VERBOSE_SCFTORTOUT_ERRSTRING("out of memory");
> +		SCFTORTOUT_ERRSTRING("out of memory");
>  		firsterr = -ENOMEM;
>  		goto unwind;
>  	}
> -- 
> 2.32.0
> 
