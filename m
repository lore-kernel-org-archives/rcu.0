Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EFAC433EF
	for <rcu@archiver.kernel.org>; Tue, 12 Jul 2022 21:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiGLVNK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGLVNJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jul 2022 17:13:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9A33E11
        for <rcu@vger.kernel.org>; Tue, 12 Jul 2022 14:13:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p14so3497596qvo.9
        for <rcu@vger.kernel.org>; Tue, 12 Jul 2022 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kZcVDwWPHTQfTjMoqKy5WY6hg7zcTdUaNPrz0DE0+wg=;
        b=mFt3Kqx+cl8tHXR1iv5wb2gIO7oc0ywY85DklmItz6he6SNAyGvByShJFVqgZUcyhS
         Mze5ut9JTI8cdXILTIv3TO4AL45F9j1++OpBThYUpaj1Qd8S0lc766iwHHvHNtEaas/t
         12zSUlBTS6IjL3TFsfc8sySjc8Rp3I8DmGYPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kZcVDwWPHTQfTjMoqKy5WY6hg7zcTdUaNPrz0DE0+wg=;
        b=MpTElJ6AoC6QZgVg9N56MM38fQ2j+WgGQSjaKAek6mq44cKFJ/tdc5dTZihT2b3p51
         rL34RX3mQPiEws1MPvHwSFqq5BaT9pFjBeHRbzfJVnvcpzHXUi15rs4U70hUcV7fMKOQ
         hVfPWb/W4uqu8x//tr/Wetu8Z3Oo7SgVfi+f4jcxkcTbCvohZxoxi8onNvefDu5utgVj
         HAhQn7gCYrBEC6HjV8OxdErlfqCSbSi+k5EnH6iPUYDvMLncqrsXLs1tVgZ7r5e/XEw9
         Ysc3TLShtSZ9uSvMytFPGEVn0pLC9WfhJ1yLz4Q0Y8QHFhTbC8cPAkWBaUm6BgO0reVc
         C4Wg==
X-Gm-Message-State: AJIora9ZL8yXHDroY460dRN8C7krRpvnn8b7JbrTT4ZoKYdbUnxHUOY5
        a916ObiCY6bBGFd1Ai7cpvmWow==
X-Google-Smtp-Source: AGRyM1tTu6pfLmvZ/icZP3G7UAhhSDtYABLXSGk2pLXY3sAjaJBFm11q4T3wSwvQfCIFd7SZn3jUcg==
X-Received: by 2002:a05:6214:1cc7:b0:470:5371:26ff with SMTP id g7-20020a0562141cc700b00470537126ffmr19292095qvd.9.1657660387207;
        Tue, 12 Jul 2022 14:13:07 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm11062857qko.127.2022.07.12.14.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:13:06 -0700 (PDT)
Message-ID: <8441c152-2953-3cb1-c585-b3b0d48a363f@joelfernandes.org>
Date:   Tue, 12 Jul 2022 17:10:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yso4690g+lI/8eJS@google.com>
 <20220710160330.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <aef0f8a6-cde6-18f3-16ab-7e07a4413f31@joelfernandes.org>
 <20220712210406.GF1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220712210406.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/12/2022 5:04 PM, Paul E. McKenney wrote:
> On Tue, Jul 12, 2022 at 04:53:48PM -0400, Joel Fernandes wrote:
>>
>> On 7/10/2022 12:03 PM, Paul E. McKenney wrote:
>> [..]
>>>>>> +	// Note that if the bypass list has lazy CBs, and the main list is
>>>>>> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
>>>>>> +	// the lazy CBs to the main list as well. That's the right thing to do,
>>>>>> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
>>>>>> +	// one, we can just reuse that GP for the already queued-up lazy ones.
>>>>>> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
>>>>>> +	    (lazy && n_lazy_cbs >= qhimark)) {
>>>>>>  		rcu_nocb_lock(rdp);
>>>>>>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>>>>  		if (*was_alldone)
>>>>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>>> -					    TPS("FirstQ"));
>>>>>> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
>>>>>> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
>>>>>> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
>>>>>
>>>>> The "false" here instead of "lazy" is because the caller is to do the
>>>>> enqueuing, correct?
>>>>
>>>> There is no difference between using false or lazy here, because the bypass
>>>> flush is not also enqueuing the lazy callback, right?
>>>>
>>>> We can also pass lazy instead of false if that's less confusing.
>>>>
>>>> Or maybe I missed the issue you're raising?
>>>
>>> I am mostly checking up on your intended meaning of "lazy" in various
>>> contexts.  It could mean only that the caller requested laziness, or in
>>> some cases it could mean that the callback actually will be lazy.
>>>
>>> I can rationalize the "false" above as a "don't care" in this case
>>> because (as you say) there is not callback.  In which case this code
>>> is OK as is, as long as the header comment for rcu_nocb_flush_bypass()
>>> clearly states that this parameter has meaning only when there really
>>> is a callback being queued.
>>
>> I decided to change this and the below to "lazy" variable instead of
>> true/false, as the code is cleaner and less confusing IMO. It makes
>> sense to me and in my testing it works fine. Hope that's Ok with you.
> 
> Sounds plausible.
> 
>> About changing the lazy length count to a flag, one drawback of doing
>> that is, say if there are some non-lazy CBs in the bypass list, then the
>> lazy shrinker will end up reporting an inaccurate count. Also
>> considering that it might be harder to add the count back later say if
>> we need it for tracing, I would say lets leave it as is. I will keep the
>> counter for v3 and we can discuss. Does that sound good to you?
> 
> You lost me on this one.  If there are any non-lazy callbacks, the whole
> bypass list is already being treated as non-lazy, right?  If so, then
> the lazy shrinker should report the full count if all callbacks are lazy,
> and should report none otherwise.  Or am I missing something here?
> 

That's one way to interpret it, another way is say there were a 1000
lazy CBs, and now 1 non-lazy came in. The shrinker could report the lazy
count as 0 per your interpretation. Yes its true they will get flushed
out in the next jiffie, but for that time instant, the number of lazy
CBs in the list is not zero! :) Yeah OK its a weak argument, still an
argument! ;-)

In any case, we saw the need for the length of the segcb lists to figure
out things via tracing, so I suspect we may need this in the future as
well, its a small cost so I would rather keep it if that's Ok with you! :)

Thanks,

- Joel

