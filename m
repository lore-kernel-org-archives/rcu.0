Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA87C6FA86
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 16:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiIFQjS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiIFQi1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 12:38:27 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978537FE7B
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 09:16:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u5so4350796qvv.3
        for <rcu@vger.kernel.org>; Tue, 06 Sep 2022 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aVnRGtDVLzh7r4gYFcY61GaoBWZiLmborlFfjmuLMU4=;
        b=ZDoW0sLOggTRhVpOzEH7HAUZVpdfWMQbNrRKI8pSG67+BRA12SZzhgmqXyyZ8dizC7
         ETZtYOFAPc/qu8HbE8datiRiGzrRxRFS/aeINBpeyktdrgJLzzkw4nWYJjVEAO12Dy4l
         reIMGjr0Tm4O6CFp87SMDKLvM8ASQnfPULzy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aVnRGtDVLzh7r4gYFcY61GaoBWZiLmborlFfjmuLMU4=;
        b=X6iK+fIUyfiu22q7WiSy+2exk8vucIsu/ioucQhIBz5ElbYbXvDFzPUNhZmYScrOON
         1DC3RfTnTWIjeEKGuYUXQ7ESrDzvYuACd8r2l0jX74txniq/sc6Idl9JEVfaMPcs9wTK
         13h9b1yWv2/36QluiQYDTg0uM4FSgnMRazBCbXEifM/pOo0+rg+H79rFAeF3WogY/3zN
         7J3yCNIZxWXKu7JOGQ1qJ7onGby1eL2yyrTwwfYeWys9k4110vgm8ckigVL+K1s4K6iU
         oSVxpVXT8J0RL/LYE/TKjfWG+rHccXac5QXYttmpae/js/DXLZrS+Vg8mhmq1iS2evF4
         nHaQ==
X-Gm-Message-State: ACgBeo0s8ufsvkw1NfMRcsqXukGNPCai6ij/2s5xpIiXN9k0D7QY+Xws
        +OLR6E9Bu9q3iylw4becbtTIbg==
X-Google-Smtp-Source: AA6agR7JAGXv25sBX/IfvFoTv+3Xzbnvqe9k5ZW5X/VeHbRl6H9W6wfJwAK5E6VtkmLR6tTcneJLSw==
X-Received: by 2002:a05:6214:3013:b0:4a8:ee66:c839 with SMTP id ke19-20020a056214301300b004a8ee66c839mr6967251qvb.115.1662480981697;
        Tue, 06 Sep 2022 09:16:21 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id de32-20020a05620a372000b006bad7a2964fsm12265369qkb.78.2022.09.06.09.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:16:21 -0700 (PDT)
Message-ID: <11d8b17a-1a82-148d-6da9-5e624b8e5942@joelfernandes.org>
Date:   Tue, 6 Sep 2022 12:16:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
 <20220905125949.GA173859@lothringen>
 <d82fec15-af9a-6ff6-69dd-a315cdca9892@joelfernandes.org>
 <20220906085512.GI4315@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220906085512.GI4315@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 9/6/2022 4:55 AM, Paul E. McKenney wrote:
> On Mon, Sep 05, 2022 at 04:32:26PM -0400, Joel Fernandes wrote:
>>
>>
>> On 9/5/2022 8:59 AM, Frederic Weisbecker wrote:
>>> I'd rather see an updated patch (not the whole patchset but just this one) rather
>>> than deltas, just to make sure I'm not missing something in the whole picture.
>>>
>>> Thanks.
>>
>> There is also the previous patch which needs a fix up you suggested.
>>
>> I will reply to individual patches with in-line patch (for you), as well as
>> refreshing whole series since it might be easier for Paul to apply them together.
> 
> To say nothing of the greater probability that the result will match
> your intent.  ;-)

It is shaping up well ;-)

thanks,

 - Joel
