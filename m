Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D7EC001DB
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 15:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjHGPAb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjHGPA3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 11:00:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE181701
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 08:00:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso72206671fa.0
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691420426; x=1692025226;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FHLBgrHQuG7Eic7m1Xx9ElThO1Zo7ZpAOBZaMPYlyQ=;
        b=Ep36kkPbwC/dGyfmAIg+gYYfxQGMcGgqfOfCvvoOMV67sPGvU4FNWXilX8HuxwKGPx
         +2DAolibdjZot13aC/Onuh6GzEzS91+mOg55MvSebzTJgJ5yhmDQ9J16zRsEbEC3r1io
         xPdtc6d8d7nJopwLKUiG083E3WIzhcq7iOoKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420426; x=1692025226;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FHLBgrHQuG7Eic7m1Xx9ElThO1Zo7ZpAOBZaMPYlyQ=;
        b=BcYSGe472dFq1H90Q3W5fpUR4kWpxJZKnSdrNqfQR2Ihcnw6JF3OFRYPtLlWrQzsb+
         QRIeomt4LxstGvm6qD8RjVMpASV3c3rqUx52GfD7IbGVqTf+XihI2xRLDqH6w6sZXmCi
         taaB2Pdu//Hjx5xjx7VvAbdZod3Ojcm5Mi1XnCVDTfS0Jf/t8MfUjmA+O/vLTINdCrrt
         Msp5aXOm9wjyVpC4ZOZrxjNHbAult1gi4VbtlPoLlIuwbADXvWFshs5m40RNavXOxtD4
         6+j2omn3n4ZCJySmxFAoKAr4NDjlRMby/hGNl4mO2y217ECeO85/MLqKkhQQ1CXpi7L2
         eCBQ==
X-Gm-Message-State: AOJu0YzF3bigwbSBVLGU4MMVlDL2rk0NxRtrfc7thUynXxMgUGA7t7Mu
        I5GMt+ZHfXKLbdDK7A1Zepn93DdPj0cKG5R6qtKG02fuc8jDEfjBZp4=
X-Google-Smtp-Source: AGHT+IFTkqdvLlDtlyvwrikCiBqnOaF4ys4HyVdGqC80Qmav0+bJ8px5yXh5vEJo9H4yvQWeQvJkKZwGapqU7nJjchU=
X-Received: by 2002:a2e:80da:0:b0:2b9:4c17:7939 with SMTP id
 r26-20020a2e80da000000b002b94c177939mr7495787ljg.12.1691420425866; Mon, 07
 Aug 2023 08:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
In-Reply-To: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 11:00:19 -0400
Message-ID: <CAEXW_YTyT9_Cg8jpU=q4pAR3rAh=Ci6A1jkq57DuKwBrTYL5_w@mail.gmail.com>
Subject: Re: TREE04 and TREE07 failures on 5.15 stable
To:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Btw full logs are here:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/80=
/artifact/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/

And some more comments:

On Mon, Aug 7, 2023 at 10:22=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello, Frederick, all,
> TREE04 and TREE07 still fail on the 5.15 kernel.
>
> The stutter patches helped 5.10, 6.1 and 6.4 but 5.15 still is
> troubled. Any thoughts?
>
> OTOH, I am not sure how many NO_HZ_FULL users are on the 5.15 kernel.
> Do you have any idea?
>
> Meanwhile I'll continue to debug it. Thank you!
>
>  --- Mon Aug  7 07:37:10 AM UTC 2023 Test summary:
> Results directory:
> /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linux-=
5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration 60
> RUDE01 ------- 22984 GPs (6.38444/s) [tasks-rude: g0 f0x0 total-gps=3D0]
> SRCU-N ------- 318544 GPs (88.4844/s) [srcu: g4127136 f0x0 total-gps=3D41=
27136]
> SRCU-P ------- 268977 GPs (74.7158/s) [srcud: g2180244 f0x0 total-gps=3D2=
180244]
> SRCU-T ------- 497422 GPs (138.173/s) [srcu: g57760 f0x0 total-gps=3D5776=
0]
> SRCU-U ------- 1152598 GPs (320.166/s) [srcud: g33534 f0x0 total-gps=3D33=
534]
> TASKS01 ------- 11516 GPs (3.19889/s) [tasks: g0 f0x0 total-gps=3D0]
> TASKS02 ------- 13407 GPs (3.72417/s) [tasks: g0 f0x0 total-gps=3D0]
> TASKS03 ------- 4598 GPs (1.27722/s) [tasks: g0 f0x0 total-gps=3D0]
> TINY01 ------- 422041 GPs (117.234/s) [rcu: g0 f0x0 total-gps=3D0]
> n_max_cbs: 77229
> TINY02 ------- 441676 GPs (122.688/s) [rcu: g0 f0x0 total-gps=3D0]
> n_max_cbs: 10691
> TRACE01 ------- 12593 GPs (3.49806/s) [tasks-tracing: g0 f0x0 total-gps=
=3D0]
> TRACE02 ------- 106606 GPs (29.6128/s) [tasks-tracing: g0 f0x0 total-gps=
=3D0]
> TREE01 ------- 42614 GPs (11.8372/s) [rcu: g346169 f0x0 total-gps=3D86809=
]
> TREE02 ------- 161421 GPs (44.8392/s) [rcu: g1356445 f0x0
> total-gps=3D339371] n_max_cbs: 177936
> TREE03 ------- 105074 GPs (29.1872/s) [rcu: g1699381 f0x2
> total-gps=3D425089] n_max_cbs: 631295
> TREE04 ------- 106036 GPs (29.4544/s) n_max_cbs: 550875
> QEMU killed

This seems hotplug related. Not sure.

> TREE04 no success message, 222 successful version messages
> !!! PID 2616159 hung at 3780 vs. 3600 seconds Mon Aug  7 06:27:38 AM UTC =
2023
> TREE05 ------- 132006 GPs (36.6683/s) [rcu: g1043673 f0x0
> total-gps=3D261183] n_max_cbs: 160463
> TREE07 ------- 52858 GPs (14.6828/s) n_max_cbs: 429828
> QEMU killed
> TREE07 no success message, 234 successful version messages
>  [033mWARNING:  [mAssertion failure in
> /usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linux-=
5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/TREE07/co=
nsole.log
> TREE07
>  [033mWARNING:  [mSummary: Call Traces: 6 Stalls: 5 Starves: 1

Looks like this was because it is missing:
lore.kernel.org/r/20230101061555.278129-1-joel@joelfernandes.org

Thanks,

 - Joel
