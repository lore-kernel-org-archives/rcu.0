Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0CC432BE
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 01:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D465C60F9E
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 01:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhIABEm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Aug 2021 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbhIABEl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Aug 2021 21:04:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED9C061575
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 18:03:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q3so1299975edt.5
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Og2XeLLtBDyQbgZF40moaeubFtlUHVE06sOHR2tsRHs=;
        b=B1ZDrgpE8Fz5Q2c3nyWfPKKalpP10I5KztGo2sQF1uY6PEtiGUOQL3He7qlrm8nSHf
         yYbZyNtApEcJxJP5Za5emr9jiQ3g+OIGCVyHFb3jGWvY/btWBU9UdLAv0LxdmH0flad9
         ErmTqSZSpt8y8/Rq1uIC+IIubM7IpHgj/J8rG36mTvEWgJ+x61HkBMA2KNdHC3Qf+yf/
         VAbsJYuBStORBNk9XkNh4a433rC60wPM3q0f6aXifKf013VU4dfuOUAfalLQ/lSZ4g7p
         uJuX7/KmJqAKblkbynxUJDwIAdaXz+shxOJSnePvxrQHxe1ttDj221jlQ92/4VaLnREE
         Zrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og2XeLLtBDyQbgZF40moaeubFtlUHVE06sOHR2tsRHs=;
        b=lYIRNRa31yTce66n6r1/CyMV/bubL2R1EtRGxSg5jms0VcJHtfZ1lW264pNReq2avZ
         YG2yOXb95s587cClF3qC4kOJwU4inpeuxK3opYPtcDToCOMZLMhOrpklfRLlBipgQtCo
         AA0g/vPBozBR9Hg7tRGar90sUkL2TZ4P7VknoyX2WunMl6lYfPMQmXxwIDzC8LNBK0M8
         dYAHW72Fi455dgF9+YU/gBvTvlePq8Lcm51i5f9B96T/K/vwBM3rSZ+lHeVpDwPgXXgl
         IF1Lz88dnvBqQwQ3+vQ14yvMC42SJqr99YSyWSA9ayE9JDV0UWSvcKBvWLTW9W/sMcGw
         PHsw==
X-Gm-Message-State: AOAM530NOTLsBCVNGgztZNH5hlq2jrw9WQNyxsm/Dn95ue7g4L+HCd37
        A+g+BKtj9rqWrqV9s+VzJxyqKbSniHmoN8nodps=
X-Google-Smtp-Source: ABdhPJzS13zlLX9f5v7YH5ZUNeeL9gre2rXFbLFjq3BtXfcNmmHeW1mfS0YcUHMl9MKkKLWw3KVUdofvBPFF645TctY=
X-Received: by 2002:a05:6402:221b:: with SMTP id cq27mr21568440edb.374.1630458224183;
 Tue, 31 Aug 2021 18:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210831152144.GA28128@trex> <CAABZP2xGnSLVbgxqjKMq=Oj_H7rYfYjuCvmBpmZ4tRptGs3SEw@mail.gmail.com>
 <CAABZP2wUdToiAWOAgqDZrZtkuEdrXEv9GDgbioW3PZAyseOSgA@mail.gmail.com>
In-Reply-To: <CAABZP2wUdToiAWOAgqDZrZtkuEdrXEv9GDgbioW3PZAyseOSgA@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 1 Sep 2021 09:03:32 +0800
Message-ID: <CAABZP2zg8c_gkm4+h4-mPCv_uDf5-iJFHEExCDFoES0jmBeuKw@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
List-Id: <soc.lore.kernel.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

I  perform following two new rounds of experiments:


Test environment (x86_64 debian10 virtual machine: kvm -cpu host -smp
8 -hda ./debian10.qcow2 -m 4096 -net
user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
-vnc :30)

1.   CONFIG_RCU_BOOST=y
1.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
1.2 as regular user at the same time, run $stress-ng --sequential 100
--class scheduler -t 5m --times

System begin OOM kill after 6 minutes:
31 19:41:12 debian kernel: [  847.171884] task:kworker/1:0     state:D
stack:    0 pid: 1634 ppid:     2 flag\
s:0x00004000
Aug 31 19:41:12 debian kernel: [  847.171890] Workqueue: ipv6_addrconf
addrconf_verify_work
Aug 31 19:41:12 debian kernel: [  847.171897] Call Trace:
Aug 31 19:41:12 debian kernel: [  847.171903]  __schedule+0x368/0xa40
Aug 31 19:41:12 debian kernel: [  847.171915]  schedule+0x44/0xe0
Aug 31 19:41:12 debian kernel: [  847.171921]
schedule_preempt_disabled+0x14/0x20
Aug 31 19:41:12 debian kernel: [  847.171924]  __mutex_lock+0x4b1/0xa10
Aug 31 19:41:12 debian kernel: [  847.171935]  ? addrconf_verify_work+0xa/0x20
Aug 31 19:41:12 debian kernel: [  847.171948]  ? addrconf_verify_work+0xa/0x20
Aug 31 19:41:12 debian kernel: [  847.171951]  addrconf_verify_work+0xa/0x20
Aug 31 19:41:12 debian kernel: [  847.171955]  process_one_work+0x1fa/0x5b0
Aug 31 19:41:12 debian kernel: [  847.171967]  worker_thread+0x64/0x3d0
Aug 31 19:41:12 debian kernel: [  847.171974]  ? process_one_work+0x5b0/0x5b0
Aug 31 19:41:12 debian kernel: [  847.171978]  kthread+0x131/0x180
Aug 31 19:41:12 debian kernel: [  847.171982]  ? set_kthread_struct+0x40/0x40
Aug 31 19:41:12 debian kernel: [  847.171989]  ret_from_fork+0x1f/0x30
Aug 31 19:41:12 debian kernel: [  847.176007]
Aug 31 19:41:12 debian kernel: [  847.176007] Showing all locks held
in the system:
Aug 31 19:41:12 debian kernel: [  847.176016] 1 lock held by khungtaskd/56:
Aug 31 19:41:12 debian kernel: [  847.176018]  #0: ffffffff82918b60
(rcu_read_lock){....}-{1:2}, at: debug_show_a\
ll_locks+0xe/0x1a0

