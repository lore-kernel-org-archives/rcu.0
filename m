Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22A9C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5C36101B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhGUUBa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGUUBa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:01:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9FC061757
        for <rcu@vger.kernel.org>; Wed, 21 Jul 2021 13:42:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m16so5084450lfg.13
        for <rcu@vger.kernel.org>; Wed, 21 Jul 2021 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csX/v4wZK/8khKbWOQHMHKPVkpan3K/PQpV5i6hI1c0=;
        b=RIOdAP9M9gXS951krhcwLpREAahAyipS213qzagLjn9qzHnaba4oO8CHqBJEXCWXL8
         +FxzgIvAS2ZmXmep4rv8XOlP7+zh/uTP17V4d0uuaZivHXqxLDzTHqsr8T2h/2tfvOG+
         baDbARcSNcjAOApHnuGY1cVlFgtvbyDiPc0Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csX/v4wZK/8khKbWOQHMHKPVkpan3K/PQpV5i6hI1c0=;
        b=RHU8bWJ1HVs5ymQGNLxzFGdRYnsG/NBvWShd7pNkBXDotzqWdPzyd7k3SUkRriar0K
         v4Ge21DGFm7t1oFjGUQ+y7TY5L4bo0NATtQ9F1CWOQg6HBb4Cxv308sk08LUrYEMxaHA
         mX6Qrsjz0OFJe8fuUiqfJ9j2aekJusnr2boXjyk071w8HGKmRAHky3EeQWJmbu1JYWkR
         i4jnIZ4yI96HPtHdhCl/hyg1g3EgDA+MtvKK7M6UFAhdqqUVwYXHA/2tKWtRC4lN8791
         hbqewZl78uukIhFcwwY0aPDw8Emn4pBGpgKGAb6UmHElwIX64+gZX5uvg/T8temV7kYm
         ICHw==
X-Gm-Message-State: AOAM530DrLlzCULezGb8jdjnw4/ta3lk1Lq0Qu9B/8JZw2CMD9VrJJuI
        ElsnepmcOHoCRV3hB/+obI7gLwoUpcEO6A8X
X-Google-Smtp-Source: ABdhPJyX0ExtkGJYyvKyD277LTwFx+w9zDPvju5T5hpjjjF1VfqDUCK100LYW0i9oG2l8E6+Pvxk/A==
X-Received: by 2002:ac2:5e3c:: with SMTP id o28mr28164908lfg.592.1626900123978;
        Wed, 21 Jul 2021 13:42:03 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id j21sm1814643lfg.56.2021.07.21.13.42.02
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:42:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b16so3400135ljq.9
        for <rcu@vger.kernel.org>; Wed, 21 Jul 2021 13:42:02 -0700 (PDT)
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr16138636ljg.465.1626900121924;
 Wed, 21 Jul 2021 13:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1> <20210721202127.2129660-4-paulmck@kernel.org>
In-Reply-To: <20210721202127.2129660-4-paulmck@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 13:41:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgm_W82CcbiJHZPw45QRwomFbWcHkFoOd5C5hG-5GGoRQ@mail.gmail.com>
Message-ID: <CAHk-=wgm_W82CcbiJHZPw45QRwomFbWcHkFoOd5C5hG-5GGoRQ@mail.gmail.com>
Subject: Re: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hmm.

This actually seems to make some of the ordering worse.

I'm not seeing a lot of weakening or optimization, but it depends a
bit on what is common and what is not.

On Wed, Jul 21, 2021 at 1:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> +/*
> + * Increment the current CPU's rcu_data structure's ->dynticks field
> + * with ordering.  Return the new value.
> + */
> +static noinstr unsigned long rcu_dynticks_inc(int incby)
> +{
> +       struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +       int seq;
> +
> +       seq = READ_ONCE(rdp->dynticks) + incby;
> +       smp_store_release(&rdp->dynticks, seq);
> +       smp_mb();  // Fundamental RCU ordering guarantee.
> +       return seq;
> +}

So this is actually likely *more* expensive than the old code was, at
least on x86.

The READ_ONCE/smp_store_release are cheap, but then the smp_mb() is expensive.

The old code did just arch_atomic_inc_return(), which included the
memory barrier.

There *might* be some cache ordering advantage to letting the
READ_ONCE() float upwards, but from a pure barrier standpoint this is
more expensive than what we used to have.

> -       if (atomic_read(&rdp->dynticks) & 0x1)
> +       if (READ_ONCE(rdp->dynticks) & 0x1)
>                 return;
> -       atomic_inc(&rdp->dynticks);
> +       rcu_dynticks_inc(1);

And this one seems to not take advantage of the new rule, so we end up
having two reads, and then that potentially more expensive sequence.

>  static int rcu_dynticks_snap(struct rcu_data *rdp)
>  {
> -       return atomic_add_return(0, &rdp->dynticks);
> +       smp_mb();  // Fundamental RCU ordering guarantee.
> +       return smp_load_acquire(&rdp->dynticks);
>  }

This is likely cheaper - not because of barriers, but simply because
it avoids dirtying the cacheline.

So which operation do we _care_ about, and do we have numbers for why
this improves anything? Because looking at the patch, it's not obvious
that this is an improvement.

              Linus
