Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42314C4332F
	for <rcu@archiver.kernel.org>; Sun,  1 Jan 2023 02:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjAACfD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 21:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAACfD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 21:35:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954864EC
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 18:35:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so25170849pjj.4
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 18:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ltWGXNIsA0zSlK8nhYjplE5mXxXa/hYSDGSdQxj+SDI=;
        b=QpRwu5wPAbG541Cxpnahgayyf4ODNh/S5O6Bc/79pkrBFWOiKiZtgBwuVXpgiR2Y/S
         rxAXL3wlsH8234NAAdV0zRjhglMh9n1AxKpXOAvj84AG85zXScfafG0y2oZvzKTtzIIv
         9JHFpR+ihf1Im32RMTZWZe/QXxnG50n9ADO4wg1ImW4KLvm9EpkLFKw++eTz9xr5FynA
         MeLawn00FmudRAKXFKp1YBKYcdBXdUydFOsewKgedyDLZwGZ3nRn1oWE9S7yarMom8AM
         fcw15dPfbb2ycV8KeQhospTlXOFGTImVjZQrwsWTXx2XsVC0dsvgQniTF6xGzT8Mpcem
         FzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltWGXNIsA0zSlK8nhYjplE5mXxXa/hYSDGSdQxj+SDI=;
        b=XU7u+O9BoQ6yofOSvk7fG65YL5BbhBeuYMdppBSHPQl3B/VF2Ql+QTL5uRSK5zk7mo
         Md0t+jhAtkbb2mKykHbSUXxThhDmJGgnR/l3iGrhz1OtmBhWaXuTJPKMqKp0Fnyzx8qR
         l/PGiOWIt7bgVets6FVUMwsHq5nHYTgI4JFd+m5f3p1QTBjSjsUtSsFBm4eA5mDrfBkO
         z/zbXvprDLWAv/axMbc7AoSGBbaHa4+j8X0OTwuSTIHvYJEg8lOAnoiyalqTWSWhPC1X
         8x0jrOcfVJDgd+CNNtKSgq4Qdds44h0e+ZhNdGch+2qs8dKoNAXV6zLDXZraEAXc9sUd
         pX7Q==
X-Gm-Message-State: AFqh2kp9EoRCIg6X4cDk64j41lwLaKZtkWR50PFH07+e014Yk2XWTD35
        e3JHEN60ZWmpbQAlDxtiOgtTRAV6q+FYDqdbDTg=
X-Google-Smtp-Source: AMrXdXsG1orz2WgxxTpCx5OMIB+D5aKnfvsdZGTDw9dM5XqZMamLQViy40Z6xsvEfDPlLN4HpSxEPv+57b+RFHjtBwU=
X-Received: by 2002:a17:90a:9f42:b0:219:5f5a:7192 with SMTP id
 q2-20020a17090a9f4200b002195f5a7192mr2659572pjv.144.1672540499661; Sat, 31
 Dec 2022 18:34:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <CAABZP2xNJoR2ABsQ6uPEHrK-KU2WO3gRt46==n10yMZ7fNZ6mA@mail.gmail.com> <CAEXW_YT3ZGANz2w7M=WiPO6diUYz0PTkV9U14=8NssqZQa6boA@mail.gmail.com>
In-Reply-To: <CAEXW_YT3ZGANz2w7M=WiPO6diUYz0PTkV9U14=8NssqZQa6boA@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 1 Jan 2023 10:34:48 +0800
Message-ID: <CAABZP2xdiWeT8bVzGgU6ZKNXf4ri13sz-AL4sjUd3T7SUDf5eA@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 10:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Dec 30, 2022 at 9:04 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > Hi Joel
> >
> > As a beginner, I am interested and I have time, could you tell me
> > where to download 6.0.16-rc2-g50f737b34ede when you are convenient?
> > And could you tell me which torture command you are invoking? I may
> > help to do some tests ;-)
>
> Sure Zhouyi, You can checkout linux-6.0.y from the stable tree [1] and
> easily reproduce it via:
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5
> --configs "25*TREE07"
> This will take 2 hours to run a total of 25 tests of TREE07. The main
> interest is in the shutdown stage.
>
> If you want to collect traces when the RCU stall triggers, you can do
> something like:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5
> --configs 20*TREE07 --bootargs
> "trace_event=sched:sched_switch,sched:sched_waking,sched:sched_wakeup,rcu:rcu_callback,rcu:rcu_fqs,rcu:rcu_grace_period
> ftrace_dump_on_oops panic_on_warn=1 sysctl.kernel.panic_on_rcu_stall=1
> sysctl.kernel.max_rcu_stall_to_panic=1" trace_buf_size=300K --kconfig
> "CONFIG_RCU_TRACE=y CONFIG_DEBUG_INFO_DWARF5=y
> CONFIG_RANDOMIZE_BASE=n"
Preliminary test results:
Linux 6.0.16-rc2 (git head f54b936f8ec7)
1) Dell PowerEdge R270 two Intel(R) Xeon(R) CPU E5-2660 128G memory:
total 80(4*20) rounds of TREE07
77 of them finished without error
3 of them  reported "rcu: INFO: rcu_sched detected stalls on CPUs/tasks" [1]

2) Lenovo Thinkpad P1 gen 4 i7-11800H 64G memory
total 100(5*20) rounds of TREE07
all 100 finished without error

[1] http://154.220.3.115/logs/20230101/console.log

I learned a lot during this process, and am very interested in this
problem, there is still much for me to learn.

Happy New Year to you, Paul and all RCUers ;-)

Cheers
Zhouyi
>
> You can see these traces in a link in my last email. Refer to that
> email for the special trace_printk() patch as well if you fancy,
> though that is optional.
>
> As a suggestion, also avoid top-posting to mailing lists [2]
>
> Cheers,
> Joel
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> [2] https://kernelnewbies.org/mailinglistguidelines
>
> >
> > Cheers
> > Zhouyi
> >
> > On Sat, Dec 31, 2022 at 9:46 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > Hello,
> > >
> > > I have been firefighting a hang on 6.0.y stable kernels with
> > > rcutorture. It happens mostly consistently when TREE07 is shutting
> > > down.
> > >
> > > It appears that the RCU torture threads are attempted to stop but the
> > > shutdown thread, but are constantly awakened by a timer softirq
> > > handler in ksoftirqd context. When they wake up, they immediately goto
> > > sleep in uninterruptible state until the next time a timer handler
> > > wakes them up. It appears the timer softirq is long enough to cause
> > > RCU stalls and I see it calling 100s of timer function handlers
> > > (call_timer_fn).
> > >
> > > I am doing some more investigation with trace_printk(s):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> > >
> > > Regarding the timer handlers, I was wondering if it is possible that a
> > > large number of timer handlers constantly queued can cause RCU stalls
> > > due to the timer softirq taking a very long time. That certainly
> > > appears to be the case here. Shouldn't the timer softirq also do
> > > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > > many of them?
> > >
> > > Here is a full log with trace dump if you anyone wants to take a look:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
> > > And the res directory:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/
> > >
> > > Any thoughts on any patches 6.0 might be missing?
> > >
> > > Meanwhile, debug here continues... thanks,
> > >
> > >  - Joel
