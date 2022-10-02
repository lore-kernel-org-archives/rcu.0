Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE9C433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJBNaQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJBNaP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 09:30:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB910FC9
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 06:30:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z4so13229248lft.2
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XtbzWf4TdDwi8k95llNSVJ1wvlKKHDuzwPb5NZ9Ptsg=;
        b=qODesehi3ilWALfIhTXjApzPEyr9opSa/kO1WrvccsxekAy/Q0E//Kh7pN3eph9+7g
         g3NxDtbt0t6A19pNx91y8FDsOgYsFWO7TuwsxPHKLnLluDildMUnsd/Y9uQWO3oMwTxS
         ILrB1sijYqRU/h0gZBk+azPTx/CHYl/XjhoR/PoR6+Oxx50MlJgbd6dn3huo/kHQGsLk
         zE+XwsXcX7Juh5t0ixa5lC6EIghSFDL7rBGcflS8CNwH+GbMNvwZwoB4+p9kbVOzft7y
         uRqjUAAyHU/JPogHk76zkdqsiGj/Ub2cSJ1yc3XFRQ90AqxeSETHHZODMQDYtE4BFH+V
         sQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XtbzWf4TdDwi8k95llNSVJ1wvlKKHDuzwPb5NZ9Ptsg=;
        b=bgVW+bu8SCUE931mKSoNzoZy4dVD/bIB52DDs+3AoBpFTJn/cQK1mwyyhx0ZYFhT+M
         tJRMD2ag+TesotnwOhEyQ9lI5gyj+9VB5Pad4DNGW/O1EXdSx76FrRMK1gv01IMj314Q
         fYE9MI+uVa9f3rwdKmpfv+JawyJiVaH2TXSn23vP0p81IAci+oBcEg4sQK+NIxWzq2RJ
         a1FDWRTPY1WoQkpbIKUDPlHh3hd6gX40GL1azTmPQika6TxjGRp16nUNu36v1otiZnDD
         XxghhdHmUX/v/VH227CoVnaOo5XY4D666YVsQtHYoDK0yPrFbN+drF39djDQHUjqImUz
         xWKg==
X-Gm-Message-State: ACrzQf2Q6IO5uYog1HgEXs88GvCBu2GhkunC/ETLm7Ag05BD6aYyvNoz
        75Z1FYCx6dfSgpOQo7LfGAFn5t12vIRRpV852w==
X-Google-Smtp-Source: AMsMyM7+YAzzlwH1PEMX9OBIrt9IGcjbGARFTCa+htkWVnvrUG17Hd6HTl+19WHHElMbsaOnAdgY+PuD4mZVs9PxrKY=
X-Received: by 2002:a19:7412:0:b0:4a2:26d5:e87e with SMTP id
 v18-20020a197412000000b004a226d5e87emr2163280lfe.326.1664717410990; Sun, 02
 Oct 2022 06:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220916134258.GB25891@lothringen> <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen> <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com> <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com> <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 2 Oct 2022 21:29:59 +0800
