Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A9ECAAD4
	for <rcu@archiver.kernel.org>; Sat,  3 Sep 2022 14:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiICOFe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 3 Sep 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiICOFd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 3 Sep 2022 10:05:33 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCA332073
        for <rcu@vger.kernel.org>; Sat,  3 Sep 2022 07:05:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h22so3458126qtu.2
        for <rcu@vger.kernel.org>; Sat, 03 Sep 2022 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yyyd1sxsmE6D0QxlQAOs5slwkgmkiRw7J9KYMdVF/nI=;
        b=JnpaPPUzT0cPHP1fhbSh0qZ6GChZnhQyLsbs9fabP7LH+x/Azw7dkoBHbb2MYD8U0o
         oO4/xqx68kMJ0CIOjgvSybbK/qTOPrmaqSqvLawtFU/j4/3YnfyaaxqnE+0yndLjRpIQ
         lI4khU2O53b8hCY9xErCstasXwylls+KtWHlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yyyd1sxsmE6D0QxlQAOs5slwkgmkiRw7J9KYMdVF/nI=;
        b=WStYf8gmwQ/5Si39ouMPG/SRPoHLgqFxoNd/FNVMIMDTUhGNRxgXmr/m7hZzlPt8e3
         jKEjn6tngI8+FNCPmTauCbEBcZKhd0jgRsEI+flYWmPNgvRJp2Z8kEzIjkWP+wJehhp8
         K3q+HsQW9OISHpqxiRUSkGAR02Yo0wQ/ltUGwu4oFCCI/RFf2UCuxbiUHzKGP91F09J6
         TrDDdoWPzCYMVY8LKQKqXmrNjuNAcpTosqiv6bgHez89GYDxEtggN8MCcmaLuNPfeDo1
         rWwSEZCzoYZktmAcZbndRniExkAD1EvvReBO1s/jLDn3PpdBAPy7M7jZtUU7NlMqnBuW
         Q6Gw==
X-Gm-Message-State: ACgBeo33W3YGRsvPyLidmcIcTVPomweecipjwIDmR6o1Ge9A8PiwcBTh
        pjpioZcXfiQlvo9RP3vhwmEeTg==
X-Google-Smtp-Source: AA6agR73skQVg8J2Imx9ubSCfVnAaNPqvzfDpU633Y7CafLZG5iQJ388BgfY5d4ESxY/+Pob9extYQ==
X-Received: by 2002:ac8:5a8b:0:b0:343:7075:2129 with SMTP id c11-20020ac85a8b000000b0034370752129mr33386358qtc.393.1662213930635;
        Sat, 03 Sep 2022 07:05:30 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87313000000b0034490214788sm2986718qto.49.2022.09.03.07.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 07:05:29 -0700 (PDT)
Message-ID: <c96c36f2-c324-39f7-1d66-7634eb26d909@joelfernandes.org>
Date:   Sat, 3 Sep 2022 10:05:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist
 happens
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <20220903140403.GU6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220903140403.GU6159@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/3/2022 10:04 AM, Paul E. McKenney wrote:
> On Thu, Sep 01, 2022 at 10:17:06PM +0000, Joel Fernandes (Google) wrote:
>> When the bypass cblist gets too big or its timeout has occurred, it is
>> flushed into the main cblist. However, the bypass timer is still running
>> and the behavior is that it would eventually expire and wake the GP
>> thread.
>>
>> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
>> soon as the flush happens. Otherwise, the lazy-timer will go off much
>> later and the now-non-lazy cblist CBs can get stranded for the duration
>> of the timer.
>>
>> This is a good thing to do anyway (regardless of this series), since it
>> makes the behavior consistent with behavior of other code paths where queueing
>> something into the ->cblist makes the GP kthread in a non-sleeping state
>> quickly.
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/rcu/tree_nocb.h | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 0a5f0ef41484..31068dd31315 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -447,7 +447,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>>  			rdp->nocb_gp_adv_time = j;
>>  		}
>> -		rcu_nocb_unlock_irqrestore(rdp, flags);
>> +
>> +		// The flush succeeded and we moved CBs into the ->cblist.
>> +		// However, the bypass timer might still be running. Wakeup the
>> +		// GP thread by calling a helper with was_all_done set so that
>> +		// wake up happens (needed if main CB list was empty before).
>> +		__call_rcu_nocb_wake(rdp, true, flags)
> 
> TREE01 and TREE04 gripe about the missing ";".  I added it.

Sorry about that, I must have messed lost the semicolon during re-basing.

 - Joel

