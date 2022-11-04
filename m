Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45668C4332F
	for <rcu@archiver.kernel.org>; Fri,  4 Nov 2022 09:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKDJiV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Nov 2022 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKDJiT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Nov 2022 05:38:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCC2A96F
        for <rcu@vger.kernel.org>; Fri,  4 Nov 2022 02:38:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g12so6681529lfh.3
        for <rcu@vger.kernel.org>; Fri, 04 Nov 2022 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dhhnkI9EEd+K9MLjuL6iawNK/Q1MgYNmURrylUzFfVA=;
        b=PEy3wa7HWBIMn1UajWkjMUIVgDNVUATzRlqlQq43sZYvzWgE80yQTFlyD+hm2IGkFL
         KeH3pJjdC/sTX3ffzRmmjEm3TCv0S0ZRjaIov1ay+RRDucJxR0YnK3nrItigqiFf9GfU
         K1ypNJgJGEdAgWMyD5W4asRIJIXPFfBKAay6nEUDuQpnCiH5HNzDCf/Mzj90QMHcuxsk
         cDd0cc/8AHoska7ucCcNHAg2vutiVJzSXP5WKP8cp7R24pPhbnG5pLmdCLFGzuZmKdQY
         xep+zzsyfH/cfv6+c9KQTBDB7LlsF+a9o5m/zpKYu6lnV03ljulAKQJWI/EaQUOTh1Og
         R2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhhnkI9EEd+K9MLjuL6iawNK/Q1MgYNmURrylUzFfVA=;
        b=eimfAiODGBB2BZA1k0KNfOsEwP0UHJrK1iuYxuijE5gfeEH3LLPj5xNzgMTvz5ah3o
         MXNmoNpi38hCNrUjscRIO7Rw3Fy6rwNoLAiCAWh8IO7m3QAdJToqwk1PFp8Iu7VzSWVU
         oVNmnOkWrb4xxDABlQEsevRLk3BFzJBV6bXoVKhrs0KZlG9QUj70Yc+wsi629Q8gMBNS
         vJ+jeV2A/nwtveX4eafmLIoyY4xK3rhD+OHyhO7YnCSAtEdKywRllv69SrklGuGHcDUn
         PsoIweeDbY7dO3Dlh8/s08ds92nKtFRbkH4fasxuG2yUzWfTlEk+amHyYyGfGZ+N6B5X
         r6zw==
X-Gm-Message-State: ACrzQf0j1nUmwpQGfoBbLZvxeDfW2VQf+bGHacoU92CI72ge18UfW8gY
        bC6NOZh1RDCApPoC9/rPlI3nxEBhTUpsin3D0A==
X-Google-Smtp-Source: AMsMyM4kmIvQhnMsj7o0wzleUCco66rghGk34B6JIOIRuQNMfpvYue3RLJfiAvXiqNSgmZFBUAgvSgJCPA6cTQgA5w4=
X-Received: by 2002:ac2:4908:0:b0:4b1:5094:d45 with SMTP id
 n8-20020ac24908000000b004b150940d45mr5488705lfi.1.1667554696040; Fri, 04 Nov
 2022 02:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221103131313.41536-1-kernelfans@gmail.com> <20221103133607.GB1410480@lothringen>
In-Reply-To: <20221103133607.GB1410480@lothringen>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 4 Nov 2022 17:38:04 +0800
Message-ID: <CAFgQCTsq58dRvAKJ+4WSLntNxn1y8-K+aVTdgZXGDSbsOJsKpg@mail.gmail.com>
Subject: Re: [PATCH] srcu: Fix a rare race issue in __srcu_read_(un)lock()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 3, 2022 at 9:36 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Thu, Nov 03, 2022 at 09:13:13PM +0800, Pingfan Liu wrote:
> > Clarify at first:
> >   This issue is totally detected by code suspicion, not a real experience.
> >
> > Scene:
> >
> >   __srcu_read_(un)lock() uses percpu variable srcu_(un)lock_count[2].
> > Normally, the percpu can help avoid the non-atomic RMW issue, but in
> > some rare cases, it can not.
> >
> > Supposing that __srcu_read_lock() runs on cpuX, the statement
> >     this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> > can be decomposed into two sub group:
> >     -1. get the address of this_cpu_ptr(ssp->sda)->srcu_lock_count[idx],
> > denoted as addressX and let unsigned long *pX = addressX;
> >     -2. *pX = *pX + 1;
>
> It's not supposed to happen:
>
> * The weak version of this_cpu_inc() disables interrupts during the whole.
> * x86 adds directly to gs/fs memory
> * arm64, loongarch, s390 disable preemption
>
> This has to be a fundamental constraint of this_cpu_*() ops implementation.
>

Thanks! I find the exact implementation in the code, also there is
notes about this_cpu_*() api, which says they are safe from preemption
and interrupt.

Regards,

    Pingfan
