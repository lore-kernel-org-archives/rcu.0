Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA5C38142
	for <rcu@archiver.kernel.org>; Fri, 20 Jan 2023 03:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjATDPA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 22:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjATDO7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 22:14:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9EF9005
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 19:14:58 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id j9so3028953qvt.0
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 19:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xKzm9ndNgAZ3n1qGRub6U8C9Gfc3KHDIIF/tjQDlEM=;
        b=m44zaOQkQ6ybI6EyHHLAMaKTSDPlX152AcKKf/sdncMKOtzTj5XdOkYow8SRBzCSWh
         EtIkORMprMVXC2tqTdODJ1BMRULcWsZa8H8Eb7HponRkwZEw8BCsxdbry0jorzjdyPMo
         hNKDLBH8k5iXsaC9wFlQ8M9/5tWc30NrUj0WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xKzm9ndNgAZ3n1qGRub6U8C9Gfc3KHDIIF/tjQDlEM=;
        b=7sWmrR1GSta/yW0HY+VkDUBgYmrYqaPN892//qm/Mt8htHubV+tRoDogV5BhPWO9oR
         XdiXfSFfDsHRcFkQx7ZgbCySVQGIGYW7A+Qiexs2WJqzjyfvyEZqccg+jSWoxv7UqYe6
         Ev8sw58v+OzXH3/27r8LfwwiaddF7elfc8rBtvvGftro18LiMrhwwt+T/ZhfySSRzIQ+
         SAKwSJlOAbwtnSmAdG70X42J8SjOjIZvE51Trcf89tcYesF/RXfqJPZP1bKrUi4xShA+
         5aVmF2NpGohMAW/ZmoBpOpr2B3d11UBAaMIsHpGjVuYhvb2qcmJMBW3UWmvrdgwzTEez
         TUDg==
X-Gm-Message-State: AFqh2konWP1qEyJXXCThPXT9tytFXVSQVP/HGgQYQR8Jxk7ZAIi1Tc2E
        76CONbQIvdExERDFpY0p860fJg==
X-Google-Smtp-Source: AMrXdXtpT0zkxvA6pOTV7mgIcAXwUW5c9AzZqy9wFlj68ECsfrrn7DoOmRWSp+Jeeku//5n831bY8w==
X-Received: by 2002:a05:6214:5d11:b0:534:a476:e10 with SMTP id me17-20020a0562145d1100b00534a4760e10mr18371006qvb.25.1674184497085;
        Thu, 19 Jan 2023 19:14:57 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006fa43e139b5sm25312634qkl.59.2023.01.19.19.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:14:56 -0800 (PST)
Date:   Fri, 20 Jan 2023 03:14:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y8oHL0uuSEef5aiI@google.com>
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 18, 2023 at 10:07:14AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> > When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> > grpmask has not been cleared from the corresponding rcu_node structure's
> > ->qsmask, after that will clear and report quiescent state, but in this
> > time, this also means that current grace period is not end, the current
> > grace period is ongoing, because the rcu_gp_in_progress() currently return
> > true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> > to return true.
> > 
> > This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Queued (wordsmithed as shown below, as always, please check) for further
> testing and review, thank you both!
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Wed Jan 18 15:30:14 2023 +0800
> 
>     rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
>     
>     The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
>     only if there is a grace period in progress that is still blocked
>     by at least one CPU on this rcu_node structure.  This means that
>     rcu_accelerate_cbs() should never return the value true, and thus that
>     this function should never set the needwake variable and in turn never
>     invoke rcu_gp_kthread_wake().
>     
>     This commit therefore removes the needwake variable and the invocation
>     of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
>     rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
>     detect situations where the system's opinion differs from ours.
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2c2045294780..7a3085ad0a7df 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	bool needwake = false;
>  	bool needacc = false;
>  	struct rcu_node *rnp;
>  
> @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		 * NOCB kthreads have their own way to deal with that...
>  		 */
>  		if (!rcu_rdp_is_offloaded(rdp)) {
> -			needwake = rcu_accelerate_cbs(rnp, rdp);
> +			/*
> +			 * The current GP has not yet ended, so it
> +			 * should not be possible for rcu_accelerate_cbs()
> +			 * to return true.  So complain, but don't awaken.
> +			 */
> +			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
>  		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
>  			/*
>  			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		rcu_disable_urgency_upon_qs(rdp);
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>  		/* ^^^ Released rnp->lock */
> -		if (needwake)
> -			rcu_gp_kthread_wake();

AFAICS, there is almost no compiler benefit of doing this, and zero runtime
benefit of doing this. The WARN_ON_ONCE() also involves a runtime condition
check of the return value of rcu_accelerate_cbs(), so you still have a
branch. Yes, maybe slightly smaller code without the wake call, but I'm not
sure that is worth it.

And, if the opinion of system differs, its a bug anyway, so more added risk.


>  
>  		if (needacc) {
>  			rcu_nocb_lock_irqsave(rdp, flags);

And when needacc = true, rcu_accelerate_cbs_unlocked() tries to do a wake up
anyway, so it is consistent with nocb vs !nocb.

So I am not a fan of this change. ;-)

thanks,

 - Joel

