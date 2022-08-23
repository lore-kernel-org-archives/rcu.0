Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0227C32789
	for <rcu@archiver.kernel.org>; Tue, 23 Aug 2022 18:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiHWSyl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiHWSyT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Aug 2022 14:54:19 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E01156F4
        for <rcu@vger.kernel.org>; Tue, 23 Aug 2022 10:19:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g21so10807770qka.5
        for <rcu@vger.kernel.org>; Tue, 23 Aug 2022 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=J8kAD4j1aDbrOL8pqQ4PSxZdc2KSr76uCoEoAk5Qv3Q=;
        b=Or/03RuB/QcXJKlsFjfna/1jlrdirhlKUsJQnnat8ZF8DONLiOvM8/fxfZJ+qbj9eM
         GRwnanArjL2DHajYPAaFdktqXNPsZ/oQ6xI7mGsBhMBNtbb7BgzLcgTSDVNW9sr8A4Lu
         MJdATycLEHijD4j/L71/r7S18YQ+voA1BBij8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=J8kAD4j1aDbrOL8pqQ4PSxZdc2KSr76uCoEoAk5Qv3Q=;
        b=dAe9suMnepc9kXCPlCu+ympUBCPCm0ZpYLnjTRl1erI/cvb/kJOM0Cef7bODeBe8fK
         R//JT2VYeMGlqWFGi81z1+ADVnEp40WJyxtyEL0FYO999RJsWi3NZlUwPLL8xhiRQqRQ
         Y+vnk2t+IWmwEyGyo6VAm+3kAldrDJcn5DHiFePsOHSZqXx39ic8JBY43EmPN8mKjIva
         mh5qaC5HD+RkfyF8jh5LLO1aDIS5noX4rcYvmDmsxRo+n2r9CsDU9eNsS+PPZmlFQLDq
         KQ2MQbYRw0O1BMl4v8hJ+Wfp+4y49YZInyOqeLx1YYxbOgEFkevE4NFEXdf6+684mXcZ
         D50g==
X-Gm-Message-State: ACgBeo0uK1KDD1++yz3l3eCQaeNteQ8TdBQQv+t0X4UhXshGaohek9oJ
        FNJLUWqzbbsFkLhnlrUCce2ZjA==
X-Google-Smtp-Source: AA6agR5XPaucXIdlwVL5TviP2IZVZoU+T+JLcjbD56Je7P2xX52xcL8+qa7oP1byA2FR62bNtjSUsQ==
X-Received: by 2002:a05:620a:2710:b0:6b5:bf24:10e9 with SMTP id b16-20020a05620a271000b006b5bf2410e9mr16951583qkp.28.1661275182063;
        Tue, 23 Aug 2022 10:19:42 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id g2-20020ac87742000000b003445d06a622sm11268923qtu.86.2022.08.23.10.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 10:19:41 -0700 (PDT)
