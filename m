Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C4C32793
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 15:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjARP5E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjARP4s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 10:56:48 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972BF21A0D
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 07:52:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id bn6so37085894ljb.13
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANEgTCLQobJ8CDitOEvRfBlC0/KRtspmm7fIPUr1eYs=;
        b=YzKt0zX3yoc+5dtqAVkfkk0wxh2qWLJ13RK5BgUmgzeVgnGIwp5Rprso/GISiOvjDD
         k3OpLTr4FzSM5JCrYk8pPOq84ZcuQDD9mOEi+6/JZeK+n1F8Q5AVahfHL0wUKCxtefY4
         zQQT4Er+IFzf7+JjdrtAeaVgMlmjyaeKivAII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANEgTCLQobJ8CDitOEvRfBlC0/KRtspmm7fIPUr1eYs=;
        b=xUk2/MFhat12c5uFL74EuirnITq27Q5oXVA/uRRXIKR3KWC51am7/sLCfKNRLfjVkS
         Llysn/Fnl2yvt+Ifep/0Dt/RaOuYOfkiNrZSZ4I4Z5T6O3ErJYV1C0wUw0BQqdBy3yDM
         p+sXONT0PCVBhP3x1ffamDLFEK+p9ONh9SeYWUbDathpgoD+hN8x1/QmuJPSvexUonCH
         R3OvjzT7RtKcxTbnWwieXuX7gSW+0v9wuiHjDqr30wPmHxNenTciJMtZ3Snx1g6GyaUe
         P/PDS612os65Rr21QFZA1Ndgkx1QHLPWyDKj5dJ00v/2YzKgbLvs0pQOcq9/69ZCdnEb
         99rA==
X-Gm-Message-State: AFqh2ko/CSWT9DpweizrH7yAdaN1A69qfkzz3TirBfqHyubkvFd5w8Oh
        rClnBNBx7QRnam0TkmsoiJ70wPoRG4y1FyNiiH8bug==
X-Google-Smtp-Source: AMrXdXtK2MAVK3awHGs/bumBf5vDs0CNhGmyfFWPCW6KhSn4lGyDjpRJU49kMG/V81TdabzQ8FHjGuiv0xKBqgkDNMA=
X-Received: by 2002:a2e:a485:0:b0:27f:bb8b:7520 with SMTP id
 h5-20020a2ea485000000b0027fbb8b7520mr664916lji.371.1674057125582; Wed, 18 Jan
 2023 07:52:05 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2zHs+Zatp+SUWNsPzGn81StKF9WL_+XB3pVTJNakxh5Dw@mail.gmail.com>
 <6191067A-8033-4670-BBD0-873C5F9E8878@joelfernandes.org> <CAABZP2xbvz_SS3eZZ6SJFN6kA++DowsirDOsJANGTEX3b0DGBQ@mail.gmail.com>
 <CAABZP2yUtgHbTkk87QvQw-4ptWxeP_RituEDh3BdsqDkBSmteQ@mail.gmail.com>
In-Reply-To: <CAABZP2yUtgHbTkk87QvQw-4ptWxeP_RituEDh3BdsqDkBSmteQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Jan 2023 15:51:54 +0000
Message-ID: <CAEXW_YQbKq3H+X+G1px7sKFeqg9D7WbiODT0__OvBrdhr3ZWkA@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 18, 2023 at 10:15 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> On Tue, Jan 17, 2023 at 7:42 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > On Tue, Jan 17, 2023 at 12:34 PM Joel Fernandes <joel@joelfernandes.org=
> wrote:
> > >
> > >
> > >
> > > > On Jan 16, 2023, at 10:15 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wr=
ote:
> > > >
> > > > =EF=BB=BFOn Tue, Jan 17, 2023 at 9:45 AM Joel Fernandes <joel@joelf=
ernandes.org> wrote:
> > > >>
> > > >>> On Tue, Jan 17, 2023 at 08:37:16AM +0800, Zhouyi Zhou wrote:
> > > >>> On Tue, Jan 17, 2023 at 8:15 AM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> > > >>>>
> > > >>>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > > >>>>> Hi Zhouyi,
> > > >>>>>
> > > >>>>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> > > >>>>>>
> > > >>>>> [..]
> > > >>>>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> > > >>>>>>>
> > > >>>>>>> Hello,
> > > >>>>>>> I am seeing -EBUSY returned a lot during torture_onoff() when=
 running
> > > >>>>>>> rcutorture on arm64. This causes hotplug failure 30% of the t=
ime. I am
> > > >>>>>>> also seeing this in 6.1-rc kernels. I believe see this only f=
or CPU0.
> > > >>>>>>>
> > > >>>>>>> This causes warnings in torture tests:
> > > >>>>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 fail=
ed: errno -16
> > > >>>>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 fail=
ed: errno -16
> > > >>>>>>>
> > > >>>>>>> Full kernel log here:
> > > >>>>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/j=
ob/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.1=
5-14.51.11/TREE04/console.log
> > > >>>>>>>
> > > >>>>>>> Any ideas on why this is happening and only for CPU 0 (presum=
ably the
> > > >>>>>>> boot CPU)? I'd personally need these warnings to go away for =
my tests
> > > >>>>>>> as this causes rcutorture's tests to not cleanly pass for me.=
 It
