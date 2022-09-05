Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2930ECAAD3
	for <rcu@archiver.kernel.org>; Mon,  5 Sep 2022 20:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiIEUcb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiIEUca (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Sep 2022 16:32:30 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F90B20F71
        for <rcu@vger.kernel.org>; Mon,  5 Sep 2022 13:32:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ml1so774868qvb.1
        for <rcu@vger.kernel.org>; Mon, 05 Sep 2022 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ztsxO5nf3rOxBwCm23dNmjFyypdLoAd00WVVSh6LeoM=;
        b=VCod74WRi3zoQYiXKpg14CNEH6XhiY2X6duH5xQKuIdqTmQPGzdn48ac/sHrMoX2Nz
         kBgfliqW8NHI4V0g/14b4p+sscgJvymv3WghWesuuPosKRuutO2Yw1GMjYAsqeIeCxH2
         63VbW3pRKB4/MyGl+7dnPuBbZ64s//eKpBgWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ztsxO5nf3rOxBwCm23dNmjFyypdLoAd00WVVSh6LeoM=;
        b=dJDzpFZ2N505MM5AZ9OTuU8BVRYUjBJgWUyEKdR+miJ9xFyTeHaV7L1FYS0OTIjS9m
         r65LdggN861mmOatDS5krI8g0hvrGI1RbrWj1QOBEBjtCSML/uEmQDD7d+4pf1CdzVq+
         t3wGhY/IyBmLTqF5RUZqgYzXIje+EPR6zQCeAdlT4d83aGXYkJr3RbncyPZJlPpYlqJE
         DEJ9hvPHm8sUu+5Q93KkGVP3tyGLfQwd1y5vwYauZz3nEEAo87aMU/ayze7hS2fGgZ5w
         bbwPxEqdbeRh+qxlNxTwAT5Fqs33IQQ87xkw9cCOHk0em2l5KRLhTAr+xX9ZV5K60w5u
         X2Ug==
X-Gm-Message-State: ACgBeo1eeWh+kcbJYmWSsDD9F89BGJw6VUerIHPdVOxb0NxngJN8ndvd
        watk12K00nyqyz9ouB1K/Rl7eQ==
X-Google-Smtp-Source: AA6agR7aN1LutW00v13oKDQqzXZFn5fZgQM+dR7hEArcOxqXVp5B5aBGFjoWRXLckcUkM9208QI1jw==
X-Received: by 2002:a0c:a9d8:0:b0:4a4:b35d:6d60 with SMTP id c24-20020a0ca9d8000000b004a4b35d6d60mr6271758qvb.101.1662409948759;
        Mon, 05 Sep 2022 13:32:28 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a248b00b006bb29d932e1sm9437680qkn.105.2022.09.05.13.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 13:32:28 -0700 (PDT)
Message-ID: <d82fec15-af9a-6ff6-69dd-a315cdca9892@joelfernandes.org>
Date:   Mon, 5 Sep 2022 16:32:26 -0400
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
 <20220902152132.GA115525@lothringen>
 <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
 <20220905125949.GA173859@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220905125949.GA173859@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/5/2022 8:59 AM, Frederic Weisbecker wrote:
> I'd rather see an updated patch (not the whole patchset but just this one) rather
> than deltas, just to make sure I'm not missing something in the whole picture.
> 
> Thanks.

There is also the previous patch which needs a fix up you suggested.

I will reply to individual patches with in-line patch (for you), as well as
refreshing whole series since it might be easier for Paul to apply them together.

thanks,

- Joel
