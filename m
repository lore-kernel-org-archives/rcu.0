Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC1FC77B73
	for <rcu@archiver.kernel.org>; Fri, 26 May 2023 21:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbjEZV5S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 May 2023 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244312AbjEZV4e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 May 2023 17:56:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D8E5F
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 14:55:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso2143198a12.0
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685138119; x=1687730119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS3kqGVuLq0Clh8JmF5WGl1IDCwum22o6Kw3GqzDB2I=;
        b=W8W03I3p9cr8E9bt3dWZNfjpKQMdFBm5qwbY3/LOJIQE5cBor6Px+x5FruwmN9Rw9M
         f9yLaVqzVTESWHkLsJXYb/A2//DibtfQ10LUjDEa5+F3gsS4+JbRb5aBkourNsGap1lE
         Au1XD4U9A1e0CTWuJml1l6P5oy2fg2TG1AJcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138119; x=1687730119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS3kqGVuLq0Clh8JmF5WGl1IDCwum22o6Kw3GqzDB2I=;
        b=S9WKWYfjX7EAJ+Lnhg3+2PX5OJ/vjkJ7kZxYBuwLUIcqRt8jQVpJim5oKBS2PF5lpF
         9RtBKWc7d1AVJI+PI47oko0/gWaV0CGKfTBvDx01lBxYG1vXc7apg6ym8hTiS6EFv5FN
         x6lNbpfPzCeLrcy4HvbIMkdT4MYsq36g5HoUO2/NGDgiVilbtcQ8dkJtFzjxROX2MfSo
         x1kfEujas5eo97+BkiGf5+qwFU1MPNRUN5tGeKdnwP+5omcyTPtJGphj450l89keP3x7
         FI0awRQv2JgOqqANXnv3qxyaYlhs/u77YJJvKC00QoMLDq0JZbDCKEm4TPyIEXyCLLGp
         eYUA==
X-Gm-Message-State: AC+VfDwFP8aORyhpA2mKEzwSZp3b3yHXlc7QjOcHNEnNwdcerZKC58Zk
        SyCtKMpMDQfKwIcowZDne+swcxkKM3Jw90uKpOOpNCEj
X-Google-Smtp-Source: ACHHUZ7vm2zT9tbxytsM2TMk9meJBpJrgPcXlu49rqyArCG1JdLmhe42KXATwOT3ilTHVVGKCTVAPw==
X-Received: by 2002:aa7:dcc6:0:b0:50d:91c8:9e10 with SMTP id w6-20020aa7dcc6000000b0050d91c89e10mr2425150edu.10.1685138118853;
        Fri, 26 May 2023 14:55:18 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7da45000000b005148e981bd3sm180948eds.12.2023.05.26.14.55.18
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:55:18 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-970028cfb6cso231266966b.1
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 14:55:18 -0700 (PDT)
X-Received: by 2002:a17:907:7f0b:b0:96f:e080:4f56 with SMTP id
 qf11-20020a1709077f0b00b0096fe0804f56mr3497831ejc.31.1685138098025; Fri, 26
 May 2023 14:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <20230526205855.587341916@infradead.org>
 <20230526212454.GB4057254@hirez.programming.kicks-ass.net>
In-Reply-To: <20230526212454.GB4057254@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 14:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgt=cq_fU33DCv0=xD30sH8eOGHsEQRJQi=2vtrWt7oPQ@mail.gmail.com>
Message-ID: <CAHk-=wgt=cq_fU33DCv0=xD30sH8eOGHsEQRJQi=2vtrWt7oPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] locking: Introduce __cleanup__ based guards
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
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 26, 2023 at 2:25=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>> > +                                                                     =
        \
> > +static inline void ptr_guard_##_type##_cleanup(_Type **_ptr)          =
       \
> > +{                                                                     =
       \
> > +     _Type *_G =3D *_ptr;                                             =
         \
> > +     if (_G)                                                          =
       \
> > +             _Put(_G);                                                =
       \
> > +}
> > +
> > +#define ptr_guard(_type, _name)                                       =
               \
> > +     ptr_guard_##_type##_t _name __cleanup(ptr_guard_##_type##_cleanup=
)
> > +
>
> Ha, and then I wanted to create an fdput() guard... :/

I have to say, I'm not super-convinced about the macros to create
these guard functions and types.

I suspect that it would be better to literally just declare the guard
types directly.  For the fdget idiom, you really just want the guard
type to *be* the 'struct fd'.

And I think you made those macros just make too many assumptions.

It's not just "struct fd", for example.  If you want to do things like
wrap 'local_irq_save', again it's not a pointer, the context is just
'unsigned long irqflags'.

And I really don't think those type-creation macros buy you anything.

What's wrong with just writing it out:

    typedef struct fd guard_fdget_type_t;
    static inline struct fd guard_fdget_init(int fd)
    { return fdget(fd); }
    static inline void guard_fdget_exit(struct fd fd)
    { fdput(fd); }

and

    typedef struct mutex *guard_mutex_type_t;
    static inline struct mutex *guard_mutex_init(struct mutex *mutex)
    { mutex_lock(mutex); return mutex; }
    static inline void guard_mutex_exit(struct mutex *mutex)
    { mutex_unlock(mutex); }

I don't think the latter is in the *least* less readable than doing

    DEFINE_LOCK_GUARD_1(mutex, struct mutex,
                mutex_lock(_G->lock),
                mutex_unlock(_G->lock))

which is this magic macro that creates those, and makes them
completely ungreppable - and makes the type system very inflexible.

So I really think that it would be a lot easier to write out the
wrappers explicitly for the few types that really want this.

I dunno.

Once again, I have written example code in my MUA that I have not
tested AT ALL, and that may be fundamentally broken for some very
obvious reason, and I'm just too stupid to see it.

             Linus
