Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553CAC4361B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 02:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2698C23975
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 02:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLICQu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 21:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLICQu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 21:16:50 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42204C0613CF;
        Tue,  8 Dec 2020 18:16:10 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id h20so715892qkk.4;
        Tue, 08 Dec 2020 18:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MLg5U6XWpc6kk7MWokhksWgofpSTcIn/Bucp2d9U9Js=;
        b=dZEMQLgroBuHNVeNKEUWlE8AD2vwVb8V1+rz+MX3aLkgJLN3xu6p28jsN42rVMiMh5
         Zegw3FE3DH10tXDJ3fSiXpPLACoae8IAQAGa/X56lElQE0DIASTETYoDC78O8dLE1Hfc
         a4Ar49A4RSMD3PXY+3iaYfhLFPYNsmPFRK69hlf1qnQZHcUhv26PFmGubM3e5JoqLpym
         PNop1L59L/f4a/f2qaPLyrBiwjSjMH1WdnSxXnLX2UzSCfEH2KwDrRF4DZflkQUV+bni
         c5OGJoecBZYkSh91qRm1vhvgMUTM/yOxuEvUvT4xpFhZOFW3NcZvbcQ7IRbqtC2QxnhT
         sf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MLg5U6XWpc6kk7MWokhksWgofpSTcIn/Bucp2d9U9Js=;
        b=NAyRdFFYH0fQ3ih0vkl6L0GlZFhc4UM+0wDxp3I7+nApb+gTgDePnfweROjGB3cJhE
         hCIS/pFAsFAVmND6kYYvIrZRTKu+i2nvPm9zxFVWDO2FwK9Duw3fYshph+OsiHwaBEeG
         uwKCkoKfPIa0ofUQDRCQJIsYYTaNVMwBZb2Wr2JNW6SGTmBYDq9hhyyA28GOpSXtOE6m
         v2DQQMWnRNnmZpm7WcgjxUfV1ONOMZHozoRBQ4eU7QuxdSYMuXsvBK3Qx97vKU2AEYiA
         ijgXpwdfnW/KoZhf/00apUVT2xzpQ6U9bF2Z38O8/Gr/iPOmTkv0HXoc2l6Ig97pAxG7
         H11w==
X-Gm-Message-State: AOAM531nLbOUwmBbS4RY8t7TCOvVy2tB8GHxQpbh92tNyDXly3/DvXBF
        ExYmPFOETYZ7dJy5XCMePdY=
X-Google-Smtp-Source: ABdhPJwiFf47VcklTlrvTas6qHdLrCO9cmCJ89By6JiOmLWm2n9/SO8RuLD9kS78ZvoEl9X0xaBI2Q==
X-Received: by 2002:a05:620a:40d6:: with SMTP id g22mr364627qko.232.1607480169379;
        Tue, 08 Dec 2020 18:16:09 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z8sm160498qti.22.2020.12.08.18.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 18:16:08 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id D59E127C0054;
        Tue,  8 Dec 2020 21:16:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Dec 2020 21:16:06 -0500
X-ME-Sender: <xms:ZjPQXzABVja8mlXVDtYiXd8Z4JZ-s3noEo2FpZwi-J_vv8e76wBCCw>
    <xme:ZjPQX9yWFMG8wOXbsb9ezWeh0COL_xKn2qU6YFZHVqnW0bHSSXoOyJqyePiXu5n7U
    m12gzeCrU_Xp6f3eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudeijedrvddvtddrvd
    druddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZjPQX5nQyFHXT5GvsKoptzlJ57dNHrL0PN1TcOUDSMh8zK-GcU8zPw>
    <xmx:ZjPQX6FQ9Uc-tYquk4kcqrNAlLwAPV5vukB28dIRtFESGAWbLamAgA>
    <xmx:ZjPQXxWa49R52XpgbfvELEC9xCTJPJyvmShzQ619e_Mb2ynOss4YNw>
    <xmx:ZjPQX2Tu_ZTPI8C4utYd7D2HvnEKFINt2h6Kx-lBC7aX_qxmuQBgcg>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76620240065;
        Tue,  8 Dec 2020 21:16:06 -0500 (EST)
Date:   Wed, 9 Dec 2020 10:14:49 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201209021449.GK3025@boqun-archlinux>
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
 <20201208155457.GA3916@lothringen>
 <20201208171927.GS2657@paulmck-ThinkPad-P72>
 <20201208175230.GB3916@lothringen>
 <20201208182409.GT2657@paulmck-ThinkPad-P72>
 <20201208220438.GC3916@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208220438.GC3916@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic,

On Tue, Dec 08, 2020 at 11:04:38PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 08, 2020 at 10:24:09AM -0800, Paul E. McKenney wrote:
> > > It reduces the code scope running with BH disabled.
> > > Also narrowing down helps to understand what it actually protects.
> > 
> > I thought that you would call out unnecessarily delaying other softirq
> > handlers.  ;-)
> > 
> > But if such delays are a problem (and they might well be), then to
> > avoid them on non-rcu_nocb CPUs would instead/also require changing the
> > early-exit checks to check for other pending softirqs to the existing
> > checks involving time, need_resched, and idle.  At which point, entering and
> > exiting BH-disabled again doesn't help, other than your point about the
> > difference in BH-disabled scopes on rcu_nocb and non-rcu_nocb CPUs.
> 
> Wise observation!
> 
> > 
> > Would it make sense to exit rcu_do_batch() if more than some amount
> > of time had elapsed and there was some non-RCU softirq pending?
> > 
> > My guess is that the current tlimit checks in rcu_do_batch() make this
> > unnecessary.
> 
> Right and nobody has complained about it so far.
> 
> But I should add a comment explaining the reason for the BH-disabled
> section in my series.
> 

Some background for the original question: I'm revisiting the wait
context checking feature of lockdep (which can detect bugs like
acquiring a spinlock_t lock inside a raw_spinlock_t), I've post my first
version:

	https://lore.kernel.org/lkml/20201208103112.2838119-1-boqun.feng@gmail.com/	

, and will surely copy you in the next version ;-)

The reason I asked for the RCU callback context requirement is that we
have the virtual lock (rcu_callback_map) that marks a RCU callback
context, so if RCU callback contexts have special restrictions on the
locking usage inside, we can use the wait context checking to do the
check (like what I did in the patch #3 of the above series).

My current summary is that since in certain configs (use_softirq is true
and nocb is disabled) RCU callbacks are executed in a softirq context,
so the least requirement for any RCU callbacks is they need to obey the
rules in softirq contexts. And yes, I'm aware that in some configs, RCU
callbacks are not executed in a softirq context (sometimes, even the BH
is not disabled), but we need to make all the callback work in the
"worst" (or strictest) case (callbacks executing in softirq contexts).
Currently, the effect of using wait context for rcu_callback_map in my
patchset is that lockdep will complain if a RCU callback use a mutex or
other sleepable locks, but using spinlock_t (even in PREEMPT_RT) won't
cause lockdep to complain. Am I getting this correct?

Regards,
Boqun

> Thanks.
> 
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
