Return-Path: <SRS0=sv12=BS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B236AC433E0
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A407206C3
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 21:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQL4J7iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHHVSM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHVSL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 8 Aug 2020 17:18:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E8C061756
        for <rcu@vger.kernel.org>; Sat,  8 Aug 2020 14:18:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v12so5719689ljc.10
        for <rcu@vger.kernel.org>; Sat, 08 Aug 2020 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4rz3hoyI/6Ikm42Z0u/nAcwa3GSGukSjijv1Tmv+cAg=;
        b=fQL4J7iSSUfgWjy/9cS82PnugeklQzY1zUnMGEcB3/eGTxxB7YH6tzOqKeZFGhZRip
         Z9WUjMjzexy45G7mPVHVK1kAXomUL3LisQdTY6QJ3hYCHGB4THHGUfcazi4qpRPQDDZf
         RGbz0G3mACAf+EUuF7827K4NE/DYYmGAHCCee7Yaf8VGxCBQA4d15LSR0FiGXlFAi30L
         tlQ+cVZWdqnsIkq7rynrOV3cvj6IXcp4yGV9095RNKZTkCS1bjR9UwyGBzhoEZ7HHfkh
         TpoUNkHOgihLgI6zz5SxszcuvvhsPhw/jAugXi+ILwCvYfkl+/7hznN/qVyks3P53gT0
         eanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4rz3hoyI/6Ikm42Z0u/nAcwa3GSGukSjijv1Tmv+cAg=;
        b=aj5oyjoVS+aIU8p0evk6dFC8hQXbxgvuYd/Hh4I/YwS4F2RVVk8mZ2GsF1c3elaNg3
         z7PCyTWOu+GN/V2ky/Jh10jmLHwSO/VpQ9iI1rEjbNTm2IEEnjRrETNa8u0mN6rFXelC
         HRaYYKRXHheyNuy0owpLGspZ//+TFlCtQ0q2yW6YgNpXTv//9TCkP2UcuT2qHjhGE9Vp
         uwPx96bbCEr/yNWVvabjfWQP9gn5ObOKiuVMUCJzt2awtQFy2ec9ZtIkS8IxS4SWCKWx
         hTuTwOwFek/p7XI+rfbQXw1wTF9PLLiZ8aIWRS+1LSCogHEW5wmrj2v2VdrDy3XYnFu/
         mp+A==
X-Gm-Message-State: AOAM531ivD70ZMDLP61JtBCrvtQzmvmS++ZAAEXBvtDp89GTbwQ4a6EG
        uL8zaM88/0lZFPQp+h4OxnrbSonFS/aWy4YeW6FOCJpA
X-Google-Smtp-Source: ABdhPJya+lxdJb5wYZJMv4khh+bLOAzyXkbf//HHzZlm8tU+yCwYfHfcIUKd5sozqQJZdkaz9L+zk4Kq/O01zH7WpPo=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr9900788ljh.446.1596921489731;
 Sat, 08 Aug 2020 14:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
In-Reply-To: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
From:   William Tambe <tambewilliam@gmail.com>
Date:   Sat, 8 Aug 2020 16:17:57 -0500
Message-ID: <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
>
> I am having an issue in my kernel where delayed_put_task_struct() used
> through call_rcu() by put_task_struct_rcu_user() never gets called.

I am able to trace this issue to invoke_rcu_core() not getting called
in __call_rcu_core() due to rcu_is_watching() always returning true.

Any idea why I am seeing such an issue ?

>
> Any idea ?
