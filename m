Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BFFC2BB1D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193A820679
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PkqyoXMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgCPPt7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:49:59 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42687 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbgCPPt7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 11:49:59 -0400
Received: by mail-qv1-f65.google.com with SMTP id ca9so9091814qvb.9
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNebYaE/gz9C8jR4WscOnBZhY2YhTzN1/9r/OmYwa+c=;
        b=PkqyoXMHW6C709eywAoB4Zg9YbUPqoNwNsQz9znt2o/0Pi18JeWueU7X5/RY9iyeVu
         +VkwGgMT5QV7/gtTyHG1VZLICRJRzuNluXu81ChkBfZhRyraTCOxVIGQNm8jlMUzKpGi
         fIuPtGM+u8px9QURldyjZ+NoiQyg1ZhO0Ufpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNebYaE/gz9C8jR4WscOnBZhY2YhTzN1/9r/OmYwa+c=;
        b=QdYqz7X9zvdhnHZ6gzrRrzADQC3LoxMYG5YqEPobcPFNerqzKwwObiVDkupCErQ/9J
         kiRdoAsZkxqc3NmT2cVQSUJeqFttJvjLtjDh0jJOquH2drmKFRVY1jVuktI2pjvDKO3R
         EHbD9yoQkrGLnl21nIIK7ebGIudNow0TEyx+hrIMhZYuVk+8C9/0uK/wG620P+UkT6dB
         TiG22K/tjuiRCNlTq0Dy2g88BGxsCtu59tcOm/3F/3g3ew9ivxgyve6tQ052LISLh4Y9
         X7QlYwb1U7KiitaQmhxpEEjtaTeidf359r/gAMfKSPo4hY9uanVe8uXWEUtK/0VwLVpR
         DoKw==
X-Gm-Message-State: ANhLgQ0D74hUAnDJviu5VXGgNJsnX4IazB+yiles/8yd/OIE9+Z2dHJM
        xsl/OjHm7hWp0KmxlOcrIDEftpdO8kM=
X-Google-Smtp-Source: ADFU+vtI6BPuPrZxa2kjhQfZUbcQ/0LjAaWwbIcacUZdrpYQyd7J8oO/ArCb5wJ3DHEDX5+/HPc8Ag==
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr442773qvo.188.1584373797867;
        Mon, 16 Mar 2020 08:49:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z23sm22168qkg.21.2020.03.16.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:49:55 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:49:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 6/6] mm/list_lru.c: remove kvfree_rcu_local() function
Message-ID: <20200316154955.GH190951@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-7-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315181840.6966-7-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 15, 2020 at 07:18:40PM +0100, Uladzislau Rezki (Sony) wrote:
> Since there is newly introduced kvfree_rcu() API,
> there is no need in queuing and using call_rcu()
> to kvfree() an object after the GP.
> 
> Remove kvfree_rcu_local() function and replace
> call_rcu() by new kvfree_rcu() API that does
> the same but in more efficient way.

This patch LGTM:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/list_lru.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 386424688f80..69becdb22408 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/memcontrol.h>
> +#include <linux/rcupdate.h>
>  #include "slab.h"
>  
>  #ifdef CONFIG_MEMCG_KMEM
> @@ -383,21 +384,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
>  	struct list_lru_memcg *memcg_lrus;
>  	/*
>  	 * This is called when shrinker has already been unregistered,
> -	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
> +	 * and nobody can use it. So, there is no need to use kvfree_rcu().
>  	 */
>  	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
>  	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
>  	kvfree(memcg_lrus);
>  }
>  
> -static void kvfree_rcu_local(struct rcu_head *head)
> -{
> -	struct list_lru_memcg *mlru;
> -
> -	mlru = container_of(head, struct list_lru_memcg, rcu);
> -	kvfree(mlru);
> -}
> -
>  static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>  				      int old_size, int new_size)
>  {
> @@ -429,7 +422,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>  	rcu_assign_pointer(nlru->memcg_lrus, new);
>  	spin_unlock_irq(&nlru->lock);
>  
> -	call_rcu(&old->rcu, kvfree_rcu_local);
> +	kvfree_rcu(old, rcu);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
