Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD3EEB64DD
	for <rcu@archiver.kernel.org>; Tue,  8 Aug 2023 02:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHHCHB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHHCHA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 22:07:00 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A5138
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 19:06:59 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bc479cc815so4073887fac.1
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691460418; x=1692065218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mgLvTG3ckXfWKbhF1LzHS+9Zq9WASeSCCo5lEN+6iY=;
        b=St0HJZkxBTzgPPJMCdZ0EDaPrPxpT/b2iAZtk7Swyhl1Mkx+ap86XrXi6SO7qmQeTv
         rdnvtfvyrN3bWIk8o1HG8rxlhfbvRX/YFmBby8+F2YAIONlFMj+r7Sm2UlbIvVGI4J0K
         kWUedBVR8C/awg1gBWV8BXpy8SzewlKl9zrIF1Un+RpMDEHbLHVnaqvny+3pYWsiGRq7
         xF14a77+M6bRAprAExMG2vN2DyjPtDlBLaBJ40DNoQ5UQa22QXJxXhnpT7ciaxD9VRQV
         sAMb2ejrviZxdX2CmjFgGgWti+Sz3bf83sBDcg6iylgiaCIo4jxp71JU3OXcI6/m91Kg
         0SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691460418; x=1692065218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mgLvTG3ckXfWKbhF1LzHS+9Zq9WASeSCCo5lEN+6iY=;
        b=GbT3zpMnW+hlqesE+uMAcvI60sp5a5m0BRARtojRWxGj7o1vZNpnhCrspevqATQrBy
         JSO1WLePNnuQm/pyAtIqDOBH39bG5b59AmPmwWESImB0w31URyEaq54UX6PVtplssvJP
         T9LvbYPKpe/8rKVe4jh66EpciQywDDbWJLGK48DX2XWnXufQcixdIdm2N26BTGVFduGe
         h5i2kyn2cVuPr8HQeLcnPx9NipBeM8YC3iZT2YoYRC4j13esIeGaMz6UblCZb1vdivAl
         PM1s0VA4sxGhgA3Mt5DfsadPVdc4V5xUFAxZ0v8H1i9RekkfWO8nyXnFgVJr0A8RiJce
         JpBA==
X-Gm-Message-State: AOJu0YxdRqzC7gDOphm9FLvQlMhxWeG+CtgH3ja8+WnBb/kp/S8JWX4u
        6AaxX+fuDMu3f7ddZda02IHGzSTFP2H1j3+TFyla6J0i6kE=
X-Google-Smtp-Source: AGHT+IF+NXegHu2+7vofbi6qD1BS4MomCyV1a5PyGyi4FaEYU5amWLTSQnDZfLcEKsW749gpm62QOwmkMKe576SqjeI=
X-Received: by 2002:a05:6871:594:b0:1bf:1a58:c50 with SMTP id
 u20-20020a056871059400b001bf1a580c50mr13321867oan.9.1691460418324; Mon, 07
 Aug 2023 19:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
 <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com>
 <CAABZP2zsArdrV827DuzG0EjU9-kH7LQx7-fBjZRH13xLsfiPDg@mail.gmail.com>
 <CAEXW_YR4resXTGPFH63Gf9sK6KfhypT7zXZ72XHRHBbQVs4-5A@mail.gmail.com> <CAABZP2zHhmogFw0mP5RTQ_RsgXfJqXhVyN2DvVAbAfiRy+p0Eg@mail.gmail.com>
