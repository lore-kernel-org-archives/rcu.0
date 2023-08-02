Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB2C04A6A
	for <rcu@archiver.kernel.org>; Wed,  2 Aug 2023 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjHBRPz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Aug 2023 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjHBRPt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Aug 2023 13:15:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8FB2D5F
        for <rcu@vger.kernel.org>; Wed,  2 Aug 2023 10:15:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98377c5d53eso11781866b.0
        for <rcu@vger.kernel.org>; Wed, 02 Aug 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690996530; x=1691601330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=us0CaLITIVnj4VszPxxEKlt0TWFj+St3gLNGsd+vgGs=;
        b=I87QIEgEOfD0erNsso/RsE+BnF4Ke9+vXkkU7TBuVWEEQ3RCJfQYLZJBtppH49HiyI
         mY+ItaaJHj9yqK64y8KKhIrEUUUQJEQfXIC9veybAjTVDYEwYpVU/dL9yT0A2rWq5QHd
         0bhFaN0xNiM3zpjoQRA5ldUElZjqSNR7mEJKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996530; x=1691601330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=us0CaLITIVnj4VszPxxEKlt0TWFj+St3gLNGsd+vgGs=;
        b=NkRADuC8J6A/hdU/1PaXrKbpIuK7uNpj/VC2PntiVnVcaR+qNuUbDxIrHG1O6eEDNe
         klptjNnrLER10kjU3oy4lvsjXe+geOX7UrSsGw3uv6/doJtMFV1F34V2AXe/RjrK36ue
         hgRzYB1imxRdXazsj9b+4FIfQJqLbQW2+V7sUgKc8uqRmqPVLBUGcFtmOFf7ZktxpVsE
         c1apQgxkp62Ay1kGVrHnUV5AXdQ1v3IAbeV0u4c0LkSqbPipBn4YG7nvOE3TDHWoSzBy
         5PCt2sr72UQx9qM49fDWbkf9AkXvR/KgePNuiBAD1uyvXRBsWwohg30+6cdzV4uDbNw9
         UNHA==
X-Gm-Message-State: ABy/qLZvb2uKpHcOXqqzOtHd/FmhEdKIvG9Ezn+7bB7Zydb34pM6p3PN
        9I5osCrE38pVt6Xxttrdk8P/174afi32bKPCzB3idftr
X-Google-Smtp-Source: APBJJlHAYDoPtVRRwB2uNShARMhteR09RkdXkwVTNs0sWWZzpdDybgFOuMluK100qJtP8GpvI79qEQ==
X-Received: by 2002:a17:906:74d7:b0:991:b834:af83 with SMTP id z23-20020a17090674d700b00991b834af83mr5873903ejl.59.1690996529907;
        Wed, 02 Aug 2023 10:15:29 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709067b5000b009927a49ba94sm9357480ejo.169.2023.08.02.10.15.29
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:15:29 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so9632990a12.2
        for <rcu@vger.kernel.org>; Wed, 02 Aug 2023 10:15:29 -0700 (PDT)
X-Received: by 2002:a19:6d17:0:b0:4fb:89e2:fc27 with SMTP id
 i23-20020a196d17000000b004fb89e2fc27mr4136280lfc.54.1690996508881; Wed, 02
 Aug 2023 10:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net> <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net> <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de> <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net> <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net> <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
In-Reply-To: <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 10:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5iESP-=gJSHe0Mfi=Xh2HdSsy+nm8NSr7DbXB9aBDGQ@mail.gmail.com>
Message-ID: <CAHk-=wj5iESP-=gJSHe0Mfi=Xh2HdSsy+nm8NSr7DbXB9aBDGQ@mail.gmail.com>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
To:     paulmck@kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Roy Hopkins <rhopkins@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Two quick comments, both of them "this code is a bit odd" rather than
anything else.

On Tue, 1 Aug 2023 at 12:11, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h

Why is this file called "tasks.h"?

It's not a header file. It makes no sense. It's full of C code. It's
included in only one place. It's just _weird_.

However, more relevantly:

> +               mutex_unlock(&rtp->tasks_gp_mutex);
>                 set_tasks_gp_state(rtp, RTGS_WAIT_CBS);

Isn't the tasks_gp_mutex the thing that protects the gp state here?
Shouldn't it be after setting?

>                 rcuwait_wait_event(&rtp->cbs_wait,
>                                    (needgpcb = rcu_tasks_need_gpcb(rtp)),
>                                    TASK_IDLE);

Also, looking at rcu_tasks_need_gpcb() that is now called outside the
lock, it does something quite odd.

At the very top of the function does

        for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {

and 'smp_load_acquire()' is all about saying "everything *after* this
load is ordered,

But the way it is done in that loop, it is indeed done at the
beginning of the loop, but then it's done *after* the loop too, so the
last smp_load_acquire seems a bit nonsensical.

If you want to load a value and say "this value is now sensible for
everything that follows", I think you should load it *first*. No?

IOW, wouldn't the whole sequence make more sense as

        dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
        for (cpu = 0; cpu < dequeue_limit; cpu++) {

and say that everything in rcu_tasks_need_gpcb() is ordered wrt the
initial limit on entry?

I dunno. That use of "smp_load_acquire()" just seems odd. Memory
ordering is hard to understand to begin with, but then when you have
things like loops that do the same ordered load multiple times, it
goes from "hard to understand" to positively confusing.

         Linus
