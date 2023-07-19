Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E6EB64DC
	for <rcu@archiver.kernel.org>; Wed, 19 Jul 2023 01:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGSB4m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Jul 2023 21:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSB4l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Jul 2023 21:56:41 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1615FC
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 18:56:40 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635f293884cso34382756d6.3
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689731800; x=1692323800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7jJDX3yxvDMQd6iEE6RHLp8fmG3wEfDy9I1U6CxUio=;
        b=vU0Y3UXNsdXh9331z6PJ5FubCCIxosM4AbsDKt83Jrx0hukxLxRqRlg3adbvZOe8MQ
         hg9CLm12fD2AewENYTdr5R9SF928i5vAT4hDdukprSqpRg1FZctFfjN+GoSkGbz85ny7
         JjqjIFEFb8SCdBRT/4F/+PqkpalMcafFL4VwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689731800; x=1692323800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7jJDX3yxvDMQd6iEE6RHLp8fmG3wEfDy9I1U6CxUio=;
        b=l1xbAXhUZMaI5qNHdAmKh3yfrliH+rgcWQpQxidJqeLPxS6SZ65WxapqMpyF8NZ0gE
         Et3Eb7QVXOUALqXmJLNRSMn+Svx8xA/OjanZisDHWF0P9kUyvWb62u5TlziG/TPJXp5R
         HFzHSg7ce+pVr4NdrcR7Y7wJess1L1pAEW05rEmZGJ6nUN6OmrcaOP60zHpuiJK5PW9W
         UTHQZontOLcX+RtYAA449KUIshpfaDq7tA82S1HdAeGovWP539LIGYdZ9qXM0Jsk7Eje
         XwyWpjByt72hqG9xehEkSjnvMP/d6mtYhjkmMKKnVW01nfteqT+Tdw9AAzxM1vnMfif6
         FE4Q==
X-Gm-Message-State: ABy/qLYxBZDarm1R2es/r5oxYNuKrakyqxeL3ezWIJ4v/zxiNUeXsU1m
        qpOoRvux3O70vIqVqpGB3ZIvbQ==
X-Google-Smtp-Source: APBJJlHoFi7mAYLuHSzLtQQSIc/av6vC8gV658kDKvuZmgAYr01UC6fhdNHQomOyEyNNl/cC3mjs/g==
X-Received: by 2002:a0c:f885:0:b0:635:e2c1:99f3 with SMTP id u5-20020a0cf885000000b00635e2c199f3mr3431099qvn.32.1689731799880;
        Tue, 18 Jul 2023 18:56:39 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id p3-20020a0c9a03000000b006263a9e7c63sm1118690qvd.104.2023.07.18.18.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 18:56:39 -0700 (PDT)
Message-ID: <998db46d-9c76-a3c5-e7c5-b7adf1770352@joelfernandes.org>
Date:   Tue, 18 Jul 2023 21:56:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH rcu 2/6] rcu: Clarify rcu_is_watching() kernel-doc comment
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-2-paulmck@kernel.org>
 <a11d5ce7-5ee3-fbf7-9adb-4cfc805c6bb7@joelfernandes.org>
 <2e404769-67af-4240-b572-bd0808503486@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <2e404769-67af-4240-b572-bd0808503486@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 7/18/23 14:12, Paul E. McKenney wrote:
> On Tue, Jul 18, 2023 at 08:52:30AM -0400, Joel Fernandes wrote:
>> Hi Paul,
>>
>> On 7/17/23 14:03, Paul E. McKenney wrote:
>>> Make it clear that this function always returns either true or false
>>> without other planned failure modes.
>>>
>>> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>    kernel/rcu/tree.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 1449cb69a0e0..fae9b4e29c93 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -679,10 +679,14 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>>>    /**
>>>     * rcu_is_watching - see if RCU thinks that the current CPU is not idle
>>
>> Would it be better to modify the 'not idle' to 'not idle from an RCU
>> viewpoint'? This matches the comments in ct_nmi_enter() as well.
> 
> We have the "if RCU thinks that" earlier.
> 
> But maybe something like this?
> 
>   * rcu_is_watching - RCU read-side critical sections permitted on current CPU?
> 

Yes, that's better.

>>>     *
>>> - * Return true if RCU is watching the running CPU, which means that this
>>> - * CPU can safely enter RCU read-side critical sections.  In other words,
>>> - * if the current CPU is not in its idle loop or is in an interrupt or
>>> - * NMI handler, return true.
>>> + * Return @true if RCU is watching the running CPU and @false otherwise.
>>> + * An @true return means that this CPU can safely enter RCU read-side
>>> + * critical sections.
>>> + *
>>> + * More specifically, if the current CPU is not deep within its idle
>>> + * loop, return @true.  Note that rcu_is_watching() will return @true if
>>> + * invoked from an interrupt or NMI handler, even if that interrupt or
>>> + * NMI interrupted the CPU while it was deep within its idle loop.
>>
>> But it is more than the idle loop, for ex. NOHZ_FULL CPUs with single task
>> running could be idle from RCU's viewpoint? Could that be clarified more?
> 
> Perhaps something like this?
> 
>   * Although calls to rcu_is_watching() from most parts of the kernel
>   * will return @true, there are important exceptions.  For example, if the
>   * current CPU is deep within its idle loop, in kernel entry/exit code,
>   * or offline, rcu_is_watching() will return @false.
> 
> (Where nohz_full CPUs are covered by kernel entry/exit code.)

To me, "kernel exit" does not immediately make the nohz_full CPU case 
obvious. But yes, your suggestion is an improvement so we can go with 
that. :)

Also because we agree on the changes, for next revision:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  - Joel

