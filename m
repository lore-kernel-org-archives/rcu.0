Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB4BC3DA7C
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 02:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiLaCmA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiLaCly (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 21:41:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB462FD
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:41:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d15so23601899pls.6
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tC0FPA0wAFy5d+yh6qFLaiiENPL3q/0NidOp+RU+in8=;
        b=cZyuxAOJijDa6PXF63Npx+UHfEhDA3IGR0L1SDaZ2ISOqV+0dujQSYE76Ls50OSUap
         81MZra8mJiUKtnC3M2llSZOtgLoUudxetKgNmJk9D0C5pDgv/mn8oELKc+paviTEjuxt
         XG9TmInLHxo4mN1XjKySvHULaOq7MjJFVq6QMj9+HHuOkpDTbZlXR4xdBzao39U+szdx
         ExUQIbSz6rrWuC/21raJJwcPMUzwLZUK13MgS1uPEyTk7XYyv1jE2mUEC3JAMSaqkq38
         9K+RQVfpT7vumd5r4RWt0PKGDacZxBSa2TVmVu2Mzx8+7qGs59u7g3c06aD7EUMGXI9n
         svqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tC0FPA0wAFy5d+yh6qFLaiiENPL3q/0NidOp+RU+in8=;
        b=44ZsqjIMwUb+lkKXwW1oKpk7U9YL6Jjgo+b3Z/Cx/a4YjCO/yg2XKYRIivI4iUdODz
         1EHtktL2u/Gse3+Mq+iM/iTCGQ4VT+M1X8sAjnchG/bFPucbk3BZWvLW8xN7d3x5kJmK
         wRjXZiQZxRCCD60rlJMguxcNRcCeqHvapl4FD7j7R6hehptfI/e0mB8vpuxqx6O+CzIP
         B99BQFxtYursH36d0cGsD1ItXKUi31G4aYWAOjhn2dC6nXuYcMCIbsbFnahBnnwk1+L7
         KcGhnwkIfKyU+fAscubdirzVURV7mqmIvF+ULlfobeWyZ4Dm6fp7WEHnDc9k5cBj8Ty4
         4Rmg==
X-Gm-Message-State: AFqh2krodtd885brGEuHknIqrTvQURsSJJSZLSPmfZBvOa+3+c06GFFI
        EL/Ik0DmbOzhUcYhaWFSBvrb8gylii05ixJY4fQ=
X-Google-Smtp-Source: AMrXdXs5vRQEeTxPyDEEDbTWONWA45akOZj1FnCnuPsAzekcbsxOJpQ4NVoUP96RnFNGGRq67MugWKlbvVmFMs/h98E=
X-Received: by 2002:a17:90a:4311:b0:214:291f:87b5 with SMTP id
 q17-20020a17090a431100b00214291f87b5mr3039414pjg.115.1672454512620; Fri, 30
 Dec 2022 18:41:52 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <CAABZP2xNJoR2ABsQ6uPEHrK-KU2WO3gRt46==n10yMZ7fNZ6mA@mail.gmail.com> <CAEXW_YT3ZGANz2w7M=WiPO6diUYz0PTkV9U14=8NssqZQa6boA@mail.gmail.com>
In-Reply-To: <CAEXW_YT3ZGANz2w7M=WiPO6diUYz0PTkV9U14=8NssqZQa6boA@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 31 Dec 2022 10:41:41 +0800
Message-ID: <CAABZP2yfVztwWEFFgCxXZwt0X81s7h4z=K33m6UXKuuywOJOvQ@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
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
>
> You can see these traces in a link in my last email. Refer to that
> email for the special trace_printk() patch as well if you fancy,
> though that is optional.
Thank Joel for your guidance! Your instruction is clear and easy to
follow! I will do it. I may report my testing result tomorrow.
>
> As a suggestion, also avoid top-posting to mailing lists [2]
Thank Joel for your guidance! Thank you for correcting my mistake,
which I have been doing like this for years.
Without your guidance, I may continue my inappropriate behavior forever.

Cheers
Zhouyi
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
