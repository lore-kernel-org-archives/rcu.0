Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F36EECAAA1
	for <rcu@archiver.kernel.org>; Wed,  7 Sep 2022 02:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIGCn0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 22:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIGCnZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 22:43:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F87A776
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 19:43:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y18so9508410qtv.5
        for <rcu@vger.kernel.org>; Tue, 06 Sep 2022 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HV15brfmijT3wQpdJQzUr20Idn6RQgfVceZTRDNZ2RA=;
        b=xSduQWMCYeluZayNSc/ZHmsirDlb9V9NS3hqmtpoPmuCjOI6hsnymMlm4dMQTQDGPD
         J4T0+VqM2skudfqpfnDEGffA6LwWX9ZtfksqaBf8mewmSP1nOEi35pcZO/f3PgmlKhHl
         hw2/IvrXMUi65QTYz6e377fymvUm0PBmBkNQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HV15brfmijT3wQpdJQzUr20Idn6RQgfVceZTRDNZ2RA=;
        b=m/hAqoaQGuSDnFD/M3tvgPaykK7gubjuosLTRHNxu583AbbkOJB3D04spMHQUYXyxX
         DTLM2/0mDMRXV/QahdFeHeszAdl96vA/vBremVy+E2sdQU1w5pvNsNW5qNV/4Pe1/Y9D
         6qqCHzlCPdzofE7GP/r/4mrPb7bK2/zzsD83PVJYoUMcLf+5cNuADQyl2S2KqF+3rWUE
         fYO/kd800sHLfBR08s1Ubkdb6sqi4I122d/6ZCmi2cKLpT4GxfCjsGxEixetV9rogxCT
         79MtKP+NBL4L/bWoxl+dHZUPbbg61ri2NrW0HtGs6GeLZbO1UxTnW+wqvM3Go6Zd3noo
         ZtHw==
X-Gm-Message-State: ACgBeo0EP+eUmmdPfYvpQKGKGV/zTvwe1ZnuQ2RIhD2ShLFXM6RJby9Z
        0t3Kg8vDqq6POcPdRCGVb8LMLA==
X-Google-Smtp-Source: AA6agR4g8U9tCuV/rPUVPEgqT2qIUDioJHoiieKqfwpb7oxjTNDvFQ9Y6HTa+FzF7YlFKwIwyKTxpQ==
X-Received: by 2002:ac8:5a0d:0:b0:344:de4f:b187 with SMTP id n13-20020ac85a0d000000b00344de4fb187mr1431577qta.136.1662518604011;
        Tue, 06 Sep 2022 19:43:24 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bb9-20020a05622a1b0900b00354e5b8bba3sm6629847qtb.29.2022.09.06.19.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:43:23 -0700 (PDT)
Message-ID: <a99c817f-4b0f-ad50-db38-8a55029d6ecc@joelfernandes.org>
Date:   Tue, 6 Sep 2022 22:43:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist
 happens
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <Yxa5WVwwcDmCL9Dw@google.com> <20220906094852.GA174244@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220906094852.GA174244@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/6/2022 5:48 AM, Frederic Weisbecker wrote:
>>  		}
>> -		rcu_nocb_unlock_irqrestore(rdp, flags);
>> +
>> +		// The flush succeeded and we moved CBs into the ->cblist.
>> +		// However, the bypass timer might still be running. Wakeup the
> That part of the comment mentioning the bypass timer looks strange...
> 
> 
>> +		// GP thread by calling a helper with was_all_done set so that
>> +		// wake up happens (needed if main CB list was empty before).
> How about:
> 
>                 // The flush succeeded and we moved CBs into the regular list.
> 		// Don't wait for the wake up timer as it may be too far ahead.
> 		// Wake up now GP thread instead if the cblist was empty
> 
> Thanks.
> 
> Other than that the patch looks good, thanks!
> 

I updated it accordingly and will send it for next revision, thank you!

 - Joel
