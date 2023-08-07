Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A5C001B0
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 21:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjHGVIr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGVIq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 17:08:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B4B6
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 14:08:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-268b3ddc894so2723226a91.1
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691442524; x=1692047324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7223AFXvaNe/pTAKrXMr4M82+84BcOqSEcWrHGV8YD4=;
        b=skwE40pI0jzO/BV5lQzLCa6wkMXwOD+ucc5f0E/bBTQTQghI9YdWazcMNppU7m6wTv
         l3U11smk0dKhryQAfQf5U7yrmZ3UC+jW3fqshK1NPEocYF9VSL0E6/hbFO9qD+a4iNMK
         VuK1IXh97yBYmWnmfV0rsaszwpRDs48RR5Wwu4Y1h4FlAM2tBWG60ppe63v212VlzzZO
         0NtQY6WQcnHYLcekiWQtq8L2/WxdhH/DF4k3HRlJVI4iWIgJdZz2gSeCWJF4sJoaH5Nx
         U8BrI6uiXe6Gds0PEdZwRrrqTVejnWSYlqidX52taAjQQX3RMu5vo+gbekBZNfykL0dY
         UzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442524; x=1692047324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7223AFXvaNe/pTAKrXMr4M82+84BcOqSEcWrHGV8YD4=;
        b=gw2rqDrQ4aGwxuuSj4QnxaFcG8ODG9DUdXaScthLpTVRHPc4ql9Rw0925Aw44nOUzU
         H1B5CTVl7WUWDGvbjqApa52vVUjxfynOGbyUcgNdQkb+2bGONfIl+mBe1Cmf20w6LBmc
         1+CtTZseK5B+0miZ4UAUnZf2tJxdYiQQIFM6YsTyYwef/+qrbjOF9s3WZtfKO4EQwfTU
         PkD1TITGip4KM3skz+JOtms+Sjv2yhGWrORZ4Emm3dtTCij4TmtNTGaEgZMIQc61Ze7U
         N8noBCG/YODv9aeoHyf3uJ42JOZRC2RoGYStGChpU8RvdWQcpEndVi2wpN8vyNnFyJsf
         7rDw==
X-Gm-Message-State: AOJu0YwDrU/rL84tfN/42itIH12/I7hax57jIGA933t8oJolaT+yJAZ6
        vxveb7RXMXaaHdd690QJovIuhwQ+QvZ4fxcGtiCqnJBbrNc=
X-Google-Smtp-Source: AGHT+IFhM/wI/gQVyslVdoGOP6R8tRVPlIxSyq3PX4q+62XfrxI13jg99cHNwp5EaqMG4xs2jmrMBPh+LCz2XCaOtYE=
X-Received: by 2002:a17:90b:4a03:b0:268:1d47:4d2b with SMTP id
 kk3-20020a17090b4a0300b002681d474d2bmr7691203pjb.34.1691442524373; Mon, 07
 Aug 2023 14:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
 <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com>
 <CAABZP2zsArdrV827DuzG0EjU9-kH7LQx7-fBjZRH13xLsfiPDg@mail.gmail.com> <CAEXW_YR4resXTGPFH63Gf9sK6KfhypT7zXZ72XHRHBbQVs4-5A@mail.gmail.com>
In-Reply-To: <CAEXW_YR4resXTGPFH63Gf9sK6KfhypT7zXZ72XHRHBbQVs4-5A@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 8 Aug 2023 05:08:33 +0800
Message-ID: <CAABZP2zHhmogFw0mP5RTQ_RsgXfJqXhVyN2DvVAbAfiRy+p0Eg@mail.gmail.com>
Subject: Re: TREE04 and TREE07 failures on 5.15 stable
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 8, 2023 at 12:56=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
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
Thank you Joel for your instruction.
I stopped torture.sh, and run the kvm.sh with the options above both
on my  i7-12800H and Dell PowerEdge R720 with two Intel(R) Xeon(R) CPU
E5-2660 (which I use to test [1]).

The tests seem to end after 7200 seconds, I will report to you after that.

Thanks
Zhouyi
[1] https://lore.kernel.org/all/CAABZP2wSoEzfMWRdxGb6TmWVeN4xDUu5qjnG0d8Rfa=
O7AovGZQ@mail.gmail.com/
>
> - Joel
