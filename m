Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F066FC3DA78
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 11:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjAQLnN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 06:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjAQLnC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 06:43:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BDF1F5C1
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 03:43:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q23-20020a17090a065700b002290913a521so14597383pje.5
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 03:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5xRUbHCqiGfYtni6iCyWK1clmVHpeVlNYRNRkkJo1k=;
        b=PpfxOtLnVXPiNGSajv5ehV3m4/J8qgxnrCWGYKCDP1R4nIeHrZXJVRxMdJvQTlVIKu
         KAn407X6GOUU3n6Obpk9nj8dv8E5go+JeaaHhTgeEK2YLIqyglKzTiCIDQLxPcFRfixn
         oNzDRn9guxAq5alahKvxyrlCf/ta7aa4lcByzpYoODUyyCSiU/nCD86UK5v5jRk0tgxk
         4TsC9+SnqztVWOEtjzM3fzm6PvjTGF/z8oJfB8rC5xyGNDuhYzNqJXbbPL39yP6lBnRH
         fPnrWV8glXq1299EkQ/m5QAb4tpJ9pACByog0ahsiOKzpKuPQ5RSUz4UI72SJexDKHCu
         sOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5xRUbHCqiGfYtni6iCyWK1clmVHpeVlNYRNRkkJo1k=;
        b=qOdl/akmMDVWQhXKE6XkIasbrFkNOidCTH4Di5BDRsdCgSBYylDhaLr2hbqLOTiyaO
         t7uZbX4qaNt0bs3cUmGhqNYA1Id1k4OI9M7xrE896OR30hqlyE4WXYiUG5U4ImBhAlsA
         SJHLgnHZ4R9seHQWMqMnqUX9+VwRRLRbb5yKTZVl0YwiXghtNWFH2mDow6ZrTMgKYczK
         G+x+hHxVZSoczc564VHo7ircCkoXEkDgUN8V6OofG6puG0HWTFqA3LFYH8a4/hH0FNnQ
         +iQwqm99txMwVE6fsacVd9t7/TTh0+pgDZqyUsO65tB6EmHOuDktmzZg9iPCz0ofTlcE
         Bkdw==
X-Gm-Message-State: AFqh2ko01laQ3oqfxuvNwfPPQAq/6auNV4hkoiFEhK3qeMt1dm0cnaSi
        w4mZjL9ZcvZZOtrwqPCDmAKrq6UBiEziF1aZCa8=
X-Google-Smtp-Source: AMrXdXuyxwasBc6z2pLrwy2nMwd+XWPXfTlIFertYaHYOrLjsD7/oWalWH10gE1P3hYK8zzj/Clv9Yt+2iTJIS7hpZU=
X-Received: by 2002:a17:902:9041:b0:194:721e:6118 with SMTP id
 w1-20020a170902904100b00194721e6118mr245112plz.44.1673955780801; Tue, 17 Jan
 2023 03:43:00 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2zHs+Zatp+SUWNsPzGn81StKF9WL_+XB3pVTJNakxh5Dw@mail.gmail.com>
 <6191067A-8033-4670-BBD0-873C5F9E8878@joelfernandes.org>
In-Reply-To: <6191067A-8033-4670-BBD0-873C5F9E8878@joelfernandes.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 17 Jan 2023 19:42:49 +0800
Message-ID: <CAABZP2xbvz_SS3eZZ6SJFN6kA++DowsirDOsJANGTEX3b0DGBQ@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Joel Fernandes <joel@joelfernandes.org>
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

