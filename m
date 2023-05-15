Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F55C77B7D
	for <rcu@archiver.kernel.org>; Mon, 15 May 2023 01:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEOBzV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 14 May 2023 21:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjEOBzR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 14 May 2023 21:55:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD1172B
        for <rcu@vger.kernel.org>; Sun, 14 May 2023 18:55:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52160f75920so8311414a12.2
        for <rcu@vger.kernel.org>; Sun, 14 May 2023 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684115714; x=1686707714;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7aq/zAbKUztcwnH0bed+5qyLimDVuUiT38aBCbLdzA=;
        b=QLvz4oBs8PTye9MzSjfrv3GwGquWLXqGxqNfAQnlzcaNBdjLzGEpzw9SvEh8k28fpc
         u3TYhuchnCww6yFIKj1qbmN5UFFJEKmmLTY8QvSLpBWfLbip+RWhVHxlz9RlzMRuyhCO
         v8t7p2k8lWR5B/+H0mCnKbeZUIfWV9TeATXUoM+90GwmlfXfy8ZVuJlhaw3DaVodhGOi
         b62XF0Hc0IxwY7Ofdz0g1jGck01Y9/vsiwrA268Eey+lKzOu9chlMgp2y4HYDmzTRMf+
         yaw6vn4yvvklbpggM9mzRGAwb8ZsRxMbd6+3jtcBUWCFoA+ICX5NsCwAiMtVWIUAqmQZ
         hOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684115714; x=1686707714;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7aq/zAbKUztcwnH0bed+5qyLimDVuUiT38aBCbLdzA=;
        b=NUW4NUqJwZI4OLAJ7/ZAQ4mYqVOhu4njXKeNnOJgIu+tUhUEBhewn5VN7kZhonG2d6
         HbdDZVPfhbnTm4UsYu27Mgy35YRgzwRIo/3DXQ09Wk0ZiGVaZJMEsxg25FGY4R05ip7R
         6JUWLPwdNlN4zv6JztnyB8lFxKVpWceBCTpSrV0BtuedrTM9+OImR6dy9Ptayl5xJ309
         WotJNDV7Z7MJEczaNE5r4epVp2KR+6Gj2t4rf9IyL1s2qZGPJCvrI0Ra/jvvF+ubnXgN
         VRw334gFDMpJsQJyN0pLymM4pUVkUh52krPIGdFzniu4eqLHjF7CLtlAaXLxTcs85uax
         wHQg==
X-Gm-Message-State: AC+VfDyXBfUJ2rnmi6cBwGrKDxCxuAVaX9PjTb97ikdlIz5BR6Hcg+ly
        ynMErkv+9BajDBojlFfd5jb6HVfLY0p9h9lOdH5gPrz2rrE=
X-Google-Smtp-Source: ACHHUZ5IZNSGSBbgCZu+B0E3Tcn6PDOn00y0l6ttnlPVW7ZiWJs9a4mjQAVdSpJmKUZvBQmPa+hogtt30+RdrjQxghc=
X-Received: by 2002:a17:90b:4b90:b0:24e:1e2e:20ea with SMTP id
 lr16-20020a17090b4b9000b0024e1e2e20eamr33929762pjb.42.1684115713862; Sun, 14
 May 2023 18:55:13 -0700 (PDT)
MIME-Version: 1.0
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 15 May 2023 09:55:02 +0800
Message-ID: <CAABZP2yo4J8tp0_oyzPnk+8KhUEC2mqSNRvpNdPsLawvaJxrRA@mail.gmail.com>
Subject: A small question about rcu_nocb_wait_contended
To:     rcu <rcu@vger.kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear RCUers:

When I study the function rcu_nocb_try_bypass, the only place it can
be called is from
function __call_rcu_common, and __call_rcu_common disable irq before
call rcu_nocb_try_bypass, so, I assume when we enter
rcu_nocb_try_bypass, there will be no
context switch.

In rcu_nocb_try_bypass, rcu_nocb_wait_contended got called, the
purpose of rcu_nocb_wait_contended is "relying on the fact that at
most two kthreads and one CPU contend for this lock".

My question is: assume there will be no context switch, why will there
be two kthreads competing for this CPU lock?

I have stumbled on this question for more than a year.

Thank you all in advance ;-)

Best Regard
Zhouyi
