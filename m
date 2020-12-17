Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BFDC4361B
	for <rcu@archiver.kernel.org>; Thu, 17 Dec 2020 10:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B742D2389A
	for <rcu@archiver.kernel.org>; Thu, 17 Dec 2020 10:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLQKtq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Dec 2020 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgLQKtp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Dec 2020 05:49:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D6C0617A7
        for <rcu@vger.kernel.org>; Thu, 17 Dec 2020 02:49:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i24so28100627edj.8
        for <rcu@vger.kernel.org>; Thu, 17 Dec 2020 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlu9YbCN+xfICT/JHvGlkfpb81Fg0+Bwk3beGhrNPiw=;
        b=kQ3mBU2A7lUDVBNP8yRDt3btPnEiLw6T6ksbE0oUVE7uD4AL1VJUPHqmZfFojJAavk
         b2PsOCEEcpC/fH/FE5zLmMl0ZOhuWuV0c1db3vyDfKWtbDYm4PQoYuSqwq7XpcWeCFq2
         LydprRMtKdgZgdQtuqcFU0pxwmUqWUB+JJ/0QeUHJLfAICUcrHxJfBnpK6+Q6mI0XQgH
         y0mERnTItVCe11ymIATF+wLOcEJ/Ig2g+BylbhqN4kaUEo3xgk2adwkcp/ZzQEJ0K2XH
         wcixbyEbG1PLAJIP2YKqCbOjG6SVNQLp4xz0SHVjAkbucXBr5WF7SV37qD48EaaN6eIs
         91Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlu9YbCN+xfICT/JHvGlkfpb81Fg0+Bwk3beGhrNPiw=;
        b=DbIXMUWjQhiBf2IM0BIcEiBmDln8FjI1FmYgz2atvMavB+PcBEN0zSNt7Jg8cz9IQB
         W+ele1/rbreocegdRTxn4zjkC2P4nEUIqewcEN6bIbWtmYc9+qai1NVb1RbcIxrUiwlI
         4i6OyrX/mwnWf+LUeWzzDWZhi9fpHIvyCFu+xf7YabInvucw9/uiS+xBI750VW/DqJqb
         s4KrbE3poaMHGxubnCrerP0FylUuYIDSwx8Wwm8ek1Z+YqwXaGBmaA0lH45MD7goCzmY
         77pJY/RusScj8HLGBcQQ1LJjCzFSwsTzvhFzYiV99v4L35agq3GvjLj7ekWSQn/yIJ1r
         1kfw==
X-Gm-Message-State: AOAM530CRSegs9fIajQ1xYUaTNsLZJgkJ+c0S5NSUraY53YMB0XU9cHx
        ce7LwYq3Ax8DxjyEf2zcfSZUV15EJEhyxlpBbG0QuQ==
X-Google-Smtp-Source: ABdhPJz5RsUSEq4LXUEu+gfDETPHdfWF2gjImVecob/CD0EldRDfVC4tj9PvGcLX4A9AW/SaCcTttdQEdLjhxB23uYk=
X-Received: by 2002:a05:6402:229b:: with SMTP id cw27mr37587049edb.23.1608202143684;
 Thu, 17 Dec 2020 02:49:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsVud9EmeDnijucxAN49a8S5zjnML6LSmmnPTG3cO5-Hg@mail.gmail.com>
 <20201216160330.GG2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201216160330.GG2657@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Dec 2020 16:18:52 +0530
Message-ID: <CA+G9fYsqcSjzEfGerJ_bJJJ3e00Cnqe0zE9yjqfQQYM78UQgtg@mail.gmail.com>
Subject: Re: i386: rcu-torture: WARNING: at kernel/rcu/rcutorture.c:1169
 rcu_torture_writer [rcutorture]
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

Thanks for your inputs.

On Wed, 16 Dec 2020 at 21:33, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Dec 16, 2020 at 03:40:04PM +0530, Naresh Kamboju wrote:
> > Linux Kernel Functional Testing (LKFT) started running rcu-torture tests on
> > qemu_arm64, qemu_arm qemu_x86_64 and qemu_i386 from our CI build systems.
> >
> > The following warning(s) noticed on qemu_i386 while running rcu-torture test
> > on Linux mainline and Linux -next master branch. Since we do not have baseline
> > results i can not comment this as regression but when compared with
> > stable-rc 5.4 kernel this warning is new on mainline and next.
>
> The rcutorture testing "stutters", that is, it periodically intentionally
> drops the test load down to zero for a few seconds.  The expectation is
> that with no load, rcutorture will have no trouble finishing any needed
> grace periods within that zero-load period.  If at the end of the stutter
> period, RCU work remains undone, then this warning is emitted.
>
> This warning can be a false positive in the following situations:
>
> 1.      The system on which you are running rcutorture is under
>         additional heavy load.

The DUT is running the test - rcutorture - only.

> 2.      You are running multiple guest OSes, each of which is running
>         rcutorture, and vCPUs from each of the guest OSes ends up
>         sharing a core with a vCPU from one of the other guests.  This
>         can cause the zero-load period to not be so unloaded.
>
> 3.      You built rcutorture into your kernel, so that rcutorture starts
>         immediately at boot time (CONFIG_RCU_TORTURE_TEST=y).  If your
>         boot takes long enough, rcutorture can massively overload the
>         single boot CPU, which can in turn result in this warning.

The test was built as a module.
CONFIG_RCU_TORTURE_TEST=m

>
> If you are in situation #1, I suggest disabling stuttering using the
> rcutorture.stutter=0 kernel boot parameter.
>
> If you are in situation #2, I suggest binding the guest-OS vCPUs
> to avoid them sharing cores with each other.
>
> If you are in situation #3, I have patches that I expect to submit
> upstream in the v5.12 merge window that can help.  Hey, they work for me!
> If you would like to test them before then, please let me know.
>
> If something else is going on, please let me know what it is so that
> I can fix it one way or another.

We were running on qemu_i386 today. I have tested on real hardware
and the reported problem has been reproduced.

> This warning has been present for quite some time, but I continually
> make rcutorture more aggressive, and this could well be part of the
> fallout of additional rcutorture aggression.
>
> And either way, thank you for trying out rcutorture!

We are happy to test :)

- Naresh
