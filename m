Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D2C001B0
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjHGPr6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHGPrz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 11:47:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685F10F6
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 08:47:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2680f27b52dso2617476a91.0
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691423271; x=1692028071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLMos5XOS2jM4Zqg5AXAqg+ZpPtomDcajaOQZdvw3mE=;
        b=mQJEMOk94kw5JH+Et2RaNPkICii6cW2PAgkDHDW5tGzXQseSIRWSMpWNBV20RFO558
         5pYHG8qjgA/7K77CaSz9USI7v4gns5Flfm44B+PnLDNdWTzjq3bS/z1qOGJpQrpwkzFp
         8LzHcILrIUIBlBPCYcOJ7AF1M9CwfmeXBARZK7+hYSG1a3KYHgnYtS7mad7aQU1sMTNo
         UeLrcGnZHgBWfKMvj9Xqoky8QZgWQENMIC39NiwDpcofsQ0e+86gX18AcJXRoaYmb2XV
         URQ+oHE92Y4274YFaiGST5TtSlR9O+1Wp/oL+FjYQJURM61jqiTG7vQfAJpzkI0etwbw
         9TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691423271; x=1692028071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLMos5XOS2jM4Zqg5AXAqg+ZpPtomDcajaOQZdvw3mE=;
        b=kOS5f1PeOD/yL0lARltKYM/nRPSoYKhsaNrLnXZaL41l47G5NIVmVuNZ3Qs9GIXKal
         X5FNAlSNSA0EZG7Ls5UOP2GSaIUKw0cXkHvKTdboJ1XcT2K2jg4KZmAFc05GBEFEo8YM
         A61yZfhnJYVH7ZoH0SFlEtV4t11lpniH591t0h7oxYqpEQ/3NO3HKvrOxfuRThzWAdiN
         AK3I8wMnWuLg3KZfnA4ZtgTVuPI/WJL93eOxQSnjM18LbpCQU1YRiQDDWoZp3dyhWZNI
         bpsDg516N7yLV6dmH1VCfNHKW8PMYqS0waHfAbu7lwCWLR/R80vCyEQ7HV39+JiHTMok
         946Q==
X-Gm-Message-State: AOJu0YyLBcSXB6zm5e0uNfUKtyX7BdGfKKU98Ef4shJZ4n7BNPHwFCTi
        GFw0A0FURxvMPwfSXR9m5N+dA5+U0hSmH516vUw=
X-Google-Smtp-Source: AGHT+IFNalOn/FEyXgaraIccGD1W6Gnn+rLsfqpSFTzIcef5sr2FwzzbM0uDCl+RSphlwnkYt2crTglF8McTYVz1o9w=
X-Received: by 2002:a17:90b:23d3:b0:268:f987:305d with SMTP id
 md19-20020a17090b23d300b00268f987305dmr8821009pjb.5.1691423271499; Mon, 07
 Aug 2023 08:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
 <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com>
In-Reply-To: <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 7 Aug 2023 23:47:39 +0800
Message-ID: <CAABZP2zsArdrV827DuzG0EjU9-kH7LQx7-fBjZRH13xLsfiPDg@mail.gmail.com>
Subject: Re: TREE04 and TREE07 failures on 5.15 stable
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 7, 2023 at 11:38=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Btw full logs are here:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/=
80/artifact/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/
>
> And some more comments:
>
> On Mon, Aug 7, 2023 at 10:22=E2=80=AFAM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > Hello, Frederick, all,
> > TREE04 and TREE07 still fail on the 5.15 kernel.
> >
> > The stutter patches helped 5.10, 6.1 and 6.4 but 5.15 still is
> > troubled. Any thoughts?
> >
> > OTOH, I am not sure how many NO_HZ_FULL users are on the 5.15 kernel.
> > Do you have any idea?
> >
> > Meanwhile I'll continue to debug it. Thank you!
> >
> >  --- Mon Aug  7 07:37:10 AM UTC 2023 Test summary:
> > Results directory:
> > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linu=
x-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19
> > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration 60
> > RUDE01 ------- 22984 GPs (6.38444/s) [tasks-rude: g0 f0x0 total-gps=3D0=
]
> > SRCU-N ------- 318544 GPs (88.4844/s) [srcu: g4127136 f0x0 total-gps=3D=
4127136]
> > SRCU-P ------- 268977 GPs (74.7158/s) [srcud: g2180244 f0x0 total-gps=
=3D2180244]
> > SRCU-T ------- 497422 GPs (138.173/s) [srcu: g57760 f0x0 total-gps=3D57=
760]
> > SRCU-U ------- 1152598 GPs (320.166/s) [srcud: g33534 f0x0 total-gps=3D=
33534]
> > TASKS01 ------- 11516 GPs (3.19889/s) [tasks: g0 f0x0 total-gps=3D0]
> > TASKS02 ------- 13407 GPs (3.72417/s) [tasks: g0 f0x0 total-gps=3D0]
> > TASKS03 ------- 4598 GPs (1.27722/s) [tasks: g0 f0x0 total-gps=3D0]
> > TINY01 ------- 422041 GPs (117.234/s) [rcu: g0 f0x0 total-gps=3D0]
> > n_max_cbs: 77229
> > TINY02 ------- 441676 GPs (122.688/s) [rcu: g0 f0x0 total-gps=3D0]
> > n_max_cbs: 10691
> > TRACE01 ------- 12593 GPs (3.49806/s) [tasks-tracing: g0 f0x0 total-gps=
=3D0]
> > TRACE02 ------- 106606 GPs (29.6128/s) [tasks-tracing: g0 f0x0 total-gp=
s=3D0]
> > TREE01 ------- 42614 GPs (11.8372/s) [rcu: g346169 f0x0 total-gps=3D868=
09]
> > TREE02 ------- 161421 GPs (44.8392/s) [rcu: g1356445 f0x0
> > total-gps=3D339371] n_max_cbs: 177936
> > TREE03 ------- 105074 GPs (29.1872/s) [rcu: g1699381 f0x2
> > total-gps=3D425089] n_max_cbs: 631295
> > TREE04 ------- 106036 GPs (29.4544/s) n_max_cbs: 550875
> > QEMU killed
>
> This seems hotplug related. Not sure.
>
> > TREE04 no success message, 222 successful version messages
> > !!! PID 2616159 hung at 3780 vs. 3600 seconds Mon Aug  7 06:27:38 AM UT=
C 2023
> > TREE05 ------- 132006 GPs (36.6683/s) [rcu: g1043673 f0x0
> > total-gps=3D261183] n_max_cbs: 160463
> > TREE07 ------- 52858 GPs (14.6828/s) n_max_cbs: 429828
> > QEMU killed
> > TREE07 no success message, 234 successful version messages
> >  [033mWARNING:  [mAssertion failure in
> > /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linu=
x-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/TREE07/=
console.log
> > TREE07
> >  [033mWARNING:  [mSummary: Call Traces: 6 Stalls: 5 Starves: 1
>
> Looks like this was because it is missing:
> lore.kernel.org/r/20230101061555.278129-1-joel@joelfernandes.org
5.15.y (38d4ca22a528) is missing above patch. I started
tools/testing/selftests/rcutorture/bin/torture.sh on my  i7-12800H
nested kvm ubuntu environment just now, the test will last for about 7
hours.

Hope I can be of some beneficial ;-)
Thanks
Zhouyi
>
> Thanks,
>
>  - Joel
