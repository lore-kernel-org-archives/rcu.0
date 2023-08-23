Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF7FEE4993
	for <rcu@archiver.kernel.org>; Wed, 23 Aug 2023 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHWNux (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Aug 2023 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjHWNuw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Aug 2023 09:50:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A419A
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 06:50:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b962c226ceso87860611fa.3
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692798648; x=1693403448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1EOrOgCseln8t37rY5FBO1h5UdCTgTFQYEVgsNrZcU=;
        b=WCv92+IcD6D4hZoAESWW3dioRImv+ylYqTQXvnpsjZrO7x7/uDFqq1qpN/dGI5YwKU
         B3EQpk9J1MSDK1wHZrKHxl3c+pqEgaokusOZaajgwzzvTQJQYrY/9oAh3gluHFn9nVN3
         EBWyGiXWGM1USSI7Tggn9O1VCe9KE2y6lM6ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798648; x=1693403448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1EOrOgCseln8t37rY5FBO1h5UdCTgTFQYEVgsNrZcU=;
        b=BROKw9eFY9nbZobARUlT3TIm3nZw15VFsvZPO6jh0yfn6UzKEhKfHZW4QFortMpdqx
         tgeCAcVLO+hC4H0pgElCFlizbzMCWCpdf8cS3/lTh46b0Z8+9qYcUH7cwKLiFrz+wDok
         0KEuVHvRpVEhLSg3dawOAdkYWHWyBfhT2DscWkmuuObReUmlnkTnIqZQFHYUogAd1zGV
         Q9x7TkjBJKi1VAHsPcjYE6XXrDfJCF4BiRIQXfzFs5Eec0g9A6RsLGIcbI8NO0CXZGbN
         UUvnOlTTYehE6t9c8ba74te6LzwcTk9nvsKjbSJqE/MtWuOM5ZS+a0hqolWY2N7xNr50
         SNmg==
X-Gm-Message-State: AOJu0YxgppsLXx1ce3g9XQmfy+XZVqv3cz0XN4XnxjDlPt1HorIrxekZ
        zL/UIm52jdPgeP2fJ+qRzGski6vk3qNkObmySAeMkA==
X-Google-Smtp-Source: AGHT+IGo9+IRolLSArCmBrn+ncxG6gkdaLbU303VOalvuv1hvpM3HIfnQtUrdt3ph1C3tx20196fcVyK0fOYtp0qG8A=
X-Received: by 2002:a2e:81d3:0:b0:2bc:db5a:9545 with SMTP id
 s19-20020a2e81d3000000b002bcdb5a9545mr1737607ljg.14.1692798648532; Wed, 23
 Aug 2023 06:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
In-Reply-To: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 23 Aug 2023 09:50:37 -0400
Message-ID: <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com>
Subject: Re: rcutorture: Can not Disable RT throttling
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 3:37=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> When running build-in rcutorture tests in 6.5.0-rc4-rt, and found that,
> although the value of /proc/sys/kernel/sched_rt_runtime_us is -1,
>
> cat /sys/kernel/debug/sched/debug
> ....
> rt_rq[6]:
>   .rt_nr_running                 : 4
>   .rt_nr_migratory               : 0
>   .rt_throttled                  : 0
>   .rt_time                       : 0.000000
>   .rt_runtime                    : 950.000000
>
> but the rt_runtime still is 950.000000.
> set sysctl_sched_rt_runtime in rcu_torture_disable_rt_throttle()
> does not disable rt-throttling.

I think you have hit a bug. I think the problem is
rcu_torture_disable_rt_throttle() modifies the sysctl knobs, but does
not change def_rt_bandwidth and reinitialize the rt_rq. I think we
need to call sched_rt_do_global() like the sysfs handler does, or
change the sysctl knobs to be earlier in the boot process before the
rt_rq are initialized.

Or better yet (not sure if it is possible) trigger the sysctl change
via the sysctl layer and let it do the same logic.

Thoughts?

Thanks.
