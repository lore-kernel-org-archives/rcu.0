Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E0C77B7C
	for <rcu@archiver.kernel.org>; Sat, 27 May 2023 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjE0TSs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 27 May 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0TSr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 27 May 2023 15:18:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F4D3
        for <rcu@vger.kernel.org>; Sat, 27 May 2023 12:18:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4d6aee530so2004957e87.2
        for <rcu@vger.kernel.org>; Sat, 27 May 2023 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685215123; x=1687807123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiZDicadLOv4XdKaxJfdtxSHBlAKSLxuzhTSlpG/fpI=;
        b=T8cMUQ79n7frJxzUf3BFrw9g1qBEwoGDayFHjhY5vxP6kO/SreM1+HdnSt9a7mnxG4
         rFUVfX/rsUvMCD4DNix9UeH2I5m2UviSlfXhfE82oB+wTXrcP2dTKUg1/ce2Q7dCoP6v
         Fbxl9BuJbdfsOh2OGEBcrM9I8abvXm0u/JECk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685215123; x=1687807123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiZDicadLOv4XdKaxJfdtxSHBlAKSLxuzhTSlpG/fpI=;
        b=iFXyQfF0rw+RrQMhKlGY0nfCea0hyfj2DZcU+fBO0AjX+xYDVvwAML63ou4fxi7VnP
         VtIotep/No6SDgDe+d2gPlxSZ5bONxqFfaM0MbOeSAcRMYur2NEQIzCltEsWm1OacpLS
         1NOYvP/HmvR7Y78jcLfo+hArVXEh+49cwMLTHrJUyp51+Q9eB1jHvEPIwDAMrNIzQbEu
         TpXeHYMe55y2naBerxgeUwxDSrMl87nj1oDi9Pdf8AQKZFJTAzsZ70vntWMvwQGfFgi7
         pkXGGb4gCS+WtYIfkN/gAb59MxEj9jGXCGNOQb1bQ8bH/6yXl2CPzbNnorwuxcK9Xmqw
         jkaQ==
X-Gm-Message-State: AC+VfDwHrBhSkpqpkDu0IUEUN9jNcF7uVBv0whyrtlNEhwi11Hi+gscN
        Kh2a0XyoOpXS3webGWDRwm0B4reuyWCvJo6YCZH0ig==
X-Google-Smtp-Source: ACHHUZ4ZSUqjPg9+beDOtJ+GnM3fhHzNwP4ASUV0Ip7nxzK8VJudaogNZ2aMuTn+LnQZ4oZZ0O16Kw==
X-Received: by 2002:a05:6512:481:b0:4cb:280b:33c9 with SMTP id v1-20020a056512048100b004cb280b33c9mr1916033lfq.24.1685215122951;
        Sat, 27 May 2023 12:18:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u7-20020a056512040700b004f1482d9db6sm1248409lfk.155.2023.05.27.12.18.42
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 12:18:42 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so2009488e87.1
        for <rcu@vger.kernel.org>; Sat, 27 May 2023 12:18:42 -0700 (PDT)
X-Received: by 2002:aa7:d70d:0:b0:514:8e4a:2d72 with SMTP id
 t13-20020aa7d70d000000b005148e4a2d72mr2607269edq.22.1685215100909; Sat, 27
 May 2023 12:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org>
In-Reply-To: <20230526205204.861311518@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 May 2023 12:18:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
Message-ID: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
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
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 26, 2023 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> By popular demand, a new and improved version :-)

Well, I certainly find the improved version more legible, despite my
further comment about the type macros being too complicated.

But now I've slept on it, and I think the problem goes beyond "macros
being too complicated".

I actually think that the whole "create a new scope" is just wrong. I
understand why you did it: the whole "its' going out of scope" is part
of the *idea*.

BUT.

Adding a new scope results in

 (a) pointless indentation

 (b) syntax problems with fighting the limited syntax of for loops

 (c) extra dummy variables - both for the for loop hack, but also for
the scope guard thing itself

and none of the above is an *advantage*.

So how about we take a step back, and say "what if we don't create a
new scope at all"?

I think it actually improves on everything. The macros become
*trivial*. The code becomes more legible.

And you can have multiple different scopes very naturally, or you can
just share a scope.

Let me build up my argument here. Let's start with this *trivial* helper:

    /* Trivial "generic" auto-release macro */
    #define auto_release_name(type, name, init, exit) \
        type name __attribute__((__cleanup__(exit))) =3D (init)

it's truly stupid: it creates a new variable of type 'type', with name
'name', and with the initial value 'init', and with the cleanup
function 'exit'.

It looks stupid, but it's the *good* stupid. It's really really
obvious, and there are no games here.

Let me then introduce *one* other helper, because it turns out that
much of the time, you don't really want to  pick a name. So we'll use
the above macro, but make a version of it that just automatically
picks a unique name for you:

    #define auto_release(type, init, exit) \
        auto_release_name(type, \
                __UNIQUE_ID(auto) __maybe_unused, \
                init, exit)

