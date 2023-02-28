Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19523C64EC7
	for <rcu@archiver.kernel.org>; Tue, 28 Feb 2023 20:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjB1Ujn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjB1Ujl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Feb 2023 15:39:41 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D380F34C17
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 12:39:32 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id y12so7803827qvt.8
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 12:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677616772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3N2ywhkR/bMPSeXmwyHCwpyMHSCbDCyuk19SKsi7Rfg=;
        b=agY7M0SISSdJupcls04a1QBQDOpWIBYSAesvX1+dRM5Tf/TKtCupRGPyem+9EZlYnn
         40/a0mJ1MjcqAxbM0a4CYgn87T4aFjwtfCato8dAjIiQygAc7AVMzUzlMsFUd6+f4edD
         NhE/DZIV3iiL7BRk9fi2RH5TsT8AmpR09suxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677616772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N2ywhkR/bMPSeXmwyHCwpyMHSCbDCyuk19SKsi7Rfg=;
        b=XtIJyYtrn3Mo9tQgMF/GdMELXmxh2w5+lo9kg6Z196yHa3aDFbjnMBCA0OwVcjM5EZ
         /vlXFs+FhTHkWnDkdLC7oqFHRPhWeoWeyEJ6M2e3YTVXxw1nXj2SgtqCG/hCMEYoA9xL
         r2xmf1WPokYoNdC/yxBjPqC/E4xtTsZPW48Pxb83VTQDfQ9uuB0CZC3YVOqAjRJMMJZA
         51yki/gpdkSXBW4bV0jGUd6BLBVpFDqbFB7P+tKJMrK13MOLw5UEFaUoHXPgPjfX1zE+
         bZ+kLgpQYvNqXU4htGMtmIrx0ngxt0k+X3wjp//d4vvNzNmH4QSNgwXzf5Zr7mUEhREl
         xzhA==
X-Gm-Message-State: AO0yUKU9aLXpvC8L4nlVCkkrzNRX3H8mMFqH4v64MXphb8FK++/TCvHN
        YhT9RtM4PLsMa4PnL+wlK1ZJQw==
X-Google-Smtp-Source: AK7set/zofXKOT7Or3LOrmfABLDV6LwDDjSbBnAaw0bI6AAd+d8bCXukM4oVLnnSBzOzJB9BaffATA==
X-Received: by 2002:ad4:5aea:0:b0:574:8ef8:89cc with SMTP id c10-20020ad45aea000000b005748ef889ccmr8817048qvh.41.1677616771783;
        Tue, 28 Feb 2023 12:39:31 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id 81-20020a370c54000000b007423ccd892csm7479037qkm.47.2023.02.28.12.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:39:31 -0800 (PST)
Date:   Tue, 28 Feb 2023 20:39:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <Y/5mguXPPqdP3MZF@google.com>
References: <20230228155121.3416-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228155121.3416-1-ubizjak@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 28, 2023 at 04:51:21PM +0100, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move instruction in
> front of cmpxchg).

In my codegen, I am not seeing mov instruction before the cmp removed, how
can that be? The rax has to be populated with a mov before cmpxchg right?

So try_cmpxchg gives: mov, cmpxchg, cmp, jne
Where as cmpxchg gives: mov, cmpxchg, mov, jne

So yeah you got rid of compare, but I am not seeing reduction in moves.
Either way, I think it is an improvement due to dropping cmp so:

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> No functional change intended.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/rcu/tree_stall.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a..d81c88e66b42 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -760,7 +760,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	jn = jiffies + ULONG_MAX / 2;
>  	if (rcu_gp_in_progress() &&
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> -	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +	    try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>  
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
> @@ -778,7 +778,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  
>  	} else if (rcu_gp_in_progress() &&
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> -		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +		   try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>  
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
> -- 
> 2.39.2
> 
