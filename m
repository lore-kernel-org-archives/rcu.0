Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2265CEB64DA
	for <rcu@archiver.kernel.org>; Tue, 18 Jul 2023 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGRNrM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Jul 2023 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjGRNqs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Jul 2023 09:46:48 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60FE5
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 06:46:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-635e107642fso24940446d6.1
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689687986; x=1692279986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5gDeWaSeLpSSmm/E8qPIij+tO48vpZFmnMjNa47DSU=;
        b=fgQxFQm80HjUt8ykOXh/bprQWsULUuDuQXvsgRomxjBN71NgyX4eFyR50GKFtF+3Fj
         d/P1DVxCOePJHTk1y3eciUa2a6/ahctJsncy1S/k/gCCCLTwOi2yIXwb3ntLYXX8TmxC
         DiiGnyXZx3hnbDfQDT2nuLzzfmbXZkfheZO8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687986; x=1692279986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5gDeWaSeLpSSmm/E8qPIij+tO48vpZFmnMjNa47DSU=;
        b=XGZfeyMApdjqmDEDNA3NvgJA4QK7EStvS9lMvT8v75WkC6RrrRk8fObdw8iaf2d53+
         lzCgB9Sv2QCReU+LaH3Ix/SdK74Z5BdeDlJowpwDCOraKqru0g5tJhxUYRoHgOoIth0N
         eqBbIDX5/oqxJHW7+9bK7XKWTMADBkrmwNJd+Z6y0aEk3QJFEqD0eHVxebo7oWZA+3As
         T/uQ3I+hzHwhulb7PNRDM7AdeOfYhqW0ojsO65uiWFDcQTPZCDEnF9O7wZ+ZZSObQQ/i
         BqegQMy61TY1hZ70stm1voWlVvYLsDn2wEUwJH3xCv85bDCqCTNzlLYsfQdhHDzp8+G+
         9X8w==
X-Gm-Message-State: ABy/qLZOL3dPsZzhPhSgAjsYy3Uukq1QFl19sNn98m+zUUSgWD7rjPBR
        7mR92IS+RPr7dUOV6GRaQW7Rng==
X-Google-Smtp-Source: APBJJlGSfPIcEdlW4LkiisGeLuk2NGMuBA7JnbuYHT3/uLBJ72nuFA5/x2aJpeUpPEKOX1vWK0g2dQ==
X-Received: by 2002:a05:6214:260c:b0:635:e041:71c6 with SMTP id gu12-20020a056214260c00b00635e04171c6mr15072873qvb.17.1689687986032;
        Tue, 18 Jul 2023 06:46:26 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id b6-20020a0cb3c6000000b00631fc149a19sm725092qvf.110.2023.07.18.06.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:46:25 -0700 (PDT)
Message-ID: <3586af97-e9bc-341f-4a81-678b5e1e96f8@joelfernandes.org>
Date:   Tue, 18 Jul 2023 09:46:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 5/6] rcu: Make the rcu_nocb_poll boot parameter usable
 via boot config
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-5-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-5-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> The rcu_nocb_poll kernel boot parameter is defined via early_param(),
> whose parsing functions are invoked from parse_early_param() which
> is in turn invoked by setup_arch(), which is very early indeed.  It
> is invoked so early that the console output timestamps read 0.000000,
> in other words, before time begins.
> 
> This use of early_param() means that the rcu_nocb_poll kernel boot
> parameter cannot usefully be embedded into the kernel image.  Yes, you
> can embed it, but setup_boot_config() is invoked from start_kernel()
> too late for it to be parsed.
> 
> But it makes no sense to parse this parameter so early.  After all,
> it cannot do anything until the rcuog kthreads are created, which is
> long after rcu_init() time, let alone setup_boot_config() time. >
> This commit therefore switches the rcu_nocb_poll kernel boot parameter
> from early_param() to __setup(), which allows boot-config parsing of
> this parameter, in turn allowing it to be embedded into the kernel image.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree_nocb.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 43229d2b0c44..5598212d1f27 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -77,9 +77,9 @@ __setup("rcu_nocbs", rcu_nocb_setup);
>   static int __init parse_rcu_nocb_poll(char *arg)
>   {
>   	rcu_nocb_poll = true;
> -	return 0;
> +	return 1;
>   }
> -early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
> +__setup("rcu_nocb_poll", parse_rcu_nocb_poll);

I was trying to see if core_param() could be used. But I am not sure if the RCU 
offload threads are spawned too early for that.

I am Ok with it:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  -Joel


>   /*
>    * Don't bother bypassing ->cblist if the call_rcu() rate is low.

