Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11997C433FE
	for <rcu@archiver.kernel.org>; Fri,  4 Dec 2020 18:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF21B22582
	for <rcu@archiver.kernel.org>; Fri,  4 Dec 2020 18:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgLDSfz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLDSfz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 13:35:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B77C061A52
        for <rcu@vger.kernel.org>; Fri,  4 Dec 2020 10:35:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b2so6848527edm.3
        for <rcu@vger.kernel.org>; Fri, 04 Dec 2020 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VazwCTbw4qFEcnDS99kE7+UPTpKgFLvwXrTcJ/OGLV8=;
        b=UoAtycuWbYXPQuHZa93zSkhDkJSIw0b5/ox+c+olIK8DcmAbppcTQ0S5nqiX68rqak
         O0OcRXvbaYs59/0lhZyyDXuBE89LpLU/4sCiBqYoY+7kZml0b8FecNEzYnsNUW08Ihz5
         QF7SSKQPyyDDQa2ClfTAFtqizjUB+y8xrZebWbkw7H4Qp0JbSS6Bojpr/Kkqn2+Oksnw
         wT3LhcfoTMGVZj4tJFFM5mxJMYg2KBifKrCXcs7TzgB+i0DrF+DvPoqZuF/7IlEChaWv
         6gSm3TUC/frYOd6VZB2UEePpomfz08LS4mRk9rLZ8P3hSyX0ElAYgJiZ6EcXcffOOCH/
         GBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VazwCTbw4qFEcnDS99kE7+UPTpKgFLvwXrTcJ/OGLV8=;
        b=b3YcDEPHyrVUSj6T8tJBtqR9vAmDDzJ5+yNR2mPgr4iSu5r3XYAjeSMNRVsYHPhKxM
         oayxrsaJWAhIJeGMScsftstE77WB613c0lITQgGYXmCFCI/91qbRjAVv9uthvS70qMXe
         0TkvQ7NkL9r5bx4ImzEA0FuZwwQREbQyT4jsRr8xF60trokpitPdy7oNy4qUJxg0rRay
         i5gOoTBTptvovuXd1IYwxDDZUmK3uKX3ThMZAHx5kb94u3W7BxTgo4eriN6pmd2ozZ6T
         CzZ9LBX/vyJ/MFaipnrp26GsPuISLusuyC6W7Vitn7wXYpyjpzyUOWcVX/lihL3uA9Mj
         R6cg==
X-Gm-Message-State: AOAM530wzwIL5z2qPOxjYwzLMRm3wCDAjQIoUOHqXt86wc8+/KdlybsP
        d+VsFL+LKnL2WkJeyXUxbQnwOGzBkqOnOVfax122ng==
X-Google-Smtp-Source: ABdhPJySBMs5wep5prKn4dGE0xz5+ByoMr95Z/1QhLJVmuU6vp5fZu61EN8FWgCSAJCp3cpH5tedG2S4/91FYDuyvnU=
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr5352244eds.78.1607106913506;
 Fri, 04 Dec 2020 10:35:13 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 5 Dec 2020 00:05:02 +0530
Message-ID: <CA+G9fYvhvZtDYVBo4kj9OkKY_vVFSa6EbWz99iCmRPojExRieA@mail.gmail.com>
Subject: BUG: KCSAN: data-race in __rpc_do_wake_up_task_on_wq / xprt_request_transmit
To:     kasan-dev <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, chuck.lever@oracle.com,
        bfields@fieldses.org, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

LKFT started testing KCSAN enabled kernel from the linux next tree.
Here we have found BUG: KCSAN: data-race in
__rpc_do_wake_up_task_on_wq / xprt_request_transmit

This report is from an x86_64 machine clang-11 linux next 20201201.
Since we are running for the first time we do not call this regression.

[   17.316725] BUG: KCSAN: data-race in __rpc_do_wake_up_task_on_wq /
xprt_request_transmit
[   17.324821]
[   17.326322] write to 0xffff90a801de6a9c of 2 bytes by task 142 on cpu 1:
[   17.333022]  __rpc_do_wake_up_task_on_wq+0x295/0x350
[   17.337987]  rpc_wake_up_queued_task+0x99/0xc0
[   17.342432]  xprt_complete_rqst+0xef/0x100
[   17.346533]  xs_read_stream+0x9c6/0xc40
[   17.350370]  xs_stream_data_receive+0x60/0x130
[   17.354819]  xs_stream_data_receive_workfn+0x5c/0x90
[   17.359784]  process_one_work+0x4a6/0x830
[   17.363795]  worker_thread+0x5f7/0xaa0
[   17.367548]  kthread+0x20b/0x220
[   17.370780]  ret_from_fork+0x22/0x30
[   17.374359]
[   17.375858] read to 0xffff90a801de6a9c of 2 bytes by task 249 on cpu 3:
[   17.382473]  xprt_request_transmit+0x389/0x7a0
[   17.386919]  xprt_transmit+0xfe/0x250
[   17.390583]  call_transmit+0x10d/0x120
[   17.394337]  __rpc_execute+0x12d/0x700
[   17.398089]  rpc_async_schedule+0x59/0x90
[   17.402100]  process_one_work+0x4a6/0x830
[   17.406114]  worker_thread+0x5f7/0xaa0
[   17.409868]  kthread+0x20b/0x220
[   17.413099]  ret_from_fork+0x22/0x30
[   17.416675]
[   17.418167] Reported by Kernel Concurrency Sanitizer on:
[   17.423475] CPU: 3 PID: 249 Comm: kworker/u8:1 Not tainted
5.10.0-rc6-next-20201201 #2
[   17.431385] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   17.438778] Workqueue: rpciod rpc_async_schedule

metadata:
    git_repo: https://gitlab.com/aroxell/lkft-linux-next
    target_arch: x86
    toolchain: clang-11
    git_describe: next-20201201
    download_url: https://builds.tuxbuild.com/1l8eiWgGMi6W4aDobjAAlOleFVl/

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/2002643#L1005

-- 
Linaro LKFT
https://lkft.linaro.org
