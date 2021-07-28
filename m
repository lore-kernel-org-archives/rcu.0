Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1545C432BE
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8292B60BD3
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 19:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhG1TCy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhG1TCy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 15:02:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A0C061757
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 12:02:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y7so2424486eda.5
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mLJclBpYBjhUfUWPAk4A67K9qVvzDPVHZO2WkQdA/g=;
        b=T07r2c1vyn3l3czDvtg1PT8m1MuOm+AE7RG7tSRhBnbgravg9PfJwDbDkF+a1k0NQr
         AfGvVfhBaow/QsjhXEHnz1RPeEKfFGDu28W7gYXNRoiQJ/4z5tgPJ8XFl5ItVK+yF8qa
         NxCa9TsGsc+a3NyUtJskbZHARtKEs+5g0Gm+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mLJclBpYBjhUfUWPAk4A67K9qVvzDPVHZO2WkQdA/g=;
        b=UU39r1AWrhAlKAoWAyhab0Un1lhuRvyrUx9qV6dhNC0MAEDS198Kxhp31+GZMMBwa6
         pYnDJLyDImgF0jZKvUIpMXyNDnqa23QYd656xb+9XBQfF30kBbjx6crChUggrwVLJrgR
         h8EEBaukrlm0O9Yn/HexdjHLJQi68d2dsGr2aIcWmceWBGOwZp/1m9axd2tlYqfd3UeJ
         OgJbNRlRrxhM5oXuxOC/pDFJTGHGWTrWmlq7n52H7D4J5sZSw6qTwaQjkaNelr1maoBy
         6uVIq8k65la9tTkoV31GYUmlKkW2gwvqF5IKSf/pCK/VIqSxofEsqeYqRjNzsqo9GdVt
         /KrQ==
X-Gm-Message-State: AOAM531sGbI0yzp21yKZhe22gz/kRmtSy1LSg1gnFU1cyyLro1JbrpiV
        vvM489Z2x1Pkb+pELRwoRQyf/JmJFErwTje0HIs=
X-Google-Smtp-Source: ABdhPJxB5ERjH2vRkjQtgDRnWPMjtll0XgQYUBUXrxYXkkhJCou2wrS5qO+sq7UerUdvmj1thsV1Lg==
X-Received: by 2002:a05:6402:1d37:: with SMTP id dh23mr1489342edb.360.1627498969971;
        Wed, 28 Jul 2021 12:02:49 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id o17sm185273ejb.84.2021.07.28.12.02.49
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 12:02:49 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id hp25so6219159ejc.11
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 12:02:49 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr681760lfv.201.1627498650428;
 Wed, 28 Jul 2021 11:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com> <20210728184605.GI4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210728184605.GI4397@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jul 2021 11:57:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-5vtA_-9xs6zV0U20LRaRhVeE1Ky7X+9kHeucrb6_ig@mail.gmail.com>
Message-ID: <CAHk-=wj-5vtA_-9xs6zV0U20LRaRhVeE1Ky7X+9kHeucrb6_ig@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
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

On Wed, Jul 28, 2021 at 11:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> But atomic_read_this_cpu(&rcu_data.dynticks) isn't all that much shorter
> than atomic_read(this_cpu_ptr(&rcu_data.dynticks)).

It's not so much that it's shorter to write for a human, it's that we
could generate better code for it.

That atomic_read(this_cpu_ptr()) pattern generates code like

        movq    $rcu_data+288, %rax
        add %gs:this_cpu_off(%rip), %rax
        movl    (%rax), %eax

but it *could* just generate

        movl %gs:rcu_data+288, %rax

instead.

Similar patterns for the other per-cpu atomics, ie it would be
possible to just generate

        lock ; xaddl %gs:..., %rax

instead of generating the address by doing that "add %gs:this_cpu_off" thing..

But no, it doesn't look like there are enough users of this to matter.
We're just talking a few extra bytes, and a couple of extra
instructions (and possibly slightly higher register pressure, which
then generates more instructions).

The *expensive* part remains the SMP serialization of the "lock".

                Linus
