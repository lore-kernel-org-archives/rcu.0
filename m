Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32059EB64DD
	for <rcu@archiver.kernel.org>; Thu,  3 Aug 2023 16:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjHCQDO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbjHCQDG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Aug 2023 12:03:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C222B1BD5
        for <rcu@vger.kernel.org>; Thu,  3 Aug 2023 09:03:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso17488101fa.3
        for <rcu@vger.kernel.org>; Thu, 03 Aug 2023 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691078583; x=1691683383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6fPXN1Y9yrLJWUvpQ1dOJ0f2gtTCyYtwPND4T/OOXc=;
        b=wZVUnlR9atwhT2lwA8w6dmGtQ8WIMlp3Hi6kFog+Pr+p1TstbIMmbmHwGeD4NFCisN
         MDC5zDueHnTxhPfEszdNtSZYvbym+BMFnqLvfV6VAA0dby1toFrYaykLzA+qSetOjMBk
         iJ6+NJBBMp61taEtgQcv5YWfhVRSaYhqsmpXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691078583; x=1691683383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6fPXN1Y9yrLJWUvpQ1dOJ0f2gtTCyYtwPND4T/OOXc=;
        b=TVLF9FEcb9dO6d2KDnQa1k3Vg9q+STxf7tkV015o8gwKOTq3wW1/2g3NVnJawjQ2yD
         B+hnuVnUGHHymZj87uFJG6Q2KY+D4zP8Z1dTnyqCQZCJYgvXlCLsCUoYHmnQ8X0HAbzS
         VqY1NZVM4y0ClOSKkf9QyHj/GnXZKY+mOLT7Xj3YMOAXH9VKgAqCQyRAW+5fRio8UrVv
         8KOAXrCaModK8t8mLw/DEnjnyK+H2pKS7nHoET7gjnxeLwIRxxUPcBAak8OO4YG5P1PL
         8tC7VSdy+KNKO4irfkFOl4bOFGJfElUMbD786WviH9XzSg88UBkrylx2bj1Mh0VQ19Ft
         j9cg==
X-Gm-Message-State: ABy/qLYEZVzngy6Aa4LM8iRtUI695IJWxdwbEqiYrhudu/bBl3xVscW+
        X74nWPWjqeijUmYxpsfNm/cIo5Mu1KjqibAD5bMEpw==
X-Google-Smtp-Source: APBJJlHPWxX3W6bfNKfEv1Mj86REh38AnPaJ8howZb3wlsyQXhcPnxN2zR/W+dNw7SUae3Z9mZCz611xVpac2siIMcc=
X-Received: by 2002:a2e:3502:0:b0:2b9:4aa1:71e1 with SMTP id
 z2-20020a2e3502000000b002b94aa171e1mr7187847ljz.50.1691078582873; Thu, 03 Aug
 2023 09:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230803144025.14023-1-arnd@kernel.org>
In-Reply-To: <20230803144025.14023-1-arnd@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Aug 2023 12:02:52 -0400
Message-ID: <CAEXW_YQSO_OZ5MCT6kaTHLV7SgBWyiu8ATfcU7fsCdO=GwiQ9Q@mail.gmail.com>
Subject: Re: [PATCH] rcu: include torture_sched_setaffinity() declaration
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 3, 2023 at 10:40=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The prototype for torture_sched_setaffinity() moved to a
> different header, which needs to be included from update.c
> to avoid this W=3D1 warning:
>
> kernel/rcu/update.c:529:6: error: no previous prototype for 'torture_sche=
d_setaffinity' [-Werror=3Dmissing-prototypes]
>   529 | long torture_sched_setaffinity(pid_t pid, const struct cpumask *i=
n_mask)
>
> Fixes: 521ec59e5453e ("torture: Move rcutorture_sched_setaffinity() out o=
f rcutorture")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel


> ---
>  kernel/rcu/update.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 0533b510f0a8..c534d6806d3d 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -25,6 +25,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
> +#include <linux/torture.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/percpu.h>
> --
> 2.39.2
>
