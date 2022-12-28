Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B6C4708D
	for <rcu@archiver.kernel.org>; Wed, 28 Dec 2022 01:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiL1Brh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Dec 2022 20:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiL1Br1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Dec 2022 20:47:27 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B12E60
        for <rcu@vger.kernel.org>; Tue, 27 Dec 2022 17:47:26 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id i12so10220480qvs.2
        for <rcu@vger.kernel.org>; Tue, 27 Dec 2022 17:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TCs/qBg8Q1qIz5e/XHdhZF1/2FzgwoG8hNaOrTUD/M=;
        b=i76tlqGmQ1t8wKOwqLtH6zQYUPAqJeshJoSE9nDbg/SVrFwYkSD0RfkB/Jv91tQ2PX
         9sjvB4GWXEO828yxszkfrJiSX3GctzFBJQbmwkf4KLpkgDv9EY1+WyltW8a0wGYI8o/c
         ERWWP1A7nYowtaYyTT8wQhijxt2qMk68eM65A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TCs/qBg8Q1qIz5e/XHdhZF1/2FzgwoG8hNaOrTUD/M=;
        b=fab8Hy963MkIEoS65wtK90yiVR5YK7dLchg1t1k+LpeHhmq2v0Eyiwdugn9Uc4c1U8
         evH27j2d+I8XxmFKouJ4nMa7GTvH43j1BqbJLTFKWpry1BSrMkkTx6HKNVqZbD5yAY6v
         H+xPPrp0P7qcHJXm84AS4m873WkChL3qAo+FmYQtaJHQrkVa0IsakAlXAfXDrRqAVmgs
         xpamWZM74VLhCXTgj6lRkBEK61LkAl3yYy5qPSv62tdfU4baT89WIDihFEaKXXWckMgi
         JW/gZvloOlLgGeHMeQoicAYdQhH0IslqK1zZJqIybDlz5tXRo7xpRrnIgirQ1Sx0tDyS
         hSUA==
X-Gm-Message-State: AFqh2koZZ25eCOcMC/wlQVs7sa5AifzVFTv4GOIRqdNMVc/LjvVeR5wb
        Tm5iOzbFpzmUvwHRJpZ2L8uiZA==
X-Google-Smtp-Source: AMrXdXt2RiBXhrh7vPY2IawoK71sRupbOB97Ni9BUo+cqTsusl9lmKRGlChE88iIlKqrVyPw8808tw==
X-Received: by 2002:a0c:e98e:0:b0:4c7:8c96:d2ca with SMTP id z14-20020a0ce98e000000b004c78c96d2camr24898024qvn.15.1672192045515;
        Tue, 27 Dec 2022 17:47:25 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a04e500b006fab416015csm10332387qkh.25.2022.12.27.17.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:47:24 -0800 (PST)
Date:   Wed, 28 Dec 2022 01:47:24 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, rcu@vger.kernel.org
Subject: Please apply to v5.15 stable: 96017bf90397 ("rcu-tasks: Simplify
 trc_read_check_handler() atomic operations")
Message-ID: <Y6ugLOSaqylFlRjZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,

Please apply 96017bf90397 ("rcu-tasks: Simplify trc_read_check_handler()
atomic operations") to the stable v5.15 stable kernel. It made it in v5.16.

I confirmed the patch fixes the following splat which happens twice on TRACE02:

[  765.941351] WARNING: CPU: 0 PID: 80 at kernel/rcu/tasks.h:895 trc_read_check_handler+0x61/0xe0
[  765.949880] Modules linked in:
[  765.953006] CPU: 0 PID: 80 Comm: rcu_torture_rea Not tainted 5.15.86-rc1+ #25
[  765.959982] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  765.967964] RIP: 0010:trc_read_check_handler+0x61/0xe0
[  765.973050] Code: 01 00 89 c0 48 03 2c c5 80 f8 a5 ae c6 45 00 00 [..]
[  765.991768] RSP: 0000:ffffa64ac0003fb0 EFLAGS: 00010047
[  765.997042] RAX: ffffffffad4f8610 RBX: ffffa26b41bd3000 RCX: ffffa26b5f4ac8c0
[  766.004418] RDX: 0000000000000000 RSI: ffffffffae978121 RDI: ffffa26b41bd3000
[  766.011502] RBP: ffffa26b41bd6000 R08: ffffa26b41bd3000 R09: 0000000000000000
[  766.018778] R10: 0000000000000000 R11: ffffa64ac0003ff8 R12: 0000000000000000
[  766.025943] R13: ffffa26b5f4ac8c0 R14: 0000000000000000 R15: 0000000000000000
[  766.034383] FS:  0000000000000000(0000) GS:ffffa26b5f400000(0000) knlGS:0000000000000000
[  766.042925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  766.048775] CR2: 0000000000000000 CR3: 0000000001924000 CR4: 00000000000006f0
[  766.055991] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  766.063135] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  766.070711] Call Trace:
[  766.073515]  <IRQ>
[  766.075807]  flush_smp_call_function_queue+0xec/0x1a0
[  766.081087]  __sysvec_call_function_single+0x3e/0x1d0
[  766.086466]  sysvec_call_function_single+0x89/0xc0
[  766.091431]  </IRQ>
[  766.093713]  <TASK>
[  766.095930]  asm_sysvec_call_function_single+0x16/0x20

Full kernel logs:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/Linux%20Stable%20RC%205.15/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2022.12.27-20.43.34/TRACE02/console.log

Cheers,

 - Joel

