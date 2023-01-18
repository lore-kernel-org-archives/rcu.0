Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF2C38159
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjARCRW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 21:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARCRV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 21:17:21 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FBD3E0B8
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 18:17:20 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p25so28942825ljn.12
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZXjIZ1kW/agTRJWBn93GViS8uIVmUhc+5MixXUeJjQ=;
        b=rOMJ3ou/0PbCK76hIhqEUjr0GPwlyFvykxwlxcGEHmLQcPuzkj6cNiubuprxWUQXck
         x8WwTRFc6a2Ofkbw5FZHxjCEnr9KFnEM3pcRwYyjHdYSi1HwUJ7e6Ey/vq+qhIS0QPqm
         hpiZwZV2kRNox3DcrBaPtZTeL8U71dWjKB2f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZXjIZ1kW/agTRJWBn93GViS8uIVmUhc+5MixXUeJjQ=;
        b=o38AwplTyT9ms3lByWxahxnb0muThrqv6BqrdMtdia7Y3d13hHBKPyNhsQGkWv+JTm
         DcCWQc9a7ziRwSz8ETfIN/m+xZgv8wnSnR/STZXZVdik7bItMeyM+vxW/44B65iGW1JC
         5WUSq2p7yyImypR+N/RA7ypeEfAuvCGv3fqtDSbdutZSnLDeJ+uVOZMAY8HIM+C/oaT3
         zp3Clm5MFMviAhMVKGWHIpaWdoG/ccOyYX+2lvFJ4ep0e69udP1uq+uOW9pdi3urzrkB
         TF/WqIRnIwoBQsiDmaYN4OCP8WGjOTNuheSeiL28MiVUePLn2uN7mneYIfWSGyRvFyIt
         3LAg==
X-Gm-Message-State: AFqh2kqpGXUD59pqK0Ske4A7pAF4Mv740SFEtxAS3FMy58DQWIv8UDkn
        zkUgXngKf/7PLk5oC2plZ66BIeVCOhW6S0Cpwd7RY+DwKh9EcyeW
X-Google-Smtp-Source: AMrXdXsKhEQ7F00vSqW+Y/Pult1X5WYLQkb5K1VWuoWoV/59nw4x0FcQwMWsBN2kDbhlppHM5RahMgXBegY3bBpb5Lg=
X-Received: by 2002:a2e:7019:0:b0:284:6390:1f8 with SMTP id
 l25-20020a2e7019000000b00284639001f8mr528258ljc.167.1674008238710; Tue, 17
 Jan 2023 18:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org> <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com> <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Jan 2023 02:17:06 +0000
Message-ID: <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     paulmck@kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Tue, Jan 17, 2023 at 8:42 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Tue, Jan 17, 2023 at 08:02:24PM +0000, Joel Fernandes wrote:
> > On Tue, Jan 17, 2023 at 4:54 AM Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > >
> > > On Mon, Jan 16, 2023 at 11:36:57PM -0500, Joel Fernandes wrote:
> > > > > On Jan 16, 2023, at 11:30 PM, Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > > > > =EF=BB=BFOn Tue, Jan 17, 2023 at 12:15:07AM +0000, Joel Fernandes=
 wrote:
> > > > >>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > > > >>> Hi Zhouyi,
> > > > >>>
> > > > >>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> > > > >>>>
> > > > >>> [..]
> > > > >>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> > > > >>>>>
> > > > >>>>> Hello,
> > > > >>>>> I am seeing -EBUSY returned a lot during torture_onoff() when=
 running
> > > > >>>>> rcutorture on arm64. This causes hotplug failure 30% of the t=
ime. I am
> > > > >>>>> also seeing this in 6.1-rc kernels. I believe see this only f=
or CPU0.
> > > > >>>>>
> > > > >>>>> This causes warnings in torture tests:
> > > > >>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 fail=
ed: errno -16
> > > > >>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 fail=
ed: errno -16
> > > > >>>>>
> > > > >>>>> Full kernel log here:
> > > > >>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/j=
ob/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.1=
5-14.51.11/TREE04/console.log
> > > > >>>>>
> > > > >>>>> Any ideas on why this is happening and only for CPU 0 (presum=
ably the
> > > > >>>>> boot CPU)? I'd personally need these warnings to go away for =
my tests
> > > > >>>>> as this causes rcutorture's tests to not cleanly pass for me.=
 It