Message-ID: <b4145008-6840-fc69-a6d6-e38bc218009d@joelfernandes.org>
Date:   Tue, 23 Aug 2022 13:19:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Content-Language: en-US
To:     paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        neeraj.iitr10@gmail.com,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, frederic@kernel.org, rostedt@goodmis.org
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/14/2022 4:51 PM, Paul E. McKenney wrote:
> On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
>> Hello!
>>
>> Please find the next improved version of call_rcu_lazy() attached.  The main
>> difference between the previous versions is that:
>> - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
>>   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
>>   requested by Paul.
>> - Fixed checkpatch and build robot issues.
>> - Some more changes to 'lazy' parameter passing and consolidation of segcblist
>>   functions.
>> - more testing via rcutorture and rcuscale.
> 
> Thank you!  What I am going to do is to pull these into an experimental
> not-for-mainline branch and run the usual set of rcutorture tests.
> I will then take a look at the patches.
> 
>> Note that these tests were run on v2 patches, I am expecting similar power
>> improvements however I've not yet tested power.
>>
>> Following are power savings we saw on top of RCU_NOCB_CPU on an Intel platform
>> in v2.  The observation is that due to a 'trickle down' effect of RCU
>> callbacks, the system is very lightly loaded but constantly running few RCU
>> callbacks very often. This confuses the power management hardware that the
>> system is active, when it is in fact idle.
>>
>> For example, when ChromeOS screen is off and user is not doing anything on the
>> system, we can see big power savings.
>> Before:
>> Pk%pc10 = 72.13
>> PkgWatt = 0.58
>> CorWatt = 0.04
>>
>> After:
>> Pk%pc10 = 81.28
>> PkgWatt = 0.41
>> CorWatt = 0.03
> 
> When you update these numbers, please explain what they all are and
> evaluate them in the cover letter (or in the relevant patch's commit log).
> For final submission, please also include some estimate of the variance.
> For example, CorWatt might be essentially the same both before and after,
> as in 0.035 and 0.034, or there might be a large difference, as in 0.044
> and 0.025.  The 81.28 might be constant in all four digits (ha!), or it
> might vary between (say) 80 and 83.  And so on.
> 
> Based on our earlier emails, my guess is that Pk%pc10 is the percent of
> time that the system is in a low-power state (bigger is better), PkgWatt
> is power consumed by the CPU chip (smaller is better), and CorWatt is
> power consumed by the CPU core (again, smaller is better).
> 
> It all might sound painfully obvious to you right now, but please have
> pity on future readers of this series.

Following is some power data I collected with Turbostat on an x86 ChromeOS
ADL machine. The power seems better on the upstream kernel already versus
my earlier tests, however I still see 5-8% power improvement with the patches.

Rushikesh, Sitanshu, Neeraj, Vlad - could you test power with these as well?
The following branch boots on ChromeOS ADL:
https://github.com/joelagnel/linux-kernel/tree/chromeos-kernelupstream-5.19-rc4.aug22

These are output from Turbostat running:
turbostat -S -s PkgWatt,CorWatt --interval 5
PkgWatt - summary of package power in Watts 5 second interval.
CoreWatt - summary of core power in Watts 5 second interval.

I could not get PC10% on the upstream kernel, it always shows 0. Maybe that is a turbostat
version issue or something.

+───────────+─────────────────────────+──────────+───+──────────────────────────+──────────+
|           | Screen on idle (After)  |          |   | Screen on idle (Before)  |          |
+───────────+─────────────────────────+──────────+───+──────────────────────────+──────────+
|           | PkgWatt                 | CorWatt  |   | PkgWatt                  | CorWatt  |
|           |                         |          |   |                          |          |
|           | 0.6100                  | 0.0500   |   | 0.6700                   | 0.0500   |
|           | 0.5800                  | 0.0400   |   | 0.6200                   | 0.0500   |
|           | 0.5800                  | 0.0400   |   | 0.6500                   | 0.0500   |
|           | 0.6600                  | 0.0800   |   | 0.6200                   | 0.0500   |
|           | 0.5900                  | 0.0400   |   | 0.6200                   | 0.0500   |
|           | 0.5900                  | 0.0400   |   | 0.6400                   | 0.0600   |
|           | 0.6000                  | 0.0500   |   | 0.6700                   | 0.0600   |
|           | 0.6400                  | 0.0600   |   | 0.6200                   | 0.0500   |
|           | 0.6000                  | 0.0500   |   | 0.6200                   | 0.0500   |
|           | 0.5800                  | 0.0400   |   | 0.6200                   | 0.0500   |
|           | 0.6000                  | 0.0400   |   | 0.6200                   | 0.0500   |
|           | 0.6000                  | 0.0500   |   | 0.7200                   | 0.0900   |
--------------------------------------------------------------------------------------------
| Variance  | 0.0006                  | 0.0001   |   | 0.0010                   | 0.0001   |
| Mean      | 0.6025                  | 0.0483   |   | 0.6408                   | 0.0550   |
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
|           | Lid closed + no suspend            |   Lid closed + no suspend               |
|                                                |                                         |
|           | Screen off idle (After)            |   | Screen off idle (Before)            |
--------------------------------------------------------------------------------------------
|           | PkgWatt                 | CorWatt  |   | PkgWatt                  | CorWatt  |
|           | 0.3100                  | 0.0700   |   | 0.3500                   | 0.0700   |
|           | 0.3100                  | 0.0700   |   | 0.3200                   | 0.0700   |
|           | 0.3300                  | 0.0700   |   | 0.4100                   | 0.0900   |
|           | 0.3100                  | 0.0600   |   | 0.3400                   | 0.0700   |
|           | 0.3300                  | 0.0700   |   | 0.3200                   | 0.0700   |
|           | 0.3800                  | 0.0900   |   | 0.3400                   | 0.0700   |
|           | 0.3600                  | 0.0700   |   | 0.3400                   | 0.0700   |
|           | 0.3100                  | 0.0700   |   | 0.3300                   | 0.0700   |
|           | 0.3300                  | 0.0700   |   | 0.3300                   | 0.0800   |
|           | 0.3700                  | 0.0800   |   | 0.3200                   | 0.0700   |
|           | 0.3500                  | 0.0800   |   | 0.3400                   | 0.0700   |
|           | 0.2900                  | 0.0600   |   | 0.4300                   | 0.1100   |
|           | 0.3300                  | 0.0700   |   | 0.3400                   | 0.0700   |
|           | 0.3300                  | 0.0700   |   | 0.3200                   | 0.0700   |
|           | 0.3400                  | 0.0700   |   | 0.3600                   | 0.0800   |
|           | 0.3000                  | 0.0700   |   | 0.3200                   | 0.0700   |
|           | 0.3400                  | 0.0700   |   | 0.3300                   | 0.0700   |
|           | 0.3400                  | 0.0900   |   | 0.3500                   | 0.0800   |
|           | 0.3400                  | 0.0700   |   | 0.3800                   | 0.0800   |
--------------------------------------------------------------------------------------------
| Variance  | 0.0005                  | 0.0001   |   | 0.0010                   | 0.0001   |
| Mean      | 0.3028                  | 0.0664   |   | 0.3174                   | 0.0700   |
+───────────+─────────────────────────+──────────+───+──────────────────────────+──────────+

Thanks,

 - Joel


