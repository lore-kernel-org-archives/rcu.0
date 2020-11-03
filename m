Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ADAC388F7
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D86221D91
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DpKEK4aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgKCRyZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgKCRyY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 12:54:24 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A81C0617A6
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 09:54:24 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z6so15616979qkz.4
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gQIdH+KYMzHor18vx9OZ/2FWWOokJq94zc6XYSXneW0=;
        b=DpKEK4aB/HIU11tArZycrVOChpZNTGD38KrzZpwB5kFti7K3eOMs9D9aPUFn3Uj44c
         qrLBR2lDtk/ORa1oOhdnrMbCizV2xKCvjfgEQu7Afd125n+/ABz0aMIoL90AZajKPQO/
         i3fK5Ob1fcokwezA1t0bDBBh0510gobzD0bag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQIdH+KYMzHor18vx9OZ/2FWWOokJq94zc6XYSXneW0=;
        b=bJEvpj4Z4ZhzcP8oaDzoIq7mcBelT3ipYkRpRlF+HyHd+420DWnIbsMor9HwoUg/WY
         ejTzcj8zzm35KNYNnbSkmw5RIt9WJzp2GWXjGl355XFjpDd4WreKa7vwYbOM8rDD02lK
         qZvTe0RViLdFLrjWOBGq/0H8r29rdhUNaaZJ+4WyW8DBfwm6z7AE0V6JpR+vEs9spZF6
         DOQnNU/tKaWFn7lNy8dpZC1E8UKx8mQKtqnrt+euzvOiVjLhfkHO0H1Ext1p3N6ELD8l
         JwMzPOeYUiavZeRyEXwMYLKwUf5CBuB9QACkMPTcHIRVUzIEIixeWDEwcqtIQAxn55Px
         I8hg==
X-Gm-Message-State: AOAM533H5+iJoKM5JPGekK2G2+BUg2b+bkeoi03xMWkSGJbitBSp1QLB
        daxqO+aLeMufnbubZpiXSJ3cyA==
X-Google-Smtp-Source: ABdhPJxtfTigGbXqptLlX2dIbWdfb56HQCOG0dST1YxH8ZsXbcXyH2ofqKjbXP2DpAFgXD7H502fhQ==
X-Received: by 2002:a37:315:: with SMTP id 21mr21262307qkd.330.1604426063190;
        Tue, 03 Nov 2020 09:54:23 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v206sm4234881qkb.114.2020.11.03.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:54:22 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:54:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201103175422.GB1310511@google.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> The current memmory-allocation interface presents to following
> difficulties that this patch is designed to overcome
[...]
> ---
>  kernel/rcu/tree.c | 109 ++++++++++++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 06895ef85d69..f2da2a1cc716 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
>   * per-CPU. Object size is equal to one page. This value
>   * can be changed at boot time.
>   */
> -static int rcu_min_cached_objs = 2;
> +static int rcu_min_cached_objs = 5;
>  module_param(rcu_min_cached_objs, int, 0444);
>  
>  /* Retrieve RCU kthreads priority for rcutorture */
> @@ -3084,6 +3084,9 @@ struct kfree_rcu_cpu_work {
>   *	In order to save some per-cpu space the list is singular.
>   *	Even though it is lockless an access has to be protected by the
>   *	per-cpu lock.
> + * @page_cache_work: A work to refill the cache when it is empty
> + * @work_in_progress: Indicates that page_cache_work is running
> + * @hrtimer: A hrtimer for scheduling a page_cache_work
>   * @nr_bkv_objs: number of allocated objects at @bkvcache.
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
> @@ -3100,6 +3103,11 @@ struct kfree_rcu_cpu {
>  	bool monitor_todo;
>  	bool initialized;
>  	int count;
> +
> +	struct work_struct page_cache_work;
> +	atomic_t work_in_progress;

Does it need to be atomic? run_page_cache_work() is only called under a lock.
You can use xchg() there. And when you do the atomic_set, you can use
WRITE_ONCE as it is a data-race.

> @@ -4449,24 +4482,14 @@ static void __init kfree_rcu_batch_init(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -		struct kvfree_rcu_bulk_data *bnode;
>  
>  		for (i = 0; i < KFREE_N_BATCHES; i++) {
>  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
>  		}
>  
> -		for (i = 0; i < rcu_min_cached_objs; i++) {
> -			bnode = (struct kvfree_rcu_bulk_data *)
> -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> -
> -			if (bnode)
> -				put_cached_bnode(krcp, bnode);
> -			else
> -				pr_err("Failed to preallocate for %d CPU!\n", cpu);
> -		}
> -
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> +		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;

During initialization, is it not better to still pre-allocate? That way you
don't have to wait to get into a situation where you need to initially
allocate.

AFAICS after the above line deletions, the bulk pages are initially empty.

thanks,

 - Joel


>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
> -- 
> 2.20.1
> 
