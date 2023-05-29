Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FEC77B7A
	for <rcu@archiver.kernel.org>; Mon, 29 May 2023 21:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjE2V1k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 29 May 2023 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2V1k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 29 May 2023 17:27:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380FC7
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 14:27:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51403554f1dso5870064a12.1
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685395657; x=1687987657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61VW9HGCWfC0EBNWmKXJZsShQWh32M3fbrHZIXCR3TY=;
        b=U3I8SFoSTJQGKd0KbkytvoP9Y0hMEHn9UPJ7sFvc8RRifXO9kw2+49NOAKMtW2iMon
         vIzYh8oavMm4JGQMOXSdgINIjPakWqorYYvtbPFvGO/1IWb/bMg0+tn4qIE8zSmGprEk
         9mxstWX+wTXOFK6tDDoPUzTc/vi9lAho3+sEbZvW8lJ+yANTwEDP8ZytHk8P4oAylsMc
         7ftzwcTYEQI8vTaVpb1ppw40L+Jg5T8MQZBfrLSmLq3tvSX19s/rHMOfE83JX75jgHTB
         MwbA8TcsUKHdxF3UmItsSw8938aJGFLgEqIm3MUV3/0akou3Xp3uiE4ydUZcxJZ6RKRY
         IL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685395657; x=1687987657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61VW9HGCWfC0EBNWmKXJZsShQWh32M3fbrHZIXCR3TY=;
        b=V7jfJScbd1SrJ5rRvKmaKGYA/cHT2UqwOT42D3tnt/nVcerte9NaGuv+CC0ZnSDnl7
         JT+pmzEPldafzXOM5o3OOD11VZ1V23zO6NhfW/SYRnKkshw6VS0XCsVAVYGa81hok43m
         NVr4jTPrAj/q5eKtVCNYQYcIJ/BzQIaQvqwL989CF6GBom1RHPO63HF7FbP79WwIFvak
         5qWIc3BoS/VixIi0JSh8SuxQjeoewaNw8gKD5mlI0JVMzLfFEomhp0XU7rb8gnJ3AjNl
         lPXBbr7MR37vs9Eqb7yVRIMLVHnynxNbICCYcFbfVA616RGEtQLVlH1U9RUE5K+N3d7u
         yWGQ==
X-Gm-Message-State: AC+VfDzdrMGufaS1dnoGEIoAgyM7H9YBl0ONu8n3PVAMTVex5iYcbiQT
        ybA1yjlPzBhHXnBWsSQE0HsdAXVaApEiab9DXyfOeA==
X-Google-Smtp-Source: ACHHUZ4+zZff9YbZNmvXfqMcj4QpYOSj7tSzXl9/IVjLSIjL17vIdhAUK7X+TJpb472mfoAEOr6h7EudD5cM+QcYFAg=
X-Received: by 2002:a17:907:7296:b0:96f:e45f:92e9 with SMTP id
 dt22-20020a170907729600b0096fe45f92e9mr359475ejc.16.1685395656834; Mon, 29
 May 2023 14:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com> <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com>
From:   Ian Lance Taylor <iant@google.com>
Date:   Mon, 29 May 2023 14:27:25 -0700
Message-ID: <CAKOQZ8w_X8GyqE6xg2oY31hYkDWCPnVjLpdOK5Xo4E+ZMdJ9nA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
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

On Mon, May 29, 2023 at 12:04=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, May 29, 2023 at 8:09=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Sat, May 27, 2023 at 9:18=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > It's also an example of something people need to be aware of: the
> > > auto-releasing is not ordered. That may or may not be a problem. It's
> > > not a problem for two identical locks, but it very much *can* be a
> > > problem if you mix different locks.
> >
> > It is guaranteed. It would be nice to have it documented, but if you
> > look at the intermediate representation of this simple example:
>
> Well, I can see that it might be doing that reverse ordering in
> practice, but for the life of me, I can't actually find anything that
> says it is guaranteed.
>
> Google did find me one blog post by Ian Lance Taylor from 2008 that
> said that yes, each __cleanup__ attribute basically creates its own
> little scope, and that the cleanup in reverse declaration order is
> thus guaranteed.
>
> Let's add Ian to the cc, partly to confirm it wasn't just a random
> implementation detail, but also partly to perhaps ask him to get
> somebody to document it.
>
> Because if it's not documented, how do we know that the clang
> implementation of that attribute then ends up also guaranteeing the
> reverse order cleanup, even if gcc might guarantee it?
>
> I *suspect* - but cannot find any guarantees - that it's going to
> match C++ destructors, and you probably end up pretty much always
> having to deal with these cleanup functions in reverse order, so it
> all sounds very likely to me.
>
> And maybe it's even documented somewhere that neither of us could find.
>
> Anyway, I do like the option to use cleanup functions, but I think
> we'd better make sure, since we really may require nesting for locks
> (even if in many cases it won't matter).
>
> Ian? Any chance you can either point us at documentation, or maybe
> just confirm it, and hopefully make said documentation happen?


It was a while ago, but I expect that I was just thinking of the
implementation.  I agree that the documentation could be clearer.  I
filed https://gcc.gnu.org/PR110029.

Ian
