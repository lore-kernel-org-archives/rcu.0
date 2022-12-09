Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB3C4332F
	for <rcu@archiver.kernel.org>; Fri,  9 Dec 2022 21:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLIVvZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLIVvY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Dec 2022 16:51:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7424389ED
        for <rcu@vger.kernel.org>; Fri,  9 Dec 2022 13:51:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b13so9049172lfo.3
        for <rcu@vger.kernel.org>; Fri, 09 Dec 2022 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9R0XsnfqeHqoIAIfxozR0ZabRMe8wmId4Da2hGWSIsg=;
        b=R3j4WbAQK9nqY1gPToQMNc8ATVS5QEV5HZToNNBjsFoLiB6yd9SudD7p3DkXJRvkUT
         uuhgG/YwWlsadCOYkwAtnf/8vQspdr0SUjRoougW87eYfG8EaNSl6XVBW7Z4SB4qLctu
         dlZzVyuiszE61Yu+74mKq6rn8VWCWdABN37wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9R0XsnfqeHqoIAIfxozR0ZabRMe8wmId4Da2hGWSIsg=;
        b=ftWeFBQ3LmjfLdi3mOJ3h0TnAqHwgBTzGXpPbsmzYznFePuUY0tliFCmEL/hO6URl/
         4exwXBWTgbaA7SkLzfRJnvetFjCO6PdserZSNr/jvPixvbMaLmlu1xW+9usZtAmviE+r
         ZkoMepMUoWXlFTRlZbZYcO39ONxMpz5nSiz7KFUWBrEtGGQPVczvwK1nyqujSOxTWpYQ
         FQAYSdX6/RTEw0UuIR0GTp1SCecqhvGHWfHpmiqyAZCI6Iq1jQtCdAPbhSpkfPq3gNpM
         6wFIMYMmxszTcLJmCfKPokeLO5oU9dJdTGkNGv/on4f6MAForqajx/PvlFGYBy6MH+pw
         iqvg==
X-Gm-Message-State: ANoB5pmik+UwxMPBsSAby6E+s6MpCvEpUVjNeMTdZ08GYQlU0TCKtOBp
        XFNTyaFHhBlJXTMBZDzupiOureYUsImGM76BbB6r/Q==
X-Google-Smtp-Source: AA0mqf5C84foVZwTU3cAbuyGJeB76Ob84ixpcM5Lxf/zIQOtbVeK+yWxt+TNZQD0EX6bHGLNw/cFzbUy8r2DzGnQV2c=
X-Received: by 2002:ac2:510c:0:b0:4af:d4e:dfa7 with SMTP id
 q12-20020ac2510c000000b004af0d4edfa7mr26332168lfb.582.1670622682112; Fri, 09
 Dec 2022 13:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org>
 <20221209022305.321149-2-joel@joelfernandes.org> <20221209163759.6s7pqf5wdvy32ywn@offworld>
In-Reply-To: <20221209163759.6s7pqf5wdvy32ywn@offworld>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 9 Dec 2022 21:51:10 +0000
Message-ID: <CAEXW_YRyhXvvyiw=TrPLk4UwBThqeUh+aP_pvCiBSr6Mko2zxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 9, 2022 at 5:02 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:
>
> >The rt boosting in locktorture has a factor variable s currently large enough
> >that boosting only happens once every minute or so. Add a tunable to reduce the
> >factor so that boosting happens more often, to test paths and arrive at failure
> >modes earlier. With this change, I can set the factor to like 50 and have the
> >boosting happens every 10 seconds or so.
> >
> >Tested with boot parameters:
> >locktorture.torture_type=mutex_lock
> >locktorture.onoff_interval=1
> >locktorture.nwriters_stress=8
> >locktorture.stutter=0
> >locktorture.rt_boost=1
> >locktorture.rt_boost_factor=50
> >locktorture.nlocks=3
> >
> >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Thank you!

> >---
> > kernel/locking/locktorture.c | 12 +++++++-----
> > 1 file changed, 7 insertions(+), 5 deletions(-)
> >
> >diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >index 8968fd65a90d..b64a528e511c 100644
> >--- a/kernel/locking/locktorture.c
> >+++ b/kernel/locking/locktorture.c
> >@@ -48,6 +48,7 @@ torture_param(int, stat_interval, 60,
> > torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> > torture_param(int, rt_boost, 2,
> >               "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
> >+torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
> > torture_param(int, verbose, 1,
> >            "Enable verbose debugging printk()s");
> > torture_param(int, nlocks, 1,
> >@@ -133,12 +134,12 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
> >
> > static void __torture_rt_boost(struct torture_random_state *trsp)
> > {
> >-      const unsigned int factor = 50000; /* yes, quite arbitrary */
> >+      const unsigned int factor = rt_boost_factor;
> >
> >       if (!rt_task(current)) {
> >               /*
> >-               * Boost priority once every ~50k operations. When the
> >-               * task tries to take the lock, the rtmutex it will account
> >+               * Boost priority once every rt_boost_factor operations. When
> >+               * the task tries to take the lock, the rtmutex it will account
>
> Nit: maybe refer to it as 'rt_boost_factor'?

Sorry, I did not follow. Refer to what?

thanks,

 - Joel


>
> >                * for the new priority, and do any corresponding pi-dance.
> >                */
> >               if (trsp && !(torture_random(trsp) %
> >@@ -148,8 +149,9 @@ static void __torture_rt_boost(struct torture_random_state *trsp)
> >                       return;
> >       } else {
> >               /*
> >-               * The task will remain boosted for another ~500k operations,
> >-               * then restored back to its original prio, and so forth.
> >+               * The task will remain boosted for another 10*rt_boost_factor
> >+               * operations, then restored back to its original prio, and so
> >+               * forth.
> >                *
> >                * When @trsp is nil, we want to force-reset the task for
> >                * stopping the kthread.
> >--
> >2.39.0.rc1.256.g54fd8350bd-goog
> >