On Tue, Jan 17, 2023 at 12:34 PM Joel Fernandes <joel@joelfernandes.org> wr=
ote:
>
>
>
> > On Jan 16, 2023, at 10:15 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > =EF=BB=BFOn Tue, Jan 17, 2023 at 9:45 AM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> >>
> >>> On Tue, Jan 17, 2023 at 08:37:16AM +0800, Zhouyi Zhou wrote:
> >>> On Tue, Jan 17, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.or=
g> wrote:
> >>>>
> >>>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> >>>>> Hi Zhouyi,
> >>>>>
> >>>>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
> >>>>>>
> >>>>> [..]
> >>>>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes=
.org> wrote:
> >>>>>>>
> >>>>>>> Hello,
> >>>>>>> I am seeing -EBUSY returned a lot during torture_onoff() when run=
ning
> >>>>>>> rcutorture on arm64. This causes hotplug failure 30% of the time.=
 I am
> >>>>>>> also seeing this in 6.1-rc kernels. I believe see this only for C=
PU0.
> >>>>>>>
> >>>>>>> This causes warnings in torture tests:
> >>>>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: =
errno -16
> >>>>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: =
errno -16
> >>>>>>>
> >>>>>>> Full kernel log here:
> >>>>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/l=
inux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14=
.51.11/TREE04/console.log
> >>>>>>>
> >>>>>>> Any ideas on why this is happening and only for CPU 0 (presumably=
 the
> >>>>>>> boot CPU)? I'd personally need these warnings to go away for my t=
ests
> >>>>>>> as this causes rcutorture's tests to not cleanly pass for me. It
> >>>>>>> appears remove_cpu() -> device_offline() is what returns the erro=
r.
> >>>>>>>
> >>>>>> I guess this probably because CPU 0 is the tick_do_timer_cpu in
> >>>>>> nohz_full mode, which prevent that cpu from
> >>>>>> going offline [1]. We have discussed this topic, but there is no
> >>>>>> agreement on how to solve it yet.
> >>>>>
> >>>>> But I am seeing the issue in TRACE02 config which is:
> >>>>> CONFIG_NO_HZ_IDLE=3Dy
> >>>>> # CONFIG_NO_HZ_FULL is not set
> >>>>>
> >>>>> So that is not NO_HZ_FULL:
> >>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/lin=
ux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.5=
1.11/TRACE02/console.log.diags/
> >>>>> However, I can't seem to find the full kernel logs for that.
> >>>>>
> >>>>> Also, other than the TRACE02 fail, I only see the issue with config=
s
> >>>>> with CONFIG_NO_HZ_FULL=3Dy
> >>>>>
> >>>>> Can you try TRACE02 specifically, and see if you can reproduce the
> >>>>> same issue on your setup? Meanwhile, I'll try to trace what is
> >>>>> returning the -EBUSY.
> >>> I am trying TRACE02 on my X86_64 machine using cross compile and
> >>> qemu-system-aarch64 now, my equipment is limited, but hope I can be o=
f
> >>> beneficial to the community ;-)
> >>
> >> Cool, I am assuming you are trying the patch you shared which you wrot=
e in
> >> November. I bet you will still see the issue.
> > yes, I still see the issue with no hz full.
> >>
> >>>>
> >>>> How about something simple like the following? (untested)
> >>>>
> >>>> ---8<-----------------------
> >>>>
> >>>> diff --git a/kernel/torture.c b/kernel/torture.c
> >>>> index bc8fb361efc0..cd64110694c0 100644
> >>>> --- a/kernel/torture.c
> >>>> +++ b/kernel/torture.c
> >>>> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attem=
pts, long *n_offl_successes,
> >>>>                        // PCI probe frequently disables hotplug duri=
ng boot.
> >>>>                        (*n_offl_attempts)--;
> >>>>                        s =3D " (-EBUSY forgiven during boot)";
> >>>> +               } else if (tick_nohz_full_running && ret =3D=3D -EBU=
SY) {
> >>>> +                       (*n_offl_attempts)--;
> >>>> +                       s =3D " (-EBUSY forgiven if nohz_full is run=
ning)";
> >>> Fantastic fix!! thus we can fix the time keeper cpu torture problem
> >>> without touch the time keeper code.
> >>
> >> Thanks. Unfortunately this does not fix the issue for TRACE02 and the =
patch
> >> you shared does not fix it either -- because TRACE02 is not a no-hz-fu=
ll
> >> test. :-(
> >>
> >> We will need to do a bit of tracing to figure out where the -EBUSY is =
coming
> >> from for TRACE02.
> > agree TRACE02 is another issue, unfortunately I can't reproduce the
> > bug neither with your original Image [1]
> > nor with my cross compiled kernel using [2].
> >
> > I guess there may be two reasons:
> > 1) my testbed is X86_64 based.
> > 2) the command that I invoke qemu is not right:
> > 2-1) the newly compiled linux-5.15.89-rc1
> > qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -smp 4
>
> Does 8 CPUs make any difference? That is my setup.
8 CPUs make no difference ;-(
>
> Not sure what else is different. It could be a CPU model specific issue, =
or something. But why donot you just use the same setup you used in Novembe=
r and check TRACE02? That is actually what I was requesting you to rest, si=
nce you saw the same issue on that setup.
I guess it may be a CPU model specific issue, while I can't invoke
qemu-system-aarch64  with  "-machine virt,gic-version=3Dhost -cpu host"
because I didn't have an aarch64 bare metal host.

OK, I am doing the same setup on linux-5.15.y as I did last November
in the PPC VM of Open Source Lab of Oregon State University, this will
take about 20 hours, and report what I found after the test finishes.

Thanks
Zhouyi
>
> Thanks,
>
> Joel
>
>
>
> > -serial file:/tmp/consoleJan1702.log  -kernel arch/arm64/boot/Image
> > -append "console=3DttyAMA0 oops=3Dpanic panic_on_warn=3D1 panic=3D-1
> > ftrace_dump_on_oops=3Dorig_cpu debug earlyprintk=3Dserial slub_debug=3D=
UZ
> > rcutorture.torture_type=3Dtasks-tracing rcutorture.onoff_interval=3D100=
0
> > rcutorture.onoff_holdoff=3D1000 rcutorture.n_barrier_cbs=3D4
> > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D1200
> > test_no_idle_hz=3D1 verbose=3D1" -m 2048 -net user,hostfwd=3Dtcp::10024=
-:22
> > -net nic
> > 2-2) original Image [1]
> > qemu-system-aarch64 -machine virt   -cpu cortex-a57   -nographic -smp
> > 4  -serial file:/tmp/consoleJan1701.log   -kernel /home/zzy/Image
> > -append "console=3DttyAMA0  oops=3Dpanic panic_on_warn=3D1 panic=3D-1
> > ftrace_dump_on_oops=3Dorig_cpu debug earlyprintk=3Dserial slub_debug=3D=
UZ
> > rcutorture.torture_type=3Dtasks-tracing rcutorture.onoff_interval=3D100=
0
> > rcutorture.onoff_holdoff=3D30 n_barrier_cbs=3D4
> > rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D1200
> > test_no_idle_hz=3D1 verbose=3D1"   -m 2048   -net
> > user,hostfwd=3Dtcp::10023-:22 -net nic
> >
> > As Mark can reproduce the issue using [1], there must be something
> > wrong with my x86_64 based environment.
> >
> > Sorry not to be of help this time.
> >
> > I am very happy and interested to perform further tests whenever there
> > are further instructions ;-)
> >
> > [1] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/lin=
ux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.5=
1.11/TRACE02/Image
> > [2] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/lin=
ux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.5=
1.11/TRACE02/.config
> >>
> >> I wonder if we should ignore -EBUSY altogether, since as Thomas mentio=
ned,
> >> hotplug failure is "normal". Thoughts?
> > This decision is too important for a beginner like me, however may
> > thanks for your trust in me ;-) What does Paul think about it ;-)
> >
> > Thanks
> > Zhouyi
> >>
> >> thanks,
> >>
> >> - Joel
> >>
