Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F529C1975A
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 01:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E9D206EB
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 01:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qP2ixFBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgCOB2z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:28:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40248 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgCOB2y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 Mar 2020 21:28:54 -0400
Received: by mail-io1-f67.google.com with SMTP id d8so13590447ion.7
        for <rcu@vger.kernel.org>; Sat, 14 Mar 2020 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pinTi/t1yYoUNm8IVr+xW1d/79zVLYYM3Ifu/x4kb6g=;
        b=qP2ixFBWouQwucdaAze/oC0Kc9fOqSEKLCfl4tAnRKyKgvvivoBb1y7t9cSpyY4QlN
         R3mYYc/VRLHf5QiZyk0KDXJ8//akfLXe8Z2se7q1X50v5E+IsNEZZAHlU1vCNk1Ma7Ay
         pCCds55bcoTlzTnz+VNLLaf9+dRD5arJfiRPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pinTi/t1yYoUNm8IVr+xW1d/79zVLYYM3Ifu/x4kb6g=;
        b=oI1FMDiQzuMWO286j+gjlOOWWoyXQGhnMQWHrkcSZLXtT7mYs1vRSW09VfK3Fu/4N8
         1+7OBUCRhLrWUmzKklYbXA3Sc8BRQgthGpYONKfB/6yIhFDIwy/qjK0OKUb+9S10IfFp
         I6vvueASMQkeF+JclGNlhdOj5eMJL7WM2ce/r5Dir+v5Q72dlev8SQZN/ktS49F6+UT7
         WCzTN9tXXq2D2NCiMyU5/HickUQrNhbd49TdAhMlhxdeAaUinqMVwCUi98lL7abFDJsi
         IBTHgX2LukpMJ3qNlgecwEL3B+JiY8F9M1B0qNM2lzcxEJY2SDHGr33SMiF7ZpumN+YJ
         bkSQ==
X-Gm-Message-State: ANhLgQ1coeByJ9MIWxjVEMQFxGLZUKSnAJXhKwJE+y+KLVhWlz0a5QOa
        ZRhKGxk66K4sLEpCHFEiYkrXZixWMfY=
X-Google-Smtp-Source: ADFU+vudb0sNgUmAbbvIyvQmEohGmf5qtoxYEyDVJyFIlPlr/TyiQb3JX0PnvQfsx1hFemqXPUZJ2w==
X-Received: by 2002:ae9:f80a:: with SMTP id x10mr3474931qkh.43.1584234264685;
        Sat, 14 Mar 2020 18:04:24 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm31293227qti.84.2020.03.14.18.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 18:04:24 -0700 (PDT)
Date:   Sat, 14 Mar 2020 21:04:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Avoid recursion in
 lockdep_count_{for,back}ward_deps()
Message-ID: <20200315010422.GA134626@google.com>
References: <20200312151258.128036-1-boqun.feng@gmail.com>
 <20200313093325.GW12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313093325.GW12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 10:33:25AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 12, 2020 at 11:12:55PM +0800, Boqun Feng wrote:
> 
> Thanks!

