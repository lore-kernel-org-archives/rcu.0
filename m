Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31BC74A5B
	for <rcu@archiver.kernel.org>; Fri, 24 Mar 2023 00:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXAmC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Mar 2023 20:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXAmB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Mar 2023 20:42:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F612A999
        for <rcu@vger.kernel.org>; Thu, 23 Mar 2023 17:41:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t13so736420qvn.2
        for <rcu@vger.kernel.org>; Thu, 23 Mar 2023 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679618518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WrcWjQAomAOFK08UVf0mOA1ZiXhOdNxV9B2NaRKg6Y=;
        b=bddRNScTZqOEcrm9EfRiwJwr//oeSdemoVLMEi1ieHb6qIFPj925se9lnQ/0+KAM+S
         JTwz9uCMDciWumVXN9IAmJZgBGZVg4umEb2PMzaiWLAk6/KzSW1Jcav1qYByjGJAyjEn
         bNcwkMlG1WpzSP1+8ta8zi2He6uZxiNNGMDtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679618518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WrcWjQAomAOFK08UVf0mOA1ZiXhOdNxV9B2NaRKg6Y=;
        b=pe9SYlUomhASybC9H+0gGWBkbGRpOrzioe9BTGzYhOmdXhcol/wOSqOnqbfVSkAWlT
         aLD3oyOuyfLSfYcTlqap6mLIDVpPE0uSVQcc6uLIfzQ7Jzs+28MJHIuI40dNT/45S0a9
         W0CC4UrQCKbkQ0sW6aZHOgk/qy/JKiwz4KGr7g3LnvQD6plLV/iCIp+Nq2mAgLU1U55i
         Rg5L0xquc4rjdC67OAU/twinYjM6gtCMM/8pcT6I0jXQPMLmzl9Wd8PUUOVm6DZysF0a
         cv+GkTg5Mu7vv2SJtMhKiWywsoCnPPHeHMd6rhW2+zoqGxrewxke7dlDAUTugTxplArJ
         bq7A==
X-Gm-Message-State: AAQBX9cqZ2xL2op1GJxjEBQVkgspNwWevSOPQJhbKMwwJQriL03YmstN
        NwH+IQUxwbw06N1oDvV8H9qTSQ==
X-Google-Smtp-Source: AKy350ZHV3z/WVewRBoM/V7Ff0dBwRBx5dbcnDkVFGFPYTWjha9zZOEeaN2dIhqxxhxMRz1Zp+GeBA==
X-Received: by 2002:ad4:5f05:0:b0:56e:fe99:b296 with SMTP id fo5-20020ad45f05000000b0056efe99b296mr1290590qvb.42.1679618517895;
        Thu, 23 Mar 2023 17:41:57 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id ev11-20020a0562140a8b00b005dd8b9345bcsm278409qvb.84.2023.03.23.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 17:41:57 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:41:57 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Message-ID: <20230324004157.GA723582@google.com>
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322194456.2331527-5-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 22, 2023 at 08:44:56PM +0100, Frederic Weisbecker wrote:
> Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
> over the NOCB mask is enough for both counting and scanning. Just lock
> the mostly uncontended barrier mutex on counting as well in order to
> keep rcu_nocb_mask stable.
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index a3dc7465b0b2..185c0c9a60d4 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1319,13 +1319,21 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  	int cpu;
>  	unsigned long count = 0;
>  
> +	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
> +		return 0;
> +
> +	/*  Protect rcu_nocb_mask against concurrent (de-)offloading. */
> +	mutex_lock(&rcu_state.barrier_mutex);
> +
>  	/* Snapshot count of all CPUs */
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, rcu_nocb_mask) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  
>  		count +=  READ_ONCE(rdp->lazy_len);
>  	}
>  
> +	mutex_unlock(&rcu_state.barrier_mutex);
> +
>  	return count ? count : SHRINK_EMPTY;
>  }
>  
> @@ -1336,6 +1344,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	unsigned long flags;
>  	unsigned long count = 0;
>  
> +	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
> +		return 0;
>  	/*
>  	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
>  	 * may be ignored or imbalanced.
> @@ -1343,7 +1353,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	mutex_lock(&rcu_state.barrier_mutex);
>  
>  	/* Snapshot count of all CPUs */
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, rcu_nocb_mask) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  		int _count;
>  
> -- 
> 2.34.1
> 