> > > >>>>>>> appears remove_cpu() -> device_offline() is what returns the =
error.
> > > >>>>>>>
> > > >>>>>> I guess this probably because CPU 0 is the tick_do_timer_cpu i=
n
> > > >>>>>> nohz_full mode, which prevent that cpu from
> > > >>>>>> going offline [1]. We have discussed this topic, but there is =
no
> > > >>>>>> agreement on how to solve it yet.
> > > >>>>>
> > > >>>>> But I am seeing the issue in TRACE02 config which is:
> > > >>>>> CONFIG_NO_HZ_IDLE=3Dy
> > > >>>>> # CONFIG_NO_HZ_FULL is not set
> > > >>>>>
> > > >>>>> So that is not NO_HZ_FULL:
> > > >>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job=
/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-=
14.51.11/TRACE02/console.log.diags/
> > > >>>>> However, I can't seem to find the full kernel logs for that.
> > > >>>>>
> > > >>>>> Also, other than the TRACE02 fail, I only see the issue with co=
nfigs
> > > >>>>> with CONFIG_NO_HZ_FULL=3Dy
> > > >>>>>
> > > >>>>> Can you try TRACE02 specifically, and see if you can reproduce =
the
> > > >>>>> same issue on your setup? Meanwhile, I'll try to trace what is
> > > >>>>> returning the -EBUSY.
> > > >>> I am trying TRACE02 on my X86_64 machine using cross compile and
> > > >>> qemu-system-aarch64 now, my equipment is limited, but hope I can =
be of
> > > >>> beneficial to the community ;-)
> > > >>
> > > >> Cool, I am assuming you are trying the patch you shared which you =
wrote in
> > > >> November. I bet you will still see the issue.
> > > > yes, I still see the issue with no hz full.
> > > >>
> > > >>>>
> > > >>>> How about something simple like the following? (untested)
> > > >>>>
> > > >>>> ---8<-----------------------
> > > >>>>
> > > >>>> diff --git a/kernel/torture.c b/kernel/torture.c
> > > >>>> index bc8fb361efc0..cd64110694c0 100644
> > > >>>> --- a/kernel/torture.c
> > > >>>> +++ b/kernel/torture.c
> > > >>>> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_a=
ttempts, long *n_offl_successes,
> > > >>>>                        // PCI probe frequently disables hotplug =
during boot.
> > > >>>>                        (*n_offl_attempts)--;
> > > >>>>                        s =3D " (-EBUSY forgiven during boot)";
> > > >>>> +               } else if (tick_nohz_full_running && ret =3D=3D =
-EBUSY) {
> > > >>>> +                       (*n_offl_attempts)--;
> > > >>>> +                       s =3D " (-EBUSY forgiven if nohz_full is=
 running)";
> > > >>> Fantastic fix!! thus we can fix the time keeper cpu torture probl=
em
> > > >>> without touch the time keeper code.
> > > >>
> > > >> Thanks. Unfortunately this does not fix the issue for TRACE02 and =
the patch
> > > >> you shared does not fix it either -- because TRACE02 is not a no-h=
z-full
> > > >> test. :-(
> > > >>
> > > >> We will need to do a bit of tracing to figure out where the -EBUSY=
 is coming
> > > >> from for TRACE02.
> > > > agree TRACE02 is another issue, unfortunately I can't reproduce the
> > > > bug neither with your original Image [1]
> > > > nor with my cross compiled kernel using [2].
> > > >
> > > > I guess there may be two reasons:
> > > > 1) my testbed is X86_64 based.
> > > > 2) the command that I invoke qemu is not right:
> > > > 2-1) the newly compiled linux-5.15.89-rc1
> > > > qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -smp 4
> > >
> > > Does 8 CPUs make any difference? That is my setup.
> > 8 CPUs make no difference ;-(
> > >
> > > Not sure what else is different. It could be a CPU model specific iss=
ue, or something. But why donot you just use the same setup you used in Nov=
ember and check TRACE02? That is actually what I was requesting you to rest=
, since you saw the same issue on that setup.
> > I guess it may be a CPU model specific issue, while I can't invoke
> > qemu-system-aarch64  with  "-machine virt,gic-version=3Dhost -cpu host"
> > because I didn't have an aarch64 bare metal host.
> >
> > OK, I am doing the same setup on linux-5.15.y as I did last November
> > in the PPC VM of Open Source Lab of Oregon State University, this will
> > take about 20 hours, and report what I found after the test finishes.
> There are some problems in launching linux-5.15.y in the PPC VM of
> Open Source Lab of Oregon State University, I am digging out why, so I
> can't report the test result today, I'm sorry ;-(. I will report to
> you once I have any progress as soon as possible.
>

No problem! Looking forward to seeing what you see.

On my side I am not able to reproduce the TRACE02 issue any more, so
it was a one-off I think. However, I see arm64 hotplug failures as
expected on all other CONFIG_RCU_NO_HZ_FULL configs.

Will debug / work on a solution for that a bit later today hopefully.

Thanks,

 - Joel
