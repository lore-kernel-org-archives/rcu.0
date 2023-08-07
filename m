Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3EEC001B0
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 16:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHGQ45 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHGQ4u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 12:56:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D1D19B7
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 09:56:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so75900411fa.0
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691427387; x=1692032187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+e5cgO+6f+JC0a7XFOl9KDesC5zdpgEZDqEJmbHLUg=;
        b=Rimvg0Dm926Po8Ooj1vrHanZTYSWl8owoI0laDiCKnJwcXUtiJzpLm1EuovKNaMKFL
         71arZVaD97Me3pERfx/kg/CwQl1oDB/M8viwaeI6bivhK5+JpM2UfD/Fsw1CchkhrTpT
         RNPwoHlUItyEAujoojoNyjvrN6ZswJxM54+RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427387; x=1692032187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+e5cgO+6f+JC0a7XFOl9KDesC5zdpgEZDqEJmbHLUg=;
        b=ltERJsohVx0vzzas7dPDqqjZT3vuxKuf1+z0X3QD6TSZL2oLT73VPVQXpx0GOramDd
         UlZ6bGzZH9yxsL62fD6pjEN6thW6Lot/IzyiTF18Omb0ZOAsarnk3EBap8xQKCGwaavG
         rTb3zzJLFmtjY/gJ8B34Dk3ZPp+/8OnEvGUHUI99yWTQ68AfwiofgcYsdQ1ndutQkMD1
         GjtsH7Dd830Iueny3zhbqyQVOxbjOY0qYwYe/vpIvHj2FcTFJy3t2iguldyWDx9v6ggV
         GIFxfATPInsI2o+l2eDKN6AJdn+rScj9wu9H2iBMtSocu/02LRAxp8xvm+OcI7ORklGs
         /h0Q==
X-Gm-Message-State: AOJu0Yzs/+xYXUhAnaGEqbhwsROBT1KstGL7WbQoag3KZhuBEftuUvDF
        cGbrXWbgVNUfavqF1TZTwU/E5gIgtmEv4nFIuS0Rf+ioHqWTmeTYI2o=
X-Google-Smtp-Source: AGHT+IHdzJEeF+aRJN3q1cpzo7nuSBA+WKmPkaA38gJM1QQuxTu/zTWL0AwC1l68oDGPhxNH6OZVojPXj/x8XFpinAc=
X-Received: by 2002:a2e:7301:0:b0:2b9:b693:c906 with SMTP id
 o1-20020a2e7301000000b002b9b693c906mr6440985ljc.27.1691427387060; Mon, 07 Aug
 2023 09:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
 <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com> <CAABZP2zsArdrV827DuzG0EjU9-kH7LQx7-fBjZRH13xLsfiPDg@mail.gmail.com>
