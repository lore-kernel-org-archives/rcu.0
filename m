Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6BFC001B0
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHGVIY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGVIX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 17:08:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBFB1710
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 14:08:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so76733441fa.1
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691442499; x=1692047299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StUMzJQhfbW2owGEC+lYlO4au0P0RX4rAx8UEsJ/9bY=;
        b=oUsx0Usj0u4/T6jHm41eLg8aItHysrb0zvxVOOfkHCvAmmCwPqM+NxlglvqrCI3O3v
         60wmmYF5wIHWEX4lAGBysolnyZf33Fnvhl+DllKCfHkEwgi1WzW/R9hS4ycRgL8BsWG7
         /EVHTVGH/v0ctiozeouMb+kRFtSCD+asgFN/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442499; x=1692047299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StUMzJQhfbW2owGEC+lYlO4au0P0RX4rAx8UEsJ/9bY=;
        b=FCp/OHS0lVshnJJqEq3UH/MF/09ZroDKl/SmTkhqeUF+JjkRSU2bfpqfnJs/UCqGxy
         m+pyYAaAP3Jo7xqk2Qzrloxn4zTBOSVkM7I48oM4NJebwyvLAfddmw9vH/QLPq2IPBhj
         t/0cRmhlInVBh7jc+qUGwuhmEtCZxXMr/mdtzMLibiACgrCoIFtmvlQfVJTLWHZRVgeW
         zIpdXgGRkosuAl7d5KKMcdCD+XcxUQnaPrqXXoSya7BooAakrRJNEqWNv1yWM5iU5ccI
         Y22qcG+LV8j7Lk19ltly4N6maP3KD2OH6p416MHi3lI2aHpToMxYGFq7slODixj0BXGZ
         0ENA==
X-Gm-Message-State: AOJu0YyC+D5IPLD+dY75EzXQbIc1WSi34IVbRop34fyNay3u37CqSWsU
        B6fiZd0tSOZFsW3oKp5KrHaYSfAH9VE7doEP3JF4LLBST2BJ/i+3w/A=
X-Google-Smtp-Source: AGHT+IH5729S7bWGK379Btut9dLRh61mOIQ2HNM9cbbwCDMbYEwmZoQ3piVAEgDiI5vmfieqA4trV12gKc4OnuRxHx4=
X-Received: by 2002:a2e:b041:0:b0:2b6:c16a:db06 with SMTP id
 d1-20020a2eb041000000b002b6c16adb06mr7706494ljl.39.1691442499224; Mon, 07 Aug
 2023 14:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
 <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com>
 <CAABZP2zsArdrV827DuzG0EjU9-kH7LQx7-fBjZRH13xLsfiPDg@mail.gmail.com> <CAEXW_YR4resXTGPFH63Gf9sK6KfhypT7zXZ72XHRHBbQVs4-5A@mail.gmail.com>
