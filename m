Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DAAC433EF
	for <rcu@archiver.kernel.org>; Tue, 12 Jul 2022 20:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiGLU5J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiGLUzn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jul 2022 16:55:43 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48991D0863
        for <rcu@vger.kernel.org>; Tue, 12 Jul 2022 13:53:52 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kh20so3462624qvb.5
        for <rcu@vger.kernel.org>; Tue, 12 Jul 2022 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=63Rqkci8efDQK/XrqXZEbkqW7bm87nTCnyVteDzNOV8=;
        b=jQBo1lbmNVuSSwPy2BFySA96dRli1/csLDrvldYgiZ7EgcEurztDpLm2LdTghaxmOD
         4375O0MLeoGuLsIOH0MGRuYP5l7/2kGFleE/FrL5pwMHR0WPr4jfChcD7cN4N5vhCEsx
         VwHr+VUoPnTf0sqVqZDx5GV2nJo/N3ML00mZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=63Rqkci8efDQK/XrqXZEbkqW7bm87nTCnyVteDzNOV8=;
        b=7Rt+jEGBl+xuUM8w77FlD5FqW/BRbv2iGqLEfHKuejxcNJ52xTWZRpgxF8LWkYlMwS
         GQhsVohEUX/zwRec8zCPVtPFoTtoEdG3zm9+NdE6ue8R42AnpFbf0UhtNEzganyweDOw
         bDJNWO3aZas63/1CENUZdIWytzh3ctllBHoGvbp6hSl5Ibk9RtGwuLv8PutkQQcMiwwD
         GmW/vbhyWTYLFrxWkFgyIWsVEWdnLQF7br1c77NIBbGY6gwym76G+1pURcdWrrrVcj/z
         4Yuc0a6eJG7ajEwhYxSiJ5WoEfA1xMPafoxqKLG5oNKy6P75Z7BE4+sKISiQ7PAnFTl8
         JBbA==
X-Gm-Message-State: AJIora/1+muc00S45+hdy28p3JX/uoHZeGNOJA00lS3lzigVuZFRvXub
        GUG88b5i5Uyr950ISTRVcR0q2YHH6J7r8n6i
X-Google-Smtp-Source: AGRyM1u33vMmFolX24m3QiAJ/ZX3+PbcxlksKB0OyFeeL0hx6xU8LSvtGhR6kyzPgWBpeW6h2XuPHA==
X-Received: by 2002:a05:6214:544a:b0:473:5ada:7360 with SMTP id kz10-20020a056214544a00b004735ada7360mr23002qvb.103.1657659230924;
        Tue, 12 Jul 2022 13:53:50 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id s2-20020ac85282000000b0031ec2a48050sm1479106qtn.34.2022.07.12.13.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:53:50 -0700 (PDT)
Message-ID: <aef0f8a6-cde6-18f3-16ab-7e07a4413f31@joelfernandes.org>
Date:   Tue, 12 Jul 2022 16:53:48 -0400
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
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220710160330.GI1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On 7/10/2022 12:03 PM, Paul E. McKenney wrote:
[..]
>>>> +	// Note that if the bypass list has lazy CBs, and the main list is
>>>> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
>>>> +	// the lazy CBs to the main list as well. That's the right thing to do,
>>>> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
>>>> +	// one, we can just reuse that GP for the already queued-up lazy ones.
>>>> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
>>>> +	    (lazy && n_lazy_cbs >= qhimark)) {
>>>>  		rcu_nocb_lock(rdp);
>>>>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>>  		if (*was_alldone)
>>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>> -					    TPS("FirstQ"));
>>>> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
>>>> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
>>>> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
>>>
>>> The "false" here instead of "lazy" is because the caller is to do the
>>> enqueuing, correct?
>>
>> There is no difference between using false or lazy here, because the bypass
>> flush is not also enqueuing the lazy callback, right?
>>
>> We can also pass lazy instead of false if that's less confusing.
>>
>> Or maybe I missed the issue you're raising?
> 
> I am mostly checking up on your intended meaning of "lazy" in various
> contexts.  It could mean only that the caller requested laziness, or in
> some cases it could mean that the callback actually will be lazy.
> 
> I can rationalize the "false" above as a "don't care" in this case
> because (as you say) there is not callback.  In which case this code
> is OK as is, as long as the header comment for rcu_nocb_flush_bypass()
> clearly states that this parameter has meaning only when there really
> is a callback being queued.

I decided to change this and the below to "lazy" variable instead of
true/false, as the code is cleaner and less confusing IMO. It makes
sense to me and in my testing it works fine. Hope that's Ok with you.

About changing the lazy length count to a flag, one drawback of doing
that is, say if there are some non-lazy CBs in the bypass list, then the
lazy shrinker will end up reporting an inaccurate count. Also
considering that it might be harder to add the count back later say if
we need it for tracing, I would say lets leave it as is. I will keep the
counter for v3 and we can discuss. Does that sound good to you?

I think some more testing, checkpatch running etc and I should be good
to send v3 :)

Thanks!

 - Joel


> 
>>>>  		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>>>>  		return false; // Caller must enqueue the callback.
>>>>  	}
>>>>  
>>>>  	// If ->nocb_bypass has been used too long or is too full,
>>>>  	// flush ->nocb_bypass to ->cblist.
>>>> -	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
>>>> -	    ncbs >= qhimark) {
>>>> +	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark) {
>>>>  		rcu_nocb_lock(rdp);
>>>> -		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
>>>> +		if (!rcu_nocb_flush_bypass(rdp, rhp, j, true)) {
>>>
>>> But shouldn't this "true" be "lazy"?  I don't see how we are guaranteed
>>> that the callback is in fact lazy at this point in the code.  Also,
>>> there is not yet a guarantee that the caller will do the enqueuing.
>>> So what am I missing?
>>
>> Sorry I screwed this part up. I think I meant 'false' here, if the list grew
>> too big- then I think I would prefer if the new lazy CB instead is treated as
>> non-lazy. But if that's too confusing, I will just pass 'lazy' instead. What
>> do you think?
> 
> Good point, if we are choosing to override the laziness requested by the
> caller, then it should say "true".  It would be good to have a comment
> saying that is what we are doing, correct?
> 
>> Will reply more to the rest of the comments soon, thanks!
> 
> Sounds good!  (Hey, wouldn't want you to be bored!)
> 
> 							Thanx, Paul