In-Reply-To: <CAABZP2zsArdrV827DuzG0EjU9-kH7LQx7-fBjZRH13xLsfiPDg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 12:56:16 -0400
Message-ID: <CAEXW_YR4resXTGPFH63Gf9sK6KfhypT7zXZ72XHRHBbQVs4-5A@mail.gmail.com>
Subject: Re: TREE04 and TREE07 failures on 5.15 stable
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 7, 2023 at 11:47=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> On Mon, Aug 7, 2023 at 11:38=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > Btw full logs are here:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.=
y/80/artifact/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/
> >
> > And some more comments:
> >
> > On Mon, Aug 7, 2023 at 10:22=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Hello, Frederick, all,
> > > TREE04 and TREE07 still fail on the 5.15 kernel.
> > >
> > > The stutter patches helped 5.10, 6.1 and 6.4 but 5.15 still is
> > > troubled. Any thoughts?
> > >
> > > OTOH, I am not sure how many NO_HZ_FULL users are on the 5.15 kernel.
> > > Do you have any idea?
> > >
> > > Meanwhile I'll continue to debug it. Thank you!
> > >
> > >  --- Mon Aug  7 07:37:10 AM UTC 2023 Test summary:
> > > Results directory:
> > > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_li=
nux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration 60
> > > RUDE01 ------- 22984 GPs (6.38444/s) [tasks-rude: g0 f0x0 total-gps=
=3D0]
> > > SRCU-N ------- 318544 GPs (88.4844/s) [srcu: g4127136 f0x0 total-gps=
=3D4127136]
> > > SRCU-P ------- 268977 GPs (74.7158/s) [srcud: g2180244 f0x0 total-gps=
=3D2180244]
> > > SRCU-T ------- 497422 GPs (138.173/s) [srcu: g57760 f0x0 total-gps=3D=
57760]
> > > SRCU-U ------- 1152598 GPs (320.166/s) [srcud: g33534 f0x0 total-gps=
=3D33534]
> > > TASKS01 ------- 11516 GPs (3.19889/s) [tasks: g0 f0x0 total-gps=3D0]
> > > TASKS02 ------- 13407 GPs (3.72417/s) [tasks: g0 f0x0 total-gps=3D0]
> > > TASKS03 ------- 4598 GPs (1.27722/s) [tasks: g0 f0x0 total-gps=3D0]
> > > TINY01 ------- 422041 GPs (117.234/s) [rcu: g0 f0x0 total-gps=3D0]
> > > n_max_cbs: 77229
> > > TINY02 ------- 441676 GPs (122.688/s) [rcu: g0 f0x0 total-gps=3D0]
> > > n_max_cbs: 10691
> > > TRACE01 ------- 12593 GPs (3.49806/s) [tasks-tracing: g0 f0x0 total-g=
ps=3D0]
> > > TRACE02 ------- 106606 GPs (29.6128/s) [tasks-tracing: g0 f0x0 total-=
gps=3D0]
> > > TREE01 ------- 42614 GPs (11.8372/s) [rcu: g346169 f0x0 total-gps=3D8=
6809]
> > > TREE02 ------- 161421 GPs (44.8392/s) [rcu: g1356445 f0x0
> > > total-gps=3D339371] n_max_cbs: 177936
> > > TREE03 ------- 105074 GPs (29.1872/s) [rcu: g1699381 f0x2
> > > total-gps=3D425089] n_max_cbs: 631295
> > > TREE04 ------- 106036 GPs (29.4544/s) n_max_cbs: 550875
> > > QEMU killed
> >
> > This seems hotplug related. Not sure.
> >
> > > TREE04 no success message, 222 successful version messages
> > > !!! PID 2616159 hung at 3780 vs. 3600 seconds Mon Aug  7 06:27:38 AM =
UTC 2023
> > > TREE05 ------- 132006 GPs (36.6683/s) [rcu: g1043673 f0x0
> > > total-gps=3D261183] n_max_cbs: 160463
> > > TREE07 ------- 52858 GPs (14.6828/s) n_max_cbs: 429828
> > > QEMU killed
> > > TREE07 no success message, 234 successful version messages
> > >  [033mWARNING:  [mAssertion failure in
> > > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_li=
nux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/TREE0=
7/console.log
> > > TREE07
> > >  [033mWARNING:  [mSummary: Call Traces: 6 Stalls: 5 Starves: 1
> >
> > Looks like this was because it is missing:
> > lore.kernel.org/r/20230101061555.278129-1-joel@joelfernandes.org
> 5.15.y (38d4ca22a528) is missing above patch. I started
> tools/testing/selftests/rcutorture/bin/torture.sh on my  i7-12800H
> nested kvm ubuntu environment just now, the test will last for about 7
> hours.
>
> Hope I can be of some beneficial ;-)

Thanks Zhouyi ;-)

I am also doing a debug run to trackdown what's up with TREE04,  you
can see the test running live here ;-)
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/83=
/console

(in case you want to see the kvm.sh options I passed for tracing, take
a look at the link).

- Joel
