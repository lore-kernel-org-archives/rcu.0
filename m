Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C612FC61DA4
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBWThD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjBWThC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 14:37:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6007359E41
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:37:00 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z2so14438703plf.12
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQq/mm4mVMTZxYtA4ktk06ZMrV8tkbfv6EC6oErMWRs=;
        b=yk/31gPQIW8T+JwtNs9NMWW5pAjbGRjZGw4JzJfVBGGg9YdO/8usKXYUnWm9BkUrrk
         7Ul+EqakaIJH31edVRc8mKMcD5WdJZrZLE2JdC62vgdhiOWElxJae/Qtw32Yw/VlT1yd
         QMbxK28NiowSYMQuIGLpYaa0sYwNdyXGZXAp2QXkr+Td9ZVhg2KAF9S2zMYGZzQ8zAtR
         wvLP+jLEYHkk4SIC6RGfvZOZOibsO4TwTOy4CeWxAL9DAFUxV/ClCxVzxoZGxJYHxJ6i
         KWIF+aZD9Hti8gMd57T2Zufn9NPd1b7rsOARyN2UyV81xnkvwPOHQ+O2Cch/WKKP03hB
         7pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQq/mm4mVMTZxYtA4ktk06ZMrV8tkbfv6EC6oErMWRs=;
        b=ydOKVCYnysxFYuFacuBZmdn8Z9V+UlGmLpAdhyjoznUCo39pvBJi8yua5/gBxEHizY
         9TGP66DzrYIc9sfK9bShfPOeuo15y6pWOVthQa86mKgVd/mqPks7zPKPAmzlesN0aJwn
         ucpIbfqWcF77YNzlOU3CPqto7C8ydLZ+JLw5Clc3cYLW7JYG56Ddt45VdbQt7lEpI+B0
         kK6kAL7Pezm/S/92ZC5IzDMuktDP4hw+T+Mu/rEalzVAGMa/cMWBMXfUTAYAGXHlfFSB
         ry7XAzCrmWggPrIV/qJKBZKO/xrY9z0sdF3GOfJQiklGM7Gc5pnerOPGgs+AAECnFRum
         qh5Q==
X-Gm-Message-State: AO0yUKXQ4lqj5v02tGPTfsvmOVrd04e04L1rWPHmv8F7X9kSGfTEdJAU
        7vSyO1D4WOa4eYXJWtyxviOqGg==
X-Google-Smtp-Source: AK7set9NH5+hrOF1a5TsdpFpUrS3bE2ZL0vGh7moKt24R5JglynJw+bnqDgX30BvoT3U7PSauYjLXg==
X-Received: by 2002:a17:902:e80d:b0:19a:a815:2877 with SMTP id u13-20020a170902e80d00b0019aa8152877mr13564702plg.6.1677181019801;
        Thu, 23 Feb 2023 11:36:59 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b00196519d8647sm5041338pln.4.2023.02.23.11.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:36:59 -0800 (PST)
Message-ID: <ae3a6434-1b3a-b848-c8f9-bf6b3d0521e6@kernel.dk>
Date:   Thu, 23 Feb 2023 12:36:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
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
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230223183124.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2/23/23 11:31 AM, Paul E. McKenney wrote:
> On Thu, Feb 23, 2023 at 07:57:13AM -0700, Jens Axboe wrote:
>> On 2/1/23 8:08 AM, Uladzislau Rezki (Sony) wrote:
>>> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
>>> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
>>>
>>> 1.
>>> The problem is that, recently we have run into a precedent when
>>> a user intended to give a second argument to kfree_rcu() API but
>>> forgot to do it in a code so a call became as a single argument
>>> of kfree_rcu() API.
>>>
>>> 2.
>>> Such mistyping can lead to hidden bags where sleeping is forbidden.
>>>
>>> 3.
>>> _mightsleep() prefix gives much more information for which contexts
>>> it can be used for.
>>
>> This patchset seems weird to me. We have a LOT of calls that might
>> sleep, yet we don't suffix them all with _mightsleep(). Why is this
>> any different? Why isn't this just a might_sleep() call in the
>> actual helper, which will suffice for checkers and catch it at
>> runtime as well.
> 
> Fair enough, and the situation that this patchset is addressing is also a
> bit unusual.  This change was requested by Eric Dumazet due to a situation
> where someone forgot the optional second argument to kfree_rcu().  Now,
> you are right that this would be caught if invoked from a non-sleepable
> context, but there are also cases where sleeping is legal, but where the
> occasional wait for an RCU grace period would be a problem.  The checkers
> cannot easily catch this sort of thing, and hence the change in name.
> 
> Hey, the combined one/two-argument form seemed like a good idea at
> the time!  ;-)

Hah, not sure what you were smoking back then!

-- 
Jens Axboe


