Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E77BC7EE2C
	for <rcu@archiver.kernel.org>; Fri, 26 May 2023 05:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjEZFjz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 May 2023 01:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjEZFjz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 May 2023 01:39:55 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85018D
        for <rcu@vger.kernel.org>; Thu, 25 May 2023 22:39:52 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-457201c47f6so87703e0c.1
        for <rcu@vger.kernel.org>; Thu, 25 May 2023 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685079591; x=1687671591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S20EpxC0jYqjEdVLeuZpI5et5CF0gwUWywR2BM1QKQ=;
        b=HjPkzZFhNcN47pTjWy00/2W8LzsulrTckq+2FiyTCWDCn+W3Avug/sChlVelvbSk4T
         BHSRMp8f/J9Ys1AaoTG6mP3+SmC6LnpNSSXJbuHC1NXygNq069wlYoBoz2Ge8bgOufUK
         VeW/0En/8moVGwCxvLgTsuqutGHV6g8UH1UrTNYkN4klcEeGTKekFYnDjz+K+TYgHFeN
         WAvzgsiI+NvuHqcIdLKCoqc5c9ZoMaUqYhJ/grjDY5K+93HOxXUQL2UWVWqi67aBjmCU
         yCxDHnzCYjhPWqxST9qQ2X9zj+IIhwaUIeXcW47OYw4Mh872iyb0sV8pfFyc3KOHxhlC
         SNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685079591; x=1687671591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S20EpxC0jYqjEdVLeuZpI5et5CF0gwUWywR2BM1QKQ=;
        b=KJrukJZuCbshb8iTS4H497pJB6mJ8jyxMRkhGsO60zZ0KtQHDlLHh2gXeTTJ3vqPUP
         H+5xqRhmd2b2kXLT9FQwTfabm3cuM2kn52ixvgFjdYYqws8v/d3TU/GwZYSOELLDooY9
         TGP7wq3MhjQlPAI6JUkBCxzKda/2p8ti/D82j2eEHW96gr5MOT6KY2Snm7wq3Yg6NXtz
         GUK+cEjUAou+AQ4mnsTMHJcuvW6NRhoyQxNmXli2O0zmBkcPjk3Go/+OFwt3ijHdWMvx
         2ZIfSyt5aZLK771OzyKCek/ouXQeVTEGMtH32J4LmsO6eF/qus6W7/t3oL+8ybQmfncH
         kVpg==
X-Gm-Message-State: AC+VfDwR6hB+rIb/OBQ/4Mm3qGz1TT+2AvtHahw7YAgAnz9M7IntX68o
        P70F+GmeeheksxaKi/3wnY483BhSXczy+djtRBo3fw==
X-Google-Smtp-Source: ACHHUZ6SISstX0iLvYrXJgi52QO9jWx5aTs73MrvJ3WfJIQHyb4MaDC7DJJGXlH18HF/RbDIl8P1FzmNV2RUA/yR7rM=
X-Received: by 2002:a1f:5e02:0:b0:457:400a:f3fc with SMTP id
 s2-20020a1f5e02000000b00457400af3fcmr170510vkb.2.1685079591105; Thu, 25 May
 2023 22:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtCCTxT78c0T+5JFw+sN01ZnX_kvBBgDLoVLfPARc9ZuA@mail.gmail.com>
 <CAEXW_YQwBy9xNRV9Xrdti46cC8vNE8nOocoL9pRrhjNMGdEWeg@mail.gmail.com>
In-Reply-To: <CAEXW_YQwBy9xNRV9Xrdti46cC8vNE8nOocoL9pRrhjNMGdEWeg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 26 May 2023 11:09:39 +0530
Message-ID: <CA+G9fYs3LT9OaKVZw9C3v3YxGPBk6ZWCdqur=hL-XoLM5rgtww@mail.gmail.com>
Subject: Re: Perf: RIP: 0010:__schedule on qemu-x86_64
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

HI Joel,

On Thu, 25 May 2023 at 20:51, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>
> Hello Naresh,
>
> On Wed, May 24, 2023 at 5:02=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Following kernel crash noticed while running perf testing on qemu-x86_6=
4
> > with stable-rc 6.3.4-rc2 + kselftest merge configs.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > logs:
> > =3D=3D=3D=3D=3D
> > INFO: Performing perf record test...
> >
> > Parse sched tracepoints fields: Ok
> >  16: syscalls:sys_enter_openat event fields     :
> > --- start ---
> > test child forked, pid 255
> > <4>[  152.221288] int3: 0000 [#1] PREEMPT SMP PTI
> > <4>[  152.221564] CPU: 0 PID: 255 Comm: perf Not tainted 6.3.4-rc2 #1
> > <4>[  152.221607] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.14.0-2 04/01/2014
> > <4>[  152.221733] RIP: 0010:__schedule+0x29e/0xaa0

<trim>

> I wonder if this is a deadlock related to runqueue lock since another
> CPU call stack are similarly in schedule.
>
> I tried to run gdb on your vmlinux but it does not have symbols, would
> it be possible for you to provide a copy of vmlinux with symbols?

DEBUG_INFO not enabled on this build.

>
> Were you able to narrow down the commit/release using git bisect to
> see when it started happening?

I will bisect this problem and get back to you.

>
> Thank you,
>
>  - Joel

- Naresh
