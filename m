Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6DFC6FA8B
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 16:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiIFQwc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiIFQwG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C652317A
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 09:38:44 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j6so8565162qkl.10
        for <rcu@vger.kernel.org>; Tue, 06 Sep 2022 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1gYTTxjYZerYSduS1CB/y4q52BEAFNoe9EHoCeN+Gps=;
        b=sKLoDSqHRVukiqSqvBEm8ZtabDPv3B2TNNaQp+Tui4BBkDp+THCmdS2aiicF6f+R1q
         4LP/LnvbHexBHpfs7QE6/5diOkoBPst52U5mGeJKsPs7KLV0qVY4EDZBiyH6T382y6VN
         uOQ80DwJe12YW5MEm6Ku9xvRCYXumhwPTf5u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1gYTTxjYZerYSduS1CB/y4q52BEAFNoe9EHoCeN+Gps=;
        b=oKoaFiF86teHfCqW8lWbK5XsG9Abo7QrQ5np0Ix8SKm87lhhzJkSHYDZPJzvl6SWgd
         UyGIYlBqs/tYNw0HHbr4cE7MX9882trUnwmVDQ+etTTO48nnroDhe/idBIqWAoIcLYVL
         OclK+hLH/Gru3QfyS4qcjiz5FyDfVJQT3WhrsE8EZAGSqUmqU/4kWcLgVMOpcJojuvwE
         mWdpw4JJNyRczI8FwQu6dOAoLJTM2a4PlTKMS0zTJ78TzLWuIJiAGYM2zyBjWUrH3gn9
         y0wPwi2fLtcXkyOIXQVKO1SfFBnotrD6oFSuS30jS84KLe+DYPPCcH2ag3CQshc2PBQP
         VQ3Q==
X-Gm-Message-State: ACgBeo2geFPDl4SrQwWziF2jiTUD2yg7uLMr91Vs6zG9Yw4UOgLspl6A
        UVhuw9hCeLF1GaeY6lyvz4anEw==
X-Google-Smtp-Source: AA6agR7K1FmlDGHrYEUX+m2WTgJzp+JYl2gA83FXOFqQEOZXmvhLyZJZsEoL341w/RITZiqG/sAJ6w==
X-Received: by 2002:a05:620a:31a7:b0:6bc:138:2828 with SMTP id bi39-20020a05620a31a700b006bc01382828mr37145148qkb.733.1662482322739;
        Tue, 06 Sep 2022 09:38:42 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id a29-20020ac8611d000000b0033b30e8e7a5sm10147362qtm.58.2022.09.06.09.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:38:42 -0700 (PDT)
Message-ID: <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
Date:   Tue, 6 Sep 2022 12:38:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
 <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
In-Reply-To: <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/6/2022 12:31 PM, Joel Fernandes wrote:
> 
> 
> On 9/6/2022 12:15 PM, Joel Fernandes wrote:
>>>> @@ -461,16 +521,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>>  	// We need to use the bypass.
>>>>  	rcu_nocb_wait_contended(rdp);
>>>>  	rcu_nocb_bypass_lock(rdp);
>>>> +
>>>>  	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>>>>  	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
>>>>  	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
>>>> +		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
>>>> +
>>>>  	if (!ncbs) {
>>>>  		WRITE_ONCE(rdp->nocb_bypass_first, j);
>>>>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
>>>>  	}
>>>> +
>>>>  	rcu_nocb_bypass_unlock(rdp);
>>>>  	smp_mb(); /* Order enqueue before wake. */
>>>> -	if (ncbs) {
>>>> +
>>>> +	// We had CBs in the bypass list before. There is nothing else to do if:
>>>> +	// There were only non-lazy CBs before, in this case, the bypass timer
>>> Kind of misleading. I would replace "There were only non-lazy CBs before" with
>>> "There was at least one non-lazy CBs before".
>> I really mean "There were only non-lazy CBs ever queued in the bypass list
>> before". That's the bypass_is_lazy variable. So I did not fully understand your
>> suggested comment change.
>>
>>>> +	// or GP-thread will handle the CBs including any new lazy ones.
>>>> +	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
>>>> +	// case the old lazy timer would have been setup. When that expires,
>>>> +	// the new lazy one will be handled.
>>>> +	if (ncbs && (!bypass_is_lazy || lazy)) {
>>>>  		local_irq_restore(flags);
>>>>  	} else {
>>>>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
>>>> @@ -479,6 +552,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>  					    TPS("FirstBQwake"));
>>>>  			__call_rcu_nocb_wake(rdp, true, flags);
>>>> +		} else if (bypass_is_lazy && !lazy) {
>>>> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>> +					    TPS("FirstBQwakeLazy2Non"));
>>>> +			__call_rcu_nocb_wake(rdp, true, flags);
>>>
>>> Not sure we need this chunk. Since there are pending callbacks anyway,
>>> nocb_gp_wait() should be handling them and it will set the appropriate
>>> timer on the next loop.
>>
>> We do because those pending callbacks could be because of a bypass list flush
>> and not because there were pending CBs before, right? I do recall missed wake
>> ups of non-lazy CBs, and them having to wait for the full lazy timer duration
>> and slowing down synchronize_rcu() which is on the ChromeOS boot critical path!
>>
> 
> Just to add more details, consider the series of events:
> 
> 1. Only lazy CBs are ever queued. Timer is armed for multiple seconds.
> rcu_segcblist_pend_cbs remains false.
> 
> 2. First non-lazy CB triggers to code that does the bypyass rate-limit thing.
> 
> 3. By pass list is flushed because it is non-lazy CB and we need to start GP
> processing soon.

Correcting the events, #3 does not happen if we got here.

> 
> 4. Due to flush, rcu_segcblist_pend_cbs() is now true.

So rcu_segcblist_pend_cbs() cannot be true.

> 5. We reach this "else if" clause because bypass_is_lazy means only lazy CBs
> were ever buffered. We need to reprogram the timer or do an immediate wake up.
> That's the intention of __call_rcu_nocb_wake().
> 
> I really saw #1 and #2 trigger during boot up itself and cause a multi-second
> boot regression.

So may be this hunk is needed not needed any more and the boot regression is
fine. I can try to drop this hunk and run the tests again...

Thanks!

 - Joel


