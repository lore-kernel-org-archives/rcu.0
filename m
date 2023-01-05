Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38196C54EBE
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 15:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjAEPhB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjAEPgv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Jan 2023 10:36:51 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DE4D4B5
        for <rcu@vger.kernel.org>; Thu,  5 Jan 2023 07:36:46 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id b192so19667082iof.8
        for <rcu@vger.kernel.org>; Thu, 05 Jan 2023 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxD+fPyTMK6yZqv8JN1rj388R1I1cODwiId4PjsgzdE=;
        b=HBGLDt+NCUjn+M83u8f8QIr9XDlgqtQMmpw9tZXfXCY6GEvU9BatYu9i5xPaZueeP7
         +d/U2+515FH/F6tZS4MxKOzjg0NuokOQD2TlR+i9B/Elx75LHUIqWVURICvuZKLlpcf1
         pqHiJTzVMlWg5gYpUBzVaiM5h9Z5fXtQE6R89sPhx6a+HVEYnwTxY9XIfeq294euDfK+
         HnJTsA8AEFAmBgGMsDj6u24w8o+/DNYEiqoOFYPYUL7vYXz0vbf38wcHo69ZvlQVdB26
         ASd84o/Yrx/88npBQZ3jBsDDdrYVQeG2fcT+As7XInqcXu1m9Ai6p8oC+UcV8ezJRGAL
         yORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxD+fPyTMK6yZqv8JN1rj388R1I1cODwiId4PjsgzdE=;
        b=ok3fTiOHW/QLYoPFBSpjJst9DC8pKfLav7SquYMZxChogGCstGfBVUHoa/8Swp6dVa
         1VAqZhr/Xnh7Rgv2JTA8UvfkcemcOyRfNGga8aIo+2wd1RGGCekeSBCSO8ALvFlk+/d0
         4y/eKJJU00r+oM2R+ApFcGCwQZcpttbw3hdikTE+NQlTVYz5ZnUXEUh/m9sqj2Zi7Ydw
         aiLuPJCimCUcJAE6bsUP4tH2iqkn1IePClA1wUdn+60RmPu3ZIHBQ8GsN6mN/F15GY5i
         XEr5ziZYxwtTca6rXOxDljMLcBz7j/BbdGdbauVL6xGMbDij4az0RXxK1ZLmGK2R6PLX
         S1WA==
X-Gm-Message-State: AFqh2konHGHyA5GywXo2JmnCCVOZKCbUS+aQKn3yDvwdzlPJcSYHG9/W
        bpwAXvKilqxfAaefM6+uBJxstA==
X-Google-Smtp-Source: AMrXdXtUMjddxiPzEyLWlmqcVzA+S4ahIbByXIcZchDF/FsWVzwvMXYSbQJvFJC/R48RuN3khRB9XQ==
X-Received: by 2002:a05:6602:218a:b0:6df:b991:c03e with SMTP id b10-20020a056602218a00b006dfb991c03emr6598674iob.1.1672933005940;
        Thu, 05 Jan 2023 07:36:45 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v9-20020a02b089000000b0038a6da37802sm11895770jah.24.2023.01.05.07.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 07:36:45 -0800 (PST)
Message-ID: <f4dc3c65-c9e6-b961-cf94-f8058a67e256@kernel.dk>
Date:   Thu, 5 Jan 2023 08:36:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH rcu 07/27] block: Remove "select SRCU"
Content-Language: en-US
To:     paulmck@kernel.org, Heiko Carstens <hca@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        linux-block@vger.kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-7-paulmck@kernel.org>
 <1a9d0cdf-d39e-7eb5-39dd-3e425016c579@kernel.dk> <Y7aE2zzdTyjNId6w@osiris>
 <20230105153314.GS4028633@paulmck-ThinkPad-P17-Gen-1>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230105153314.GS4028633@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 1/5/23 8:33 AM, Paul E. McKenney wrote:
> On Thu, Jan 05, 2023 at 09:05:47AM +0100, Heiko Carstens wrote:
>> On Wed, Jan 04, 2023 at 05:43:07PM -0700, Jens Axboe wrote:
>>> On 1/4/23 5:37 PM, Paul E. McKenney wrote:
>>>> Now that the SRCU Kconfig option is unconditionally selected, there is
>>>> no longer any point in selecting it.  Therefore, remove the "select SRCU"
>>>> Kconfig statements.
>>>
>>> I'm assuming something earlier made this true (only CC'ed on this patch,
>>> not the cover letter or interesting btis...), then:
>>
>> I was wondering the same. But it is already unconditionally enabled
>> since commit 0cd7e350abc4 ("rcu: Make SRCU mandatory").
> 
> Ah, apologies for the terseness!
> 
> I took the coward's way out by making CONFIG_SRCU unconditional during
> the last merge window and removing all references during this merge
> window.  ;-)

Are you intending for maintainers to pick up these patches, or are you
collecting acks for sending the series separately? That part is also
not clear :-)

-- 
Jens Axboe


