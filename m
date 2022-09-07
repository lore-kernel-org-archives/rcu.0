Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E96FECAAD5
	for <rcu@archiver.kernel.org>; Wed,  7 Sep 2022 02:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIGC4G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGC4E (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 22:56:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260E7F09B
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 19:56:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b9so9629241qka.2
        for <rcu@vger.kernel.org>; Tue, 06 Sep 2022 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8Hov7IcVx/B7b9bwAwFPiaMdYKRwrKvRA1PUcIT81uA=;
        b=RiyJMPZkSlURBfVjeX9ou+JOhz7b+gVRNvFHKxnqFXJGbfBdLM1gPG+1sC53OmGACI
         3a24ZCcjyB/r7ZRtljaAXKHJpWsMR7Dhfj5KJd2KOLq1a2os+IgmmpG7QmTAdgkUeOvn
         1ADu6hFSFGl2czVX+GFso+EjyS+mYRH36JjIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8Hov7IcVx/B7b9bwAwFPiaMdYKRwrKvRA1PUcIT81uA=;
        b=vGYT5ymKmIeUbjlAP8xVAqE87fFRWHJYI00VGdBorZHIdBXoQsXPpdnHKbQOi4/P7t
         93lfGRL2HzQa4kCKX95r7scVlGLqhr8VualX+2KVv8LS2znNrnhzKwmgu3sxzxOfc2RE
         hKqsNmDgaHXl03uA9S2LRd3odVaP7va+RleNENXpRP19mZq93HP0Lz0Lro5uNGYk7LbP
         txJ9pwogWJXp1fo6xXVxEl0O7OZ7nvk0XlIaX2nJkWx4aNQVDyHSz08/X9W1Q6NzAAp2
         YnJ1BQDy4BiVTL2BKeDJeqFWCFoXYVX12nvQWsFyBIx3DSDf0xo5NaO73N7l7vzJkgxl
         1SpQ==
X-Gm-Message-State: ACgBeo276EyNiSw38aSW6Q24/CJRGMoNsYyxCnUkkClDZcQgBC6wDiu5
        L/kZAjfTODNGujRSveroG0gavXT1KVeg0A==
X-Google-Smtp-Source: AA6agR7P6x0pjzyF0xSF4UgrTmPl1Pp548QPKGMoQBamMrZIyKN/mO3jw8B26rBSF7wbRHOGYDF7yA==
X-Received: by 2002:a05:620a:1590:b0:6be:6c26:469b with SMTP id d16-20020a05620a159000b006be6c26469bmr1294067qkk.415.1662519362670;
        Tue, 06 Sep 2022 19:56:02 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b006bbc3724affsm14090000qkp.45.2022.09.06.19.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:56:02 -0700 (PDT)
Message-ID: <8812ea75-ef14-0d5d-19d8-bda70394b41a@joelfernandes.org>
Date:   Tue, 6 Sep 2022 22:56:01 -0400
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
 <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
 <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
 <4f6061f0-0de7-2916-dc6e-9f5af9b944c0@joelfernandes.org>
 <20220906191110.GA187950@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220906191110.GA187950@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/6/2022 3:11 PM, Frederic Weisbecker wrote:
> On Tue, Sep 06, 2022 at 12:43:52PM -0400, Joel Fernandes wrote:
>> On 9/6/2022 12:38 PM, Joel Fernandes wrote:
>> Ah, now I know why I got confused. I *used* to flush the bypass list before when
>> !lazy CBs showed up. Paul suggested this is overkill. In this old overkill
>> method, I was missing a wake up which was likely causing the boot regression.
>> Forcing a wake up fixed that. Now in v5 I make it such that I don't do the flush
>> on a !lazy rate-limit.
>>
>> I am sorry for the confusion. Either way, in my defense this is just an extra
>> bit of code that I have to delete. This code is hard. I have mostly relied on a
>> test-driven development. But now thanks to this review and I am learning the
>> code more and more...
> 
> Yeah this code is hard.
> 
> Especially as it's possible to flush from both sides and queue the timer
> from both sides. And both sides read the bypass/lazy counter locklessly.
> But only call_rcu_*() can queue/increase the bypass size whereas only
> nocb_gp_wait() can cancel the timer. Phew!
> 

Haha, Indeed ;-)

> Among the many possible dances between rcu_nocb_try_bypass()
> and nocb_gp_wait(), I haven't found a way yet for the timer to be
> set to LAZY when it should be BYPASS (or other kind of accident such
> as an ignored callback).
> In the worst case we may arm an earlier timer than necessary
> (RCU_NOCB_WAKE_BYPASS instead of RCU_NOCB_WAKE_LAZY for example).
> 
> Famous last words...

Agreed.

On the issue of regressions with non-lazy things being treated as lazy, I was
thinking of adding a bounded-time-check to:

[PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and invocation.

Where, if a non-lazy CB takes an abnormally long time to execute (say it was
subject to a race-condition), it would splat. This can be done because I am
tracking the queue-time in the rcu_head in that patch.

On another note, boot time regressions show up pretty quickly (at least on
ChromeOS) when non-lazy things become lazy and so far with the latest code it
has fortunately been pretty well behaved.

Thanks,

 - Joel