Message-ID: <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 30, 2022 at 11:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
[...]
> > > I have managed to grasp three two-socket machine, each has 256 cpus.
> > > The test has run about 7 hours till now without any problem by the following command:
> > > tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 sys3" \
> > > --duration 45h --cpus 256 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "96*TREE04"
> > >
> > > It seems promising.
> > >
> >
> > The test is against v6.0-rc7 kernel, and only with 96926686deab ("rcu:
> > Make CPU-hotplug removal operations enable tick") reverted. It is
> > close to the end, but unfortunately it fails.
> > Quote from remote-log
> > "
> > TREE04.57 ------- 4410955 GPs (27.2281/s) [rcu: g36045577 f0x0
> > total-gps=9011687] n_max_cbs: 4111392
> > TREE04.58 ------- 4368391 GPs (26.9654/s) [rcu: g35630093 f0x0
> > total-gps=8907816] n_max_cbs: 2411104
> > TREE04.59 ------- 800516 GPs (4.94146/s) n_max_cbs: 3634471
> > QEMU killed
> > TREE04.59 no success message, 10547 successful version messages
> > ^[[033mWARNING: ^[[mTREE04.59 GP HANG at 800516 torture stat 1925
> > ^[[033mWARNING: ^[[mAssertion failure in
> > /home/linux/tools/testing/selftests/rcutorture/res/2022.09.26-23.33.34-remote/TREE04.59/console.log
> > TREE04.59
> > ^[[033mWARNING: ^[[mSummary: Call Traces: 1 Stalls: 8615
> > TREE04.6 ------- 4348443 GPs (26.8422/s) [rcu: g35341129 f0x0
> > total-gps=8835575] n_max_cbs: 2329432
>
> First, thank you for running this!
>
> This is not the typical failure that we were seeing, which would show
> up as a 2.199.0-second RCU CPU stall during which time there would be
> no console messages.
>
> But please do let me know how continuing tests go!
>

This time, the same test environment except against v6.0-rc7 mainline,
also encountered the not typical failure.

Quote from remote-log:
"
TREE04.11 ------- 555429 GPs (3.42857/s) n_max_cbs: 1907355
QEMU killed
TREE04.11 no success message, 10547 successful version messages
^[[033mWARNING: ^[[mTREE04.11 GP HANG at 555429 torture stat 1330
^[[033mWARNING: ^[[mAssertion failure in
/home/linux/tools/testing/selftests/rcutorture/res/2022.09.29-00.28.29-remote/TREE04.11/console.log
TREE04.11
^[[033mWARNING: ^[[mSummary: Call Traces: 1 Stalls: 9213
TREE04.12 ------- 4379523 GPs (27.0341/s) [rcu: g35803501 f0x0
total-gps=8951168] n_max_cbs: 2585955
...
TREE04.42 ------- 4383911 GPs (27.0612/s) [rcu: g35706861 f0x0
total-gps=8927008] n_max_cbs: 2544071
TREE04.43 ------- 4370806 GPs (26.9803/s) [rcu: g35793529 f0x0
total-gps=8948675] n_max_cbs: 2490251
^[[033mWARNING: ^[[mAssertion failure in
/home/linux/tools/testing/selftests/rcutorture/res/2022.09.29-00.28.29-remote/TREE04.43/console.log
TREE04.43
^[[033mWARNING: ^[[mSummary: Warnings: 1 Call Traces: 1
TREE04.44 ------- 4379942 GPs (27.0367/s) [rcu: g35806165 f0x0
total-gps=8951834] n_max_cbs: 1473528
...
TREE04.95 ------- 4850446 GPs (29.941/s) [rcu: g38867685 f0x0
total-gps=9717212] n_max_cbs: 2917447
TREE04.96 ------- 4880570 GPs (30.127/s) [rcu: g39023821 f0x0
total-gps=9756247] n_max_cbs: 1267969
2 runs with runtime errors.
 --- Done at Fri Sep 30 09:35:31 PM EDT 2022 (1d 21:07:02) exitcode 2
"

Quote from TREE04.11 console.log
"
...
[162001.301549] rcu_torture_fwd_prog n_max_cbs: 281053
[162001.301994] rcu_torture_fwd_prog: Starting forward-progress test 0
[162001.302531] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
[162001.308449] rcu_torture_fwd_prog_cr: Waiting for CBs:
rcu_barrier+0x0/0x3b0() 0
[162002.352445] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
[162002.360429] rcu_torture_fwd_prog_nr: Waiting for CBs:
rcu_barrier+0x0/0x3b0() 0
[162002.464428] rcu_torture_fwd_prog: tested 2104 tested_tries 2105
[162002.464989] rcu-torture: rcu_torture_fwd_prog is stopping
[162002.465518] rcu-torture: Stopping rcu_torture_writer task
[162005.040419] rcu-torture: rtc: 0000000089bf6f56 ver: 555429 tfle: 0
rta: 555430 rtaf: 0 rtf: 555420 rtmbe: 0 rtmbkf: 0/234319 rtbe: 0
rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 206274892 onoff:
184783/184783:184787/184787 1,2001:2,3303 25759026:47497333 (HZ=1000)
barrier: 773866/773866:0 read-exits: 185056 nocb-toggles: 0:0
[162005.042858] rcu-torture: Reader Pipe:  344206401977 936546 0 0 0 0 0 0 0 0 0
[162005.043504] rcu-torture: Reader Batch:  344194661258 12677265 0 0
0 0 0 0 0 0 0
[162005.044047] rcu-torture: Free-Block Circulation:  555429 555428
555427 555426 555425 555424 555423 555422 555421 555420 0
[162005.044857] ??? Writer stall state RTWS_COND_SYNC_EXP(8) g30399832
f0x0 ->state 0x2 cpu 1
[162005.045474] rcu: rcu_sched: wait state: RCU_GP_WAIT_GPS(1)
->state: 0x402 ->rt_priority 0 delta ->gp_start 2575 ->gp_activity
2571 ->gp_req_activity 2575 ->gp_wake_time 2575 ->gp_wake_seq 30399828
->gp_seq 30399832 ->gp_seq_needed 30399832 ->gp_max 1118 ->gp_flags
0x0
[162005.047265] rcu:    CB 1^0->2 KbclSW F3852 L3852 C5 ..... q0 S CPU 0
[162005.047856] rcu:    CB 2^0->3 KbclSW F3747 L3747 C2 ..... q0 S CPU 0
[162005.048415] rcu:    CB 3^0->-1 KbclSW F2583 L2583 C2 ..... q0 S CPU 0
[162005.048992] rcu: nocb GP 4 KldtS W[..] ..:0 rnp 4:7 2042607 S CPU 0
[162005.049569] rcu:    CB 4^4->5 KbclSW F3839 L3839 C6 ..... q0 S CPU 0
[162005.050040] rcu:    CB 5^4->6 KbclSW F4449 L4449 C0 ..... q0 S CPU 0
[162005.050515] rcu:    CB 6^4->7 KbclSW F3784 L3785 C1 ..... q0 S CPU 0
[162005.050984] rcu:    CB 7^4->-1 KbclSW F3837 L3837 C7 ..... q0 S CPU 0
[162005.051478] rcu: RCU callbacks invoked since boot: 1422160737
[162005.051908] rcu-torture: rcu_torture_stats is stopping
"

Quote from TREE04.43 console.log
"
...
[162003.262292] rcu-torture: rtc: 0000000000000000 VER: 4371112 tfle:
0 rta: 4371112 rtaf: 0 rtf: 4371103 rtmbe: 0 rtmbkf: 0/1801158 rtbe: 0
rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 206435148 onoff:
189317/189317:189321/189321 1,1877:1,3248 25561605:45469848 (HZ=1000)
barrier: 769073/769073:0 read-exits: 185104 nocb-toggles: 0:0
[162003.264714] rcu-torture: Reader Pipe:  338936620402 7452360 0 0 0
0 0 0 0 0 0
[162003.265336] rcu-torture: Reader Batch:  338929088717 14984045 0 0
0 0 0 0 0 0 0
[162003.265967] rcu-torture: Free-Block Circulation:  4371111 4371111
4371110 4371109 4371108 4371107 4371106 4371105 4371104 4371103 0
[162003.266980] rcu-torture: rcu_torture_stats is stopping
[162003.267450] rcu_torture_cleanup: Invoking rcu_barrier+0x0/0x3b0().
[162003.278480] Stack Depot allocating hash table of 32768 entries with kvcalloc
[162003.279947] mem_dump_obj() slab test: rcu_torture_stats =
0000000000000000, &rhp = ffffa0aa0035feb8, rhp = ffff965e01a58000, &z
= ffffffffa676d9a0
[162003.281079] mem_dump_obj(ZERO_SIZE_PTR): zero-size pointer
[162003.281563] mem_dump_obj(NULL): NULL pointer
[162003.281935] mem_dump_obj(ffffa0aa0035feb8): 4-page vmalloc region
starting at 0xffffa0aa0035c000 allocated at kernel_clone+0x92/0x3b0
[162003.283044] mem_dump_obj(ffff965e01a58000): slab rcuscale start
ffff965e01a58000 pointer offset 0 allocated at
rcu_torture_cleanup+0x432/0x4e0
[162003.284138]     kmem_cache_alloc+0x19d/0x1b0
[162003.284522]     rcu_torture_cleanup+0x432/0x4e0
[162003.284918]     torture_shutdown+0xce/0x1c0
[162003.285285]     kthread+0xb7/0xe0
[162003.285587]     ret_from_fork+0x22/0x30
[162003.285926] mem_dump_obj(ffff965e01a58008): slab rcuscale start
ffff965e01a58000 pointer offset 8 allocated at
rcu_torture_cleanup+0x432/0x4e0
[162003.287045]     kmem_cache_alloc+0x19d/0x1b0
[162003.287436]     rcu_torture_cleanup+0x432/0x4e0
[162003.287835]     torture_shutdown+0xce/0x1c0
[162003.288202]     kthread+0xb7/0xe0
[162003.288510]     ret_from_fork+0x22/0x30
[162003.288848] mem_dump_obj(ffffffffa676d9a0): non-slab/vmalloc memory
[162003.289426] mem_dump_obj() kmalloc test: rcu_torture_stats =
0000000000000000, &rhp = ffffa0aa0035feb8, rhp = ffff965e144447e0
[162003.290421] mem_dump_obj(kmalloc ffff965e144447e0): slab
kmalloc-16 start ffff965e144447e0 pointer offset 0 size 16
[162003.291316] mem_dump_obj(kmalloc ffff965e144447e8): slab
kmalloc-16 start ffff965e144447e0 pointer offset 8 size 16
[162003.292211] mem_dump_obj() vmalloc test: rcu_torture_stats =
0000000000000000, &rhp = ffffa0aa0035feb8, rhp = ffffa0aa0002d000
[162003.293186] mem_dump_obj(vmalloc ffffa0aa0002d000): 1-page vmalloc
region starting at 0xffffa0aa0002d000 allocated at
rcu_torture_cleanup.cold+0x287/0x3ef
[162003.294372] mem_dump_obj(vmalloc ffffa0aa0002d008): 1-page vmalloc
region starting at 0xffffa0aa0002d000 allocated at
rcu_torture_cleanup.cold+0x287/0x3ef
[162003.295548] rcu-torture: rtc: 0000000000000000 VER: 4371112 tfle:
0 rta: 4371112 rtaf: 0 rtf: 4371103 rtmbe: 0 rtmbkf: 0/1801158 rtbe: 0
rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 206435148 onoff:
189317/189317:189321/189321 1,1877:1,3248 25561605:45469848 (HZ=1000)
barrier: 769073/769073:0 read-exits: 185104 nocb-toggles: 0:0
[162003.297956] rcu-torture: Reader Pipe:  338936620402 7452360 0 0 0
0 0 0 0 0 0
[162003.298578] rcu-torture: Reader Batch:  338929088717 14984045 0 0
0 0 0 0 0 0 0
[162003.299208] rcu-torture: Free-Block Circulation:  4371111 4371111
4371110 4371109 4371108 4371107 4371106 4371105 4371104 4371103 0
[162003.300220] rcu-torture:--- End of test: SUCCESS: nreaders=7
nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1
shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0
fqs_stutter=3 test_boost=1/0 test_boost_interval=7
test_boost_duration=4 shutdown_secs=162000 stall_cpu=0
stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0
n_barrier_cbs=4 onoff_interval=200 onoff_holdoff=30 read_exit_delay=13
read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
[162003.304162] i2c i2c-0: shutdown
[162003.304461] alarmtimer alarmtimer.0.auto: shutdown
[162003.304878] psmouse serio1: shutdown
...
"

I remember if reverting the commits suggested by Frederic, the failure
would occur within an hour.

But unfortunately, I did not keep the data. I will run it again and
submit the data.


Thanks,

Pingfan
