Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD33EB64DC
	for <rcu@archiver.kernel.org>; Wed, 19 Jul 2023 01:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjGSBtL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Jul 2023 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBtJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Jul 2023 21:49:09 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7379F1BF3
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 18:49:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635ee3baa14so29248596d6.3
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689731342; x=1692323342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePt0qbb27tTycT4WqVSlGhy/F+k69bMQ3wHHNqGkw8g=;
        b=ftucftlqM1A7m+5a0NUNMyV+yCtx/VHUnCHBo09FAO+BJiokRssGXbLclum0Rb7Vjw
         OF14yQ6yMnk28o83XcoVCyaGy9zhWUkZcamdMCbOWueKnvVfZG7kUvK3/73RvtuxhTEG
         1qErlQtIZtTT2udV1v6oU6Iu+pwKvF9V5ODB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689731342; x=1692323342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePt0qbb27tTycT4WqVSlGhy/F+k69bMQ3wHHNqGkw8g=;
        b=YvvSEQJGmOpYC3jCcpuPleptBfum84WASzIhENIMmGS4f24McaADg7CZusXIp9m5X/
         HVxQO6Gj48PKuYntqw4EOGpDM5HG4NJy9Cfn4fWV/SbWZ4BBHcFISEqedhwVvtb9ny9Y
         Rem0hMhyNhv8+EH9OydebX4DwHHzbxU1chGsK8zXD9BA7ihPZuactmcObVrmo0KxEz8b
         dOryuct75jc2ClKxY+muGa3aNUWH/oumyN3OJ4ljRjrYlPBJ5UZQHBjGXpZTUyJRnPIO
         K9QYzxamC/ehEL/SzCzJVxK2trwLv+O7qN1wAVBPyjgyhi3JGyWQGOcKKAwT9+yn7+tA
         zkgA==
X-Gm-Message-State: ABy/qLZonn8pz9AO90RHMczSNfgk0f5dUvFIYRQw3+V5h7OB4TU5+jRE
        VuUC9NlD54h43xJkSEWAHkWFOw==
X-Google-Smtp-Source: APBJJlEbQus1ueG5nPA4LisVdRCPwwlIEy0GOp7b9nLeIrxcSPFqAoKWGhXBDRtsYYeD/EHzxIsLsw==
X-Received: by 2002:a0c:be88:0:b0:62d:ddeb:3782 with SMTP id n8-20020a0cbe88000000b0062dddeb3782mr13468345qvi.49.1689731342551;
        Tue, 18 Jul 2023 18:49:02 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id t25-20020a0cb399000000b006238f82cde4sm1123436qve.108.2023.07.18.18.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 18:49:00 -0700 (PDT)
Message-ID: <449d0d48-ac98-659b-4d03-e75c318605d4@joelfernandes.org>
Date:   Tue, 18 Jul 2023 21:48:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
Content-Language: en-US
To:     paulmck@kernel.org, Alan Huang <mmpgouride@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
 <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
 <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
 <3f6b04b3-af22-49f0-8d3c-269640f9f762@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <3f6b04b3-af22-49f0-8d3c-269640f9f762@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/18/23 14:32, Paul E. McKenney wrote:
> On Tue, Jul 18, 2023 at 10:48:07PM +0800, Alan Huang wrote:
>>
>>> 2023年7月18日 21:49，Joel Fernandes <joel@joelfernandes.org> 写道：
>>>
>>> On 7/17/23 14:03, Paul E. McKenney wrote:
>>>> From: Alan Huang <mmpgouride@gmail.com>
>>>> When the objects managed by rculist_nulls are allocated with
>>>> SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an object
>>>> even though it is just now being added, which means the modification of
>>>> ->next is visible to readers.  This patch therefore uses WRITE_ONCE()
>>>> for assignments to ->next.
>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> Did we ever conclude that the READ_ONCE() counterparts were not needed? ;-)
>>
>> Read-side is already protected by rcu_dereference_raw() in hlist_nulls_for_each_entry_{rcu, safe}.
> 
> It turns out that different traversal synchronization designs want
> different pointers using WRITE_ONCE().

Thank you Alan and Paul,

Btw, I don't see any users of hlist_nulls_unhashed_lockless(), maybe it 
can be removed?

  - Joel

