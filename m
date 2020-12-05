Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C2C1B0D9
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBA423138
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgLESTe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgLESTN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 5 Dec 2020 13:19:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17EC061A55;
        Sat,  5 Dec 2020 10:18:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607192309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6EZpf68f2D39vWu26oe3L/pHbnRkNlnx273kJRBoik=;
        b=EseygTQiWgJd3ENN8W9+BVZkdy33cAZc/KRsw0Wpf05CJZAXjfsEwzKzMI5xTzTyKykDwZ
        I3sca5QsNHWLqv7yQqexNs/wgKk9YMMvOBy/50VsjnfQETw/Gt/xljN/C4EdoDRv1Hxkcj
        8lGSutfKpHdKNvaXJUKSAPj1HDD0X2ougHGiPtFFn4CurDPQhBXBBmf71y5TM7OW3D/yMM
        MLhaFdn1R/YiUSJxXNMWO9vJOIBAmZ5VeRuoAipeRHwU3b/s77glxf/0p//SVGNaiZ/nYK
        1oEVG6ex5QvIk9R5HnJkVIi0onj1EzvGyKWOQ5UhHtHIp3dFL/AZlpY8j+is2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607192309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6EZpf68f2D39vWu26oe3L/pHbnRkNlnx273kJRBoik=;
        b=y7llYSBDv451wnQDPINLuujA91E6eTpifB6czLyd/3fSJ85rlh37DA+qoUsFlX84r7lFrr
        CuWwbPI5xoeEHiDA==
To:     Marco Elver <elver@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: BUG: KCSAN: data-race in tick_nohz_next_event / tick_nohz_stop_tick
In-Reply-To: <CANpmjNPpOym1eHYQBK4TyGgsDA=WujRJeR3aMpZPa6Y7ahtgKA@mail.gmail.com>
References: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com> <CANpmjNPpOym1eHYQBK4TyGgsDA=WujRJeR3aMpZPa6Y7ahtgKA@mail.gmail.com>
Date:   Sat, 05 Dec 2020 19:18:28 +0100
Message-ID: <87wnxw86bv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 04 2020 at 20:53, Marco Elver wrote:
> On Fri, 4 Dec 2020 at 20:04, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> LKFT started testing KCSAN enabled kernel from the linux next tree.
>> Here we have found BUG: KCSAN: data-race in tick_nohz_next_event /
>> tick_nohz_stop_tick
>
> Thank you for looking into KCSAN. Would it be possible to collect
> these reports in a moderation queue for now?

Yes please. This is the forth or fifth incarnation of report for that
data race in the tick code and I just did not come around to work on it.

> I'm currently trying to work out a strategy on how to best proceed
> with all the data races in the kernel. We do know there are plenty. On

I think having a central point where the reports are collected, i.e. a
moderation queue, is a good start. Reports like the one at hand should
stick out because they should reproduce pretty instantanious as it's an
intentional one and on NOHZ=y machines where CPUs are not fully loaded
its hard not to detect it :)

> The report below looks to be of type (A). Generally, the best strategy
> for resolving these is to send a patch, and not a report. However, be
> aware that sometimes it is really quite difficult to say if we're
> looking at a type (A) or (B) issue, in which case it may still be fair
> to send a report and briefly describe what you think is happening
> (because that'll increase the likelihood of getting a response). I
> recommend also reading "Developer/Maintainer data-race strategies" in
> https://lwn.net/Articles/816854/ -- specifically note "[...] you
> should not respond to KCSAN reports by mindlessly adding READ_ONCE(),
> data_race(), and WRITE_ONCE(). Instead, a patch addressing a KCSAN
> report must clearly identify the fix's approach and why that approach
> is appropriate."

Yes. I've seen a fair amount of 'Fix KCSAN warnings' patches which just
slap READ/WRITE_ONCE() all over the place to shut it up without any
justification. Most of them ended in limbo when asking for that
justification.

But the problem is that it is not necessarily trivial to understand code
when there are intentional data races without a lot of comments - guilty
as charged in this case. I actually felt so guilty that I sat down and
annotated and documented it now. Took me quite some time to comment all
the racy reads correctly as I really had to think about each of them
carefully again.

OTOH, in general it's a good exercise for reporters to do such analysis
and maintainers are happy to help when the analysis is not entirely
correct or comes to the wrong conclusion, e.g. assuming type B when it's
actually A. That's way better than just reports or mechanical "paper
over it" patches.

Just getting the reports over and over is not going to solve anything
because as in this case there is always more important stuff to do and
to the people familiar with the code it's clear that it's A and
therefore not urgent.

But that causes the problem that the A types are staying around for a
long time and blend over the B/C issues which are the real interesting
ones.

> This report should have line numbers, otherwise it's impossible to say
> which accesses are racing.

I just had to look at the function names to know that it is about:

tick_do_timer_cpu :)

> [ For those curious, this is the same report on syzbot's moderation
> queue, with line numbers:
> https://syzkaller.appspot.com/bug?id=d835c53d1a5e27922fcd1fbefc926a74790156cb
> ]

Confirmed :)

So you have quite some of the same report collected and there are a few
other patterns which are all related to tick_do_timer_cpu, so I assume
there is a stash of the other variants as well. And indeed:

 https://syzkaller.appspot.com/bug?id=03911d1370705fe3667dae48c9cda46d982cea30
 https://syzkaller.appspot.com/bug?id=440c51f56c3f3923f9b364679da48b0c1a0bdfe7

It might be useful to find the actual variable, data member or whatever
which is involved in the various reports and if there is a match then
the reports could be aggregated. The 3 patterns here are not even the
complete possible picture.

So if you sum them up: 58 + 148 + 205 instances then their weight
becomes more significant as well.

/me goes back to read the tick_do_timer_cpu comments once more before
posting.

Thanks,

        tglx