In-Reply-To: <CAABZP2zHhmogFw0mP5RTQ_RsgXfJqXhVyN2DvVAbAfiRy+p0Eg@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 8 Aug 2023 10:06:46 +0800
Message-ID: <CAABZP2zYXbSjPUyJd4X5r0wTdSQBLUEm_eGmqaYf2o3HVxVn9A@mail.gmail.com>
Subject: Re: TREE04 and TREE07 failures on 5.15 stable
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 8, 2023 at 5:08=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> w=
rote:
>
> On Tue, Aug 8, 2023 at 12:56=E2=80=AFAM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > On Mon, Aug 7, 2023 at 11:47=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> > >
> > > On Mon, Aug 7, 2023 at 11:38=E2=80=AFPM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > > >
> > > > Btw full logs are here:
> > > > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5=
.15.y/80/artifact/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.1=
9/
> > > >
> > > > And some more comments:
> > > >
> > > > On Mon, Aug 7, 2023 at 10:22=E2=80=AFAM Joel Fernandes <joel@joelfe=
rnandes.org> wrote:
> > > > >
> > > > > Hello, Frederick, all,
> > > > > TREE04 and TREE07 still fail on the 5.15 kernel.
> > > > >
> > > > > The stutter patches helped 5.10, 6.1 and 6.4 but 5.15 still is
> > > > > troubled. Any thoughts?
> > > > >
> > > > > OTOH, I am not sure how many NO_HZ_FULL users are on the 5.15 ker=
nel.
> > > > > Do you have any idea?
> > > > >
> > > > > Meanwhile I'll continue to debug it. Thank you!
> > > > >
> > > > >  --- Mon Aug  7 07:37:10 AM UTC 2023 Test summary:
> > > > > Results directory:
> > > > > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stabl=
e_linux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19
> > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duratio=
n 60
> > > > > RUDE01 ------- 22984 GPs (6.38444/s) [tasks-rude: g0 f0x0 total-g=
ps=3D0]
> > > > > SRCU-N ------- 318544 GPs (88.4844/s) [srcu: g4127136 f0x0 total-=
gps=3D4127136]
> > > > > SRCU-P ------- 268977 GPs (74.7158/s) [srcud: g2180244 f0x0 total=
-gps=3D2180244]
> > > > > SRCU-T ------- 497422 GPs (138.173/s) [srcu: g57760 f0x0 total-gp=
s=3D57760]
> > > > > SRCU-U ------- 1152598 GPs (320.166/s) [srcud: g33534 f0x0 total-=
gps=3D33534]
> > > > > TASKS01 ------- 11516 GPs (3.19889/s) [tasks: g0 f0x0 total-gps=
=3D0]
> > > > > TASKS02 ------- 13407 GPs (3.72417/s) [tasks: g0 f0x0 total-gps=
=3D0]
> > > > > TASKS03 ------- 4598 GPs (1.27722/s) [tasks: g0 f0x0 total-gps=3D=
0]
> > > > > TINY01 ------- 422041 GPs (117.234/s) [rcu: g0 f0x0 total-gps=3D0=
]
> > > > > n_max_cbs: 77229
> > > > > TINY02 ------- 441676 GPs (122.688/s) [rcu: g0 f0x0 total-gps=3D0=
]
> > > > > n_max_cbs: 10691
> > > > > TRACE01 ------- 12593 GPs (3.49806/s) [tasks-tracing: g0 f0x0 tot=
al-gps=3D0]
> > > > > TRACE02 ------- 106606 GPs (29.6128/s) [tasks-tracing: g0 f0x0 to=
tal-gps=3D0]
> > > > > TREE01 ------- 42614 GPs (11.8372/s) [rcu: g346169 f0x0 total-gps=
=3D86809]
> > > > > TREE02 ------- 161421 GPs (44.8392/s) [rcu: g1356445 f0x0
> > > > > total-gps=3D339371] n_max_cbs: 177936
> > > > > TREE03 ------- 105074 GPs (29.1872/s) [rcu: g1699381 f0x2
> > > > > total-gps=3D425089] n_max_cbs: 631295
> > > > > TREE04 ------- 106036 GPs (29.4544/s) n_max_cbs: 550875
> > > > > QEMU killed
> > > >
> > > > This seems hotplug related. Not sure.
> > > >
> > > > > TREE04 no success message, 222 successful version messages
> > > > > !!! PID 2616159 hung at 3780 vs. 3600 seconds Mon Aug  7 06:27:38=
 AM UTC 2023
