Return-Path: <SRS0=GZkA=A7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1683AC433E0
	for <rcu@archiver.kernel.org>; Mon, 20 Jul 2020 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADCA22C9D
	for <rcu@archiver.kernel.org>; Mon, 20 Jul 2020 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2/c2wfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGTOOE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOOE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jul 2020 10:14:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD1C061794
        for <rcu@vger.kernel.org>; Mon, 20 Jul 2020 07:14:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so20397055ljc.5
        for <rcu@vger.kernel.org>; Mon, 20 Jul 2020 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DiHRnFNVQtLplAiqEhupb7TqEx9zvruD96MwLMbFL0=;
        b=Y2/c2wfUdN3DKORe7zeCca30O63TjzpDby0GTXv/vSxick4THyzfpL/d6o1Jc5zduK
         Qu8auVrQKid69N6GvMksvMzon7vw07vHmkJAnFdT6c6SNiP7/m1pNxD9lzzdZdPqCpa+
         BExD1qbSWx17l1TDVTT5fLzEAm36DS7lD2HcHooxy12pWtxIVMZAlI6gYat3q5VhCUd7
         CRDmCfKu3B2OaHgvOaBnPWbeObhX0xEniWddkPm3KOrHYDZI9YYhEbu618+0QllwhgO3
         pegp8c5wfrZVUc/rgHYILb2hzRAlgeJM0J4EkX6LxIQj8dQjts5OCSNsdc18rrDZIG1o
         zs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DiHRnFNVQtLplAiqEhupb7TqEx9zvruD96MwLMbFL0=;
        b=lIyvoSXgOA4RldRhuGyPbMcbIvOVi2fMyALNGErUjCuGu8R+AlODRQQ+qliR3/NvUn
         5eO3xzbzeag6OjrxNulV1MGBSlSjYsNQd8cP06krm1mUeB6c+hGDsotsJ7Z26gCZWbBi
         8097Dqq2WFRIHFw8hiYxRF6It4Y2el2SJiekdWDisZf9QLoeXJJ9rtGaRbA1YCzS6qL5
         TDfJ/uXR7XQdivzXKbesPSta3g4C3b+d8MgqmjJB1VRWGaRKt1Rz0NwZ24qJL4lVT7VX
         LKGFgiWdeu9txF5Bw+kLTj+DDz829ZoYN2KGLHx1bzugmB2Evz59g2JZUxe91X+bwoZw
         Nb4w==
X-Gm-Message-State: AOAM53024RdSiobXpkEz2kad3ZMLxecUvvh5OeAxzyhhAbo92n917uah
        41tn0gR8+XY+6AUZ//EpqS+JXPFUuv320f7IiYhi8zjqvjKeMg==
X-Google-Smtp-Source: ABdhPJxdre1sEy80DzhnFCDjTrs8GKVeM3fBJ9cozNo11ss0SEiHRDDHrpXirEVm6TiEGg0DbCOnl43o/rAgf3lKoj4=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr10612838ljg.431.1595254442239;
 Mon, 20 Jul 2020 07:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200712131003.23271-1-madhuparnabhowmik10@gmail.com>
 <20200712131003.23271-2-madhuparnabhowmik10@gmail.com> <20200712160856.GW9247@paulmck-ThinkPad-P72>
 <CA+G9fYuVmTcttBpVtegwPbKxufupPOtk_WqEtOdS+HDQi7WS9Q@mail.gmail.com>
 <CAA42JLY2L6xFju_qZsVguGtXvDMqfCKbO_h1K9NJPjmqJEav=Q@mail.gmail.com>
 <20200717170747.GW9247@paulmck-ThinkPad-P72> <CA+G9fYvtYr0ri6j-auNOTs98xVj-a1AoZtUfwokwnvuFFWtFdQ@mail.gmail.com>
 <20200718001259.GY9247@paulmck-ThinkPad-P72> <CA+G9fYs7s34mmtard-ETjH2r94psgQFLDJWayznvN6UTvMYh5g@mail.gmail.com>
 <20200719160824.GF9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200719160824.GF9247@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Jul 2020 19:43:50 +0530
Message-ID: <CA+G9fYueEA0g4arZYQpZo803FHsYvh3WCq=PhYGULHEDa86pSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: mmu: page_track: Fix RCU list API usage
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        frextrite@gmail.com, lkft-triage@lists.linaro.org,
        Dexuan Cui <decui@microsoft.com>, juhlee@microsoft.com,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 19 Jul 2020 at 21:38, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Jul 19, 2020 at 05:52:44PM +0530, Naresh Kamboju wrote:
> > On Sat, 18 Jul 2020 at 05:43, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sat, Jul 18, 2020 at 12:35:12AM +0530, Naresh Kamboju wrote:
> > > > Hi Paul,
> > > >
> > > > > I am not seeing this here.
> > > >
> > > > Do you notice any warnings while building linux next master
> > > > for x86_64 architecture ?
> > >
> > > Idiot here was failing to enable building of KVM.  With that, I do see
> > > the error.  The patch resolves it for me.  Does it help for you?
> >
> > yes.
> > The below patch applied on top of linux -next 20200717 tag
> > and build pass.
>
> Thank you!  May I add your Tested-by?

That would be great please add
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thank you !

- Naresh
