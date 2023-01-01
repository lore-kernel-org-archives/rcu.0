Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED0C4167B
	for <rcu@archiver.kernel.org>; Sun,  1 Jan 2023 05:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjAAFuC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 1 Jan 2023 00:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAFuB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 1 Jan 2023 00:50:01 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789F63A2
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 21:50:00 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id i19so13279921ljg.8
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 21:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K/qodtnECgxgeVsKbqaNVZRriEX5jqpStrRCEQRKepU=;
        b=ZEKUJ45/HNJv7nedr1ddvOV2PXkJNJ9PPAtJo8LIR68v6t5uiT2khNzEaoB+fg6iBR
         HnNFscY5Wonmup4VwRgek672gRG3rjcjrZ0eLBq+LvixQPQQpVQGdMj0neE1zK1zngPj
         i5rUEH+U0PiFAZu96IcxaqlnT+Ocjw4fjv9eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/qodtnECgxgeVsKbqaNVZRriEX5jqpStrRCEQRKepU=;
        b=XK1w1Pi4Qw3FNKLpBNpnOsOtKp2z9bdPDfBxMBoON4Duj55KJEtWBzWq/qZwowbMyK
         DNF0b+uzHBdPqHJLl6o4QOp85EcJeGoNVcPh4HkRKayH3dRgy3cvcyeNNOPO4W+PIfBe
         eBeO4GU/yj5Zib64Sk2SU3e6tEJJftSkn6+ar/3d/B1dnBHT5NarqFlZfKSYKjRTooyN
         Cf7RPnXdPUcBh1WLqF2jaTsY5PMB+maDBXHewqo1JB5SILiow+qMXhEjzowSy4lj95j8
         SHdgMWmkuP7uGo96DPbclviXVQSM2fPVxaxycOx+fTkPLotzCE+f17lddQfhCvzuVTzs
         GEAw==
X-Gm-Message-State: AFqh2krL+sBz3FAzbNbBhJBL61HCGgc3DdFadG9mELrkdxqciNSSfOaY
        1cO98Kow6tdQ73Of11OehvkXUjDG63menJc6bFDb4XeCIvndSiK8
X-Google-Smtp-Source: AMrXdXvactH6jvyqOXgOSP/ZPWcKpk67Fe8kX4rPVezglr4G+sYz4Bfm27kAEZOdsALBjHUEkSrda7SVrlCCy3D81nI=
X-Received: by 2002:a2e:3c15:0:b0:27f:dca1:8584 with SMTP id
 j21-20020a2e3c15000000b0027fdca18584mr747136lja.313.1672552199003; Sat, 31
 Dec 2022 21:49:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
 <20221231164650.GU4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YT9dAUc69igExbL0OC4C_Re58uvQ=oa3s2CQZ_xbefMQQ@mail.gmail.com>
 <CAEXW_YTwH-XyxWq3gNRo-xBxPEH-gYLjQt+aGp81TFGwuYsGtA@mail.gmail.com> <20230101051620.GZ4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230101051620.GZ4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 1 Jan 2023 00:49:52 -0500
Message-ID: <CAEXW_YTeGNDUKA1qxXA0LF6qm190HkKoYqd7EKen71zo8XvNdQ@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jan 1, 2023 at 12:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Dec 31, 2022 at 06:10:40PM -0500, Joel Fernandes wrote:
> > On Sat, Dec 31, 2022 at 4:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Sat, Dec 31, 2022 at 11:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > > > Hmmm...  Some of the tasks run at relatively high priority.  Maybe they
> > > > need to de-prioritize themselves before looping waiting to be stopped.
> > > > These loops look like this:
> > > >
> > > >         while (!kthread_should_stop()) {
> > > >                 torture_shutdown_absorb("rcu_torture_boost");
> > > >                 schedule_timeout_uninterruptible(1);
> > > >         }
> > >
> > > Yes, it appears this tight loop is live locked with the timer softirq.
> > > I am trying a run with higher timeout to see if it helps.
> > >
> > > >
> > > > Or it might be something else...
> > >
> > > I see that kthread_should_stop() returns false, but
> > > torture_must_stop_irq() returns true in the tight while loop mentioned
> > > above. So it seems like the shutdown notifier triggered first. I am
> > > seeing various "is stopping" messages. However I see no "End-test"
> > > messages, which means I think the torture_shutdown_hook() never ran
> > > properly, or something. Anyway now I am doing heavy tracing in
> > > rcu_torture_cleanup() to see what it is upto. My suspicion is it did
> > > not even call torture_stop_kthread() and we are stuck without the
> > > kthreads being stopped.
> >
> > Now all tests pass always if I do the following change in torture_stopping():
> >
> > - schedule_timeout_uninterruptible(1);
> > + schedule_timeout_uninterruptible(50);
> >
> > Current theory is, the timer softirq preempts the cleanup thread
> > before it can call kthread_stop().
> >
> > Anyway, let me know if this is an acceptable change (or not). I think
> > checking for shutdown state 20 times per seconds instead of 1000 times
> > per second is kind of reasonable.
>
> Make that schedule_timeout_uninterruptible(HZ / 20) and sold!

Thanks! I'll send a patch shortly. I think I nailed it correctly. The
problem is fullstop is set to FULLSTOP_RMMOD , before kthread_stop()
is called. This causes all the rcutorture threads to enter the tight
loop in kthread_stopping(). Further this can happening in a thundering
herd fashion with every thread queueing timers constantly causing the
timer softirq to stall a writer which just happened to be executing
synchronize.

I just did a 100 runs with HZ/20 and all pass.

Patch on the way. Thanks,

 - Joel