again, there are absolutely no games here, it's all just very very
straightforward. It's so straightforward that it all feels stupid.

But again, it's the 'S' in "KISS". Keep It Simple, Stupid.

And it turns out that the above two trivial macros are actually quite
useful in themselves. You want to do an auto-cleanup version of
'struct fd'? It's trivial:

    /* Trivial "getfd()" wrapper */
    static inline void release_fd(struct fd *fd)
    { fdput(*fd); }

    #define auto_getfd(name, n) \
        auto_release_name(struct fd, name, fdget(n), release_fd)

and now you can write code like this:

    int testfd(int fd)
    {
        auto_getfd(f, fd);
        /* Do something with f.file */
        return f.file ? 0 : -EBADF;
    }

Which is really trivial, and actually pretty legible.

Note that there is no explicit "scope" here. The scope is simply
implicit in the code. The compiler will verify that it's at the
beginning of the block, since we do that
-Wdeclaration-after-statement, so for the kernel this is always at the
beginning of a scope anyway.

And that's actually a big advantage. You want to deal with *two* file
descriptors? Sure. Just do this:

    /* Do two file descriptors point to the same file? */
    int testfd2(int fd1, int fd2)
    {
        auto_getfd(f1, fd1);
        auto_getfd(f2, fd2);
        return f1.file && f1.file =3D=3D f2.file;
    }

and it JustWorks(tm). Notice how getting rid of the explicit scoping
is actually a *feature*.

Ok, so why did I want that helper that used that auto-genmerated name?
The above didn't use it, but look here:

    /* Trivial "mutex" auto-release helpers */
    static inline struct mutex *get_mutex(struct mutex *a)
    { mutex_lock(a); return a; }

    static inline void put_mutex(struct mutex **a)
    { mutex_unlock(*a); }

    #define auto_release_mutex_lock(lock) \
        auto_release(struct mutex *, get_mutex(lock), put_mutex)

That's all you need for a nice locked region.

Or how about RCU, which doesn't have a lock type? Just do this:

    struct rcu_scope;

    static inline struct rcu_scope *get_rcu(void)
    { rcu_read_lock(); return NULL; }

    static void put_rcu(struct rcu_scope **a)
    { rcu_read_unlock(); }

    #define auto_release_rcu_lock() \
        auto_release(struct rcu_scope *, get_rcu(), put_rcu)

and you're done. And how you can *mix* all these:

    int testfd2(int fd1, int fd2)
    {
        auto_release_mutex_lock(&cgroup_mutex);
        auto_release_rcu_lock();
        auto_getfd(f1, fd1);
        auto_getfd(f2, fd2);
        return f1.file && f1.file =3D=3D f2.file;
    }

Ok. The above is insane. But it's instructive. And it's all SO VERY SIMPLE.

It's also an example of something people need to be aware of: the
auto-releasing is not ordered. That may or may not be a problem. It's
not a problem for two identical locks, but it very much *can* be a
problem if you mix different locks.

So in the crazy above, the RCU lock may be released *after* the
cgroup_mutex is released. Or before.

I'm not convinced it's ordered even if you end up using explicit
scopes, which you can obviously still do:

    int testfd2(int fd1, int fd2)
    {
        auto_release_mutex_lock(&cgroup_mutex);
        do {
                auto_release_rcu_lock();
                auto_getfd(f1, fd1);
                auto_getfd(f2, fd2);
                return f1.file && f1.file =3D=3D f2.file;
        } while (0);
    }

so I don't think the nasty "scoped()" version is any better in this regard.

And before you say "unlock order doesn't matter" - that's actually not
true. Unlock order does matter when you have things like
"spin_lock_irq()" where the irq-off region then protects other locks
too.

If you do the "unlock_irq" before you've released the other spinlocks
that needed irq protection, you're now screwed.

Final notes:

 - I think the above is simpler and objectively better in every way
from the explicitly scoped thing

 - I do think that the auto-release can be very dangerous for locking,
and people need to verify me about the ordering. Maybe the freeing
order is well-defined.

 - I also suspect that to get maximum advantage of this all, we would
have to get rid of -Wdeclaration-after-statement

That last point is something that some people will celebrate, but I do
think it has helped keep our code base somewhat controlled, and made
people think more about the variables they declare.

But if you start doing consecutive cleanup operations, you really end
up wanting to do thigns like this:

    int testfd2(int fd1, int fd2)
    {
        auto_getfd(f1, fd1);
        if (!f1.file)
                return -EBADF;
        auto_getfd(f2, fd2);
        if (!f2.file)
                return -EBADF;
        return do_something (f1, f2);
    }

and you basically *have* to allow those declarations in the middle -
because you don't want to clean up fd2 in that "f1 failed" case, since
f2 doesn't exist yet.

                  Linus
