Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3CAC7EE45
	for <rcu@archiver.kernel.org>; Thu,  8 Jun 2023 16:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjFHQAn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbjFHQAX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Jun 2023 12:00:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691230FD
        for <rcu@vger.kernel.org>; Thu,  8 Jun 2023 08:59:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so1406521a12.3
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686239985; x=1688831985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikLyVGzKcEMuSqUp/nI13OAR5DV5p124KJuoTG/oIAE=;
        b=BPVMCsunrScq9Wk3aOyLuqkN1vl7dG1WywseSfFbz9lZ2WbART6/i44iujcZvrw6+G
         44Fgtp6P2btu3Ox4QXtvhk7nZmFwsjHZKDuJ0JY1AtBl/RELYFkRTUZvxDf6camOYPAQ
         +D0/4xJFC1B2/iIcYA1InzX95iopTBkFbaK20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239985; x=1688831985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikLyVGzKcEMuSqUp/nI13OAR5DV5p124KJuoTG/oIAE=;
        b=Y719+rwuZOllBrHShtWXFnQaFzY+KMIT4aFRiCEV81f2rzPSaRGuoJ+DVeH0/Ygn7i
         iPaW8m68c7H3jTB9oPn8/HAHj36ne7j2Nc0SgBDQwDU+wnRMQR4wUowUJ4/b9LHlS/is
         oU2tv5xwu9vC3p3EUJqUapw9DjvX6a4PHDVWyt9qilzcF8mMF1vF42R0+zlTU6IiiFpp
         4h3hMJv8E8CN7+xxaE/1JQ/jOqdh8FZqe1yhTc42o9QQau5jFxaVAlxDk4pXy8Hcodzs
         kDKUobiegZ4rN8rMtqqPa/Jqz5WC4qsOV6Az+svRz35wM0zx2nGtbX3AL5zb2e8Mfbcn
         tM4Q==
X-Gm-Message-State: AC+VfDxl/ARwqMLl4gunn+Q2QwSbCmKkVvI/ydPCvztM+MfnJRhqznCd
        LPSSjxyUX5FMAJiuvt4q8VP5m2m+mIrIF6TfN0orLxjm
X-Google-Smtp-Source: ACHHUZ7Do9Aw+ihw4P1Ey8+4HemN333bHmn2PgK/oAfdtPNY/wGsXW0JuniaCqqDQlnKwwJMJZj04Q==
X-Received: by 2002:a2e:b603:0:b0:2b1:ad15:fe39 with SMTP id r3-20020a2eb603000000b002b1ad15fe39mr3617840ljn.10.1686239191371;
        Thu, 08 Jun 2023 08:46:31 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c19-20020a2e9d93000000b002b20058ecf9sm297452ljj.32.2023.06.08.08.46.30
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:46:31 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so948745e87.3
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 08:46:30 -0700 (PDT)
X-Received: by 2002:a17:907:8a15:b0:961:2956:2ed9 with SMTP id
 sc21-20020a1709078a1500b0096129562ed9mr197548ejc.25.1686239169847; Thu, 08
 Jun 2023 08:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jun 2023 08:45:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
Message-ID: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
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

On Thu, Jun 8, 2023 at 1:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Or perhaps use the smart-pointer concept applied to our classes like:
>
> #define smart_ptr(name, var) \
>         __INSTANTIATE_VAR(name, var)

So this is the only situation where I think "ptr" makes sense (your
"fat pointer" argument is nonsensical - sure, you can treat anything
as a pointer if you're brave enough, but that just means that
"pointer" becomes a meaningless word).

However, I think that for "smart pointers", we don't need any of this
complexity at all, and we don't need that ugly syntax.

> Then we can write:
>
> DEFINE_CLASS(kfree, void *, kfree(THIS), p, void *p)
>
>         smart_ptr(kfree, mem) =3D kzalloc_node(...);
>         if (!mem)
>                 return -ENOMEM;

No, the above is broken, and would result in us using "void *" in
situations where we really *really* don't want that.

For automatic freeing, you want something that can handle different
types properly, and without having to constantly declare the types
somewhere else before use.

And no, you do *not* want that "kfree(THIS)" kind of interface,
because you want the compiler to inline the freeing function wrapper,
and notice _statically_ when somebody zeroed the variable and not even
call "kfree()", because otherwise you'd have a pointless call to
kfree(NULL) in the success path too.

So for convenient automatic pointer freeing, you want an interface
much more akin to

        struct whatever *ptr __automatic_kfree =3D kmalloc(...);

which is much more legible, doesn't have any type mis-use issues, and
is also just trivially dealt with by a

  static inline void automatic_kfree_wrapper(void *pp)
  { void *p =3D *(void **)pp; if (p) kfree(p); }
  #define __automatic_kfree \
        __attribute__((__cleanup__(automatic_kfree_wrapper)))
  #define no_free_ptr(p) \
        ({ __auto_type __ptr =3D (p); (p) =3D NULL; __ptr; })

which I just tested generates the sane code even for the "set the ptr
to NULL and return success" case.

The above allows you to trivially do things like

        struct whatever *p __automatic_kfree =3D kmalloc(..);

        if (!do_something(p))
                return -ENOENT;

        return no_free_ptr(p);

and it JustWorks(tm).

And yes, it needs a couple of different versions of that
"__automatic_kfree()" wrapper for the different freeing cases (kvfree,
rcu_free, whatever), but those are all trivial one-liners.

And no, I didn't think too much about those names. "__automatic_kfree"
is too damn long to type, but you hated "auto". And "no_free_ptr()" is
not wonderful name either. But I tried to make the naming at least be
obvious, if not wonderful.

               Linus
