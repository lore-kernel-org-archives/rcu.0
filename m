Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85BC77B73
	for <rcu@archiver.kernel.org>; Tue, 30 May 2023 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjE3N7Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 May 2023 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjE3N7H (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 May 2023 09:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31931EA
        for <rcu@vger.kernel.org>; Tue, 30 May 2023 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685455098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GyS/XEJVr+X0SCCnfa5wepVjXQBcDWeiJTyar/+z4gE=;
        b=UH6ikL151zkxA2zVkRloBgAxb/hOmjqhCTgL2pPtl8NTVpMhqLsEmsU2FZOQF3W+M0JbFu
        oUXfBQAsaP3PCm0v5x+jGvjyf25iEYMhvhVAHpxsjZdZ6TlPYgCcaldooZHMeuswZYbjZt
        Qa593p7DQmtJ/RCqS0W3sLzd1TwK/m0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-v2Hj1ULAPwWycRnJucmTiw-1; Tue, 30 May 2023 09:58:16 -0400
X-MC-Unique: v2Hj1ULAPwWycRnJucmTiw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f60536450eso26631745e9.1
        for <rcu@vger.kernel.org>; Tue, 30 May 2023 06:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455095; x=1688047095;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyS/XEJVr+X0SCCnfa5wepVjXQBcDWeiJTyar/+z4gE=;
        b=cD4VJdFAYkqbwj+HXr0p7pHhDYzRrae+6eOSgVzjSLFuGKcugNFmqYm7zZkV77eCdm
         Ekg1AsWEipgVT3oNlx3pCSl3u0ijyqLMmoFnrlCCHZhSDaWPdB1XcdtL+bYv2hLg+tCd
         MWbOs2AJXIMOxrpjl3GvZEXpnOpOSNIl7yzWcjY4tdIgrsd5BfCCsCq+3i2VMt4ESk94
         GYa9Jk1q3FWsnLi+x1shSfJjLLbaj9g6MO+HOfSyYDEuTS66KnuyShVrBaVm7uEu/kmX
         VsHdL2u8dCBeLNF02oR7PURvOALlfoVNkyoX/e9bJkiovVUaL3a2/PALS0lEOv4eitQX
         WANA==
X-Gm-Message-State: AC+VfDwoL1Ql2cmG1u9XwlgGM2sE4Bwy+UPP0XuKiPhrByT5aqEAdBy4
        /zXWRMTpZ23r5IG0pb6U3t39IXYpMFislPfa/b/oRA7qhfuriUacYKMi7PFUcMVU6KC7SgYVoLx
        dSFodEXytDFwW
X-Received: by 2002:a05:600c:2242:b0:3f6:a44:73bb with SMTP id a2-20020a05600c224200b003f60a4473bbmr2278290wmm.8.1685455095762;
        Tue, 30 May 2023 06:58:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5StBwPC6tNR2MseH7QMbfqVmLsT1D8KTQf8mlITfI6xHq2esGeCKT0VsWAof/TVfeHnC9m6Q==
X-Received: by 2002:a05:600c:2242:b0:3f6:a44:73bb with SMTP id a2-20020a05600c224200b003f60a4473bbmr2278278wmm.8.1685455095496;
        Tue, 30 May 2023 06:58:15 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id s5-20020adff805000000b00307d58b3da9sm3440837wrp.25.2023.05.30.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:58:14 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
In-Reply-To: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
Date:   Tue, 30 May 2023 14:58:12 +0100
Message-ID: <xhsmhy1l5or9n.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/05/23 11:23, Peter Zijlstra wrote:
> On Sat, May 27, 2023 at 12:18:04PM -0700, Linus Torvalds wrote:
>
>
>> And it turns out that the above two trivial macros are actually quite
>> useful in themselves. You want to do an auto-cleanup version of
>> 'struct fd'? It's trivial:
>>
>>     /* Trivial "getfd()" wrapper */
>>     static inline void release_fd(struct fd *fd)
>>     { fdput(*fd); }
>>
>>     #define auto_getfd(name, n) \
>>         auto_release_name(struct fd, name, fdget(n), release_fd)
>>
>
>>  - I think the above is simpler and objectively better in every way
>> from the explicitly scoped thing
>
> Well, I think having that as a option would still be very nice.
>

IMO the explicit scoping can help with readability. It gives a clear visual
indication of where critical sections are, and you can break it up with a
scope + guards as in migrate_swap_stop() to stay at sane indentation
levels (with Python context managers, this would all be one scope).

I'd argue that for these, the scope/indentation is beneficial and not just
a byproduct. Even for longer functions like try_to_wake_up(), this works
out alright.

This obviously falls apart when dealing with too many guards
(e.g. copy_process()) or if the resulting indentation is nuts, but I concur
that keeping the explicit scope as an option would be nice.

