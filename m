Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754ECC7EE25
	for <rcu@archiver.kernel.org>; Fri,  9 Jun 2023 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjFIKbB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Jun 2023 06:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbjFIKak (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Jun 2023 06:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2592D41
        for <rcu@vger.kernel.org>; Fri,  9 Jun 2023 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686306061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQiGjNiItnmLkeqgf+FiJ4SBs5FhBkkGC4T+rqTu/+s=;
        b=eLt7PwPfZOd4BUAaL9zrKbB2uklRhHkx8lx3e/i7Yp2zMOqYl/PBbmaScxv0mpT3Ma9sCt
        Aq1DDzzDq94UPZZNmZQmXefpBlqlDzk4rh6d56McNGD2zesZ4qSzmOMXXQ74Qs3GZZqrUm
        fJrVwI2EuhF5McDUElgYX3Y/+OBMXxI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-NSWUlSVqPGObw-a9EtZQLw-1; Fri, 09 Jun 2023 06:20:57 -0400
X-MC-Unique: NSWUlSVqPGObw-a9EtZQLw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-978876e43a7so202466166b.3
        for <rcu@vger.kernel.org>; Fri, 09 Jun 2023 03:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306056; x=1688898056;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQiGjNiItnmLkeqgf+FiJ4SBs5FhBkkGC4T+rqTu/+s=;
        b=Yo3TR0aSVdV8PFo+cWwkYQCLsn1vQQT12C1xGwRlRZXHYDiFhCsMtzqYhS3ba+QEYZ
         JuhuGk6FEkk7Jn1F8OicpAGxPQniFtRt5bkrXFjgnI8a7BFC7khqO/3LO7Xl6zBue1hF
         L0g9GNFUkIv2wZ6d6bz/HN18sboUM9KRwTQZT/Y/DG/WP9jM1icHItWg0VdQ4i3xr1m3
         ZfsNxdKKCM4wXPrMcXnwCXV4v9sIKjgkvLBgV9tRtwthfRSguZrCqcp/2acbFwBhJw9v
         udq29zkwWt8bUCLCt2dPvfbm1oHsPmKbWFoVNc3PP0HPGQXS+ve9wWvHrjY4kQg6eU0B
         s20w==
X-Gm-Message-State: AC+VfDxIzsN1LQnaT5CD/YpwIhEvagOg0j48oVW9TDdXgRCj3PXNl3Xe
        jvAmlObcOdEsxYsI9rxQvQhi4sOzBHeWtKx6M0xb9nOIWdlSlOVPAPJufa6s2hCFZNm4RunZ7e1
        nwBqyswYwj89N
X-Received: by 2002:a17:907:368d:b0:961:78c2:1d27 with SMTP id bi13-20020a170907368d00b0096178c21d27mr1631081ejc.19.1686306056602;
        Fri, 09 Jun 2023 03:20:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iKtG7y80UtPpN+4/2JHdJO340nWszUvGlvULhmXBlodeeYW/klqijJzqsUOBY4fzUPfHSeQ==
X-Received: by 2002:a17:907:368d:b0:961:78c2:1d27 with SMTP id bi13-20020a170907368d00b0096178c21d27mr1631060ejc.19.1686306056270;
        Fri, 09 Jun 2023 03:20:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id y21-20020a1709064b1500b009682b2b3d66sm1086253eju.197.2023.06.09.03.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:20:55 -0700 (PDT)
Message-ID: <e7095f56-44c4-7cf1-69f5-4ff66d20952c@redhat.com>
Date:   Fri, 9 Jun 2023 12:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
References: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
 <202306080917.C0B16C8@keescook>
 <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
 <20230608185142.GA1019250@hirez.programming.kicks-ass.net>
 <CAKwvOd=MurF6DQHzRTai15h67FEpd_4R-gz_iFejzLsL=dw3dA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
In-Reply-To: <CAKwvOd=MurF6DQHzRTai15h67FEpd_4R-gz_iFejzLsL=dw3dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 6/8/23 22:14, Nick Desaulniers wrote:
> Here, we're talking about using __attribute__((cleanup())) to DTR
> locally, but then we return a "raw" pointer to a caller. What cleanup
> function should the caller run, implicitly, if at all?  If we use
> __attribute__((cleanup())) that saves us a few gotos locally, but the
> caller perhaps now needs the same treatment.

But this is only a problem when you return a void*; and in general in C 
you will return a struct more often than a raw pointer (and in C++ you 
also have the issue of delete vs. delete[], that does not exist in C).

Returning a struct doesn't protect against use-after-free bugs in the 
way std::unique_ptr<> or Rust lifetimes do, but it at least tries to 
protect against calling the wrong cleanup function if you provide a 
typed "destructor" function that does the right thing---for example by 
handling reference counting or by freeing sub-structs before calling 
kfree/vfree.

Of course it's not a silver bullet, but then that's why people are 
looking into Rust for Linux.

Paolo