In-Reply-To: <CAEXW_YR4resXTGPFH63Gf9sK6KfhypT7zXZ72XHRHBbQVs4-5A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 17:08:10 -0400
Message-ID: <CAEXW_YQXk8G6xf81nJ+vL+1qg2Fwog3bBynh5Yff-mgeas+oNg@mail.gmail.com>
Subject: Re: TREE04 and TREE07 failures on 5.15 stable
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 7, 2023 at 12:56=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Mon, Aug 7, 2023 at 11:47=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
> >
> > On Mon, Aug 7, 2023 at 11:38=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Btw full logs are here:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.1=
5.y/80/artifact/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/
> > >
> > > And some more comments:
> > >
> > > On Mon, Aug 7, 2023 at 10:22=E2=80=AFAM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > > >
> > > > Hello, Frederick, all,
> > > > TREE04 and TREE07 still fail on the 5.15 kernel.
> > > >
> > > > The stutter patches helped 5.10, 6.1 and 6.4 but 5.15 still is
> > > > troubled. Any thoughts?
> > > >
> > > > OTOH, I am not sure how many NO_HZ_FULL users are on the 5.15 kerne=
l.
> > > > Do you have any idea?
> > > >
> > > > Meanwhile I'll continue to debug it. Thank you!
> > > >
> > > >  --- Mon Aug  7 07:37:10 AM UTC 2023 Test summary:
> > > > Results directory:
> > > > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_=
linux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration =
60
> > > > RUDE01 ------- 22984 GPs (6.38444/s) [tasks-rude: g0 f0x0 total-gps=
=3D0]
> > > > SRCU-N ------- 318544 GPs (88.4844/s) [srcu: g4127136 f0x0 total-gp=
s=3D4127136]
> > > > SRCU-P ------- 268977 GPs (74.7158/s) [srcud: g2180244 f0x0 total-g=
ps=3D2180244]
> > > > SRCU-T ------- 497422 GPs (138.173/s) [srcu: g57760 f0x0 total-gps=
=3D57760]
> > > > SRCU-U ------- 1152598 GPs (320.166/s) [srcud: g33534 f0x0 total-gp=
s=3D33534]
> > > > TASKS01 ------- 11516 GPs (3.19889/s) [tasks: g0 f0x0 total-gps=3D0=
]
> > > > TASKS02 ------- 13407 GPs (3.72417/s) [tasks: g0 f0x0 total-gps=3D0=
]
> > > > TASKS03 ------- 4598 GPs (1.27722/s) [tasks: g0 f0x0 total-gps=3D0]
> > > > TINY01 ------- 422041 GPs (117.234/s) [rcu: g0 f0x0 total-gps=3D0]
> > > > n_max_cbs: 77229
> > > > TINY02 ------- 441676 GPs (122.688/s) [rcu: g0 f0x0 total-gps=3D0]
> > > > n_max_cbs: 10691
> > > > TRACE01 ------- 12593 GPs (3.49806/s) [tasks-tracing: g0 f0x0 total=
-gps=3D0]
> > > > TRACE02 ------- 106606 GPs (29.6128/s) [tasks-tracing: g0 f0x0 tota=
l-gps=3D0]
> > > > TREE01 ------- 42614 GPs (11.8372/s) [rcu: g346169 f0x0 total-gps=
=3D86809]
> > > > TREE02 ------- 161421 GPs (44.8392/s) [rcu: g1356445 f0x0
> > > > total-gps=3D339371] n_max_cbs: 177936
> > > > TREE03 ------- 105074 GPs (29.1872/s) [rcu: g1699381 f0x2
> > > > total-gps=3D425089] n_max_cbs: 631295
> > > > TREE04 ------- 106036 GPs (29.4544/s) n_max_cbs: 550875
> > > > QEMU killed
> > >
> > > This seems hotplug related. Not sure.
> > >
> > > > TREE04 no success message, 222 successful version messages
> > > > !!! PID 2616159 hung at 3780 vs. 3600 seconds Mon Aug  7 06:27:38 A=
M UTC 2023
> > > > TREE05 ------- 132006 GPs (36.6683/s) [rcu: g1043673 f0x0
> > > > total-gps=3D261183] n_max_cbs: 160463
> > > > TREE07 ------- 52858 GPs (14.6828/s) n_max_cbs: 429828
> > > > QEMU killed
> > > > TREE07 no success message, 234 successful version messages
> > > >  [033mWARNING:  [mAssertion failure in
> > > > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_=
linux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/TRE=
E07/console.log
> > > > TREE07
> > > >  [033mWARNING:  [mSummary: Call Traces: 6 Stalls: 5 Starves: 1
> > >
> > > Looks like this was because it is missing:
> > > lore.kernel.org/r/20230101061555.278129-1-joel@joelfernandes.org
> > 5.15.y (38d4ca22a528) is missing above patch. I started
> > tools/testing/selftests/rcutorture/bin/torture.sh on my  i7-12800H
> > nested kvm ubuntu environment just now, the test will last for about 7
> > hours.
> >
> > Hope I can be of some beneficial ;-)
>
> Thanks Zhouyi ;-)
>
> I am also doing a debug run to trackdown what's up with TREE04,  you
> can see the test running live here ;-)
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/=
83/console
>
> (in case you want to see the kvm.sh options I passed for tracing, take
> a look at the link).

I reproduced the TREE04 issue in ~1.5 hours with traces in the link above.

Looks like CPU5 is stalling GP.

[ 4655.497353] kvm-guest: stealtime: cpu 4, msr 1f51b140
[ 4655.747066] rcu: INFO: rcu_sched self-detected stall on CPU
[ 4655.749570] rcu-torture:
[ 4655.761836] rcu: 5-...0: (5493948 ticks this GP) idle=3D353/0/0x1
softirq=3D92919/92919 fqs=3D3 last_accelerate: 0000/71ef dyntick_enabled:
0

5 millions ticks this GP means the CPU is not spinning with interrupts
disabled AFAICS.

[ 4655.761857] (t=3D2199040 jiffies g=3D686789 q=3D41)

idle=3D353 is odd so that it was NOT in dyntick-idle mode at the time of
the stall AFAICS.

[ 4655.761891] NMI backtrace for cpu 5
[ 4655.761893] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.15.124+ #1

So the CPU was on the idle thread. Also confirmed by "0" between the 2
"/" in idle=3D.

So questions:
1. Why on earth is the CPU not in dyntick idle mode while being in the
idle loop, presumably for so long?

2. Why on earth does it keep receiving scheduler ticks but does not
report quiescent states?

One reason is maybe it is stuck in the idle loop somewhere in a read
side critical section before dyntick-idle mode is entered.

Looking at more traces:

rcu_quiescent_state_report confirms CPU5 is indeed the hold-out:

[ 4655.979846]   <idle>-0         0dNs.. 4658215924us :
rcu_quiescent_state_report: rcu_sched 686789 1>4 1 0 3 0
[ 4655.979863] rcu_sche-15        0d.... 4658215938us :
rcu_quiescent_state_report: rcu_sched 686789 4>0 1 0 3 0
[ 4655.979865] rcu_sche-15        0d.... 4658215939us :
rcu_quiescent_state_report: rcu_sched 686789 1>2 0 0 7 0

The last signs of life from CPU 5 was this:
[ 4655.979607]   <idle>-0         5d.... 4657954789us : sched_switch:
prev_comm=3Dswapper/5 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D>
next_comm=3Drcu_torture_bar next_pid=3D132 next_prio=3D120
[ 4655.979610] rcu_tort-132       5d.... 4657954799us : sched_switch:
prev_comm=3Drcu_torture_bar prev_pid=3D132 prev_prio=3D120 prev_state=3DD =
=3D=3D>
next_comm=3Dswapper/5 next_pid=3D0 next_prio=3D120

Which doesn't tell us much else than that CPU5 is in the idle loop
which we already know.

We need to figure out what is going on in the idle loop, stack traces
from the stall (below) don't seem to say much:

[ 4655.933546] Call Trace:
[ 4655.933548]  <IRQ>
[ 4655.933550]  dump_stack_lvl+0x33/0x46
[ 4655.933556]  panic+0x107/0x2e5
[ 4655.933563]  ? lapic_can_unplug_cpu+0x60/0x60
[ 4655.933569]  ? netconsole_netdev_event+0x130/0x130
[ 4655.940661]  0
[ 4655.947071]  panic_on_rcu_stall.cold+0xc/0xc
[ 4655.947080]  rcu_sched_clock_irq.cold+0x133/0x1e7
[ 4655.947086]  update_process_times+0x9c/0xd0
[ 4655.947092]  tick_sched_handle+0x1d/0x50
[ 4655.947096]  tick_sched_timer+0x5e/0x70
[ 4655.947099]  ? tick_sched_do_timer+0x50/0x50
[ 4655.947124]  __hrtimer_run_queues+0x125/0x270
[ 4655.947141]  hrtimer_interrupt+0xef/0x210
[ 4655.947146]  __sysvec_apic_timer_interrupt+0x55/0xd0
[ 4655.947151]  sysvec_apic_timer_interrupt+0x61/0x80
[ 4655.947159]  </IRQ>
[ 4655.947160]  <TASK>
[ 4655.954598]  0
[ 4655.961949]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 4655.961960] RIP: 0010:default_idle+0xb/0x10
[ 4655.961971] RSP: 0000:ffffc900000bbef8 EFLAGS: 00000246
[...]
[ 4655.962006]  ? mwait_idle+0x70/0x70
[ 4655.962013]  ? mwait_idle+0x70/0x70
[ 4655.962016]  default_idle_call+0x2e/0xb0
[ 4655.966418]  0
[ 4655.969830]  do_idle+0x1f3/0x260
[ 4655.969836]  cpu_startup_entry+0x14/0x20
[ 4655.969839]  secondary_startup_64_no_verify+0xc2/0xcb
[ 4655.969844]  </TASK>

Thanks.
