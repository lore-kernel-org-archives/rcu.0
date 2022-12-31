Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C01C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 02:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiLaCEk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiLaCEj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 21:04:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94813F81
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:04:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p4so24029079pjk.2
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ga9Ui8ykHZIHp1joantKRPo13Hlso959LQTsKT6b6M=;
        b=kwxBmHWYwcFyHEr6JWGKZzm3zfFE4y5HL3ywh9F5FbdkV6xk8/23waJOci4iWXux49
         zfJCMhuoaTSqwGhbXwA5bF6m+aqpuL0OMDIdqP2XecBEeBjKVWJOp3GvkZ1gZySobpz+
         W4kjFmhnqvail7ynRgt3dQs9AWp8tPATH9JA8t91ygQzSbggIFpPVKGE2ZstlxIDxJ4c
         hcRszG4T8Wl3XCNAg/ujdI+vKZVV1Tq2g44BRF78qIpfG2GH8cvE9E/cws7r1uwzYmLd
         QjfyDIVdI8MKHUVhn1V/1TM45gIF/jhzbFxXnROe2bPc8j1IO2AMdZdWsAQvJ3YCZpWq
         R9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ga9Ui8ykHZIHp1joantKRPo13Hlso959LQTsKT6b6M=;
        b=XMiiX0FYmZSMgUvHiqfbMYfrXbZjtKBpqSt531OiNDO3RehLEpZDv4R5mnuioo0fSH
         SQn6Lsj3Okfeef01Oa+McaDtbelzWFN6eFXsKHdPGwQ49/OfG9IAQI4C6cx9Hf5x34Sc
         A2b9s59lVH03eqRquNB7OwP64n74xKzW9P9ZkDFufA1Q2inP5K3njENBV/lLerUmpAXS
         TL6akA/wt/aUMPjZsjKcsoRj/ZGEmljOXRyQ0tpDPCbTdWzXDFArj+sjctUQIT1O00Ul
         W/ZqE2BL4FDa5XCYfQZm/WqMEYLxW5ywmXBqVSnN3aky5JXKSXfGWEANCzaKUOruN9/c
         olmA==
X-Gm-Message-State: AFqh2ko57iCD0GuP9mY3EuWE3I7RODHAT64yhHMBdIPgigFs/yiP9vPL
        M7ftG2yc3UUnt90RmJpmVTIkPH0f8GUL1pycak8=
X-Google-Smtp-Source: AMrXdXvyisT04xCtFOwUo3djL5Z7039SoGFOSLfoX6u0VpBr70K/WbI7npwzz3CWoI17xn6cd5P+SEfN8z+oEgUuUy4=
X-Received: by 2002:a17:902:9a8d:b0:192:9568:a70d with SMTP id
 w13-20020a1709029a8d00b001929568a70dmr541440plp.30.1672452276069; Fri, 30 Dec
 2022 18:04:36 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
In-Reply-To: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 31 Dec 2022 10:04:24 +0800
Message-ID: <CAABZP2xNJoR2ABsQ6uPEHrK-KU2WO3gRt46==n10yMZ7fNZ6mA@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Joel

As a beginner, I am interested and I have time, could you tell me
where to download 6.0.16-rc2-g50f737b34ede when you are convenient?
And could you tell me which torture command you are invoking? I may
help to do some tests ;-)

Cheers
Zhouyi

On Sat, Dec 31, 2022 at 9:46 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hello,
>
> I have been firefighting a hang on 6.0.y stable kernels with
> rcutorture. It happens mostly consistently when TREE07 is shutting
> down.
>
> It appears that the RCU torture threads are attempted to stop but the
> shutdown thread, but are constantly awakened by a timer softirq
> handler in ksoftirqd context. When they wake up, they immediately goto
> sleep in uninterruptible state until the next time a timer handler
> wakes them up. It appears the timer softirq is long enough to cause
> RCU stalls and I see it calling 100s of timer function handlers
> (call_timer_fn).
>
> I am doing some more investigation with trace_printk(s):
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
>
> Regarding the timer handlers, I was wondering if it is possible that a
> large number of timer handlers constantly queued can cause RCU stalls
> due to the timer softirq taking a very long time. That certainly
> appears to be the case here. Shouldn't the timer softirq also do
> rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> many of them?
>
> Here is a full log with trace dump if you anyone wants to take a look:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
> And the res directory:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/
>
> Any thoughts on any patches 6.0 might be missing?
>
> Meanwhile, debug here continues... thanks,
>
>  - Joel
