Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9545C6FA8F
	for <rcu@archiver.kernel.org>; Thu, 24 Aug 2023 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjHXNVP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Aug 2023 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbjHXNVG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Aug 2023 09:21:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52C198D;
        Thu, 24 Aug 2023 06:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4BB46306C;
        Thu, 24 Aug 2023 13:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33346C433C7;
        Thu, 24 Aug 2023 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692883264;
        bh=n1tB2/Gy8HqlywLzU9KmpZP8TUMDoVYVtcAURaRTZxw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O6hWNbxd6YyQPbTJaBcTb95ATNlHwX2pIj308g9ScWFbVKqxXxZxFaYIXhohU9B+w
         Oc16dQSmvbtNLPSjT7A1KvJNF94iS8ZzWuPdQw7/6UG6g2llHn+RqJ0c0a6SnbIjBT
         Z8e3VuXPfEHwGxPCI/J5y2EqLckwnex8gi5cPdkWsnR+EAf7jibq5jKC6hTBJQGqH9
         wGVzbY5X9dkUPk2yXrXkq3y2eLPiO8hx+iJdI0aFraGaj8Kv0pf6iigtM+P/ut8A47
         BArWTiEE11tJmiAmTt9j++pswKfedbZEElEdg/KSCUu1YsomyelV5a3uYbxdWe0Xm/
         DdB5wBySglCNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE0E4CE035E; Thu, 24 Aug 2023 06:21:03 -0700 (PDT)
Date:   Thu, 24 Aug 2023 06:21:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
> Currently, the maxcpu is set by traversing online CPUs, however, if
> the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> non-zero, and the some CPUs with larger cpuid has been offline before
> setting maxcpu, for these CPUs, even if they are online again, also
> cannot be offload or deoffload.
> 
> This commit therefore use for_each_possible_cpu() instead of
> for_each_online_cpu() in rcu_nocb_toggle().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index a58372bdf0c1..b75d0fe558ce 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
>  	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
>  	while (!rcu_inkernel_boot_has_ended())
>  		schedule_timeout_interruptible(HZ / 10);
> -	for_each_online_cpu(cpu)
> +	for_each_possible_cpu(cpu)

Last I checked, bad things could happen if the code attempted to
nocb_toggle a CPU that had not yet come online.  Has that changed?

							Thanx, Paul

>  		maxcpu = cpu;
>  	WARN_ON(maxcpu < 0);
>  	if (toggle_interval > ULONG_MAX)
> -- 
> 2.17.1
> 
