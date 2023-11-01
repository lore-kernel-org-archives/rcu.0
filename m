Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D066C4332F
	for <rcu@archiver.kernel.org>; Wed,  1 Nov 2023 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjKARMX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbjKARMW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Nov 2023 13:12:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0811B
        for <rcu@vger.kernel.org>; Wed,  1 Nov 2023 10:12:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso6214866b.0
        for <rcu@vger.kernel.org>; Wed, 01 Nov 2023 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698858735; x=1699463535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dI2vPmAxG2rnU2Trg0UzI1o//xP9o8QWeSVZuORzPA=;
        b=efZJiaHrtrD1ymHaOClSB8ut4NXymIHH7BimtyzqAPny3FI3rPl+HtJUfd0jtFTDRL
         mSLrkBMy4DeZkvch/kU/Yx49g17iFSsCJOB9UDs3HsF9T0MnXRwJH5RD3sft6dYeiurE
         1XnxJyHBsdJVT4qyLK+pQEGfiZpXHXAUC/2nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858735; x=1699463535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dI2vPmAxG2rnU2Trg0UzI1o//xP9o8QWeSVZuORzPA=;
        b=WrtvnUb1Cg808nL1QXQVBLptyv26u6Ivb7yP91fz6INrspq6IFY5BOtayXRCDWx1f3
         PI7k5XjhBKpI0x9mjGDhVfNjfbAk7JceIDNX1vTU5Eo0MB6sOYZ2dSt4KSkK+a0dMoNM
         wXNctUXPu/dj9xIJrEjBK5R8eBS8OYdQ2KRAgJMacBywGi3Lqmhzy28jVOj0e82t3wrQ
         zbG0Y7yYNfS8StxonCebFRrUk/D6vdDSO7Y39+BBApGI3Ros3nLtO/EfkEwd+3jL4RcK
         MGkNAxSfYmNG+YdYQsahcAKRnMczl1WVVRVYkEppq05Dp3jx+pFd+QPrAuZLMnnKJkC4
         0Msw==
X-Gm-Message-State: AOJu0YwC9SxlPjbnvpKgXUtIkmAB/LAuzrKkoP3hJ+WXOWSZ/bkmP3+R
        m++rrSSrNIAopkOWi31kZOMsi+QtQ6w47naa1eASKg==
X-Google-Smtp-Source: AGHT+IFEPJWIKH5NFktHk+tPdyfGjmI/h1K9npJw3Tt4ROWdsKqGWoAzwDqreMWbZJ2a4Z/0bkb+4Q==
X-Received: by 2002:a17:907:1ca7:b0:9c4:344e:b496 with SMTP id nb39-20020a1709071ca700b009c4344eb496mr2527077ejc.11.1698858735246;
        Wed, 01 Nov 2023 10:12:15 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id fx18-20020a170906b75200b009ae05f9eab3sm156175ejb.65.2023.11.01.10.12.13
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:12:14 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9adca291f99so2762966b.2
        for <rcu@vger.kernel.org>; Wed, 01 Nov 2023 10:12:13 -0700 (PDT)
X-Received: by 2002:a17:907:9612:b0:9d4:2042:775b with SMTP id
 gb18-20020a170907961200b009d42042775bmr2500473ejc.30.1698858733416; Wed, 01
 Nov 2023 10:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZTuf+xNrfqGjHFDK@lothringen> <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen> <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
 <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com> <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
In-Reply-To: <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Nov 2023 07:11:54 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
Message-ID: <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 31 Oct 2023 at 15:08, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Here are the ways forward I can see:
>
> 1.      Status quo.  This has all the issues that you call out.
>         People will hurt themselves with it and consume time and effort.
>         So let's not do this.

Well, at a *minimum*, I really want that notifier chain call to be
done *after* the core printk's.

That way, if it deadlocks or does something else stupid, at least the
core printouts make it out.

IOW, I think the notifier should be done perhaps just before the
"panic_on_rcu_stall()" call, not at the top before you've even
reported any stall conditions at all.

And yes, I think the trace_rcu_stall_warning() might be better off
later too, but at least trace events are things that get regular
testing in nasty conditions (including NMI etc), so I'm *much* less
worried about those than about "random developers who think they know
what they do and add a notifier".

And yes, I do think the notifier should be narrowed down a lot, if you
actually want to keep it.

I did not actually hear you say that there is a good use-case for it.
I only saw you say "Those of us who need this", without showing *any*
kind of indication of why anybody would use it in reality.

Why the secrecy? There is certainly no current user, nor any
description of what a user would be and what makes that notifier
useful.

The commit message also just says "It is sometimes helpful" and some
strange reference to "the subsystem causing the stall to dump its
state". It all sounds very fishy. Why would anybody ever have a known
subsystem causing RCU stalls? Except, of course, for the rcutorture
testing.

Anyway, that all absolutely SCREAMS to me "this is not something
useful in any normal kernel", and so yes:

> 3.      Add a default-n Kconfig option that depends on RCU_EXPERT
>         and KEBUG_KERNEL, so that these problems can only arise in
>         specially built kernels.
>
> 4.      Same as #3, but use a kernel boot parameter instead of a
>         Kconfig option.

let's make it clear that this is *not* something that any upstream
kernel would ever do, and the *only* possible use for it is some kind
of external temporary debug patch.

See why I so hate things like this? Let's head off any crazy use long
*long* before somebody decides that "Oh, I want to use this".

               Linus
