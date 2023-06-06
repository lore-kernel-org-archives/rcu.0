Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45888C7EE24
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 13:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjFFNSR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjFFNSP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 09:18:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB410C0
        for <rcu@vger.kernel.org>; Tue,  6 Jun 2023 06:18:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f62722d661so3118059e87.2
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686057492; x=1688649492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4m4td7TsrrilSTR7j+gHheVoaRExoQsmOFwSbyWIUo=;
        b=VB2Zq3cPIwdIOyalWR2mBUYfnSE7PfHZ3pRbZ89FlcWgWw6u7pcY5CTEaBk5WJwpqY
         i/MT2s6Ip/WQWYHOmA41j9F9LJPVNLtVTNty2z36kSWdQ9kTjHcnNzo2b3HA4HLFoXYI
         oU3YcoN0oCrF+J7c0706JqAPV7OMXqEAny15s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057492; x=1688649492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4m4td7TsrrilSTR7j+gHheVoaRExoQsmOFwSbyWIUo=;
        b=g0EcDsvW3Cb9bEj4vx6uiaHXpYZ/RlNlPRVx/1f4dT3VIu7XKLINZEgctmJbFSkSlk
         VZzQmHiQAWlKoxKMCWvcXghnZLHndrZE919ZhYS3ZzUbMrpQmbNcihBLXvsDWu72E231
         Uv5B2RGN4B1NyeHa022UB6UOWVesMK3SY/p2SsUAcKRZwdytE8gQtipDcSA9Hx+fP6LN
         IGGVkr8FnBIw5W6uU/+daXHGb3ff8IKq6gIu5bidJhgvyQv9696djeLRXV6S78GI02bU
         IrNV9BJQ5M8XYCfr1UBqHecSSV64lucItgq5cT6G3ckHjXFPX4cytf9GT7MnOBq5m/VA
         6teQ==
X-Gm-Message-State: AC+VfDw272/pLD82mcRM2+tyoQiKauNQLAh2iqqbFsexTe/e0RAF/hPl
        ThPDuheGhN7Nq3dY2ZGAegORJpZcwAwLTaePaUQ0nWjZ
X-Google-Smtp-Source: ACHHUZ4kOGMw47Dfit5L+8eG2wNM0vw65QQ+Y2HLQI9VJUXBNJ+kahHZJMbAravbNiViwh2wtFO2WA==
X-Received: by 2002:ac2:5ec7:0:b0:4f4:c289:596b with SMTP id d7-20020ac25ec7000000b004f4c289596bmr832431lfq.67.1686057492203;
        Tue, 06 Jun 2023 06:18:12 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j9-20020ac253a9000000b004f602a5a40asm1449984lfh.4.2023.06.06.06.18.11
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:18:11 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f62722d661so3118029e87.2
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 06:18:11 -0700 (PDT)
X-Received: by 2002:aa7:d605:0:b0:514:92d7:7d69 with SMTP id
 c5-20020aa7d605000000b0051492d77d69mr1793652edr.27.1686057471469; Tue, 06 Jun
 2023 06:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
In-Reply-To: <20230606094251.GA907347@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 06:17:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
Message-ID: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 6, 2023 at 2:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> ( GCC refuses to accept _Pragma() inside an expression.

If we really want this all, I think we'd just stop using
-Wdeclaration-after-statement entirely.

There are other uses for it, and people have asked for mixing
declarations and code before.

I think that particular straightjacket has been a good thing, but I
also think that it's ok to just let it go as a hard rule, and just try
to make it a coding style issue for the common case, but allow mixed
declarations and code when it makes sense.

For the whole "automatic release case it definitely makes sense, but
it's not like it isn't possible useful elsewhere. I just don't want
for it to become some global pattern for everything.

That said, I still don't understand why you lke the name "guard" for
this.  I understand not liking "auto", but "guard" doesn't seem any
better. In fact, much worse. Guarded expressions means something
completely different both in real life and in computer science.

I'm assuming there's some history there, but it makes no sense to me
as a name here.

              Linus
