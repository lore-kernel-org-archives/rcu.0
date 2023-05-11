Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B76C77B7C
	for <rcu@archiver.kernel.org>; Thu, 11 May 2023 05:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjEKFsf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 May 2023 01:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjEKFse (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 May 2023 01:48:34 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E819BA
        for <rcu@vger.kernel.org>; Wed, 10 May 2023 22:48:33 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a44a2637bso121175607b3.2
        for <rcu@vger.kernel.org>; Wed, 10 May 2023 22:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683784112; x=1686376112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEsW6ADQiyg8bgT+PjLa2gxrYjuabhXtDe3R3pceTJI=;
        b=WYZvFHSsRWZ6DhNBRi4/coBWURsX5dKxk6DutKlHzPFfCwoxXLv9gTFgvCvpEcGDNt
         /H937a3COi3QwCP54p9wfk/PZMSk3F+FI0G/JwUl1HI90H7vIaHt714KLOegn2o47NZu
         TKaaW0C2NSlVPj+6xxnnGRsYts2AzSOAVaW7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683784112; x=1686376112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEsW6ADQiyg8bgT+PjLa2gxrYjuabhXtDe3R3pceTJI=;
        b=gB1oRDxSFdXOOxEQtwCVTl47+durDF4ZMt8xptNjGrqCmtqO7ETgpn+mvWB+CvmDrs
         EgXVwhsU/8SzrujoZ7ulz/WlS+XJTimc6ldReKTrLBJXy7SEfRHy1LxA1TFOQ+5i/gb0
         pUSs5ZhAHUld+WjIjXIGB01vxJh4ybeE6oVk+Ib9t10cSbd96A3vhN0pW3pcNkBPTQvW
         Y5XwttbeeO8ZtiL8P/RDioGatFZTBtQT3eWfnl/r5uhuJqZikF1anoD/rFxmluEJb9Jm
         JmWsKOfQKKhO06TJ6hEGpqPJtA5n3WM2m3jkuel2h11lWBbTuXDGb+aVioQRPhypuhss
         YuVQ==
X-Gm-Message-State: AC+VfDzSUyiyp5YWFjouy210+bd6jedsh0jWWpSrpmdb9/R2Brmeg9Zu
        /QEsZzCN0chjxGpacrTSlNK1DXIQkSLwMpa794+nwA==
X-Google-Smtp-Source: ACHHUZ4Xspohc10WjXI/ZLcJktrJMzqRKsksA6kipW1qIT4R6dm9RJyuI17RWW6RV0fawVxqfYdgRswhQGFGZ1C0uus=
X-Received: by 2002:a81:5e41:0:b0:55a:985f:848d with SMTP id
 s62-20020a815e41000000b0055a985f848dmr24178916ywb.39.1683784112614; Wed, 10
 May 2023 22:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
In-Reply-To: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:48:21 -0700
Message-ID: <CAEXW_YTuDQPqsVYz8X-rCau1RSpUR9HBSmq+H8imHB0424Do6A@mail.gmail.com>
Subject: Re: [PATCH rcu 0/6] Torture-test updates for v6.5
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 10, 2023 at 10:12=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> Hello!
>
> This series contains torture-test and torture-test-scripting updates
> for v6.5:
>
> 1.      Add long_hold to adjust lock-hold delays.
>
> 2.      Correct name of use_softirq module parameter.
>
> 3.      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup(),
>         courtesy of Qiuxu Zhuo.
>
> 4.      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading
>         rcuscale, courtesy of Qiuxu Zhuo.
>
> 5.      doc/rcutorture: Add description of rcutorture.stall_cpu_block,
>         courtesy of Zqiang.
>
> 6.      Remove duplicated argument -enable-kvm for ppc64, courtesy of
>         Zhouyi Zhou.

Other than the small nits I mentioned, this series LGTM. Feel free to add:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel


>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
>  b/Documentation/admin-guide/kernel-parameters.txt                  |   1=
2
>  b/kernel/locking/locktorture.c                                     |   5=
1 +-
>  b/kernel/rcu/rcuscale.c                                            |  19=
4 +++++-----
>  b/tools/testing/selftests/rcutorture/bin/functions.sh              |    =
2
>  b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot |    =
2
>  b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot       |    =
2
>  kernel/rcu/rcuscale.c                                              |    =
5
>  7 files changed, 137 insertions(+), 131 deletions(-)