Thanks Peter and Boqun, the below patch makes sense to me. Just had some nits
below, otherwise:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 32406ef0d6a2..5142a6b11bf5 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -1719,9 +1719,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
> >  	this.class = class;
> >  
> >  	raw_local_irq_save(flags);
> > +	current->lockdep_recursion = 1;
> >  	arch_spin_lock(&lockdep_lock);
> >  	ret = __lockdep_count_forward_deps(&this);
> >  	arch_spin_unlock(&lockdep_lock);
> > +	current->lockdep_recursion = 0;
> >  	raw_local_irq_restore(flags);
> >  
> >  	return ret;
> > @@ -1746,9 +1748,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
> >  	this.class = class;
> >  
> >  	raw_local_irq_save(flags);
> > +	current->lockdep_recursion = 1;
> >  	arch_spin_lock(&lockdep_lock);
> >  	ret = __lockdep_count_backward_deps(&this);
> >  	arch_spin_unlock(&lockdep_lock);
> > +	current->lockdep_recursion = 0;
> >  	raw_local_irq_restore(flags);
> >  
> >  	return ret;
> 
> This copies a bad pattern though; all the sites that do not check
> lockdep_recursion_count first really should be using ++/-- instead. But
> I just found there are indeed already a few sites that violate this.
> 
> I've taken this patch and done a general fixup on top.
> 
> ---
> Subject: locking/lockdep: Fix bad recursion pattern
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Mar 13 09:56:38 CET 2020
> 
> There were two patterns for lockdep_recursion:
> 
> Pattern-A:
> 	if (current->lockdep_recursion)
> 		return
> 
> 	current->lockdep_recursion = 1;
> 	/* do stuff */
> 	current->lockdep_recursion = 0;
> 
> Pattern-B:
> 	current->lockdep_recursion++;
> 	/* do stuff */
> 	current->lockdep_recursion--;
> 
> But a third pattern has emerged:
> 
> Pattern-C:
> 	current->lockdep_recursion = 1;
> 	/* do stuff */
> 	current->lockdep_recursion = 0;
> 
> And while this isn't broken per-se, it is highly dangerous because it
> doesn't nest properly.
> 
> Get rid of all Pattern-C instances and shore up Pattern-A with a
> warning.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/lockdep.c |   74 +++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 34 deletions(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -389,6 +389,12 @@ void lockdep_on(void)
>  }
>  EXPORT_SYMBOL(lockdep_on);
>  
> +static inline void lockdep_recursion_finish(void)
> +{
> +	if (WARN_ON_ONCE(--current->lockdep_recursion))
> +		current->lockdep_recursion = 0;
> +}
> +
>  void lockdep_set_selftest_task(struct task_struct *task)
>  {
>  	lockdep_selftest_task_struct = task;
> @@ -1719,11 +1725,11 @@ unsigned long lockdep_count_forward_deps
>  	this.class = class;
>  
>  	raw_local_irq_save(flags);
> -	current->lockdep_recursion = 1;
> +	current->lockdep_recursion++;
>  	arch_spin_lock(&lockdep_lock);
>  	ret = __lockdep_count_forward_deps(&this);
>  	arch_spin_unlock(&lockdep_lock);
> -	current->lockdep_recursion = 0;
> +	current->lockdep_recursion--;

This doesn't look like it should recurse. Why not just use the
lockdep_recursion_finish() helper here?

>  	raw_local_irq_restore(flags);
>  
>  	return ret;
> @@ -1748,11 +1754,11 @@ unsigned long lockdep_count_backward_dep
>  	this.class = class;
>  
>  	raw_local_irq_save(flags);
> -	current->lockdep_recursion = 1;
> +	current->lockdep_recursion++;
>  	arch_spin_lock(&lockdep_lock);
>  	ret = __lockdep_count_backward_deps(&this);
>  	arch_spin_unlock(&lockdep_lock);
> -	current->lockdep_recursion = 0;
> +	current->lockdep_recursion--;

And here.

> @@ -4963,7 +4969,7 @@ static void free_zapped_rcu(struct rcu_h
>  
>  	raw_local_irq_save(flags);
>  	arch_spin_lock(&lockdep_lock);
> -	current->lockdep_recursion = 1;
> +	current->lockdep_recursion++;
>  
>  	/* closed head */
>  	pf = delayed_free.pf + (delayed_free.index ^ 1);
> @@ -4975,7 +4981,7 @@ static void free_zapped_rcu(struct rcu_h
>  	 */
>  	call_rcu_zapped(delayed_free.pf + delayed_free.index);
>  
> -	current->lockdep_recursion = 0;
> +	current->lockdep_recursion--;

And here also if it applies.

>  	arch_spin_unlock(&lockdep_lock);
>  	raw_local_irq_restore(flags);
>  }
> @@ -5022,11 +5028,11 @@ static void lockdep_free_key_range_reg(v
>  
>  	raw_local_irq_save(flags);
>  	arch_spin_lock(&lockdep_lock);
> -	current->lockdep_recursion = 1;
> +	current->lockdep_recursion++;
>  	pf = get_pending_free();
>  	__lockdep_free_key_range(pf, start, size);
>  	call_rcu_zapped(pf);
> -	current->lockdep_recursion = 0;
> +	current->lockdep_recursion--;

And here also if it applies.

thanks!

 - Joel

