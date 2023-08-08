Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB2C001DB
	for <rcu@archiver.kernel.org>; Tue,  8 Aug 2023 03:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjHHD2p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 23:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjHHD2Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 23:28:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8691BF1
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 20:27:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso29915e9.0
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691465261; x=1692070061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiGQp3FsAI04kcNtST/Tl1pJkj2vxq4v0LWaXPyZsOc=;
        b=pTn2KPnbpACRR1QoEDcr3ERxsHMj/OGG5vXUuUYjUIU9vaSomJncuphTCfIQ+V2jnF
         tuxaRrPri4lngxFMKN+lzupIJKyPzJY6nWDPXUBV3uZJyHiN061bifLJJKL1mEdh4Zc/
         1ZZZfF3vN5E4yc269EtGzxSwcgvKeTBrxeUQoDw0m5pTsHk06h6+eeSczXGA3bnEew9v
         Nh5ds2u/V4BlrnZURcfuVZBtEJpP1qpOo/czVYss5a/IuZ1SGP4k1se4KCifowq+EIOT
         fEnIu8rxXpbrKg4BgZkCbUGUYIVm5vkOz5UeICXSIJN5mKqoA8F8hwA46l7UAQu6fidZ
         6c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465261; x=1692070061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiGQp3FsAI04kcNtST/Tl1pJkj2vxq4v0LWaXPyZsOc=;
        b=Z+wU1lXh/T5meCYZTAp+eI/hAS1BJi4od2QHvaBOH6Jh62iGgfVZgH4Th9IyBeY/4z
         4EV2/+baulh+s78GKTGam8ogkGBu+gzpWsYK5/LExk7H/ksAPUvgEMy4PAtkZ418cFrb
         ZHA5tqJj0VO0vmJqR2gs74HUIw2OtK3v58CTVSV36FqSEgtFzgaC8YcaY5vMSOSYXrT1
         nc+pJbJ9Flv7XnCFiwJOnwjeFpqaA8pdwfsIaahk6Tcq/BCb83j4lIOqcUZwKoQzLmRz
         sRLmTMdXGr8+zXFjjBeCqqPU2SWWbZqp3yxq/xt1PoE84rixrmImD7pnRbNNnp6bC4S5
         OElg==
X-Gm-Message-State: AOJu0YxB99jZ5qzJJLmcWX1i1BBDt5Ho9SVqjSF5snL7w5tK1dccPt9k
        Kv3ChNppaPXgnMJkQfjMmpe+P8oAPK5NR8p+s2kMyywgNYttXcZgof/nVnU=
X-Google-Smtp-Source: AGHT+IHNklvPNz0M4NW5KZIZXX2bW3bL4rd8brH9A51j5QvubhasYCcxYJoodGdcImm/oRHisG2hKp4tUyZlyR0ad8Q=
X-Received: by 2002:a05:600c:1d88:b0:3f7:e463:a0d6 with SMTP id
 p8-20020a05600c1d8800b003f7e463a0d6mr296502wms.0.1691465261438; Mon, 07 Aug
 2023 20:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop> <20230728032232.816584-2-paulmck@kernel.org>
In-Reply-To: <20230728032232.816584-2-paulmck@kernel.org>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 7 Aug 2023 20:27:29 -0700
Message-ID: <CANDhNCpCrwbMp8oTwvTab+-Q1b52zJvMuZiV9LW-bP2Zgqqyhg@mail.gmail.com>
Subject: Re: [PATCH rcu 2/2] torture: Add lock_torture writer_fifo module parameter
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 27, 2023 at 8:22=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> This commit adds a module parameter that causes the locktorture writer
> to run at real-time priority.
>
> To use it:
> insmod /lib/modules/torture.ko random_shuffle=3D1
> insmod /lib/modules/locktorture.ko torture_type=3Dmutex_lock rt_boost=3D1=
 rt_boost_factor=3D50 nested_locks=3D3 writer_fifo=3D1
>                                                                          =
                               ^^^^^^^^^^^^^
>
> A predecessor to this patch has been helpful to uncover issues with the
> proxy-execution series.
>
> [ paulmck: Remove locktorture-specific code from kernel/torture.c. ]

Thanks again for improving this!  I've switched over to your version
here in my test tree.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
