Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C0C3DA78
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 03:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjAQDPf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 22:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjAQDPb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 22:15:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863523129
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 19:15:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id r21so94095plg.13
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 19:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iAeKiaCVEPPe0voXe1kiSVF9zexNLCS4SyW6q2V20Pk=;
        b=b52eMHrMQxasoLM+Pznmpsp7uW0BsZglyBz0IsoZf6ScJIBkNHWb5zmYyUwfJcsNbO
         Em5M1lOMLuwpbtBO/fBAUE8z5xjUZ/TdEApuGrRYDCppmtY4PuGjy+pZRCOfl4aTA1g+
         qJW0BJy/9KH1oaxoUdI+4AZrZkCuFCwKNL6nnde/U0BZ+whwsBLN6tazda7bkOZjrRps
         0JRXAVl8RiGa9zziNDmJ0fGo7JGAxfzpXHVlSTq6nev1LMYLGM8cJin98o0FBFkZn5QA
         zV1+nymFNvpyLY2hayj0x7msTJLTXelK4JPUGlrqbf8DqTAmlngikcq66WzXhHhelw4n
         pROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAeKiaCVEPPe0voXe1kiSVF9zexNLCS4SyW6q2V20Pk=;
        b=6KgKXhLqKPwEppNA29UYPQx8Fx2mMAGRhQg6U8tG0zCJjHfgXHfFnEFdnuzUAbGRhG
         E3bay3sAB2ArdceAqVXYBhsEX9t6+x+ZNdDpy7NswrGKNcz3l58c/nN2fU0PFU6W5aug
         naabYbPqIqHI7phBJwWsiJh0xS+ooZnW8j8OOiPgXCBUuba5dsPJQn0WwiiCWPQno67P
         i5ad0rzU8db/f32OOVRw9N6dkOFglTcdzrg9wPBhebuNZXKm5Xja7fyOfxALBFkmOvOf
         y1XfIPQhFl/NSXkYoDQj5jqI/9nzctP5GIt31reTejtWWguU0+HZ4+YwjpSGq1fXkPzl
         G6Jg==
X-Gm-Message-State: AFqh2kpQ/odMJOJ4/CR0btIgKOyyfXaVXUBSoYZcoShYsiRV7Zv6Il5L
        nXoTxbQzKhUBowW0lTEyn8D7W/NJmu/nAEeQTL8=
X-Google-Smtp-Source: AMrXdXvpgtkUI5+r2Uq81PY+ce56vH71gB1kuN8+pdro+AesfxvGPzB2v9+n+Drh7t2hLXOrslikPlqH5XuJQIzJvgA=
X-Received: by 2002:a17:903:2284:b0:193:39c4:cf54 with SMTP id
 b4-20020a170903228400b0019339c4cf54mr115193plh.48.1673925329252; Mon, 16 Jan
 2023 19:15:29 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
 <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com>
 <Y8Xoi3UvMs+Oy78O@google.com> <CAABZP2z50Fbs2rh4j2ToH-0hGfDamzQF3SoxxniC5LrXZ=Ja+A@mail.gmail.com>
 <Y8X9rL4ZB9E7gAN9@google.com>
