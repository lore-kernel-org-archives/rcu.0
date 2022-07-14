Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9899FC43334
	for <rcu@archiver.kernel.org>; Thu, 14 Jul 2022 21:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGNVdn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiGNVdl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Jul 2022 17:33:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E22EE3A
        for <rcu@vger.kernel.org>; Thu, 14 Jul 2022 14:33:40 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v28so692358qkg.13
        for <rcu@vger.kernel.org>; Thu, 14 Jul 2022 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uM8aThhfGMRWQLpommsyb2UcbxlUU/Hs46FH8RIVcvU=;
        b=xz7W+TOZMNin9+4djaVj0owlvwa0Dfyoi5HbB7FSK6bux3uZbsP78P3Br4+iE9u8tb
         7wr3EN40SnFU5ai77ooFNBaCLT376WizFAnsE/fiVf5xTXQBqlaWN4gbdnOv5ttuZvap
         BvYfg6DvmSIzzKuqeJut1tPKmpt9G/IwGC6r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uM8aThhfGMRWQLpommsyb2UcbxlUU/Hs46FH8RIVcvU=;
        b=N6CoTkOVoGSi5jRuWKoZV3lMSOS/GFSjMir24FD5vk4FDXUbnpGe7m7xC+FPcBcRQa
         MO59a2me7L+a0XQukqMsVw9j+OeCW/0Y7X4AHI8oz7iLTWk9CDIa+m3np4hQ4nysqffV
         TvZ9WdSR0py9S+e6zKGNSUpOWpnBBL8DOaShbYOIDrASz2ydVhgGced9N8atqi3tOCsS
         NVCeY1c3DFtExsiydmQbNbw36OZyKLDYO6YPELZQJBRhOVSzEY0u4R9K8UGBTDIyaPBi
         x0Hs/w8cL0zT+WlKgNIltSsWMTaNmjqTAa8XHcpPK3TMx9HEdehwr7dp9IlYhekDq/ir
         zDCQ==
X-Gm-Message-State: AJIora//FQ8Q1D8Il1QZq7CVnmrABJqkmEE9tAysgHJL3/M9lNXK2cUA
        f8R3uoCOxvTYyV4ag0LQs8OzaMUao/Oh8bDu
X-Google-Smtp-Source: AGRyM1tT6MJWFlqFNxLCwEQrcD4yhvLcsKgp9UuYa49ZiKJ0tpIbuyh8hbe96DCKrHwAUDWFY9+waQ==
X-Received: by 2002:a05:620a:4514:b0:6af:25f2:489d with SMTP id t20-20020a05620a451400b006af25f2489dmr7344649qkp.728.1657834419850;
        Thu, 14 Jul 2022 14:33:39 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id f38-20020a05622a1a2600b0031c56d5f7e1sm2556120qtb.92.2022.07.14.14.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 14:33:39 -0700 (PDT)
Message-ID: <ad4340a3-4f1f-b36b-f216-32a974299d9e@joelfernandes.org>
Date:   Thu, 14 Jul 2022 17:33:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Thanks, that sounds great.

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

Sure thanks for the suggestions and will do.

> 
> Based on our earlier emails, my guess is that Pk%pc10 is the percent of
> time that the system is in a low-power state (bigger is better), PkgWatt
> is power consumed by the CPU chip (smaller is better), and CorWatt is
> power consumed by the CPU core (again, smaller is better).

Yes that's correct.


>> Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
>> can see that the display pipeline is constantly doing RCU callback queuing due
>> to open/close of file descriptors associated with graphics buffers. This is
>> attributed to the file_free_rcu() path which this patch series also touches.
>>
>> On memory pressure, timeout or queue growing too big, we initiate a flush of of
>> the bypass lists holding the lazy CBs.
>>
>> Similar results can be achieved by increasing jiffies_till_first_fqs, however
>> that also has the effect of slowing down RCU. Especially I saw huge slow down
> 
> In the final submission, please quantify "huge slow down".  ;-)

Sure will do. IIRC it was something like 30 second to stop function
graph tracer versus the usual 2-3 seconds.

>> of function graph tracer when increasing that. That may be possible to fix via
>> rcu_expedited=1 boot parameter, however call_rcu_lazy() provides another option
>> over slowing down ALL call_rcu() globally. Further using jiffies_till_first_fqs
>> approach will still cause a wake up of the main RCU GP kthread, with this work
>> we delay even those wakeups.
>>
>> One drawback of this series is, if another frequent RCU callback creeps up in
>> the future, that's not lazy, then that will again hurt the power. However, I
>> believe identifying and fixing those is a more reasonable approach than slowing
>> RCU down for the whole system.
> 
> Like I said earlier, you are the official call_rcu_lazy() whack-a-mole
> developer.  ;-)

Haha..

Thanks,

- Joel

