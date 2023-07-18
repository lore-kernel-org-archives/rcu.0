Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DFEB64DA
	for <rcu@archiver.kernel.org>; Tue, 18 Jul 2023 12:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGRMwf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Jul 2023 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjGRMwe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Jul 2023 08:52:34 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47421701
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 05:52:32 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63770af327fso39516566d6.2
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689684752; x=1692276752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7mBVgIO2/qifoKJSIq5gF8W+IU3YGZfoFF1ujN7rTM=;
        b=K4el8zaF7GsWp0e/0K51xh7dyYz33FPapKxS1UckiNXGuFtdTwfsQzoMnWpNprO9aI
         m9+4M+ky7KirepVAMx7e4j2URNiQxFnPT4qkv6kWl909NeuzSj7V04KDrwwXvWgMTDir
         YezkZuAm9AsXuP/2GigubezbzwdlMquPSHkKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684752; x=1692276752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7mBVgIO2/qifoKJSIq5gF8W+IU3YGZfoFF1ujN7rTM=;
        b=FAHZVINmgFmOKp1aV0xuUmxosm70uynd9D92R8Mhtr20iuNG3sxotD6u5f3nBvRdu0
         eABSEoTvlXh9YW9Ouv1+tFn1mBASFTGjIhFViJKbFlwpp8LMjLl5Pwy/EIQG+XI9zJ/8
         XtC77zXIRFxVuTdsXMwmwjcTClvYbXhJjCfAKkzrIzVGZWxXJYR1pivJAUftM6WQscDj
         GkZP8X5JXPz04m5gKLjRJzzgfmDbq+JyX1roBWLD//bTFrJr8wgo+CAxaOKmKcvuOKA3
         RtcNg+0WJ+YpMuMGt1hz4loSQFt2QCWoXuPR4kEhJeYHzO7YtuRPXkYsA82Nmd1hwH2T
         L0fA==
X-Gm-Message-State: ABy/qLag2yAM9dZz0oI66Yd7EtlzjAh/JJqR6vgyloO+POomhdwbZeDM
        Hs8iuiZmibuoUbO4diCeSBYFig==
X-Google-Smtp-Source: APBJJlEkZiRXxB4ZPx8mBFrErvCSAqCeax0elCpY/p8JEmV9/fR3JLF1NdI7PqcOR3w9eHK329oLAQ==
X-Received: by 2002:a0c:e0cb:0:b0:635:dcef:b5b7 with SMTP id x11-20020a0ce0cb000000b00635dcefb5b7mr15007890qvk.56.1689684751947;
        Tue, 18 Jul 2023 05:52:31 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id y6-20020a37e306000000b00767cfac77c3sm543674qki.134.2023.07.18.05.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:52:31 -0700 (PDT)
Message-ID: <a11d5ce7-5ee3-fbf7-9adb-4cfc805c6bb7@joelfernandes.org>
Date:   Tue, 18 Jul 2023 08:52:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 2/6] rcu: Clarify rcu_is_watching() kernel-doc comment
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Masami Hiramatsu <mhiramat@kernel.org>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-2-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-2-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 7/17/23 14:03, Paul E. McKenney wrote:
> Make it clear that this function always returns either true or false
> without other planned failure modes.
> 
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1449cb69a0e0..fae9b4e29c93 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -679,10 +679,14 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>   /**
>    * rcu_is_watching - see if RCU thinks that the current CPU is not idle

Would it be better to modify the 'not idle' to 'not idle from an RCU viewpoint'? 
This matches the comments in ct_nmi_enter() as well.

>    *
> - * Return true if RCU is watching the running CPU, which means that this
> - * CPU can safely enter RCU read-side critical sections.  In other words,
> - * if the current CPU is not in its idle loop or is in an interrupt or
> - * NMI handler, return true.
> + * Return @true if RCU is watching the running CPU and @false otherwise.
> + * An @true return means that this CPU can safely enter RCU read-side
> + * critical sections.
> + *
> + * More specifically, if the current CPU is not deep within its idle
> + * loop, return @true.  Note that rcu_is_watching() will return @true if
> + * invoked from an interrupt or NMI handler, even if that interrupt or
> + * NMI interrupted the CPU while it was deep within its idle loop.

But it is more than the idle loop, for ex. NOHZ_FULL CPUs with single task 
running could be idle from RCU's viewpoint? Could that be clarified more?

thanks,

  - Joel


>    *
>    * Make notrace because it can be called by the internal functions of
>    * ftrace, and making this notrace removes unnecessary recursion calls.

