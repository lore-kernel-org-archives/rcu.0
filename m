Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F744ECAAD3
	for <rcu@archiver.kernel.org>; Mon,  5 Sep 2022 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiIEUUK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIEUUJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Sep 2022 16:20:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE88011155
        for <rcu@vger.kernel.org>; Mon,  5 Sep 2022 13:20:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id c6so4631198qvn.6
        for <rcu@vger.kernel.org>; Mon, 05 Sep 2022 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A7rOAmNlXCdkcDQTJzD9muqEqItMweVqNhp8pSdMDDE=;
        b=ZLJtjk+519vUT/+rOJG0alJPgD9zGPCZtcZ96i73GiPxCIpSFDcIv58/jVr/K3OpT7
         gpnutAgfqgOqB8d8WQFSmGQws5nOaGehcPqm7EQ9bfKHkrz7DIVU6vQJ1cfF3LnNJ2Fv
         HZGS2tX8ZjopKaGPLJ784jzcP6pjaxgWeQPw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A7rOAmNlXCdkcDQTJzD9muqEqItMweVqNhp8pSdMDDE=;
        b=bHmKD2uTN6UEm/P8v+6+J+k43keMZOspLS4Ho8kRaQ/6EidlUbUHDD8kN6N6H0Ig7D
         y2z+aZLTHkqq6gY4PuM9Bpd7ITqzylmAp0iOkzflNeiXDxLl6H+qfpHNZ7yRzPWSLfIr
         1f36K/Z6+gxRhlFTCpIWR47R+XGQsjdaJXQ2rJoazKy8DhwjrBIdVKcZtY48/Z8jGW5T
         6pRN+XufOIcet6+1na/3/pjt5XiMqbhC2F0MiRKDGebTSf3oAsv5DVTfWtBjGAIycT1c
         h83yM6rWEp863E3i83SOtPbt5Y+loAcj5UPTX9dmsihIwIebEUDChERs/+EOsQKRgpUa
         5QOg==
X-Gm-Message-State: ACgBeo1joT8sEvkWm9ulGnl5PB97fOQcjPzotLz6u/I5tPRNehrsaogd
        DVeArDqeDjIp8Um9OWMtrMUP9g==
X-Google-Smtp-Source: AA6agR6UBa+GT8cbSN0/hcSYNvBCBXPm20T2wL5jgK/TjtWBrQcFkAL4gBwTvYBpTYs0dTJRLnjmtw==
X-Received: by 2002:ad4:5d6c:0:b0:4aa:9dd7:4e0b with SMTP id fn12-20020ad45d6c000000b004aa9dd74e0bmr698161qvb.92.1662409206678;
        Mon, 05 Sep 2022 13:20:06 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006b5e50057basm9212430qko.95.2022.09.05.13.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 13:20:05 -0700 (PDT)
Message-ID: <e188418a-67a3-d0d4-8bf1-b6ad1e55fd6e@joelfernandes.org>
Date:   Mon, 5 Sep 2022 16:20:04 -0400
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
 <20220902152132.GA115525@lothringen> <YxPOfVMzRWEa7xqf@google.com>
 <20220904210133.GA149888@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220904210133.GA149888@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic,

On 9/4/2022 5:01 PM, Frederic Weisbecker wrote:
> On Sat, Sep 03, 2022 at 10:00:29PM +0000, Joel Fernandes wrote:
>> On Fri, Sep 02, 2022 at 05:21:32PM +0200, Frederic Weisbecker wrote:
>> +
>> +	raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
> 
> This is locking during the whole group iteration potentially contending call_rcu(),
> idle loop, resume to userspace on all rdp in the group...
> 
> How about not overwriting timers instead and only set the RCU_NOCB_WAKE_LAZY
> timer when it is previously in RCU_NOCB_WAKE_NOT state? After all if the timer is armed,
> it's because we have regular callbacks queued and thus we don't need to wait
> before processing the lazy callbacks since we are going to start a grace period
> anyway.
> 
> Thanks.

I like your idea better. I think it will work well to resolve the race you
described.

Thanks!

 - Joel


> 
> 
>>  	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
>>  		bool needwake_state = false;
>>  		bool flush_bypass = false;
>> @@ -855,14 +870,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>>  		// If bypass list only has lazy CBs. Add a deferred
>>  		// lazy wake up.
>>  		if (lazy && !bypass) {
>> -			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
>> +			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_LAZY,
>>  					TPS("WakeLazyIsDeferred"));
>>  		// Otherwise add a deferred bypass wake up.
>>  		} else if (bypass) {
>> -			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
>> +			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_BYPASS,
>>  					TPS("WakeBypassIsDeferred"));
>>  		}
>>  	}
>> +	raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
>>  
>>  	if (rcu_nocb_poll) {
>>  		/* Polling, so trace if first poll in the series. */
>> -- 
>> 2.37.2.789.g6183377224-goog
>>
