Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B5C433FE
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 23:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE3A23135
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 23:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgLEXr5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 5 Dec 2020 18:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLEXr4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 5 Dec 2020 18:47:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59BDC0613CF;
        Sat,  5 Dec 2020 15:47:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607212034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCD+MM2ELmrBKfWFSQdz97hYPn7ejqug1YoM2ZlKSVU=;
        b=VyPbPWrI1bxz1ctAMcXAteyGb/wjM2BQkNGgg26A8YU/N9ribTwowxtdSbsLnaHsYgPoGB
        Wo6d+5hBRxmaJMUtpgIrvoEfRVwdSjzy0N2kO9JetY/CjyizlnyR8dukzAd55+3VrU00ZM
        AVkdTrzoIlMF0DoLsFFWQDYr9UCD7eLkBZUYDyLdy38EervQy3MlCzP7Tg9wyUYMlochiO
        UPFQwel5WVfpY6oiwvi+xS9xsALi4LlD9BrWA2ZYj6WzzKkFbvPRZJMnb5pO5vhUtYEE7B
        bmg9qrK3uiJoJBay2+KSBNTM9gg7nKnax+4wqOp3zqIhvD5H5xckKVyKkafbgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607212034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCD+MM2ELmrBKfWFSQdz97hYPn7ejqug1YoM2ZlKSVU=;
        b=05aQoE1F9U/F18I37fUGznt/ZaaLvFTUNj0MvApH+5DQGoIvUTh4Mut1AjkJabBY6Pg91k
        ADR9Cy9L2HozUqBg==
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
In-Reply-To: <87wnxw86bv.fsf@nanos.tec.linutronix.de>
References: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com> <CANpmjNPpOym1eHYQBK4TyGgsDA=WujRJeR3aMpZPa6Y7ahtgKA@mail.gmail.com> <87wnxw86bv.fsf@nanos.tec.linutronix.de>
Date:   Sun, 06 Dec 2020 00:47:13 +0100
Message-ID: <87eek395oe.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 05 2020 at 19:18, Thomas Gleixner wrote:
> On Fri, Dec 04 2020 at 20:53, Marco Elver wrote:
> It might be useful to find the actual variable, data member or whatever
> which is involved in the various reports and if there is a match then
> the reports could be aggregated. The 3 patterns here are not even the
> complete possible picture.
>
> So if you sum them up: 58 + 148 + 205 instances then their weight
> becomes more significant as well.

I just looked into the moderation queue and picked stuff which I'm
familiar with from the subject line.

There are quite some reports which have a different trigger scenario,
but are all related to the same issue.

  https://syzkaller.appspot.com/bug?id=f5a5ed5b2b6c3e92bc1a9dadc934c44ee3ba4ec5
  https://syzkaller.appspot.com/bug?id=36fc4ad4cac8b8fc8a40713f38818488faa9e9f4

are just variations of the same problem timer_base->running_timer being
set to NULL without holding the base lock. Safe, but insanely hard to
explain why :)

Next:

  https://syzkaller.appspot.com/bug?id=e613fc2458de1c8a544738baf46286a99e8e7460
  https://syzkaller.appspot.com/bug?id=55bc81ed3b2f620f64fa6209000f40ace4469bc0
  https://syzkaller.appspot.com/bug?id=972894de81731fc8f62b8220e7cd5153d3e0d383
  .....

That's just the ones which caught my eye and all are related to
task->flags usage. There are tons more judging from the subject
lines.

So you really want to look at them as classes of problems and not as
individual scenarios.

Thanks,

        tglx


