Return-Path: <SRS0=4RPF=5D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3EC5ACD7
	for <rcu@archiver.kernel.org>; Wed, 18 Mar 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FDD20768
	for <rcu@archiver.kernel.org>; Wed, 18 Mar 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSiquivy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCRP4Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:56:16 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40197 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgCRP4Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 11:56:16 -0400
Received: by mail-lf1-f50.google.com with SMTP id j17so20789245lfe.7
        for <rcu@vger.kernel.org>; Wed, 18 Mar 2020 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DzOdrsW97KdLqXTxd9ksU9+GnyXc9/hhsBl/C1xbNT0=;
        b=XSiquivyhfl3GaGYHiw+zEMxuIxvv0pXuF5G2LuCQRXPuaJSiOiGLR5p9S35kt+NI/
         +NiUotKn6JvlxeHYeixqtObYKvAOMTpcfyLS+NqcjGnHbul/V2TZKdyhSXsGIF6rvLMQ
         13+ZvUJwth3SezRXe8/flOko56JkqJlOEsygfvNhojFJhgXs+Auh1xAGPLiSc1q4V6Xx
         Wqyl/D3E2ufsthHTXO+s0prGcolWaOIw1poDePkAp7WH7Tb3USbubsmH+CtNFN5P5t/J
         MagQf9CZYtUlQq1NZ97mQxSwF+8C7Kzj/zreTyMH4UdPUCE8+PzlFAtpe7VnqCrvdACT
         YSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DzOdrsW97KdLqXTxd9ksU9+GnyXc9/hhsBl/C1xbNT0=;
        b=JV5AkCEuhnwz2Cuh8ihSNt6tjGpwaiXbfGrObVO0DsduoPs6ZAzqPZ5bL0b4tB1sGs
         YOrjlojP6w4eFwIwl6hkpudEJ4Ttq0vTHs9oTuP+kD36fT1NjCjWn+rpYrN6Aj608dpL
         G9J687mjbBIn66IDAr83aRAHet2lqPIcJK5kueHpvZrguc10AFifgZBscwHrgs+5hVYA
         104xup/3aSDoYnxN/QgxwHhxpQfI4YV41jMC6yvrlqDjbq2UHnOLgVuY2GsaCsdQDYYL
         kRtIlUNvdRwXqhM4ihXIIR90ngZdVAnp6DzsUI86qC7Cy9gdgtRU0m+yJv/Q+IuyG4Tp
         YMcQ==
X-Gm-Message-State: ANhLgQ0AkQKg497IrR47i2gFdT+8QJ1MwQQL54fQceiJTcQACG/Pu99S
        JhDjlZ7Tt1A1XHlH0q3dfdricndrBlH02Of0Kqc7pzA6jy0apw==
X-Google-Smtp-Source: ADFU+vsDZbF18oB7HRyBSPzjs+IYS5tBn4pxKjv50NIP6u4ac+UT6Jp6ZtijUK5QhY8lAy9TtQ9x3BpoCJ4/RiHzx4M=
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr3225019lfq.95.1584546972965;
 Wed, 18 Mar 2020 08:56:12 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Mar 2020 21:26:01 +0530
Message-ID: <CA+G9fYsT2B0WFPV0uohH=QT+CU09OscZvsUV3pnhG-xjPF+OqA@mail.gmail.com>
Subject: =?UTF-8?B?a2VybmVsL3JjdS90YXNrcy5oOjEwNzA6Mzc6IGVycm9yOiDigJhyY3VfdGFza3NfcnVkZQ==?=
        =?UTF-8?B?4oCZIHVuZGVjbGFyZWQ=?=
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, Joel Fernandes <joel@joelfernandes.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The arm64 build failed on linux-next master branch.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image

In file included from ../kernel/rcu/update.c:562:
 ../kernel/rcu/tasks.h: In function =E2=80=98show_rcu_tasks_gp_kthreads=E2=
=80=99:
 ../kernel/rcu/tasks.h:1070:37: error: =E2=80=98rcu_tasks_rude=E2=80=99 und=
eclared
(first use in this function); did you mean =E2=80=98rcu_tasks_qs=E2=80=99?
  1070 |  show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
       |                                     ^~~~~~~~~~~~~~
       |                                     rcu_tasks_qs
 ../kernel/rcu/tasks.h:1070:37: note: each undeclared identifier is
reported only once for each function it appears in

Ref:
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/476084417

--=20
Linaro LKFT
https://lkft.linaro.org
