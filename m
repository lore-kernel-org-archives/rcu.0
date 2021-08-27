Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E3C432BE
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA30F60F92
	for <rcu@archiver.kernel.org>; Fri, 27 Aug 2021 20:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhH0U1z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Aug 2021 16:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhH0U1y (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 27 Aug 2021 16:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630096024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvUFmdthk7jLPef6R9/TSXU1gnYsUf+KUTcBRx1p1DE=;
        b=PV3sZ17PAclVpGpZNXZbjcVDsPmDLSukFWTq5swgl32VKRiNB8n4S3tBsy5MYibsnCxYVf
        wVT/sc9UcIDIxfe2d6Afkf4j/f14DO73MOsXhugfpwTqTWr5DwWUcf0PE2T603vsP2POc2
        wwGc+KdV6I7QF/1a8Mnc22KGYqEOEP8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-xvYg1o7cPRSX34oX-cOx7g-1; Fri, 27 Aug 2021 16:27:03 -0400
X-MC-Unique: xvYg1o7cPRSX34oX-cOx7g-1
Received: by mail-qv1-f72.google.com with SMTP id t12-20020ad45bcc000000b003772069d04aso1483648qvt.19
        for <rcu@vger.kernel.org>; Fri, 27 Aug 2021 13:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JvUFmdthk7jLPef6R9/TSXU1gnYsUf+KUTcBRx1p1DE=;
        b=LGIuxUquF7GvDr0r5HELnnBA64PcgPNHUo8EFYyxQ3zHzEPAC26mcerOAz7fUprHdW
         WEPw1EzFyhIL5ewyQzjD2COzMSfMOljRdOpmdRgOV+WQon2IycXyRVYxWGNPizXCMn7n
         cZdYxVip1wpmfMlLUiB1g+GY+8RWA4zGX4nujTvul2ckJlSzOPFAG82yI+TnIcd2353r
         PxQtJzIHq54h3Fx2fDntS+LA+67yoWLVC27oY9jvoR6SS4ANQJvbAUZA02NwXjZGTbBH
         xGTT+kDsTMju/ziOqxUSG4a9F/iDzspHzJnXqoO19P2PR6HdJ+DwureKbemzeaV/Wpzg
         PNGw==
X-Gm-Message-State: AOAM530QR+ICA57OEmVGvHX73+c/bOiX3tSuC1qsTVf9jeok1w0Dm4zV
        IVfLDxhUD6YptTVhKI62kb4DdlBWntc338vS2s+Fhqkc3+iCnaVghGjShRLHW7BcqhAD1xWxLrG
        +zQh8DP+qqBt9
X-Received: by 2002:ac8:47d7:: with SMTP id d23mr10075293qtr.73.1630096022620;
        Fri, 27 Aug 2021 13:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaVC191a1tAlIadHotO6wANwljm8N7F7Z8+S2yDbcvImQy/MRUKFShJP3VGOS4gvfCCav+Pg==
X-Received: by 2002:ac8:47d7:: with SMTP id d23mr10075280qtr.73.1630096022406;
        Fri, 27 Aug 2021 13:27:02 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m8sm5202923qkk.130.2021.08.27.13.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 13:27:01 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] rcu: Avoid unneeded function call in rcu_read_unlock()
To:     paulmck@kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org
References: <20210827022122.15816-1-longman@redhat.com>
 <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <34cbf3f5-9485-a82d-2548-272e87033ab2@redhat.com>
Date:   Fri, 27 Aug 2021 16:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8/27/21 2:34 PM, Paul E. McKenney wrote:
> On Thu, Aug 26, 2021 at 10:21:22PM -0400, Waiman Long wrote:
>> Since commit aa40c138cc8f3 ("rcu: Report QS for outermost
>> PREEMPT=n rcu_read_unlock() for strict GPs"). A real function call
>> rcu_read_unlock_strict() is added to the inlined rcu_read_unlock().
>> The rcu_read_unlock_strict() call is only needed if the performance
>> sagging CONFIG_RCU_STRICT_GRACE_PERIOD option is set. This config
>> option isn't set for most production kernels while the function call
>> overhead remains.
>>
>> To provide a slight performance improvement, the
>> CONFIG_RCU_STRICT_GRACE_PERIOD config check is moved from
>> rcu_read_unlock_strict() to __rcu_read_unlock() so that the function
>> call can be compiled out in most cases.
>>
>> Besides, the GPL exported rcu_read_unlock_strict() also impact the
>> the compilation of non-GPL kernel modules as rcu_read_unlock() is a
>> frequently used kernel API.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Nice, and good eyes!!!
>
> I have queued this for v5.16, that is, not the upcoming merge window
> but the one after that.
>
> I did my usual wordsmithing, so please check the following in case I
> messed something up.  I intentionally omitted the EXPORT_SYMBOL_GPL()
> discussion because:
>
> 1.	Kernels built with CONFIG_PREEMPT=y have the same issue
> 	with the __rcu_read_lock() and __rcu_read_unlock() functions.
>
> 2.	Many other RCU functions are EXPORT_SYMBOL_GPL() and have
> 	been for almost two decades.
>
> But if someone does use RCU readers within CONFIG_PREEMPT=n kernels from
> a binary module, I will happily refer them to you for any RCU issues
> that they encounter.  ;-)
>
> I am also CCing the BPF guys in case my interpretation of the code in
> the BPF verifier is incorrect.
>
> 							Thanx, Paul
>
It looks good to me. Thanks for the rewording. I did regret mentioning 
about about the GPL export symbol in the commit log and it is good that 
you had taken it out.

Cheers,
Longman

