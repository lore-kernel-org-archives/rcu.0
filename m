Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD6C433E0
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 17:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25567239D4
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 17:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhAVRbZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbhAVPrc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jan 2021 10:47:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A385C061794
        for <rcu@vger.kernel.org>; Fri, 22 Jan 2021 07:46:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g3so8288156ejb.6
        for <rcu@vger.kernel.org>; Fri, 22 Jan 2021 07:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpPrYrILqskXnutNdHkDCAFwbGpo3OQRJkbVZqI6O1A=;
        b=C2+CmALYEOr/GCPo7GmqxPD3YW/Veyf0yeltDyUF5vls7X44uYfnMP06+jjzns5z7c
         DvgkUnkjk8RuByc3fpKR+cgGPeMHLjGBtE0eDbF23X+E1l25GYXYuh4QgoOfQOphDfDD
         /D0MEsy9Ia1rsMY1S5uL2OUyJ0Z7H6QxcZObbNZUpGRQ/zLDiI82/9/A1w/h23RDydK4
         dMBXLbSRYXp0/PIYTRYOauI+w08hbHv5XQJoKQuO+01TBRCSkG94p5O10oQaKHVsxkdm
         VjjyxT8Dcgg/iC5rzWcE3zBvrcYQmpaZNMeIF3F25DW5vfWAVrp41N/ACRXcKKgka21y
         VwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpPrYrILqskXnutNdHkDCAFwbGpo3OQRJkbVZqI6O1A=;
        b=dctfNVclRaM9YH1wg7rjSGDLxyTjdJK3LtG54R1Q71kp4NaSFpMA6Fyqqy8TqEeCwR
         /rrx2wgYSqiYdokP4FRwlCdw4Ha6PEg3G6lzDwcEv2JbcJXbbjT6viJTqnvTgy7ayUi9
         4bCN2W+YfmzX4y7EZmaBFEs1QeLd/50UBm0/zac0HJwDH13V57Xv3np/awkgUeF//pJZ
         dNoqsq/4NzglLbD6TUt/fRK18fImtYOHy5d9UZ5mdhHKwTCex0JOLyzkHStUR/97Xx3c
         RTQf4Gr14/cOXtRkraxyDttbMuJnjEBN4eCefLh3O3Y3TGbxK+nEayj/iA667bHtBvar
         Fh+Q==
X-Gm-Message-State: AOAM532JAgt+sTl5ZylFbTg+ivJe/Uet4xei7v+auaEH3yBgoblRBtnU
        P37vqZVbj3B3bzNpubCHINuWiVSXlQA5/x4PJwwlCw==
X-Google-Smtp-Source: ABdhPJx/GbRd9OeNWPRmnKF1EbepFPfQ1dwi0VHs7xKXfIGv0LuebkmThA4PkQwcF0VM43CwC/CrZvPKG1OfdMsK37E=
X-Received: by 2002:a17:906:2695:: with SMTP id t21mr3534463ejc.287.1611330409763;
 Fri, 22 Jan 2021 07:46:49 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvV5SZ47M-XpABya11okgR7BJQk-3dDuFWzgVmGN3Lurg@mail.gmail.com>
 <20210121185521.GQ2743@paulmck-ThinkPad-P72> <20210121213110.GB23234@willie-the-truck>
 <20210121214314.GW2743@paulmck-ThinkPad-P72> <CA+G9fYvZ5oE2bAkZqTYE87N0ONWoo2Q6VZBXihu4NQ_+C07qgA@mail.gmail.com>
 <20210122153704.GG2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210122153704.GG2743@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Jan 2021 21:16:38 +0530
Message-ID: <CA+G9fYt=waJnq7N=109eapXZkz-xNWg91Yno6fKXmovvFUVpsQ@mail.gmail.com>
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

On Fri, 22 Jan 2021 at 21:07, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Jan 22, 2021 at 03:21:07PM +0530, Naresh Kamboju wrote:
> > On Fri, 22 Jan 2021 at 03:13, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Jan 21, 2021 at 09:31:10PM +0000, Will Deacon wrote:
> > > > On Thu, Jan 21, 2021 at 10:55:21AM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Jan 21, 2021 at 10:37:21PM +0530, Naresh Kamboju wrote:
> > > > > > While running rcu-torture test on qemu_arm64 and arm64 Juno-r2 device
> > > > > > the following kernel crash noticed. This started happening from Linux next
> > > > > > next-20210111 tag to next-20210121.
> > > > > >
> > > > > > metadata:
> > > > > >   git branch: master
> > > > > >   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > > > > >   git describe: next-20210111
> > > > > >   kernel-config: https://builds.tuxbuild.com/1muTTn7AfqcWvH5x2Alxifn7EUH/config
> > > > > >
> > > > > > output log:
> > > > > >
> > > > > > [  621.538050] mem_dump_obj() slab test: rcu_torture_stats =
> > > > > > ffff0000c0a3ac40, &rhp = ffff800012debe40, rhp = ffff0000c8cba000, &z
> > > > > > = ffff8000091ab8e0
> > > > > > [  621.546662] mem_dump_obj(ZERO_SIZE_PTR):
> > > > > > [  621.546696] Unable to handle kernel NULL pointer dereference at
> > > > > > virtual address 0000000000000008
> > > >
> > > > [...]
> > > >
> > > > > Huh.  I am relying on virt_addr_valid() rejecting NULL pointers and
> > > > > things like ZERO_SIZE_PTR, which is defined as ((void *)16).  It looks
> > > > > like your configuration rejects NULL as an invalid virtual address,
> > > > > but does not reject ZERO_SIZE_PTR.  Is this the intent, given that you
> > > > > are not allowed to dereference a ZERO_SIZE_PTR?
> > > > >
> > > > > Adding the ARM64 guys on CC for their thoughts.
> > > >
> > > > Spooky timing, there was a thread _today_ about that:
> > > >
> > > > https://lore.kernel.org/r/ecbc7651-82c4-6518-d4a9-dbdbdf833b5b@arm.com
> > >
> > > Very good, then my workaround (shown below for Naresh's ease of testing)
> > > is only a short-term workaround.  Yay!  ;-)
> >
> > Paul, thanks for your (short-term workaround) patch.
> >
> > I have applied your patch and tested rcu-torture test on qemu_arm64 and
> > the reported issues has been fixed.
>
> May I add your Tested-by?

Yes.  Please add Reported-by and Tested-by.

>
> And before I forget again, good to see the rcutorture testing on a
> non-x86 platform!

We are running rcutorture tests on arm, arm64, i386 and x86_64.

Happy to test !

- Naresh
