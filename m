Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40745C61DA4
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 19:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjBWT5K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBWT5J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 14:57:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD959410
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:57:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so471735pjb.1
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSzUOJfdtN9HqYc/iUHo6JBED4EqtZPD2VYPVWa2ehk=;
        b=CqObwow7N9ynxd+bV1Rl60ADS9LJwNa+GAXvOy3aLHz8vN/Hn53Bk9Y+FIrZWunnX4
         gUmzPG1mo011y0mLLOqQFB0MRKxk3wsadmy3Y84WunvMV2QVgviVUml6OZlTjCXnpIuk
         AD3OYzXepLMhH/lxtqkQyqzcoA6y8I4Ahf54nx9OSl7vaBmrv372UeVDR883nuMDbRHx
         3On44dy6n3wV5sje1m1Z0PSvS9x6r4tQHB+bnICcbrdoXAKTA9tiJ5RD45xR9yrDT/uV
         2/eBv85oREvpJDOSLpq7/wu37KaBbk+GwSRGj9Z6FJsSt57ymj1OvJRsoO5I/jVk0rsi
         qXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSzUOJfdtN9HqYc/iUHo6JBED4EqtZPD2VYPVWa2ehk=;
        b=ik17RUHbhWa0KJ4DkSyJfq7E0PINSrNnzMTfbryWfQ1KCQQZw3mGJz+51+hrRLivcn
         5prOr4AAs5xtkmwqxni/xihC8wHCMavJZgWOQSSkNU5D6XAIQIPZWfszf0HfncWR+7zZ
         n/P8eqNQOe3lfdbHOLi0xXvol9ibPPxoU/oL+WZ0EWEjMgwDT1khwqJ3kF3g0Zxlitje
         Pw0183wty41dV99E9jFKH/Y3bKEGGn2Ucw9VKv5BcIWfG0kscT4AhdyYDUTnfXBZp578
         3fTHm7FxBcrgRILSdVfiVhXFrbWyu24QwVNoitXo2rwgp6gK7VOSWCGSfyN1+wbDzQde
         PUwA==
X-Gm-Message-State: AO0yUKVcHwXVGafcqRPxRilQv0cuFcanIHK+wbi2ogJYGQLdYupkKRbJ
        eViUcF9Ond1Yc5/AVUt3c4MMVA==
X-Google-Smtp-Source: AK7set9d41ckYjUJSo//hzWtdXQZ7k7/qNPHIfBDpE4KC2bPtdUuTjzf3Jz4Tid9YndBYm+VHLXKvg==
X-Received: by 2002:a17:90a:f0cd:b0:237:40a5:77cb with SMTP id fa13-20020a17090af0cd00b0023740a577cbmr5897552pjb.1.1677182228038;
        Thu, 23 Feb 2023 11:57:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a6f8400b00232cf6186fdsm86404pjk.30.2023.02.23.11.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:57:07 -0800 (PST)
Message-ID: <a25bcbff-b759-7814-1454-9edfe1df7314@kernel.dk>
Date:   Thu, 23 Feb 2023 12:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <84fd00b0-aa87-e4b7-e0a4-d57b720216c0@kernel.dk>
 <20230223183124.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <ae3a6434-1b3a-b848-c8f9-bf6b3d0521e6@kernel.dk>
 <20230223194708.GI2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230223194708.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2/23/23 12:47?PM, Paul E. McKenney wrote:
>>> Hey, the combined one/two-argument form seemed like a good idea at
>>> the time!  ;-)
>>
>> Hah, not sure what you were smoking back then!
> 
> If I remember, would you like me to send you some?  ;-)

Definitely, might improve my reviews :-)

-- 
Jens Axboe

