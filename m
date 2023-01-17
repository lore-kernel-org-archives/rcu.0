Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1933C54E76
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 21:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjAQVj3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjAQVi3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 16:38:29 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168BB44A
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 12:02:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q2so34340198ljp.6
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+WztPEt31VXrvm/xWvi3xs6zYfVe7eMmmBwXvO7W/0=;
        b=fanqPOKUnbV/k/v358zH6P4FdLTvDmj6oB1TgAwV7BDJD1F1tSBbTzMpphzl5ONXyM
         5JikvPUFhGzV0oA42OIhiRaJzzF6xeBAXzcuHEFtZtDfHwMNoBwIUFFl05lLwIF1qjjs
         SBNIU8KkokdHuiC8Zgcdrd03AYTlKMfV+iG04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+WztPEt31VXrvm/xWvi3xs6zYfVe7eMmmBwXvO7W/0=;
        b=34xv3Yd4wK/bGrt1C8N7WosQXGYyLiTmvnY2B4ufPuowhi+7T5SdLyr7/KKXT9JuhG
         20PqWneEkSfWq/kZiuV9TCCph/JEuc8idWG9PFMLo306xPW2j+y70d4twU4IHuYW0pks
         BaH7M85ZJ5yohDJ3kjVbdqsUb5Xtsao9e3S0DmjgFqlyr9WRqqyrFLdOF/yymVyts5Oq
         5DA0kwbQ718mI1KgNNTDHF2PeqICnVkTFF1hptFUSga9eB9W/5PGBedjODMVEFdxR5yu
         +3rI4wuhwYoa7oksoy0ZuuEq18YdaopTxRgDcOikZsjuw9O9na3Gj+knO0VOY7G4Dihb
         KHWQ==
X-Gm-Message-State: AFqh2kr3jJXwtirT6T5RE6u23GzXqa32XE1RxGpKzc4ceoHcrQRS63T/
        pmd+AobcsltIgGESgEEtfaE6lNC54WjKXCckSltKAA==
X-Google-Smtp-Source: AMrXdXslIVeykfw8jr4dmx+rG/X5gxUhQ2rBh9DaXhc+MWNXJ86djxf5wQ6zgAYXgaQsxNso+oSiCj5l+Cszl0nwqX4=
X-Received: by 2002:a2e:2e08:0:b0:28b:8253:1a32 with SMTP id
 u8-20020a2e2e08000000b0028b82531a32mr315390lju.483.1673985755838; Tue, 17 Jan
 2023 12:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org> <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Jan 2023 20:02:24 +0000
Message-ID: <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     paulmck@kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 4:54 AM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Mon, Jan 16, 2023 at 11:36:57PM -0500, Joel Fernandes wrote:
> > > On Jan 16, 2023, at 11:30 PM, Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > > =EF=BB=BFOn Tue, Jan 17, 2023 at 12:15:07AM +0000, Joel Fernandes wro=
te:
> > >>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > >>> Hi Zhouyi,
> > >>>
> > >>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
> > >>>>
> > >>> [..]
> > >>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes=
.org> wrote:
> > >>>>>
> > >>>>> Hello,
> > >>>>> I am seeing -EBUSY returned a lot during torture_onoff() when run=
ning
> > >>>>> rcutorture on arm64. This causes hotplug failure 30% of the time.=
 I am
> > >>>>> also seeing this in 6.1-rc kernels. I believe see this only for C=
PU0.
> > >>>>>
> > >>>>> This causes warnings in torture tests:
> > >>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: =
errno -16
> > >>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: =
errno -16
> > >>>>>
> > >>>>> Full kernel log here:
> > >>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/l=
inux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14=
.51.11/TREE04/console.log
> > >>>>>
> > >>>>> Any ideas on why this is happening and only for CPU 0 (presumably=
 the
> > >>>>> boot CPU)? I'd personally need these warnings to go away for my t=
ests
> > >>>>> as this causes rcutorture's tests to not cleanly pass for me. It
> > >>>>> appears remove_cpu() -> device_offline() is what returns the erro=
r.
> > >>>>>
> > >>>> I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > >>>> nohz_full mode, which prevent that cpu from
> > >>>> going offline [1]. We have discussed this topic, but there is no
> > >>>> agreement on how to solve it yet.
> > >>>
> > >>> But I am seeing the issue in TRACE02 config which is:
> > >>> CONFIG_NO_HZ_IDLE=3Dy
> > >>> # CONFIG_NO_HZ_FULL is not set
> > >>>
> > >>> So that is not NO_HZ_FULL:
> > >>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/lin=
ux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.5=
1.11/TRACE02/console.log.diags/
> > >>> However, I can't seem to find the full kernel logs for that.
> > >>>
> > >>> Also, other than the TRACE02 fail, I only see the issue with config=
s
> > >>> with CONFIG_NO_HZ_FULL=3Dy
> > >>>
> > >>> Can you try TRACE02 specifically, and see if you can reproduce the
> > >>> same issue on your setup? Meanwhile, I'll try to trace what is
> > >>> returning the -EBUSY.
> > >>
> > >> How about something simple like the following? (untested)
> > >>
> > >> ---8<-----------------------
> > >>
> > >> diff --git a/kernel/torture.c b/kernel/torture.c
> > >> index bc8fb361efc0..cd64110694c0 100644
> > >> --- a/kernel/torture.c
> > >> +++ b/kernel/torture.c
> > >> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attem=
pts, long *n_offl_successes,
> > >>            // PCI probe frequently disables hotplug during boot.
> > >>            (*n_offl_attempts)--;
> > >>            s =3D " (-EBUSY forgiven during boot)";
> > >> +        } else if (tick_nohz_full_running && ret =3D=3D -EBUSY) {
> > >> +            (*n_offl_attempts)--;
> > >> +            s =3D " (-EBUSY forgiven if nohz_full is running)";
> > >
> > > But this should be forgiven for the timekeeping CPU, not everyone,
> > > correct?
> > >
> > > Yes, I know that CPU-hotplug operations can fail, but in my testing
> > > they almost never do.  This means that a new failure might well be a
> > > real bug somewhere that needs attention.
> >
> > Sure. We may need to expose some API to reveal that.
> >
> > It appeared though that Thomas in the other thread related to patch
> > from Zhouyi, was suggesting that rcutorture tolerate hotplug failure
> > though, because they are not abnormal, right?
>
> Based on my rcutorture testing experience on x86, they are not at all
> normal.  The only time I have seen rcutorture CPU-hotplug failures has
> been due to some bug that needed fixing.

I see, ok. I need to debug what is returning -EBUSY for !NO_HZ_FULL on
arm64, I will report back once I do.

Meanwhile, Marc I am wondering if you are able to reproduce the issue
on your side on TRACE02 config, like I am?

Here is the TRACE02 config fragment:
http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.=
y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRA=
CE02/ConfigFragment/*view*/

Here are instructions on how to run it (torture test parameters etc)
if you are loading the module yourself:
http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.=
y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRA=
CE02/bare-metal/*view*/

> Is there a plan to make CPU hotplug failures more frequent?

I am not aware of such a plan but I was going by "There are quite some
reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
not a fatal problem, really." in [1].

What about an rcutorture to skip hotplug for a certain cpu id,
rcutorture.skip_hotplug_cpus=3D"0". Can be a last resort. But we/I
should debug this issue more before getting to that.

Thanks,

- Joel
[1] https://lkml.org/lkml/2022/11/27/182
