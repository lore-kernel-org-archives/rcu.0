Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70255C433FE
	for <rcu@archiver.kernel.org>; Fri, 18 Nov 2022 12:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiKRMIu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiKRMIu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Nov 2022 07:08:50 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18D1004C
        for <rcu@vger.kernel.org>; Fri, 18 Nov 2022 04:08:48 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j16so7863401lfe.12
        for <rcu@vger.kernel.org>; Fri, 18 Nov 2022 04:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DIX+XfLWCJCMAe8SUAEX63Y07+s97211MfFN1rtoXkA=;
        b=B9jww+bRwW9dwWiN2tw+vKYapFp4mTPLHgOcqzqgmWgT+9oYVqe1Exhlo8yEUPElqa
         I+i1rx9T8dxcAzO0dYsiS1IJ/jwartrnF3oOoL38X0tVp1FQvgomXtDcT8P7QUVtlU8m
         S//Nh+lyyfY9fHN1eHLdiV7vGcHiTOCV6PMWFSGhCI1dVTMZGI6rKmdl2I9gUvZAhN7d
         GnmeY0/l9KIN/yGqd0+z2pgK8vDbyyoUmA/+YiYmo9oRfdYi9zcz6dMwObnSRFLgxOd5
         6xXoBBo2JmRtWXYwwQtW6+HMyKRQC4vDIBLPMnc4fIoUnUqRO9xh4vWdgRmUPr3Or6Z3
         7QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIX+XfLWCJCMAe8SUAEX63Y07+s97211MfFN1rtoXkA=;
        b=TQbiRKF/gPHSGCbG2daWjmQU88HUSNqd1eJ9rlz1xcCf1Tr6qiXLYcLkngJMH9dy6B
         Wy84zxsTv6XZ+qQQbDezzg6vTcX85YSH5WrP7MzeUFgHCok5Hh+1zUy4F2Y1V4hKoeR8
         bbfa5CTPK5v2NCLVp2IxCf7xMrObcaZDscuRXHvIN65OrQzRwIwEREj30vPhyWZo6bGr
         qNs9DhVJHmExhSRXVBYliyeiY2R7ycWZbn7tAmOocDtAftUVSt+Wc22vUOReM52Srz6A
         UbN7UUfJp8um5MS2PcHgYBvvgCpagcKzTcJOPCddUgy6nUWtbnRFQSNzwUp/yahqe6ta
         B/tQ==
X-Gm-Message-State: ANoB5pkKCzj5I2MEIjNJSdhYpNrVEsBNDjk913tm046qub0nAFjGpgN1
        dWNU+D21JrAiaKt4spofReBNFnqb/eklJiNwag==
X-Google-Smtp-Source: AA0mqf5J4vUNtjLHIYFRZMnB2K1FeQFuRxgYBPmXxhazlwMtzxevX7ShUOYPOttZX3G1DqRFnwY1xTz/Th/hZv060Sg=
X-Received: by 2002:ac2:5f42:0:b0:4a2:645b:15cd with SMTP id
 2-20020ac25f42000000b004a2645b15cdmr2217160lfz.308.1668773327031; Fri, 18 Nov
 2022 04:08:47 -0800 (PST)
MIME-Version: 1.0
References: <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
 <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1> <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
 <Y2v3qM3hwca7Rc2P@google.com>
