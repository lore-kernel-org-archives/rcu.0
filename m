Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB3C433F5
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 23:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA40A60F25
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJVXNH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Oct 2021 19:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhJVXNG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Oct 2021 19:13:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7769161039;
        Fri, 22 Oct 2021 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634944248;
        bh=auW2dQOL4ArLJIm2vU2QQG2Gwnc2dGDZzVEL90tmlSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sJICpNRDotoPwB2mj9p1+Lx9tKpAZpbbiPqSMhKyWEHXTse3PWmwLxcrPiok4EGgO
         Vdm0otGyay6s7HOVkyX8WxRRNpRkTu27gAXkyOZtpOXcQeOKS/iJ0pmqSwr27ycjon
         AJdInWpIMwSIKWi1Ce1eoBcWnRP1XmQ/2wpW8JcyevIGQRGR8OIpcWpr9fj9i/pISt
         3YbLJbyPDrSN9kJIaj92x68etfBBMaMWyYDap+hqTU2xZ+25j8VDh3i22rt+Jl+1Mz
         jkPzSooNFKLGxlPIzmZGbXlo5zexpnRJ7bXPfAHvf4MxxLvXKhwnz+iJjxHqDsc8vg
         ddF4zaNr0Sdtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4080D5C0BF4; Fri, 22 Oct 2021 16:10:48 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:10:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] refscale: simplify the errexit checkpoint
Message-ID: <20211022231048.GF880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 22, 2021 at 06:51:10PM +0800, Li Zhijian wrote:
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Good catch!

But given that errexit is only set once at the beginning, why not
eliminate this local variable in favor of a goto at the point that it
is currently assigned to?  That would permit further simplification.

							Thanx, Paul

> ---
>  kernel/rcu/refscale.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 66dc14cf5687..2cbe2a2ba387 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -698,26 +698,25 @@ static int main_func(void *arg)
>  	// Print the average of all experiments
>  	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
>  
> -	if (!errexit) {
> -		buf[0] = 0;
> -		strcat(buf, "\n");
> -		strcat(buf, "Runs\tTime(ns)\n");
> -	}
> +	if (errexit)
> +		goto err;
> +
> +	buf[0] = 0;
> +	strcat(buf, "\n");
> +	strcat(buf, "Runs\tTime(ns)\n");
>  
>  	for (exp = 0; exp < nruns; exp++) {
>  		u64 avg;
>  		u32 rem;
>  
> -		if (errexit)
> -			break;
>  		avg = div_u64_rem(result_avg[exp], 1000, &rem);
>  		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
>  		strcat(buf, buf1);
>  	}
>  
> -	if (!errexit)
> -		SCALEOUT("%s", buf);
> +	SCALEOUT("%s", buf);
>  
> +err:
>  	// This will shutdown everything including us.
>  	if (shutdown) {
>  		shutdown_start = 1;
> -- 
> 2.33.0
> 
> 
> 