> > > > >>>>> appears remove_cpu() -> device_offline() is what returns the =
error.
> > > > >>>>>
> > > > >>>> I guess this probably because CPU 0 is the tick_do_timer_cpu i=
n
> > > > >>>> nohz_full mode, which prevent that cpu from
> > > > >>>> going offline [1]. We have discussed this topic, but there is =
no
> > > > >>>> agreement on how to solve it yet.
> > > > >>>
> > > > >>> But I am seeing the issue in TRACE02 config which is:
> > > > >>> CONFIG_NO_HZ_IDLE=3Dy
> > > > >>> # CONFIG_NO_HZ_FULL is not set
> > > > >>>
> > > > >>> So that is not NO_HZ_FULL:
> > > > >>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job=
/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-=
14.51.11/TRACE02/console.log.diags/
> > > > >>> However, I can't seem to find the full kernel logs for that.
> > > > >>>
> > > > >>> Also, other than the TRACE02 fail, I only see the issue with co=
nfigs
> > > > >>> with CONFIG_NO_HZ_FULL=3Dy
> > > > >>>
> > > > >>> Can you try TRACE02 specifically, and see if you can reproduce =
the
> > > > >>> same issue on your setup? Meanwhile, I'll try to trace what is
> > > > >>> returning the -EBUSY.
> > > > >>
> > > > >> How about something simple like the following? (untested)
> > > > >>
> > > > >> ---8<-----------------------
> > > > >>
> > > > >> diff --git a/kernel/torture.c b/kernel/torture.c
> > > > >> index bc8fb361efc0..cd64110694c0 100644
> > > > >> --- a/kernel/torture.c
> > > > >> +++ b/kernel/torture.c
> > > > >> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_a=
ttempts, long *n_offl_successes,
> > > > >>            // PCI probe frequently disables hotplug during boot.
> > > > >>            (*n_offl_attempts)--;
> > > > >>            s =3D " (-EBUSY forgiven during boot)";
> > > > >> +        } else if (tick_nohz_full_running && ret =3D=3D -EBUSY)=
 {
> > > > >> +            (*n_offl_attempts)--;
> > > > >> +            s =3D " (-EBUSY forgiven if nohz_full is running)";
> > > > >
> > > > > But this should be forgiven for the timekeeping CPU, not everyone=
,
> > > > > correct?
> > > > >
> > > > > Yes, I know that CPU-hotplug operations can fail, but in my testi=
ng
> > > > > they almost never do.  This means that a new failure might well b=
e a
> > > > > real bug somewhere that needs attention.
> > > >
> > > > Sure. We may need to expose some API to reveal that.
> > > >
> > > > It appeared though that Thomas in the other thread related to patch
> > > > from Zhouyi, was suggesting that rcutorture tolerate hotplug failur=
e
> > > > though, because they are not abnormal, right?
> > >
> > > Based on my rcutorture testing experience on x86, they are not at all
> > > normal.  The only time I have seen rcutorture CPU-hotplug failures ha=
s
> > > been due to some bug that needed fixing.
> >
> > I see, ok. I need to debug what is returning -EBUSY for !NO_HZ_FULL on
> > arm64, I will report back once I do.
> >
> > Meanwhile, Marc I am wondering if you are able to reproduce the issue
> > on your side on TRACE02 config, like I am?
> >
> > Here is the TRACE02 config fragment:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5=
.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11=
/TRACE02/ConfigFragment/*view*/
> >
> > Here are instructions on how to run it (torture test parameters etc)
> > if you are loading the module yourself:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5=
.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11=
/TRACE02/bare-metal/*view*/
>
> I am assuming that this is directed to someone having easy access
> to ARM hardware.
>
> > > Is there a plan to make CPU hotplug failures more frequent?
> >
> > I am not aware of such a plan but I was going by "There are quite some
> > reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> > not a fatal problem, really." in [1].
> >
> > What about an rcutorture to skip hotplug for a certain cpu id,
> > rcutorture.skip_hotplug_cpus=3D"0". Can be a last resort. But we/I
> > should debug this issue more before getting to that.
>
> Yes, in fact there already are some checks along those lines, for example=
,
> the torture_offline() function's check of cpu_is_hotpluggable().  So for
> example, as I understand it, a CONFIG_NO_HZ_FULL=3Dy system should mark
> the housekeeping CPU as !cpu_is_hotpluggable().

I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
not seeing it). Even on x86, if you enable
CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy , and CONFIG_NO_HZ_FULL=3Dy, and run
rcutorture with boot args:

nohz_full=3D0-3 rcutorture.onoff_interval=3D100 rcutorture.onoff_holdoff=3D=
2
rcutorture.shutdown_secs=3D30

You will see this in the kernel logs:
[    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno -16
[    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno -16

So RCU torture test clearly thought the CPUs were hot-pluggable, when
they was chance for them to return -EBUSY (due to housekeeping and
what not). So this issue seems to be architecture independent, in that
sense.

So the 2 ways forward I see are:
- Make the torture test aware of which CPUs are 'house keeping'
- Make it possible to turn off CPU0 hotplugging on ARM64 by default
(via CONFIG or boot option).

Another option could be, forgive -EBUSY on CPU0 for
CONFIG_NO_HZ_FULL=3Dy.  Is it possible to assign a non-0 CPU id as a
housekeeping CPU?

Adding Frederic to CC as well as we are talking about
housekeeping/isolation stuff.

> And topology_init() sets this based on platform_can_hotplug_cpu(cpu).
> And this function sets CPU 0 as !cpu_is_hotpluggable() unless the
> architecture specifies a .cpu_can_disable() function.

Ah, that is 32-bit ARM code only. This issue is on 64-bit ARM (arch/arm64/)=
.

Thanks,

 - Joel


> So architectures that don't want specific CPUs to be hotpluggable
> can and should so specify.
>
>                                                         Thanx, Paul
>
> > Thanks,
> >
> > - Joel
> > [1] https://lkml.org/lkml/2022/11/27/182
