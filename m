Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71549C433E6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC5364DF6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 16:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhA1Qcg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhA1Qcf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 11:32:35 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB8C0613D6;
        Thu, 28 Jan 2021 08:31:54 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e18so7050423lja.12;
        Thu, 28 Jan 2021 08:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4OiRJxx5bDRgrHfvhZaQlIJJXqKiMdcy/FzycqDLAc=;
        b=El/vD5HO2EGCOn/tpMFK3eB0W0852ZEvQ1+9iWiVI2Jl4X7pj3DRm5WKuDHMhmg9He
         Lq0es0ZlA0JlOHVMWBikXYamYY1I73/A6Jn2UwX2tVVPkA2A3/HTwSBcB9XmQj5oLYIh
         VBgCJ54R4Z+HczjH6mYh3B2fRY6sQzUrrkdWk1NR/sAH9BRfP3t1QV5wMqyDCbOgh3XX
         S/E8mX80uPv7F5+1P2m3pqvUWaMUh5SEslTiyNA0Jt90+xl5gvueKvAyp+y+UwvwS1hC
         dZinz53FqnRION+lp4upmZs4IZJiGAMZCinwoCjQq+3SOt77gt/JQohn6xrqeBPQ/pe4
         hwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4OiRJxx5bDRgrHfvhZaQlIJJXqKiMdcy/FzycqDLAc=;
        b=gfjg9XBR1rnY9VWpvoq7DN9dNI35Tf36EjZZzZsPhpt635HIQGbjhnmXqOU7NZbMU6
         l1wqOFN+4yauLHBXL7nx0Z1FZeC2poiWIdj25mwY7KzCoSd2NXJIxKIKT5gBmbREknV4
         2FPcCjewpUMciN0vgUYJCiUbna/rjETAJD31H4uOOUzKBJGw98oERY2hoKZshZrURdlX
         jhzeCXoY1g8GbalBT0K3kDzmuaRR1TojTghLiyLkKWMCYt0ozBcMQ5ZJhCv+csihXYUY
         7GNprl2p1IqzNuSCAsbQpUdj+lqGLxeKhMOQAU6nGgRXUqsN9gQubFoNuQrVS2H2nVle
         UKRQ==
X-Gm-Message-State: AOAM533pCtdnQ4D32Brv3Yqlesp0U5z8rqxG+XNtZQM1SImQI+RskBR9
        C4fRsW/V0sa3/sb3+vycJbk=
X-Google-Smtp-Source: ABdhPJzPKXHRVKIEB9pRP1jjpFvde+0amuyf2AyihvG/d5BZYXwqALcGKJqiv7sxNhDP7MVKqcUQdA==
X-Received: by 2002:a2e:140e:: with SMTP id u14mr32705ljd.496.1611851513179;
        Thu, 28 Jan 2021 08:31:53 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c16sm1972472ljj.20.2021.01.28.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:31:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 28 Jan 2021 17:31:49 +0100
To:     qiang.zhang@windriver.com
Cc:     urezki@gmail.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvfree_rcu: Release page cache under memory pressure
Message-ID: <20210128163149.GA2397@pc638.lan>
References: <20210128130509.35489-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128130509.35489-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Zqiang.

See below some nits:

> 
> Add free per-cpu existing krcp's page cache operation, when
> the system is under memory pressure.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/rcu/tree.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c1ae1e52f638..4e1c14b12bdd 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3571,17 +3571,41 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> +static inline int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
Do we need it "inlined"?

> +{
> +	unsigned long flags;
> +	struct kvfree_rcu_bulk_data *bnode;
> +	int i, num = 0;
> +
> +	for (i = 0; i < rcu_min_cached_objs; i++) {
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
> +		bnode = get_cached_bnode(krcp);
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +		if (!bnode)
> +			break;
> +		free_page((unsigned long)bnode);
> +		num++;
> +	}
> +
> +	return num;
Get rid of "num" and return i instead?

> +}
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
>  	int cpu;
>  	unsigned long count = 0;
> +	unsigned long flags;
>  
>  	/* Snapshot count of all CPUs */
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count += READ_ONCE(krcp->count);
> +
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
> +		count += krcp->nr_bkv_objs;
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  
>  	return count;
> @@ -3604,6 +3628,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		else
>  			raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
> +		count += free_krc_page_cache(krcp);
Move it upper right after count = krcp->count;, so a "count" is set
in one place what i more readable and clear?

Thank you!

--
Vlad Rezki
