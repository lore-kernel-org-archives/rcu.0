Return-Path: <SRS0=wfWh=5X=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C693C2BA80
	for <rcu@archiver.kernel.org>; Tue,  7 Apr 2020 02:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732C220719
	for <rcu@archiver.kernel.org>; Tue,  7 Apr 2020 02:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xI/ujC/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDGCLW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:11:22 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39447 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgDGCLW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Apr 2020 22:11:22 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so1131928qvf.6
        for <rcu@vger.kernel.org>; Mon, 06 Apr 2020 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaa6SifOL9ZgGakR85u07GVO9twQQnlqkKhhw8LJ61Y=;
        b=xI/ujC/RAckrvStiyT1s/lKEcpA1186172WShsPNhGoEOvQ5y2Ser1kYDtJsnPsLga
         f6QPfBlDXJ4h7eLoL/ZFwg0+woBukzLR534NkFoPeELNS+GjxvNixkkD5xoEJUd4e+n9
         Kyrm2zsmBCRaqyD3cOlNW7XK34Oqd7RmKL8vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaa6SifOL9ZgGakR85u07GVO9twQQnlqkKhhw8LJ61Y=;
        b=jJ25DLYr/Nk3aD4r4IhmcZClq+sdGEFrMJuvlW47FXjkXHIwvMtMEYbVxiEeU1wj/+
         n3BE8mppHwXfaJBFYR2MbRbO3Wkhk4NVVAukqUtkiPvgo3pGGep82DZuVweoNumGuLtP
         pdBKHEDPKpCeekSPxq+IjJUdxDzeosqMHVQUeXl2PGC6e7zG7AcPi9av0/DWsBRwbvqs
         8ZIrpSKyQ7Htt7ZEdFTGMhy0AEXr3snCgTogZRvlsDKavWJ5wSJ1HYwTkCzHTpTGB7Qk
         3dAyvKYJHZTtlgkzY/CDXi0c5Telm8WpXxgUImz5eFCyGe4p9OchNDqtTHHV0DkQ6Xvi
         6R3Q==
X-Gm-Message-State: AGi0PuZxbW35yovqzwaGynRxWyzisU1KhhQi00oZhPoCLIjcE3uL4a60
        vqDikw5JFNZaYBtDm83xdGddjg==
X-Google-Smtp-Source: APiQypJXPpYd12Vrp+/OA+MjcYQlGqYJcYWnu164CU0oVIxQEvSPK9xJqC/qsXd3mxWCvZpUCgm1Ng==
X-Received: by 2002:ad4:4f93:: with SMTP id em19mr84697qvb.110.1586225479431;
        Mon, 06 Apr 2020 19:11:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g187sm15461721qkf.115.2020.04.06.19.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 19:11:18 -0700 (PDT)
Date:   Mon, 6 Apr 2020 22:11:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] rcu/tree: use more permissive parameters when
 attaching a head
Message-ID: <20200407021118.GB113967@google.com>
References: <20200402123253.10382-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402123253.10382-1-urezki@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 02, 2020 at 02:32:51PM +0200, Uladzislau Rezki (Sony) wrote:
> It is documneted that a headless object can be reclaimed from
> might_sleep() context only. Because of that when a head is
> dynamically attached it makes sense to drop the lock and do
> an allocation with much more permissve flags comparing if it
> is done from atomic context.
> 
> That is why use GFP_KERNEL flag plus some extra ones which
> would make an allocation most likely to be succeed. The big
> advantage of doing so is a direct reclaim process.
> 
> Tested such approach on my local tiny system with 145MB of
> ram(the minimum amount the KVM system is capable of booting)
> and 4xCPUs. For stressing the rcuperf module was used. During
> tests with difference combinations i did not observe any hit
> of our last emergency case, when synchronize_rcu() is involved.
> 
> Please note, the "dynamically attaching" path was enabled only,
> apart of that all types of objects were considered as headless
> variant during testing.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6172e6296dd7..24f620a06219 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3148,13 +3148,10 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
>  {
>  	unsigned long *ptr;
>  
> +	/* Try hard to get the memory. */
>  	ptr = kmalloc(sizeof(unsigned long *) +
> -			sizeof(struct rcu_head), GFP_NOWAIT | __GFP_NOWARN);
> -
> -	if (!ptr)
> -		ptr = kmalloc(sizeof(unsigned long *) +
> -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> -
> +		sizeof(struct rcu_head), GFP_KERNEL |
> +			__GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL);

On thing here though, you removed the NOWARN. Was there a reason? It would
now warn even when synchronously waiting right? I will fixup your commit to
add it back for now but let me know if you had some other reason to remove it.

thanks,

 - Joel


>  	if (!ptr)
>  		return NULL;
>  
> @@ -3222,9 +3219,20 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	if (!success) {
>  		/* Is headless object? */
>  		if (head == NULL) {
> +			/* Drop the lock. */
> +			if (krcp->initialized)
> +				spin_unlock(&krcp->lock);
> +			local_irq_restore(flags);
> +
>  			head = attach_rcu_head_to_object(ptr);
>  			if (head == NULL)
> -				goto unlock_return;
> +				goto inline_return;
> +
> +			/* Take it back. */
> +			local_irq_save(flags);
> +			krcp = this_cpu_ptr(&krc);
> +			if (krcp->initialized)
> +				spin_lock(&krcp->lock);
>  
>  			/*
>  			 * Tag the headless object. Such objects have a back-pointer
> @@ -3263,6 +3271,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
>  
> +inline_return:
>  	/*
>  	 * High memory pressure, so inline kvfree() after
>  	 * synchronize_rcu(). We can do it from might_sleep()
> -- 
> 2.20.1
> 
