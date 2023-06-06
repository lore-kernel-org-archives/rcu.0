Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D3C77B7A
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 23:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbjFFXXL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 19:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbjFFXXJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 19:23:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11772172D
        for <rcu@vger.kernel.org>; Tue,  6 Jun 2023 16:23:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so8229107e87.0
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686093785; x=1688685785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztzX8Ypln5t51i1Qy2TMffxcXTDyy7zyON++QBtp5gE=;
        b=R9UK+H5qUCtMwh3+/WGKzY96c0Pjj9ZDh61O4PlPXAMYfAY4adncKl8N0bgzEWlphR
         NLMgNNYiSVIEdgpeEOIbIzBlT/VlO9aPzs7JeThHvry9nRewLy4SITcy8Fo3KNW/y6U9
         biixDkBHOWAzB1H/CPexOca2EjBBypajsp0CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093785; x=1688685785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztzX8Ypln5t51i1Qy2TMffxcXTDyy7zyON++QBtp5gE=;
        b=em1Qg/LWVvTU52147kXu6LAQgs8l/TCGQ44/cg1xZO50u5t9ILovs6FwIZjzMHO2Et
         xwnjbdfblYCkDIKF9GeVS0PI5cUqiXdqDrc1m92TJ7+2NELuF0STRky7wfswgn6q71nb
         x+/tkhNIYems259fRi/F0FHZorcYRXiJhJ5dICbp/tR+NdyXZV/bAolOC/RCxDko+5yh
         eep5IwgxMXcKmvyN1Xt7i+0UKUu0HwkZChToDn7ByctTdGV0njUvCuXWSoC1klL71VMB
         gem4aNSC9/xHZ8CsK78kdAfpcUBfYP1j6GQY40X/ksovioi8WlGhI7V+nfTA6/74CZm3
         vrVA==
X-Gm-Message-State: AC+VfDxNDay/hEO7UlD4MfUY80jtUiIYSl09GsQj1JZzfLhRB1MUzbpg
        Mor10FBbKbxXyEm7U+ta4ChEDxIRhXKR0YhesEHb/KP0
X-Google-Smtp-Source: ACHHUZ7DkAu0/U7xwOzxT31KKruTPIgcKlRmljjRS4DRZvNOjgsd/zzV7Qx9STJw4+2QchqqZJt6NA==
X-Received: by 2002:ac2:538a:0:b0:4ec:8816:f4fc with SMTP id g10-20020ac2538a000000b004ec8816f4fcmr1266898lfh.6.1686093784820;
        Tue, 06 Jun 2023 16:23:04 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c10-20020a05651221aa00b004eff530efe7sm1596124lft.93.2023.06.06.16.23.04
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 16:23:04 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4effb818c37so8212324e87.3
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 16:23:04 -0700 (PDT)
X-Received: by 2002:a17:907:6e89:b0:973:da59:7c91 with SMTP id
 sh9-20020a1709076e8900b00973da597c91mr4528759ejc.51.1686093763583; Tue, 06
 Jun 2023 16:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
In-Reply-To: <20230606180806.GA942082@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 16:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
Message-ID: <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
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

On Tue, Jun 6, 2023 at 11:08=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:>
> Would it all be less offensive if I did: s/guard/cleanup/ on the whole
> thing?

It's more than "guard" for me.

What is "ptr"? Why? We already know of at least one case where it's
not a pointer at all, ie 'struct fd'.

So I *really* hate the naming. Absolutely none of it makes sense to
me. One part is a nonsensical name apparently based on a special-case
operation, and the other part is a nonsensical type from just one
random - if common - implementation issue.

What you want to do is to have a way to define and name a
"constructor/desctructor" pair for an arbitrary type - *not*
necessarily a pointer - and then optionally a way to say "Oh, don't do
the destructor, because I'm actually going to use it long-term".

I said "cleanup", but that's not right either, since we always have to
have that initializer too.

Maybe just bite the bullet, and call the damn thing a "class", and
have some syntax like

     DEFINE_CLASS(name, type, exit, init, initarg...);

to create the infrastructure for some named 'class'. So you'd have

    DEFINE_CLASS(mutex, struct mutex *,
        mutex_unlock(*_P),
        ({mutex_lock(mutex); mutex;}), struct mutex *mutex)

to define the mutex "class", and do

    DEFINE_CLASS(fd, struct fd,
        fdput(*_P),
        fdget(f), int f)

for the 'struct fd' thing.

The above basically would just create the wrapper functions (and
typedefs) for the constructor and destructor.

So the 'DEFINE_CLASS(mutex ..)' thing would basically just expand to

    typedef struct mutex *class_mutex_type;
    static inline void class_mutex_destructor(class_mutex_type *_C)
    { mutex_unlock(*_C); }
    static inline class_mutex_type class_mutex_constructor(struct mutex *mu=
tex)
    { return ({mutex_lock(mutex); mutex;}); }

Then to _instantiate_ one of those, you'd do

    INSTANTIATE_CLASS(name, var)

which would expand to

    class_name_type var
        __attribute__((__cleanup__(class_name_destructor))) =3D
class_name_constructor

and the magic of that syntax is that you'd actually use that
"INSTANTIATE_CLASS()" with the argument to the init function
afterwards, so you'd actually do

    INSTANTIATE_CLASS(mutex, n)(&sched_domains_mutex);

to create a variable 'n' of class 'mutex', where the
class_mutex_constructor gets the pointer to 'sched_domain_mutex' as
the argument.

And at THAT point, you can do this:

    #define mutex_guard(m) \
        INSTANTIATE_CLASS(mutex, __UNIQUE_ID(mutex))(m)

and now you can do

       mutex_guard(&sched_domains_mutex);

to basically start a guarded section where you hold 'sched_domains_mutex'.

And in that *very* least situation, 'guard' makes sense in the name.
But no earlier. And there is absolutely no 'ptr' anywhere here.

The above should work also for the 'struct fd' case, so you can do

       INSTANTIATE(fd, f)(fd);

to create a 'struct fd' named 'f' that is initialized with
'fdget(fd)', and will DTRT when going out of scope. Modulo any stupid
errors I did.

And ok, I didn't write out the exact macro magic to *get* those
expansions above (I just tried to write out the approximate end
result), but it should be mostly fairly straightforward.

So it would be the usual token pasting tricks to get the 'class type',
the 'class destructor' and the 'class constructor' functions.

Finally, note that the "initarg" part is a macro vararg thing. The
initargs can be empty (for things like RCU), but it could also
possibly be multiple arguments (like a "size and gfp_flags" for an
allocation?).

I'm sure there's something horribly wrong in the above, but my point
is that I'd really like this to make naming and conceptual sense.

And if somebody goes "The above is basically exactly what the original
C++ compiler did back when it was really just a pre-processor for C",
then you'd be 100% right. The above is basically (a part of) what
Bjarne did, except he did it as a separate pass.

And to answer the next question: why not just give up and do C++ -
it's because of all the *other* things Bjarne did.

             Linus
