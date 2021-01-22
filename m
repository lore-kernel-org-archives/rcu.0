Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF3C433E6
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 10:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA554239EE
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 10:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbhAVKAj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbhAVKAL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900BC0613D6
        for <rcu@vger.kernel.org>; Fri, 22 Jan 2021 01:51:19 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ke15so6734199ejc.12
        for <rcu@vger.kernel.org>; Fri, 22 Jan 2021 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SOZ0cafIsQ2pjxZKEsji3NjTpPSIIGuynZ9xZcUToY=;
        b=ztKqHymKyLAIKP1qDj25Z0vFnV8lkexGar1wlQhZ7Rfg8c4jimASSEu3EMx6QNc9xt
         /UvDVuSdpibwYuUfHMvcomb5tGn1OeKvoi71lF5ZwUl6ePE7Mfc57I4uQf5xNJ8tXEEy
         mOyktrWbjdAv6URUuvt7PwLdEnteAaSEkHPyO8vXOhNbrfQHerbzre3VYp/h/evQYlJB
         fouV9L1yJo/0dB4OCITN92tMCAmOB1RGGoybCsptJuKlo3e3nsyMl5diLyQRC9L816BZ
         BD9BAva69CDiC6VvjgBjZ04DmOq03Vlb5IxAl8CNhdH54iD+BlXZAk6UeQKt99ShdIVL
         dbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SOZ0cafIsQ2pjxZKEsji3NjTpPSIIGuynZ9xZcUToY=;
        b=loMVnixlqg5zqXg5JO93lxjIEr4v8Htko8TNnrVqRdHnretDuuEFkc61wBR+7kvk7Z
         qj41MOwEOXd2/UVwqLqdEJzd7y200PxXobpMFfhKmAnIaCGf6QMHKH9hnChlF3Pp006L
         AETXXC2XJsE8mTZyxn7AuK+U1Rhdr5CCCj7YHFddyFH2xFG+7oYmGjISybB9m1sssVSq
         TVZXufrbfPF7xL+XHucyiqihOPuHlcz2E088DGmx/r78nXPbdaLYjm9qKPiY2xoffS68
         njrODXyOOvSV6hOulF4byXzetzbmfNws9gfVQ2pRH8KEG7TlfVq2YSLjGCkukFEjdSqh
         jcGA==
X-Gm-Message-State: AOAM530SsuYY0TpF+xSeUTOs4pMiZ9SFKFkXYnWY5aOuAH0wqa7zoA7C
        8WpCCScV5G+Yh5H3zsF43FuaeKLXh7T6N5pnJxAhtQ==
X-Google-Smtp-Source: ABdhPJzEjn5GEPrffd5+4rTlgY2BHDNhZMRsd9H/LHyaUqgXSrIVK7mTGKR12AKLBujzMON638tkxawvFlPiVqhItq8=
X-Received: by 2002:a17:906:4443:: with SMTP id i3mr2288434ejp.133.1611309078552;
 Fri, 22 Jan 2021 01:51:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvV5SZ47M-XpABya11okgR7BJQk-3dDuFWzgVmGN3Lurg@mail.gmail.com>
 <20210121185521.GQ2743@paulmck-ThinkPad-P72> <20210121213110.GB23234@willie-the-truck>
 <20210121214314.GW2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210121214314.GW2743@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Jan 2021 15:21:07 +0530
Message-ID: <CA+G9fYvZ5oE2bAkZqTYE87N0ONWoo2Q6VZBXihu4NQ_+C07qgA@mail.gmail.com>
Subject: Re: rcu-torture: Internal error: Oops: 96000006
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 22 Jan 2021 at 03:13, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 09:31:10PM +0000, Will Deacon wrote:
> > On Thu, Jan 21, 2021 at 10:55:21AM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 21, 2021 at 10:37:21PM +0530, Naresh Kamboju wrote:
> > > > While running rcu-torture test on qemu_arm64 and arm64 Juno-r2 device
> > > > the following kernel crash noticed. This started happening from Linux next
> > > > next-20210111 tag to next-20210121.
> > > >
> > > > metadata:
> > > >   git branch: master
> > > >   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > > >   git describe: next-20210111
> > > >   kernel-config: https://builds.tuxbuild.com/1muTTn7AfqcWvH5x2Alxifn7EUH/config
> > > >
> > > > output log:
> > > >
> > > > [  621.538050] mem_dump_obj() slab test: rcu_torture_stats =
> > > > ffff0000c0a3ac40, &rhp = ffff800012debe40, rhp = ffff0000c8cba000, &z
> > > > = ffff8000091ab8e0
> > > > [  621.546662] mem_dump_obj(ZERO_SIZE_PTR):
> > > > [  621.546696] Unable to handle kernel NULL pointer dereference at
> > > > virtual address 0000000000000008
> >
> > [...]
> >
> > > Huh.  I am relying on virt_addr_valid() rejecting NULL pointers and
> > > things like ZERO_SIZE_PTR, which is defined as ((void *)16).  It looks
> > > like your configuration rejects NULL as an invalid virtual address,
> > > but does not reject ZERO_SIZE_PTR.  Is this the intent, given that you
> > > are not allowed to dereference a ZERO_SIZE_PTR?
> > >
> > > Adding the ARM64 guys on CC for their thoughts.
> >
> > Spooky timing, there was a thread _today_ about that:
> >
> > https://lore.kernel.org/r/ecbc7651-82c4-6518-d4a9-dbdbdf833b5b@arm.com
>
> Very good, then my workaround (shown below for Naresh's ease of testing)
> is only a short-term workaround.  Yay!  ;-)

Paul, thanks for your (short-term workaround) patch.

I have applied your patch and tested rcu-torture test on qemu_arm64 and
the reported issues has been fixed.

- Naresh
