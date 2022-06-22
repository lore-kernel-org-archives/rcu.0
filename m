Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A57C43334
	for <rcu@archiver.kernel.org>; Wed, 22 Jun 2022 23:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiFVXSG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376939AbiFVXSF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jun 2022 19:18:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248112873C
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 16:18:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 88so23966168qva.9
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lv2YHbzczEnD79dGcE3EqQq0j0lYfO0G5UeuRdLMomc=;
        b=LKwLtr9tC1PCUSXdzoCFckZrE8VzaSY4CDmlz9azEjSyQxkZM2GS0CUHp1Mu+wqEtL
         fThxINyXaVHVtWWxa9XjIf08YL+egNsTKnmI6MD8bBKhiInBE6e8KUfmYJvF6Rsv/+4h
         DR66OOmipWp5iVrlRYu1SFNE1oMLeDf0G8scQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lv2YHbzczEnD79dGcE3EqQq0j0lYfO0G5UeuRdLMomc=;
        b=qyHy7HCYKAMK2jSlGMfS3+B/nOAYnmG+9rEvc40F+ZgyzTr2sQRxOrFCaBl53Rdd6f
         MYRvP7apg+1fPYSHNT99Owduw4L8n7e5UTt+N1nod3bZfCu6/C6f6ZIm64t1fP4NHcqi
         MGY66c9gK2EnySV+WXQ3+ZOz9gCLUagwz1sH5UrwrAsZ4ymlcGLl1anRIBV3dTfv+2UZ
         ugD51vxM+2DjNYbyt2o8LeqFjsTPMreAyLT/NFibr6t5wzd7tSGFvOO1d+YVxrxGq6q9
         QvFvtIB99SS4hONdz6HXYhwwTCpqEqxFbRa1PeEfvKF3ZyWzWkAsPYxZ/qIROGT2oQ50
         byJQ==
X-Gm-Message-State: AJIora/1Nu1W+RogRogxgBN2zQ83DOOE/fdccsqIa0uB85L6HqB7ijTa
        ZAdKBXsue0mC+1A39sYMpmWBbG1WeO1PBg==
X-Google-Smtp-Source: AGRyM1t6A+bwk6XS0jPFAY5czbG4n/cXc+iiNVLIfaJo1O+D+ctCSvdqMkpVzsUOo0p14n1sEB9p6g==
X-Received: by 2002:a05:6214:20cf:b0:470:5256:c667 with SMTP id 15-20020a05621420cf00b004705256c667mr9542537qve.43.1655939883117;
        Wed, 22 Jun 2022 16:18:03 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id e12-20020ac84e4c000000b00307cebe3e07sm13474875qtw.79.2022.06.22.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:18:02 -0700 (PDT)
Date:   Wed, 22 Jun 2022 23:18:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <YrOjKnMHo4/NNDwy@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
[..]
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2ccf5845957d..fec4fad6654b 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -267,8 +267,9 @@ struct rcu_data {
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>  #define RCU_NOCB_WAKE_NOT	0
>  #define RCU_NOCB_WAKE_BYPASS	1
> -#define RCU_NOCB_WAKE		2
> -#define RCU_NOCB_WAKE_FORCE	3
> +#define RCU_NOCB_WAKE_LAZY	2
> +#define RCU_NOCB_WAKE		3
> +#define RCU_NOCB_WAKE_FORCE	4
>  
>  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>  					/* For jiffies_till_first_fqs and */
> @@ -436,9 +437,10 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j);
> +				  unsigned long j, bool lazy);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags);
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy);
>  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>  				 unsigned long flags);
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index e369efe94fda..b9244f22e102 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -256,6 +256,8 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>  }
>  
> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> +
>  /*
>   * Arrange to wake the GP kthread for this NOCB group at some future
>   * time when it is safe to do so.
> @@ -272,7 +274,10 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	 * Bypass wakeup overrides previous deferments. In case
>  	 * of callback storm, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	if (waketype == RCU_NOCB_WAKE_LAZY) {
> +		mod_timer(&rdp_gp->nocb_timer, jiffies + LAZY_FLUSH_JIFFIES);
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else {
> @@ -296,7 +301,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				     unsigned long j)
> +				     unsigned long j, bool lazy)
>  {
>  	struct rcu_cblist rcl;
>  
> @@ -310,7 +315,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
>  	if (rhp)
>  		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
> -	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +
> +	trace_printk("call_rcu_lazy callbacks = %ld\n", READ_ONCE(rdp->nocb_bypass.lazy_len));

Before anyone yells at me, that trace_printk() has been politely asked to take
a walk :-). It got mad at me, but on the next iteration, it wont be there.

thanks,

 - Joel

 
