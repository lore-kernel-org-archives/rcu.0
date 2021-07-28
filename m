Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E931C4320A
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 17:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AAA61051
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 17:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhG1R6a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhG1R6a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 13:58:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1688C0613C1
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 10:58:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a26so5502185lfr.11
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=st4BTmD3GjnmfHHn6gBxGtmKTmgLmjzYeVnW05cJn0A=;
        b=ckWa5YRohsLqQWO833u/brAzgJGjnutI0P6k82Ud0JVlkVyx7vXtjeSjndZo0mo9mY
         aUBFUVbZIGxF8sMqdngYvzcbCq4CVB2g472PBpiQFre1Kadno8zglUzss61LiyuhHL4n
         DC0o633dF8JUNRXshWFolyaCmL/kwVHPjrAXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st4BTmD3GjnmfHHn6gBxGtmKTmgLmjzYeVnW05cJn0A=;
        b=rrU9TsabQ5PV8fNU58tgIa0lSGTwZ2jcUgAMr57K7BMXeTcH1n38YKojTgSOYLyNKI
         jbFVGZD3mpFvbj35VT9xZqO00sQTA1QwWUktyblakmTLN+BvfjzgOVo8ZSO5qb88YcLP
         b+Xzpc6neEkHcJwpC429UvPziKVoW4qS4YE34iY0NCWbrRCfICLECENuxhGmB4iAzTpT
         pDKV7qNqzlwy5/hWKFLlrOHrgZq0OTp4391rCAABtlEhLtu4gPTg1PxyPydoyTY27K2D
         K0NBOQ/TSeSkEbzdQ8etfyX4AeIovPYZ5HHoCE9ukxOp16xFN+rj8b96QPtUEfW0r5O4
         Ak+A==
X-Gm-Message-State: AOAM531u9mjj6nsw6iN4x7bu26vpwuNPdlWONjwyz+ehThc7eAi0bvlI
        wZCllB4L7Piwnx80X/SbTzeWDOohAuGf1OHshKg=
X-Google-Smtp-Source: ABdhPJyfL6hJUSST6IoulN5hq7oxgE46iDyEB+JY7APjwReESYEAIaHxX7SPwnA7pQU5eJgdQlZFtg==
X-Received: by 2002:a05:6512:3e4:: with SMTP id n4mr562829lfq.88.1627495105916;
        Wed, 28 Jul 2021 10:58:25 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m25sm61133lfq.209.2021.07.28.10.58.24
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 10:58:24 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u3so5525535lff.9
        for <rcu@vger.kernel.org>; Wed, 28 Jul 2021 10:58:24 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr533031lfv.201.1627495104323;
 Wed, 28 Jul 2021 10:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jul 2021 10:58:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
Message-ID: <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
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

On Wed, Jul 28, 2021 at 10:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> +/*
> + * Increment the current CPU's rcu_data structure's ->dynticks field
> + * with ordering.  Return the new value.
> + */
> +static noinstr unsigned long rcu_dynticks_inc(int incby)
> +{
> +       return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> +}

Maybe inline?

But more I reacted to how we sadly don't have percpu atomics. They'd
be fairly easy to add on x86, but I guess it's not a huge deal.

And hey, if this is pretty much the only place that would use them, I
guess that's not much of an issue.

             Linus
