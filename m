Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17EDC00528
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 14:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHGOWh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjHGOWf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 10:22:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5FE79
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 07:22:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso70554061fa.2
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691418152; x=1692022952;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uioNtx4EroIcX/K2i5v3FWGJAJa6qBczzHeCqVex0M0=;
        b=wn4QJHa6FqcG4uZFr0bvoyDNBlp4d3cXL3b3MWhrie14GvPAr4ER4m7P7nR5ZwzLca
         amYa6wUKby5A8vOaK+saK1K9IgAa96PGzuWnkPtl+23soJJDJbdRGfEjYw3jHdDyZDs9
         IAtUAOp1IhzlddayftCKTLjXpMuiM17JSNOCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418152; x=1692022952;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uioNtx4EroIcX/K2i5v3FWGJAJa6qBczzHeCqVex0M0=;
        b=FjynNZdnIqJ+hlN5+1SGYMmDzAhpQKpUX3m/xptMciC/ev08wT2uGShAxDTVkmyNPp
         PgZoyqp3g19umF81FqCFM/YrOmns64Euz7vrfd1M1e2uHyIZHAGaSX+Xy7l16GPdHxyW
         l2tOiYBxMMpzXOW1Dv87np4Q5WcKzFM91+bejzd93uWsH2BqRlq9g1+m6Ia+zON95tZg
         zq14OivWgLnnBgN8S3JI/14dGUHDQN/Rk7+WwrJk2hER0R5zWXGrQhZHSnCnItmMZJFV
         glhoefEJo1EmVwQwGf9YfeQ4K23LRon+oYEopLzmZB+DZmvayacH97XJhYzC6imBQLbr
         YgAQ==
X-Gm-Message-State: AOJu0Yz6xGaXtPkKRX24B1MXbYgJgKcsOvtY2ydlSYnhHV+yGp52L8z6
        YcWR8cb8xEngX3ONHc8QeyymUFn4bqvVsRFD92v6Uf/pfGig0CKrasI=
X-Google-Smtp-Source: AGHT+IHCz1lf7kKJA3m8osJvYJpEsuuPlfHAyKkPC6Nvpi0C7L8yi9sHGJEoAhNTcBjHOLdIVzF6AxNorUiRxvtT9Z4=
X-Received: by 2002:a05:651c:101:b0:2b6:e623:7b57 with SMTP id
 a1-20020a05651c010100b002b6e6237b57mr7218134ljb.25.1691418151758; Mon, 07 Aug
 2023 07:22:31 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 10:22:26 -0400
Message-ID: <CAEXW_YTSX-eeFHBaodLSxmGZPoT1RBAb8mFu9oh-wm_fnYY29Q@mail.gmail.com>
Subject: TREE04 and TREE07 failures on 5.15 stable
To:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Frederick, all,
TREE04 and TREE07 still fail on the 5.15 kernel.

The stutter patches helped 5.10, 6.1 and 6.4 but 5.15 still is
troubled. Any thoughts?

OTOH, I am not sure how many NO_HZ_FULL users are on the 5.15 kernel.
Do you have any idea?

Meanwhile I'll continue to debug it. Thank you!

 --- Mon Aug  7 07:37:10 AM UTC 2023 Test summary:
Results directory:
/usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19
tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration 60
RUDE01 ------- 22984 GPs (6.38444/s) [tasks-rude: g0 f0x0 total-gps=0]
SRCU-N ------- 318544 GPs (88.4844/s) [srcu: g4127136 f0x0 total-gps=4127136]
SRCU-P ------- 268977 GPs (74.7158/s) [srcud: g2180244 f0x0 total-gps=2180244]
SRCU-T ------- 497422 GPs (138.173/s) [srcu: g57760 f0x0 total-gps=57760]
SRCU-U ------- 1152598 GPs (320.166/s) [srcud: g33534 f0x0 total-gps=33534]
TASKS01 ------- 11516 GPs (3.19889/s) [tasks: g0 f0x0 total-gps=0]
TASKS02 ------- 13407 GPs (3.72417/s) [tasks: g0 f0x0 total-gps=0]
TASKS03 ------- 4598 GPs (1.27722/s) [tasks: g0 f0x0 total-gps=0]
TINY01 ------- 422041 GPs (117.234/s) [rcu: g0 f0x0 total-gps=0]
n_max_cbs: 77229
TINY02 ------- 441676 GPs (122.688/s) [rcu: g0 f0x0 total-gps=0]
n_max_cbs: 10691
TRACE01 ------- 12593 GPs (3.49806/s) [tasks-tracing: g0 f0x0 total-gps=0]
TRACE02 ------- 106606 GPs (29.6128/s) [tasks-tracing: g0 f0x0 total-gps=0]
TREE01 ------- 42614 GPs (11.8372/s) [rcu: g346169 f0x0 total-gps=86809]
TREE02 ------- 161421 GPs (44.8392/s) [rcu: g1356445 f0x0
total-gps=339371] n_max_cbs: 177936
TREE03 ------- 105074 GPs (29.1872/s) [rcu: g1699381 f0x2
total-gps=425089] n_max_cbs: 631295
TREE04 ------- 106036 GPs (29.4544/s) n_max_cbs: 550875
QEMU killed
TREE04 no success message, 222 successful version messages
!!! PID 2616159 hung at 3780 vs. 3600 seconds Mon Aug  7 06:27:38 AM UTC 2023
TREE05 ------- 132006 GPs (36.6683/s) [rcu: g1043673 f0x0
total-gps=261183] n_max_cbs: 160463
TREE07 ------- 52858 GPs (14.6828/s) n_max_cbs: 429828
QEMU killed
TREE07 no success message, 234 successful version messages
 [033mWARNING:  [mAssertion failure in
/usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linux-5.15.y/tools/testing/selftests/rcutorture/res/2023.08.07-04.01.19/TREE07/console.log
TREE07
 [033mWARNING:  [mSummary: Call Traces: 6 Stalls: 5 Starves: 1
!!! PID 473949 hung at 3790 vs. 3600 seconds Mon Aug  7 05:10:09 AM UTC 2023
TREE09 ------- 346763 GPs (96.3231/s) [rcu: g5082937 f0x0
total-gps=1271006] n_max_cbs: 697641