In-Reply-To: <Y8X9rL4ZB9E7gAN9@google.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 17 Jan 2023 11:15:18 +0800
Message-ID: <CAABZP2zHs+Zatp+SUWNsPzGn81StKF9WL_+XB3pVTJNakxh5Dw@mail.gmail.com>
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
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 9:45 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Jan 17, 2023 at 08:37:16AM +0800, Zhouyi Zhou wrote:
> > On Tue, Jan 17, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > > > Hi Zhouyi,
> > > >
> > > > On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > > > >
> > > > [..]
> > > > > On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > Hello,
> > > > > > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > > > > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > > > > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > > > > >
> > > > > > This causes warnings in torture tests:
> > > > > > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > > > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > > >
> > > > > > Full kernel log here:
> > > > > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > > > > >
> > > > > > Any ideas on why this is happening and only for CPU 0 (presumably the
> > > > > > boot CPU)? I'd personally need these warnings to go away for my tests
> > > > > > as this causes rcutorture's tests to not cleanly pass for me. It
> > > > > > appears remove_cpu() -> device_offline() is what returns the error.
> > > > > >
> > > > > I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > > > > nohz_full mode, which prevent that cpu from
> > > > > going offline [1]. We have discussed this topic, but there is no
> > > > > agreement on how to solve it yet.
> > > >
> > > > But I am seeing the issue in TRACE02 config which is:
> > > > CONFIG_NO_HZ_IDLE=y
> > > > # CONFIG_NO_HZ_FULL is not set
> > > >
> > > > So that is not NO_HZ_FULL:
> > > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> > > > However, I can't seem to find the full kernel logs for that.
> > > >
> > > > Also, other than the TRACE02 fail, I only see the issue with configs
> > > > with CONFIG_NO_HZ_FULL=y
> > > >
> > > > Can you try TRACE02 specifically, and see if you can reproduce the
> > > > same issue on your setup? Meanwhile, I'll try to trace what is
> > > > returning the -EBUSY.
> > I am trying TRACE02 on my X86_64 machine using cross compile and
> > qemu-system-aarch64 now, my equipment is limited, but hope I can be of
> > beneficial to the community ;-)
>
> Cool, I am assuming you are trying the patch you shared which you wrote in
> November. I bet you will still see the issue.
yes, I still see the issue with no hz full.
>
> > >
> > > How about something simple like the following? (untested)
> > >
> > > ---8<-----------------------
> > >
> > > diff --git a/kernel/torture.c b/kernel/torture.c
> > > index bc8fb361efc0..cd64110694c0 100644
> > > --- a/kernel/torture.c
> > > +++ b/kernel/torture.c
> > > @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
> > >                         // PCI probe frequently disables hotplug during boot.
> > >                         (*n_offl_attempts)--;
> > >                         s = " (-EBUSY forgiven during boot)";
> > > +               } else if (tick_nohz_full_running && ret == -EBUSY) {
> > > +                       (*n_offl_attempts)--;
> > > +                       s = " (-EBUSY forgiven if nohz_full is running)";
> >  Fantastic fix!! thus we can fix the time keeper cpu torture problem
> > without touch the time keeper code.
>
> Thanks. Unfortunately this does not fix the issue for TRACE02 and the patch
> you shared does not fix it either -- because TRACE02 is not a no-hz-full
> test. :-(
>
> We will need to do a bit of tracing to figure out where the -EBUSY is coming
> from for TRACE02.
agree TRACE02 is another issue, unfortunately I can't reproduce the
bug neither with your original Image [1]
nor with my cross compiled kernel using [2].

I guess there may be two reasons:
1) my testbed is X86_64 based.
2) the command that I invoke qemu is not right:
2-1) the newly compiled linux-5.15.89-rc1
qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -smp 4
-serial file:/tmp/consoleJan1702.log  -kernel arch/arm64/boot/Image
-append "console=ttyAMA0 oops=panic panic_on_warn=1 panic=-1
ftrace_dump_on_oops=orig_cpu debug earlyprintk=serial slub_debug=UZ
rcutorture.torture_type=tasks-tracing rcutorture.onoff_interval=1000
rcutorture.onoff_holdoff=1000 rcutorture.n_barrier_cbs=4
rcutorture.stat_interval=15 rcutorture.shutdown_secs=1200
test_no_idle_hz=1 verbose=1" -m 2048 -net user,hostfwd=tcp::10024-:22
-net nic
2-2) original Image [1]
qemu-system-aarch64 -machine virt   -cpu cortex-a57   -nographic -smp
4  -serial file:/tmp/consoleJan1701.log   -kernel /home/zzy/Image
-append "console=ttyAMA0  oops=panic panic_on_warn=1 panic=-1
ftrace_dump_on_oops=orig_cpu debug earlyprintk=serial slub_debug=UZ
rcutorture.torture_type=tasks-tracing rcutorture.onoff_interval=1000
rcutorture.onoff_holdoff=30 n_barrier_cbs=4
rcutorture.stat_interval=15 rcutorture.shutdown_secs=1200
test_no_idle_hz=1 verbose=1"   -m 2048   -net
user,hostfwd=tcp::10023-:22 -net nic

As Mark can reproduce the issue using [1], there must be something
wrong with my x86_64 based environment.

Sorry not to be of help this time.

I am very happy and interested to perform further tests whenever there
are further instructions ;-)

[1] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/Image
[2] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/.config
>
> I wonder if we should ignore -EBUSY altogether, since as Thomas mentioned,
> hotplug failure is "normal". Thoughts?
This decision is too important for a beginner like me, however may
thanks for your trust in me ;-) What does Paul think about it ;-)

Thanks
Zhouyi
>
> thanks,
>
>  - Joel
>