2.  # CONFIG_RCU_BOOST is not set
2.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
2.2 as regular user at the same time, run $stress-ng --sequential 100
--class scheduler -t 5m --times
System begin OOM kill after 6 minutes:
The system is so dead, that I can't save the backtrace to file nor did
kernel has a chance to save the log to /var/log/messages

Thanks
Zhouyi

On Wed, Sep 1, 2021 at 1:11 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> followings are some of my kernel config options:
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_FANOUT=64
> CONFIG_RCU_FANOUT_LEAF=16
> # CONFIG_RCU_FAST_NO_HZ is not set
> # CONFIG_RCU_BOOST is not set
> CONFIG_RCU_NOCB_CPU=y
> # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> # end of RCU Subsystem
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # RCU Debugging
> CONFIG_PROVE_RCU=y
> # CONFIG_PROVE_RCU_LIST is not set
> # CONFIG_RCU_SCALE_TEST is not set
> CONFIG_RCU_TORTURE_TEST=m
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
>
> Thanks
> Zhouyi
>
> On Wed, Sep 1, 2021 at 1:01 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > I did an experiment just now on x86_64 virtual machines, rcu did not
> > complain after 10 minutes's test, I hope my effort can provide some
> > clue.
> >
> > 1. I clone the fresh new linux kernel (git clone
> > https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git)
> > 2. compile the kernel without CONFIG_RCU_BOOST (: # CONFIG_RCU_BOOST is not set)
> > 3. boot the kernel on a x86_64 VM (kvm -cpu host -smp 16  -hda
> > ./debian10.qcow2 -m 4096 -net
> > user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
> > -vnc :30)
> > 4. run the test (stress-ng --sequential 16  --class scheduler -t 5m --times)
> > 5. monitor the system by constantly typing top and dmesg
> > 6. after 10 minutes, nothing else happens except that the dmesg report
> > following two messages
> > [  672.528192] sched: DL replenish lagged too much
> > [  751.127790] hrtimer: interrupt took 12143 ns
> >
> > So, I guess CONFIG_RCU_BOOST is not necessary for x86_64 virtual machines
> >
> > Zhouyi
> >
> > On Tue, Aug 31, 2021 at 11:24 PM Jorge Ramirez-Ortiz, Foundries
> > <jorge@foundries.io> wrote:
> > >
> > > Hi
> > >
> > > When enabling CONFIG_PREEMPT and running the stress-ng scheduler class
> > > tests on arm64 (xilinx zynqmp and imx imx8mm SoCs) we are observing the following.
> > >
> > > [   62.578917] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [   62.585015]  (detected by 0, t=5253 jiffies, g=3017, q=2972)
> > > [   62.590663] rcu: All QSes seen, last rcu_preempt kthread activity 5254 (4294907943-4294902689), jiffies_till_next_fqs=1, root
> > > +->qsmask 0x0
> > > [   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies! g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> > > [   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > > [   62.622359] rcu: RCU grace-period kthread stack dump:
> > > [   62.627395] task:rcu_preempt     state:R  running task     stack:    0 pid:   14 ppid:     2 flags:0x00000028
> > > [   62.637308] Call trace:
> > > [   62.639748]  __switch_to+0x11c/0x190
> > > [   62.643319]  __schedule+0x3b8/0x8d8
> > > [   62.646796]  schedule+0x4c/0x108
> > > [   62.650018]  schedule_timeout+0x1ac/0x358
> > > [   62.654021]  rcu_gp_kthread+0x6a8/0x12b8
> > > [   62.657933]  kthread+0x14c/0x158
> > > [   62.661153]  ret_from_fork+0x10/0x18
> > > [   62.682919] BUG: scheduling while atomic: stress-ng-hrtim/831/0x00000002
> > > [   62.689604] Preemption disabled at:
> > > [   62.689614] [<ffffffc010059418>] irq_enter_rcu+0x30/0x58
> > > [   62.698393] CPU: 0 PID: 831 Comm: stress-ng-hrtim Not tainted 5.10.42+ #5
> > > [   62.706296] Hardware name: Zynqmp new (DT)
> > > [   62.710115] Call trace:
> > > [   62.712548]  dump_backtrace+0x0/0x240
> > > [   62.716202]  show_stack+0x2c/0x38
> > > [   62.719510]  dump_stack+0xcc/0x104
> > > [   62.722904]  __schedule_bug+0x78/0xc8
> > > [   62.726556]  __schedule+0x70c/0x8d8
> > > [   62.730037]  schedule+0x4c/0x108
> > > [   62.733259]  do_notify_resume+0x224/0x5d8
> > > [   62.737259]  work_pending+0xc/0x2a4
> > >
> > > The error results in OOM eventually.
> > >
> > > RCU priority boosting does work around this issue but it seems to me
> > > a workaround more than a fix (otherwise boosting would be enabled
> > > by CONFIG_PREEMPT for arm64 I guess?).
> > >
> > > The question is: is this an arm64 bug that should be investigated? or
> > > is this some known corner case of running stress-ng that is already
> > > understood?
> > >
> > > thanks
> > > Jorge
> > >
> > >
> > >
