Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED5C433FE
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 00:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359704AbiEMAAS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359708AbiEMAAR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 20:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9328B68B
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 17:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1D36206C
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 00:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85F9C34113;
        Fri, 13 May 2022 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400015;
        bh=AT6BTlcHwMmblG41JnfGcUJMedUVfB/doUCOSQm3AeE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TUjE/SqwfpOhQmYX/0QiDmlCDMEpzl8e7uKIvEZU3QUZVC5ugCqrVvwYisLYJhIyH
         devS4/I5r6wGPRJG4X1Mt75zOtUqYW1QlCCQP/F16K5oH28MfW9/cyEHjGhOiZtQlI
         TfDgKd9oKm5z3LUkhf6bYFqL21h4uPu+AR/mQ//BCx+VidIS9CZeNufvlxP0dvKE+S
         zAq+bDZIu/lz21g/gJDK3q2F6yu39NPvtWpllDnzt1nVS0vKFtHkeYN0PKNQHQE4GP
         XPrRxtKE7F2JuJD5HaqQIoWtTM0Y1s7MpcCVKNW27fPEinalqqlPYC9c/VFOcRdpAT
         xpH3T+TTQ0gDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B81B5C051B; Thu, 12 May 2022 17:00:15 -0700 (PDT)
Date:   Thu, 12 May 2022 17:00:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 03/14] block/blk-ioc: Move call_rcu() to call_rcu_lazy()
Message-ID: <20220513000015.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-4-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:31AM +0000, Joel Fernandes (Google) wrote:
> This is required to prevent callbacks triggering RCU machinery too
> quickly and too often, which adds more power to the system.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Hard to argue with this one given that icq_free_icq_rcu() just does
a kmem_cache_free().  ;-)

							Thanx, Paul

> ---
>  block/blk-ioc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 11f49f78db32..96d5de5df0b6 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -98,7 +98,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
>  	 */
>  	icq->__rcu_icq_cache = et->icq_cache;
>  	icq->flags |= ICQ_DESTROYED;
> -	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
> +	call_rcu_lazy(&icq->__rcu_head, icq_free_icq_rcu);
>  }
>  
>  /*
> -- 
> 2.36.0.550.gb090851708-goog
> 
