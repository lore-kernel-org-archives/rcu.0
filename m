Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B2C77B7E
	for <rcu@archiver.kernel.org>; Mon, 29 May 2023 19:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjE2TEo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 29 May 2023 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjE2TEn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 29 May 2023 15:04:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C55DF
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 12:04:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-973f8dbcc02so297154366b.3
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685387079; x=1687979079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5zBwPFXpBZ+0YOoFtMUsfZzhL5fV2k18YHtphZDnq0=;
        b=YiJryPkzyZLFS8Ewrd/zMQOPZLnDUvPvwnrb2cPasNj5YfkhhGqcSBlxxLBpNAoo6i
         6wwhFTG5aff5mSs+KESAKxwAZ/fm25kxwpeykxYn7Vy2Ydm8F1O102prN7WT748Ztt6h
         mQPz7RWMldB53/1snQzHbjl1XY49UPARjbhFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685387079; x=1687979079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5zBwPFXpBZ+0YOoFtMUsfZzhL5fV2k18YHtphZDnq0=;
        b=Uh5u9YPfpMQJlknLzEVC+LzIQnFxKK2wauGYKYlDt19uOImGQydftza69SogEw6P6n
         xuJZFjDRGtJzRA56ARwQQFr67TwJF4jvRRDzNEKn/LUwfkeEXn8RquIZcGWpjzxzJeA+
         l4MbIdnaRFbTM2Pvz2xkR4qFpzbEPl8JaQp3vI3QXJb8IUAuXZGgYKXn7nxRYYKV8B3b
         jYIk+pjIJIFoM4aduLyIxvKZ727a0PEZ5bnV6ubTwestVTuEBplaozYIKmItO0t2Fi9Y
         IiQR41QaiU0Ij+DfTyFT8a6MEgpY7aCXuD9AlcEqiOoC4giDwNIuzlfVa7ttGrTyW6sr
         zmsA==
X-Gm-Message-State: AC+VfDzUx8fguo9xYaChJGlSzUF0h6ADB0D4r9aLTcbpYpbEE3s8CPD0
        +1NPExHVg1FaiiB0Wbxc7X4iuUPLRUcREj5UREeLPQij
X-Google-Smtp-Source: ACHHUZ47ho4ptkkmJQ4a+NCes2ddERyxjwCljNzeDKKqGu+C8f1fWBg5whF+yMgHG6xx/j4qPcjg6w==
X-Received: by 2002:a17:907:9722:b0:95e:d448:477 with SMTP id jg34-20020a170907972200b0095ed4480477mr161051ejc.33.1685387079087;
        Mon, 29 May 2023 12:04:39 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id kq10-20020a170906abca00b00960005e09a3sm6209358ejb.61.2023.05.29.12.04.38
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 12:04:38 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-973f8dbcc02so297151566b.3
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 12:04:38 -0700 (PDT)
X-Received: by 2002:a17:907:c29:b0:965:6075:d100 with SMTP id
 ga41-20020a1709070c2900b009656075d100mr181880ejc.39.1685387057821; Mon, 29
 May 2023 12:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
In-Reply-To: <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 15:04:00 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com>
Message-ID: <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ian Lance Taylor <iant@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 29, 2023 at 8:09=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Sat, May 27, 2023 at 9:18=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > It's also an example of something people need to be aware of: the
> > auto-releasing is not ordered. That may or may not be a problem. It's
> > not a problem for two identical locks, but it very much *can* be a
> > problem if you mix different locks.
>
> It is guaranteed. It would be nice to have it documented, but if you
> look at the intermediate representation of this simple example:

Well, I can see that it might be doing that reverse ordering in
practice, but for the life of me, I can't actually find anything that
says it is guaranteed.

Google did find me one blog post by Ian Lance Taylor from 2008 that
said that yes, each __cleanup__ attribute basically creates its own
little scope, and that the cleanup in reverse declaration order is
thus guaranteed.

Let's add Ian to the cc, partly to confirm it wasn't just a random
implementation detail, but also partly to perhaps ask him to get
somebody to document it.

Because if it's not documented, how do we know that the clang
implementation of that attribute then ends up also guaranteeing the
reverse order cleanup, even if gcc might guarantee it?

I *suspect* - but cannot find any guarantees - that it's going to
match C++ destructors, and you probably end up pretty much always
having to deal with these cleanup functions in reverse order, so it
all sounds very likely to me.

And maybe it's even documented somewhere that neither of us could find.

Anyway, I do like the option to use cleanup functions, but I think
we'd better make sure, since we really may require nesting for locks
(even if in many cases it won't matter).

Ian? Any chance you can either point us at documentation, or maybe
just confirm it, and hopefully make said documentation happen?

            Linus
