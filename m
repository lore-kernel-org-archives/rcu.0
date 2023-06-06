Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D3C7EE24
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbjFFPqi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbjFFPqd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 11:46:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918AC10DE
        for <rcu@vger.kernel.org>; Tue,  6 Jun 2023 08:46:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-970028cfb6cso1033433566b.1
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686066387; x=1688658387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UOet92MpBdONuA5jgW7v4DmIoemYaVmbXnKM9EiZ2I=;
        b=GSNuzczthU7I6j0S4ZhMH/U5UBIiWhw4hK9A+IerZjEZqQLWbXlMdz0y+rJwBuoGnn
         Z+eU2d2xByJSGOjDlMVhQnubPA1aWV+25CGPVCFr5DbybFnBUjnQ/6/pW6JazAmoWyzj
         54MdjJBKcCOCjrSB16XCp+BKIisSL42JZ6R2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066387; x=1688658387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UOet92MpBdONuA5jgW7v4DmIoemYaVmbXnKM9EiZ2I=;
        b=fKOHR7S01KC3V3Inusj+FjotJCei4BLMGd5Rpc2hw2WxDitsTMwWfkrlsN9GWOIPjV
         qll/zxai+BWP+lfblJyv7maTMjzbV4/xSmE6SscQgpg1CbOX3m3TWORWMySNI7wmiZ5G
         SCQQsjQLjD/ABRf11fK3+/50C2tuiVtfHln83D/HpG5ympx8TyUNp6HnEuGb0Ydk86eu
         8zigCZhegbw45YwiyQIhKI8g9NGGhJr1sml2HjdlC6TK7/QbLdW4ZPsS/UX8ovIh4hrd
         Ilu1YT9BpVET1GnxKkM2rGARCTMcYOw2sCUN8yjMRGpDSdE9hIt4pqYKvjwpfcjPIruL
         Ptaw==
X-Gm-Message-State: AC+VfDw5VNepcTdxUBo4h2xMDyxTMQAornO/iAS+HKe0SIZbtW+61/pw
        NYRqCdOKRjR7GgUYhn2kFQEJQlBabPyNkw8q7Bs9un1K
X-Google-Smtp-Source: ACHHUZ6/eOZRl6lZau9ghkSKAOA+WtZp2GN1eBDxDPNhbgMeP80zFcLp9HGf8lRpr6i8Ufpt84ldfA==
X-Received: by 2002:a17:907:6d04:b0:973:946d:36b2 with SMTP id sa4-20020a1709076d0400b00973946d36b2mr2589986ejc.56.1686066386917;
        Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090637cd00b009750b9ff97asm5379374ejc.55.2023.06.06.08.46.26
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-977d6aa3758so432737866b.0
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
X-Received: by 2002:a17:906:7950:b0:974:1c90:b3d3 with SMTP id
 l16-20020a170906795000b009741c90b3d3mr3220341ejo.12.1686066366310; Tue, 06
 Jun 2023 08:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <202306060829.C2FD998CF@keescook>
In-Reply-To: <202306060829.C2FD998CF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 08:45:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
Message-ID: <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
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

On Tue, Jun 6, 2023 at 8:31=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> nit: Linus's example was "(void *)8" (instead of 1) because we've had
> issues in the past with alignment warnings on archs that are sensitive
> to it. (e.g. see the __is_constexpr() macro which is doing NULL/!NULL
> comparisons.)

Note that I don't think we ever saw such a warning, it was just a
theoretical observation that depending on type, the compiler might
warn about known mis-aligned pointer bits.

So I'm not sure the 1-vs-8 actually matters. We do other things that
assume that low bits in a pointer are retained and valid, even if in
theory the C type system might have issues with it.

But maybe I mis-remember - if you did get an actual warning, maybe we
should document that warning just to keep the memory alive.

            Linus
