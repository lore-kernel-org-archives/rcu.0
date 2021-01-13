Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A2C433DB
	for <rcu@archiver.kernel.org>; Wed, 13 Jan 2021 03:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D77923117
	for <rcu@archiver.kernel.org>; Wed, 13 Jan 2021 03:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbhAMDrc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jan 2021 22:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAMDrb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jan 2021 22:47:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D9C061575
        for <rcu@vger.kernel.org>; Tue, 12 Jan 2021 19:46:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ga15so1077365ejb.4
        for <rcu@vger.kernel.org>; Tue, 12 Jan 2021 19:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZcLpmOPkSFE/gueokH+hjJ/3Wa9K8Ju/waJdBuHgWM=;
        b=iEDcOGPYSUwWJeCtU5722M9gia30ufJhm9f4E7VlPKRXL6Q/Rqkn7HKYAX2+ELfwtq
         N4R5cyVKCIxM/C8Kuce0VxWeEWo6T1gG9/lY5GZFMs/FzJLYSy0t0yKElQul5pvH0Qh7
         KWLfja8S0+B7HqnKSQbYcI6SD88uDDeqy8YneaAZXC7QYlQjuBxEkBET0pLFzYyJmgm4
         xz9VXnF7AJbOWIP7SUjNBVHGvXzDkhNvgTGKEW6RoetRxiSnjK/edCv2lgL/06Is29re
         lOPS3r7uwdI8iJGySBsSXfUSDfpSlm2E6nOGsalXWLwkAoNevHQS/xJOmPFs9yH+UzUk
         VTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZcLpmOPkSFE/gueokH+hjJ/3Wa9K8Ju/waJdBuHgWM=;
        b=YXpqkjinJFXR1u10yHzooR4ofcsOIUfFwdsPsFye3gPP3n3M+roZ8lAjYcKJfJ7XJ6
         srK3u1Bu0KAMp08de4jL1yEIiD561/rQ0W2lz5QcaRRDMGczH7uU52EMVOSn5VGcPb9P
         tsrsn00T3ixJySDTiuvR1OqMG1ez9OEo+AjMtHVciLYlGTtGJz83fXABCsljT/iEN+So
         viK25OfVVPl6gt+vRMIWG5iIO82XPv8+v8VHzH+3GAjJxT0+wyTZ1x6qlvqbrPizDdvb
         Xa+s5dp0HAWOKQMVorYs6I90cU2IiORKQKuc5MgDLGfKzb7d1FTj8PHAgRAevqLRknPY
         U6yA==
X-Gm-Message-State: AOAM53057va+sOy5A9Tydy8jh8gekJMmjpxo4XO63G5GlSZRmEyk27WN
        89b0FFu9AhX9klTZyP8RJW7ztnWeZipcQ1UK1Bs=
X-Google-Smtp-Source: ABdhPJx33+Rm2+Ih5dVUqiTVet0kacdH5Djg7d1l4Fp5ZhG+Td/oLlo6vFi7emO80h9ONLmDPpJt0B6MqDGbMiuse4k=
X-Received: by 2002:a17:906:af5a:: with SMTP id ly26mr111534ejb.416.1610509604156;
 Tue, 12 Jan 2021 19:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20210111010859.7778-1-zhouzhouyi@gmail.com> <20210112175055.GI2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210112175055.GI2743@paulmck-ThinkPad-P72>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 13 Jan 2021 11:46:32 +0800
Message-ID: <CAABZP2yMz9VGaYTnoQ2x1W8OrEQvtrUOO5nYj5pJfQPL-1e-MA@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove surplus instrumentation_end in rcu_nmi_enter
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, neeraju@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank Paul for your encouragement and valuable advice

I achieve great self improvement in studying and participating Linux RCU

Also thank Neeraj for mutual interest in Linux RCU, your contribution
makes me believe
that even a small enhancement of code can still attract interest and
draw favorable attention
from peers.

Cheers
Zhouyi
On Wed, Jan 13, 2021 at 1:50 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> Good catch, applied, thank you!  As usual, I edited a bit, so please
> check below to see if I messed anything up.
>
> I did add Neeraj Upadhyay's Reported-by because he noted this, though you
> beat him with a public posting, though mostly because I asked him whether
> he could make this happen.  I also added the Fixes, but could you please
> do that in the future?  You can use "git blame" or either "git log" and
> "gitk" with appropriate options to find the offending commit.
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 3f91ff7fd4f76e7eb48bad79666c466bc3530324
> Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Date:   Mon Jan 11 09:08:59 2021 +0800
>
>     rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()
>
>     In rcu_nmi_enter(), there is an erroneous instrumentation_end() in the
>     second branch of the "if" statement.  Oddly enough, "objtool check -f
>     vmlinux.o" fails to complain because it is unable to correctly cover
>     all cases.  Instead, objtool visits the third branch first, which marks
>     following trace_rcu_dyntick() as visited.  This commit therefore removes
>     the spurious instrumentation_end().
>
>     Fixes: 04b25a495bd6 ("rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr")
>     Reported-by Neeraj Upadhyay <neeraju@codeaurora.org>
>     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 63c6dba..e04e336 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1050,7 +1050,6 @@ noinstr void rcu_nmi_enter(void)
>         } else if (!in_nmi()) {
>                 instrumentation_begin();
>                 rcu_irq_enter_check_tick();
> -               instrumentation_end();
>         } else  {
>                 instrumentation_begin();
>         }
