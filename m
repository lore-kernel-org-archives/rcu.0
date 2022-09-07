Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72E3C54EE9
	for <rcu@archiver.kernel.org>; Wed,  7 Sep 2022 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIGOBX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIGOBV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 7 Sep 2022 10:01:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020D6CF4C
        for <rcu@vger.kernel.org>; Wed,  7 Sep 2022 07:01:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m5so10515837qkk.1
        for <rcu@vger.kernel.org>; Wed, 07 Sep 2022 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/s29LV2sR+vq6yN67Lm8Tg/CBgP8Mafr42Z5nWlRis4=;
        b=a1EH48PXO2HWnFkMr2lckeI3ZeIMzujU9/AVEutHPRJbwWB4FXTYrKVICugf0zgD0l
         C9ijJ0XmodomYxoNRd906F8T7JlQv9gPAn1QGXrESsy99SvMcFO0ta/O0ftnRkTuypMa
         r7vpYltcScc+dBchRLYT/A/bAm/k53n+hTneU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/s29LV2sR+vq6yN67Lm8Tg/CBgP8Mafr42Z5nWlRis4=;
        b=5M3wuNj1CRctm5vQadbMWBwmMmF4p5v6G3t0b5yTr6jP2o70+EqX8XCZrs3KplHeKT
         WFW4nqmsuOYF+LKzs8mppGnsXGnHwRWONIaMIUAgw1zDavzCRedfeb9z2II5Q/FMAWI1
         4HmrW1tLY+kHHH6BVrVRbpoS1exd96ZC6e81x82iS3kydSnUA0E7FM6QE/yCr6Q7MPlC
         LxyLW8Xtc6szVFGKsUsluSqWIDKDUj5kqPKywpRTEellPZW429n+iDoHwcM1rvcsZzSs
         /raYoJ1Hsw1a7CBaHkHc5dtvAOBfbDrmG4NZ9mRC9RwCkUdqXa4Y/Wwr7L2Z7/yPv6tq
         cWTQ==
X-Gm-Message-State: ACgBeo1XTlczhJEbxq3i3d2mCtjPLXpd73ff8wWGQDa3O24rJJOLa29y
        GY2XRHw/f8gajjxNlyiLR9K+vA==
X-Google-Smtp-Source: AA6agR7Vf1kI9nc64NEmeizsB7LyogdUqy4T6UbinGSXFJslNqEA7lhb3SWeJvZiL15yTsHtKnb1hw==
X-Received: by 2002:a37:4553:0:b0:6be:6c1d:92ff with SMTP id s80-20020a374553000000b006be6c1d92ffmr2819196qka.151.1662559279446;
        Wed, 07 Sep 2022 07:01:19 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id 6-20020a370c06000000b006bbbd4ce6e1sm13319885qkm.35.2022.09.07.07.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:01:18 -0700 (PDT)
Message-ID: <b106edc3-2557-0669-86bf-10c08739a86a@joelfernandes.org>
Date:   Wed, 7 Sep 2022 10:01:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
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
 <20220907100349.GB194889@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220907100349.GB194889@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/7/2022 6:03 AM, Frederic Weisbecker wrote:
> On Tue, Sep 06, 2022 at 12:15:19PM -0400, Joel Fernandes wrote:
>>>> +
>>>> +	// We had CBs in the bypass list before. There is nothing else to do if:
>>>> +	// There were only non-lazy CBs before, in this case, the bypass timer
>>>
>>> Kind of misleading. I would replace "There were only non-lazy CBs before" with
>>> "There was at least one non-lazy CBs before".
>>
>> I really mean "There were only non-lazy CBs ever queued in the bypass list
>> before". That's the bypass_is_lazy variable. So I did not fully understand your
>> suggested comment change.
> 
> I may well be missing something but to me it seems that:
> 
> bypass_is_lazy = all bypass callbacks are lazy
> !bypass_is_lazy = there is at least one non-lazy bypass callback
> 
> And indeed as long as there is at least one non-lazy callback, we don't
> want to rely on the LAZY timer.
> 
> Am I overlooking something?

No you are not over looking and you are very right that I may need to change the
comment.

To clarify my intent, a wake up or timer adjustment needs to be done only if:

1. Bypass list was fully empty before (this is the first bypass list entry).

Or both the below conditions are met:

1. Bypass list had only lazy CBs before.

2. The new CB is non-lazy.

Instead of saying, "nothing needs to be done if...", I will change it to:

        // A wake up of the grace period kthread or timer adjustment needs to
        // be done only if:
        // 1. Bypass list was empty before (this is the first bypass queue).
        //      Or, both the below conditions are met:
        // 1. Bypass list had only lazy CBs before.
        // 2. The new CB is non-lazy.

That sounds less confusing...

Or, I can just make the edit you suggested... let me know either way!

Thanks!

 - Joel
