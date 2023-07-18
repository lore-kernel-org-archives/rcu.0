Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BCBEB64DA
	for <rcu@archiver.kernel.org>; Tue, 18 Jul 2023 12:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjGRM6t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Jul 2023 08:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGRM6t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Jul 2023 08:58:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C939E77
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 05:58:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a43cbb432aso3332760b6e.3
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689685127; x=1692277127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3kTN4YamSI+ko6dM/L7aHZSrCBexbIuSEJDZBtJUAU=;
        b=V+gPh2q0SUEyDUZvPYeclcaF/8fPibKR2Mh4HcvaG7m+e1W9m2jy6j86KjZKJqPyli
         Ex5mdJMaInMua4Pci1caiiBmH9NhSkantEJiqAe9/wrWVklSVmW1JyJRgMkRKd59QlVM
         Emtpvet9H93Uwl5XzgunsWYR+Xhp9Ts6EBKlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685127; x=1692277127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3kTN4YamSI+ko6dM/L7aHZSrCBexbIuSEJDZBtJUAU=;
        b=IkWJkNm5XwF3ik9sBx09zffuyFeeM82oSJx6pGusumjZLIQJFJrfaWENEec3OWD4Ij
         /FPzGgVry8Ec24cfxTupXyvvNB6gO5poqMOO0eqc0BCinEOHd5ysS9OUl3ASE9dFMF0d
         LPRSpaCH6j/Y8vwZsj/cAY23FvxQFmK8b8sDYCGBkWinPhruTKcwpVt5+ww7Mb0MR4NR
         l+a/epiGLitP4umay3QypWypj5eYjFW0b9umNxFYYkYegAqfFouFp0a0Z+wtHZ0bFTWH
         7yftnTDs+UjEpMwZUO+Gy3AvghoR1gTHH03c4TWP9FCK6B9B84wQt2QG2IDjy9jGKjDk
         0BQw==
X-Gm-Message-State: ABy/qLa6VACBKc8uCw0anxl+Ykuoz0UrNZ7Lp3Kx57w1n60ZncD4anUq
        XkHdGOukU3M6dKH3thGGQpGMsg==
X-Google-Smtp-Source: APBJJlEeGKkl9XfQikXV6rHJcKhcxgaZv0WTquFZ9YpiKbVJxip385yT/48/pCqV0JXTJun8tsNziw==
X-Received: by 2002:aca:bd03:0:b0:3a4:1539:afff with SMTP id n3-20020acabd03000000b003a41539afffmr12850777oif.25.1689685127233;
        Tue, 18 Jul 2023 05:58:47 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a0cde08000000b00635efe2f65csm709096qvk.30.2023.07.18.05.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:58:46 -0700 (PDT)
Message-ID: <e34dd41a-b48c-578d-e45b-8c3b4a5df93a@joelfernandes.org>
Date:   Tue, 18 Jul 2023 08:58:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 4/6] rcu: Mark __rcu_irq_enter_check_tick()
 ->rcu_urgent_qs load
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-4-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-4-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> The rcu_request_urgent_qs_task() function does a cross-CPU store
> to ->rcu_urgent_qs, so this commit therefore marks the load in
> __rcu_irq_enter_check_tick() with READ_ONCE().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fae9b4e29c93..aec07f2ec638 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -632,7 +632,7 @@ void __rcu_irq_enter_check_tick(void)
>   	// prevents self-deadlock.  So we can safely recheck under the lock.
>   	// Note that the nohz_full state currently cannot change.
>   	raw_spin_lock_rcu_node(rdp->mynode);
> -	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> +	if (READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
>   		// A nohz_full CPU is in the kernel and RCU needs a
>   		// quiescent state.  Turn on the tick!
>   		WRITE_ONCE(rdp->rcu_forced_tick, 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>


thanks,

- Joel