> > > > > TREE05 ------- 132006 GPs (36.6683/s) [rcu: g1043673 f0x0
> > > > > total-gps=3D261183] n_max_cbs: 160463
> > > > > TREE07 ------- 52858 GPs (14.6828/s) n_max_cbs: 429828
> > > > > QEMU killed
> > > > > TREE07 no success message, 234 successful version messages
> > > > >  [033mWARNING:  [mAssertion failure in
> > > > > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stabl=
e_linux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/T=
REE07/console.log
> > > > > TREE07
> > > > >  [033mWARNING:  [mSummary: Call Traces: 6 Stalls: 5 Starves: 1
> > > >
> > > > Looks like this was because it is missing:
> > > > lore.kernel.org/r/20230101061555.278129-1-joel@joelfernandes.org
> > > 5.15.y (38d4ca22a528) is missing above patch. I started
> > > tools/testing/selftests/rcutorture/bin/torture.sh on my  i7-12800H
> > > nested kvm ubuntu environment just now, the test will last for about =
7
> > > hours.
> > >
> > > Hope I can be of some beneficial ;-)
> >
> > Thanks Zhouyi ;-)
> >
> > I am also doing a debug run to trackdown what's up with TREE04,  you
> > can see the test running live here ;-)
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.=
y/83/console
> >
> > (in case you want to see the kvm.sh options I passed for tracing, take
> > a look at the link).
> Thank you Joel for your instruction.
> I stopped torture.sh, and run the kvm.sh with the options above both
> on my  i7-12800H and Dell PowerEdge R720 with two Intel(R) Xeon(R) CPU
> E5-2660 (which I use to test [1]).
I can't reproduce the phenomenon in above environments, maybe the
hardware plays in important role in our scenery.

[ 7204.697370] mem_dump_obj() vmalloc test: rcu_torture_stats =3D
0000000000000000, &rhp =3D ffffc9000036feb0, rhp =3D ffffc9000000c000
[ 7204.701895] mem_dump_obj(vmalloc ffffc9000000c000): 1-page vmalloc
region starting at 0xffffc9000000c000 allocated at
rcu_torture_cleanup.cold+0x218/c
[ 7204.707293] mem_dump_obj(vmalloc ffffc9000000c008): 1-page vmalloc
region starting at 0xffffc9000000c000 allocated at
rcu_torture_cleanup.cold+0x218/c
[ 7204.712755] rcu-torture: rtc: 0000000000000000 VER: 343876 tfle: 0
rta: 343876 rtaf: 0 rtf: 343865 rtmbe: 0 rtmbkf: 0/138644 rtbe: 0
rtbke: 0 rtbre: 0
[ 7204.723319] rcu-torture: Reader Pipe:  12958247071 489089 0 0 0 0 0 0 0 =
0 0
[ 7204.726240] rcu-torture: Reader Batch:  12957121006 1615154 0 0 0 0 0 0 =
0 0 0
[ 7204.729146] rcu-torture: Free-Block Circulation:  343875 343875
343872 343871 343870 343869 343868 343867 343866 343865 0
[ 7204.733441] rcu-torture:--- End of test: SUCCESS: nreaders=3D7
nfakewriters=3D4 stat_interval=3D15 verbose=3D1 test_no_idle_hz=3D1
shuffle_interval=3D3 stutter=3D50
[ 7204.750432] platform platform-framebuffer.0: shutdown

I am very regret not able to help

Thanks
Zhouyi
>
> The tests seem to end after 7200 seconds, I will report to you after that=
.
>
> Thanks
> Zhouyi
> [1] https://lore.kernel.org/all/CAABZP2wSoEzfMWRdxGb6TmWVeN4xDUu5qjnG0d8R=
faO7AovGZQ@mail.gmail.com/
> >
> > - Joel
