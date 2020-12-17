Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90864C4361B
	for <rcu@archiver.kernel.org>; Thu, 17 Dec 2020 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5837F238EC
	for <rcu@archiver.kernel.org>; Thu, 17 Dec 2020 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgLQRRf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQRRe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Dec 2020 12:17:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597BC061794
        for <rcu@vger.kernel.org>; Thu, 17 Dec 2020 09:16:54 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw27so29405004edb.5
        for <rcu@vger.kernel.org>; Thu, 17 Dec 2020 09:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32HWdLH3ahsWaEMBqr4y/T3+8il/2Dtt23Z7+8cwuBg=;
        b=xglzgtO4m5n8iIyIsHmLKdgtxJZMRETXJD3N9AFBCk971dKtusTiMP11YDGsV0n2JN
         YI0p7cgfm1aokX2+vJoIeWVnk8EnkRfupLBb/xcXqij8EDWox3Hjb5jxu8v3DtHG+7kW
         t6ekoHDoVtzae1sD6r8an/j90BVe29ef9yCbRL284r/BJiU6d+wIfHvOIwlYdpT2GlVc
         TGt7kHMvS2wU7vWgJyiKGaQoZymtOEfY376QpLj1pZqfpXcqTZqlkk/rEDCGTgbCkX0K
         6g94z8dSYoyFvtbh/iWDGtaNy9hVv1NiLCHwntfFfhr+//5YQ4BVDtPNevApE/pE0F8s
         +/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32HWdLH3ahsWaEMBqr4y/T3+8il/2Dtt23Z7+8cwuBg=;
        b=lyptbLDJWEQns9EIFP8A811D1G/gdhgwoqdQpi9uiYUMjtSddWPwf1a/Y7nldhoD4Z
         NS3IKtmVRNwJKhs64BfBR6z0rOvkgRJZd8VNzPX/NVmZcjLJQ8ie8t8XmFejEBuN4USY
         2/gTUfg1s3Q1egxWvXP1r5vFWk3G55t3YvmpX4CupNXZnkdT289cCzO6LcawI16GMwQG
         QjoF19G9WgmoQi/pt8rVbdVUqo1DWXEqD5ANOwI8eT/jpVbD5b2kXeH4V8gpB08Xjsjs
         KkGkZavVLYpYctrrRqzcMStN1gD4MU/GnYikJRVPePUPZEHL2OQ9aHJs32qnskLT4CeL
         2R5Q==
X-Gm-Message-State: AOAM533f17te4D/F7yc+WY3O5QPjqjXySn2wITaHZqIgWaR6nlnB47yM
        66jyGqAeoMj0+sVwb7QAVbyoevGthSp7vIY1dPtKmwfLJtCUVQ==
X-Google-Smtp-Source: ABdhPJwzyOBERpFYFJlriRomCHY+nJifkNHHwNdb49sktchEgC38YrZ6TB3nSfmerTQFK5EgepAbcgolT5bZbcLJvtA=
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr322625eds.239.1608225412524;
 Thu, 17 Dec 2020 09:16:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsVud9EmeDnijucxAN49a8S5zjnML6LSmmnPTG3cO5-Hg@mail.gmail.com>
 <20201216160330.GG2657@paulmck-ThinkPad-P72> <CA+G9fYsqcSjzEfGerJ_bJJJ3e00Cnqe0zE9yjqfQQYM78UQgtg@mail.gmail.com>
 <20201217152406.GS2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201217152406.GS2657@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Dec 2020 22:46:41 +0530
Message-ID: <CA+G9fYtd0=Uw4t861T6Y0VhArGQO_C=NzP1TUxRhD9SQvR3MdA@mail.gmail.com>
Subject: Re: i386: rcu-torture: WARNING: at kernel/rcu/rcutorture.c:1169
 rcu_torture_writer [rcutorture]
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> Is this reproducible?  If so, could you please try bisection?
Yes. This issue is reproducible.
I will run bisection and get back to you (might take some time).

- Naresh
