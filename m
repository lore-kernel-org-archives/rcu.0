Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB672C7EE2E
	for <rcu@archiver.kernel.org>; Thu,  8 Jun 2023 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjFHQ7y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbjFHQ7u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Jun 2023 12:59:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD406270D
        for <rcu@vger.kernel.org>; Thu,  8 Jun 2023 09:59:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso1010534e87.1
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686243585; x=1688835585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTh/iWKmmyZ+KHSVz7lo3LyFxk+kpCnAqa64Bwwppv8=;
        b=RKFgsbO7ZuBOK5vf27aRqtnq4J5ihTQmOLjxs7zdyMg1NYlnb8bmYe3Gw2GQpiur8L
         Tu49A2MRxwnjafPlZpkFSFDh7XUjDIT1HRjRSa1Af5c/cty/wa1RdAUxyrEixQlyTMAl
         TmEUUHETPqkSvUA3Wu3up6yYsvy/QxUznsFY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243585; x=1688835585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTh/iWKmmyZ+KHSVz7lo3LyFxk+kpCnAqa64Bwwppv8=;
        b=LAGOWwB39gbVX9K5C3hyjZVyU+ZHRFnWHRga/mbPSbHDsfmpvkP3OwiqA03F7JZDfm
         13fztj/ymyydbCx4xwZRVT7LFoy+ANXH9KHa65V16c3oQqGeb788wpMpQbBI2hAxY/Rx
         0Z0O4P/RuDT4URJ3RNCf60h3oRzvQktVlu2pokra3rDQUC8Syrh18Gkwj3HSHVIU1M9X
         zyfAytg/tCbVmUYhFzcvYRKbrm/KEz2SlcotHk4+O7ZNHWGVCWOQGZT1AOM5aaFm3lRG
         PrD3ihB9SsWwdHV2OHUzL4zFN/acRb6zBP9YJs3Qy21e7ypnDnLEQF0JechJaXwofScX
         Ppog==
X-Gm-Message-State: AC+VfDwbxHc+6hVKyJgUEujhJHNF5P8tQMDOuKAMHirh5/706Lv5kwYe
        IGL/qGWsv7QrZS6kDbCUuk7Q/hg0oi3B7Q+WOCcjyILQ
X-Google-Smtp-Source: ACHHUZ5s8arbVIOjm0oK7xUeo9jk6qOGjKktzzCLsNDWm12wvuVRRYD9IReEv9j8s0EHt29LUp4vkg==
X-Received: by 2002:ac2:46f9:0:b0:4f6:3677:553 with SMTP id q25-20020ac246f9000000b004f636770553mr3677791lfo.38.1686243584800;
        Thu, 08 Jun 2023 09:59:44 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g4-20020ac25384000000b004d8546456c6sm241220lfh.195.2023.06.08.09.59.44
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:59:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so1003307e87.2
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 09:59:44 -0700 (PDT)
X-Received: by 2002:a17:907:c27:b0:966:17b2:5b0b with SMTP id
 ga39-20020a1709070c2700b0096617b25b0bmr364290ejc.49.1686243563225; Thu, 08
 Jun 2023 09:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <202306080917.C0B16C8@keescook>
In-Reply-To: <202306080917.C0B16C8@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jun 2023 09:59:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga3uyr_MZVPt3HmvjKKDJVw1s-PZfDvrVnJDJbBKzqdA@mail.gmail.com>
Message-ID: <CAHk-=wga3uyr_MZVPt3HmvjKKDJVw1s-PZfDvrVnJDJbBKzqdA@mail.gmail.com>
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

On Thu, Jun 8, 2023 at 9:47=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> I am a little worried about how (any version so far of) this API could go
> wrong, e.g. if someone uses this and does "return p" instead of "return
> no_free_ptr(p)",

Absolutely. I think the whole "don't always cleanup" is quite
dangerous, and maybe not worth it, but it _is_ a fairly common
pattern.

>     I was hoping we could do
> something like this to the end of automatic_kfree_wrapper():
>
>        *(void **)pp =3D NULL;

That would be a lovely thing, but as you found out, it fundamentally
cannot work.

The whole point of "cleanup" is that it is done when the variable -
not trh *value* - goes out of scope.

So when you have that

        return var; /* oops, forgot to disable cleanup */

situation, by definition "var" hasn't gone out of scope until _after_
you read the value and return that value, so pretty much by definition
it cannot make a difference to assign something to 'pp' in the cleanup
code.

> The point being, if we can proactively make this hard to shoot ourselves =
in
> the foot, that would be nice. :)

So the good thing is that things like KASAN would immediately notice,
and since this all happens (presumably) for the success case, it's not
about some unlikely error case.

I also think that -fanalyzer might just catch it (as part of
-Wanalyzer-use-after-free) at compile-time, but I didn't check. So
if/when people start using -fanalyze on the kernel, those things would
be caught early.

So while this "forget to avoid cleanup" is a worry, I think it ends up
likely being one that is fairly easy to avoid with other checks in
place.

Famous last words.

             Linus
