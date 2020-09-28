Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDDC4346E
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 00:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69642239A1
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 00:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ukJOK6nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1ANp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Sep 2020 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1ANp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Sep 2020 20:13:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F77C0613CE
        for <rcu@vger.kernel.org>; Sun, 27 Sep 2020 17:13:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so8608753qkc.2
        for <rcu@vger.kernel.org>; Sun, 27 Sep 2020 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KIK63/wTLAsMMEvtCu6RaqQGvZckuPgS8U08wx8ekI=;
        b=ukJOK6nbxwSQRhtC+rI6Zriz5UbWGyHGQ1Apiw7mkRvgACIByAGvFvG58eT1IbleYl
         +mwtLrVmpwblkHxhyNKTTVCPvbhnLZ9Ts35D1GwDqYKvIUSw+AIhHQp8oEvryhnohkY0
         my8/0Xr+YCAzJ8i1AtXvYo8F2LGzEQkwLEMQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KIK63/wTLAsMMEvtCu6RaqQGvZckuPgS8U08wx8ekI=;
        b=AlEchodoRr/r+0gn/lzRYPvFfrmZ/a3o0uImqXb9AedFFQn/f/M5bKoI/dK9VBc/Pv
         8c1zGm1AG6nDK2G3IlNZkGoDiA1+RHnLXNbD/WndbxGAsflhvpl4tXCQF/MvAenpeMni
         3mZQdxOs8mzzWFDvfyG3hgnvnVg1bnDOk4grEl5V9f5FFy3gBM06MxCn5pdslFiXfN+u
         +xhwza6cnwfXhm8jSKhdXK3ukYWCbyPc48X+MQoLAEV08lGADT4D84AaHitth5G+ChOJ
         3C7mrNCYhMac1bXT5heUzE6mbBWtVQ4kcve3bcfYgrpQ3/orujq4cLm2yOrZZIJWMx6n
         E1qw==
X-Gm-Message-State: AOAM5323yl/BCPyz82/7uxfU76+MjLisYNkAtDEkmMH1Z1medMy75XFw
        z3BQeUkaUC1Zt7uYb0Pupq086A==
X-Google-Smtp-Source: ABdhPJwTo++0DGqt5xpLNQkHItW/QFuIGHd6Ms9nOfxRKz9gzXOjUez+xjdT4njIgx1BpvABAexvKg==
X-Received: by 2002:a05:620a:2118:: with SMTP id l24mr9993709qkl.298.1601252023946;
        Sun, 27 Sep 2020 17:13:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l5sm8837846qtc.28.2020.09.27.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 17:13:43 -0700 (PDT)
Date:   Sun, 27 Sep 2020 20:13:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Message-ID: <20200928001342.GD500818@google.com>
References: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 12:04:10PM +0530, Neeraj Upadhyay wrote:
> Clarify the "x" in rcuox/N naming in RCU_NOCB_CPU config
> description.
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/rcu/Kconfig | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index b71e21f..5b22747 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -227,11 +227,12 @@ config RCU_NOCB_CPU
>  	  specified at boot time by the rcu_nocbs parameter.  For each
>  	  such CPU, a kthread ("rcuox/N") will be created to invoke
>  	  callbacks, where the "N" is the CPU being offloaded, and where
> -	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
> -	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
> -	  on the specified CPUs, but (1) the kthreads may be preempted
> -	  between each callback, and (2) affinity or cgroups can be used
> -	  to force the kthreads to run on whatever set of CPUs is desired.
> +	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
> +	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
> +	  from running on the specified CPUs, but (1) the kthreads may be
> +	  preempted between each callback, and (2) affinity or cgroups can
> +	  be used to force the kthreads to run on whatever set of CPUs is
> +	  desired.
>  
>  	  Say Y here if you want to help to debug reduced OS jitter.
>  	  Say N here if you are unsure.
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