In-Reply-To: <Y2v3qM3hwca7Rc2P@google.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 18 Nov 2022 20:08:35 +0800
Message-ID: <CAFgQCTv+cYijiZ_exiyqPgtUNg7j4mV8aKD=Ko0ccu5ude3CkQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 10, 2022 at 2:55 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Nov 07, 2022 at 08:07:26AM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 03, 2022 at 09:51:43AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 31, 2022 at 11:24:37AM +0800, Pingfan Liu wrote:
> > > > On Fri, Oct 28, 2022 at 1:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Mon, Oct 10, 2022 at 09:55:26AM +0800, Pingfan Liu wrote:
> > > > > > On Mon, Oct 3, 2022 at 12:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > >
> > > > > > > > But unfortunately, I did not keep the data. I will run it again and
> > > > > > > > submit the data.
> > > > > > >
> > > > > >
> > > > > > I have finished the test on a machine with two sockets and 256 cpus.
> > > > > > The test runs against the kernel with three commits reverted.
> > > > > >   96926686deab ("rcu: Make CPU-hotplug removal operations enable tick")
> > > > > >   53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full
> > > > > > IRQ entry")
> > > > > >   a1ff03cd6fb9c5 ("tick: Detect and fix jiffies update stall")
> > > > > >
> > > > > > Summary from console.log
> > > > > > "
> > > > > >  --- Sat Oct  8 11:34:02 AM EDT 2022 Test summary:
> > > > > > Results directory:
> > > > > > /home/linux/tools/testing/selftests/rcutorture/res/2022.10.07-23.10.54
> > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > > > 125h --bootargs rcutorture.onoff_interval=200
> > > > > > rcutorture.onoff_holdoff=30 --configs 32*TREE04
> > > > > > TREE04 ------- 1365444 GPs (3.03432/s) n_max_cbs: 850290
> > > > > > TREE04 no success message, 2897 successful version messages
> > > > > > Completed in 44512 vs. 450000
> > > > > > TREE04.10 ------- 1331565 GPs (2.95903/s) n_max_cbs: 909075
> > > > > > TREE04.10 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.11 ------- 1331535 GPs (2.95897/s) n_max_cbs: 1213974
> > > > > > TREE04.11 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.12 ------- 1322160 GPs (2.93813/s) n_max_cbs: 2615313
> > > > > > TREE04.12 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.13 ------- 1320032 GPs (2.9334/s) n_max_cbs: 914751
> > > > > > TREE04.13 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.14 ------- 1339969 GPs (2.97771/s) n_max_cbs: 1560203
> > > > > > TREE04.14 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.15 ------- 1318805 GPs (2.93068/s) n_max_cbs: 1757478
> > > > > > TREE04.15 no success message, 2897 successful version messages
> > > > > > Completed in 44510 vs. 450000
> > > > > > TREE04.16 ------- 1340633 GPs (2.97918/s) n_max_cbs: 1377647
> > > > > > TREE04.16 no success message, 2897 successful version messages
> > > > > > Completed in 44510 vs. 450000
> > > > > > TREE04.17 ------- 1322798 GPs (2.93955/s) n_max_cbs: 1266344
> > > > > > TREE04.17 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.18 ------- 1346302 GPs (2.99178/s) n_max_cbs: 1030713
> > > > > > TREE04.18 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.19 ------- 1322499 GPs (2.93889/s) n_max_cbs: 917118
> > > > > > TREE04.19 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > ...
> > > > > > TREE04.4 ------- 1310283 GPs (2.91174/s) n_max_cbs: 2146905
> > > > > > TREE04.4 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.5 ------- 1333238 GPs (2.96275/s) n_max_cbs: 1027172
> > > > > > TREE04.5 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.6 ------- 1313915 GPs (2.91981/s) n_max_cbs: 1017511
> > > > > > TREE04.6 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.7 ------- 1341871 GPs (2.98194/s) n_max_cbs: 816265
> > > > > > TREE04.7 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.8 ------- 1339412 GPs (2.97647/s) n_max_cbs: 1316404
> > > > > > TREE04.8 no success message, 2897 successful version messages
> > > > > > Completed in 44511 vs. 450000
> > > > > > TREE04.9 ------- 1327240 GPs (2.94942/s) n_max_cbs: 1409531
> > > > > > TREE04.9 no success message, 2897 successful version messages
> > > > > > Completed in 44510 vs. 450000
> > > > > > 32 runs with runtime errors.
> > > > > >  --- Done at Sat Oct  8 11:34:10 AM EDT 2022 (12:23:16) exitcode 2
> > > > > > "
> > > > > > I have no idea about the test so just arbitrarily pick up the
> > > > > > console.log of TREE04.10 as an example. Please get it from attachment.
> > > > >
> > > > > Very good, thank you!
> > > > >
> > > > > Could you please clearly indicate what you tested?  For example, if
> > > > > you have an externally visible git tree, please point me at the tree
> > > > > and the SHA-1.  Or send a patch series clearly indicating what it is
> > > > > based on.
> > > > >
> > > >
> > > > Yes, it is a good way to eliminate any unexpected mistakes before a rigid test.
> > > >
> > > > Please clone it from https://github.com/pfliu/linux.git  branch:
> > > > rcu#revert_tick_dep
> > >
> > > Thank you very much!
> > >
> > > > > Then I can try a long run on a larger collection of systems.
> > > > >
> > > >
> > > > Thank you very much.
> > > >
> > > > > If that works out, we can see about adjustments to mainline.  ;-)
> > > > >
> > > >
> > > > Eager to see.
> > >
> > > I ran 200 hours of TREE04 and got an RCU CPU stall warning.  I ran 2000
> > > hours on v6.0, which precedes these commits, and everything passed.
> > >
> > > I will run more, primarily on v6.0, but that is what I have thus far.
> > > At the moment, I have some concerns about this change.
> >
> > OK, so I have run a total of 8000 hours on v6.0 without failure.  I have
> > run 4200 hours on rcu#revert_tick_dep with 15 failures.  The ones I
> > looked at were RCU CPU stall warnings with timer failures.
> >
> > This data suggests that the kernel is not yet ready for that commit
> > to be reverted.
>
> Even if the tests pass, can we really survive with this patch
> that he reverted?
> https://github.com/pfliu/linux/commit/03179ef33e8e2608184ade99a27f760f9d01e6b7
>
> If stop machine on a CPU spends a good amount of time in kernel mode, while a
> grace period starts on another CPU, then we're kind of screwed if we don't
> have the tick enabled right?
>

In this case, I think multi_cpu_stop()->rcu_momentary_dyntick_idle()
can serve this purpose.

Thanks,

    Pingfan

> Or, did we make any changes to stop machine such that, that's no longer an
> issue?
>
> thanks,
>
>  - Joel
>
