Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E504C11F67
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B43A613E9
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 23:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhGAXti (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhGAXth (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 19:49:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0B9761409;
        Thu,  1 Jul 2021 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625183226;
        bh=yV6Mox2/vbwi+Fx1vIt/VkdM0p3xUkZ7Vf1yo2nt8Qw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z/HXr0azsUWbR3BnkwifDN3usPECCOLw5Ex1OoWNkoImi8Pbg9PDToUIXG7oUnOWZ
         SavEc/ZDlbJZ1Lg2b3Rd5B5xW3R1GX8VovzZyzWebBFr8r9tVBDERyNGpGvYNmegqJ
         2elAsMamk06SvduGl+w7M5cn8nuH+gn+DpPTanDVi1dOMzdfaTcErjEMVNoZU/z0zM
         xPj1BjYftvUgDpBjmCjxPKD/NyJ7SWJZCxO2CiKdu5PSA44uPTIndNKEas1cdlVRZb
         D2cJ06pAaTUEm5e/IUY0VOKWN41AdYLEx+qNF14i3yfhA2jlXlJZBtdn58E7nTnUvd
         y41/cfjUasm7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F27B5C0525; Thu,  1 Jul 2021 16:47:06 -0700 (PDT)
Date:   Thu, 1 Jul 2021 16:47:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Liu Song <fishland@aliyun.com>, liu.song11@zte.com.cn,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
Message-ID: <20210701234706.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210630140802.39138-1-fishland@aliyun.com>
 <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
 <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <bb788228-9756-2ee9-f11c-eae133c34593@codeaurora.org>
 <20210701183933.GA1948@pc638.lan>
 <20210701195701.GG4397@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT9emLvb=n5mHgg_BsGH=mdDKgN6VOLdHwJSfc+zf1jSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YT9emLvb=n5mHgg_BsGH=mdDKgN6VOLdHwJSfc+zf1jSQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 01, 2021 at 04:03:58PM -0400, Joel Fernandes wrote:
> On Thu, Jul 1, 2021 at 3:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jul 01, 2021 at 08:39:33PM +0200, Uladzislau Rezki wrote:
> > > On Thu, Jul 01, 2021 at 10:35:43PM +0530, Neeraj Upadhyay wrote:
> > > >
> > > >
> > > > On 7/1/2021 10:01 PM, Paul E. McKenney wrote:
> > > > > On Thu, Jul 01, 2021 at 08:24:32PM +0530, Neeraj Upadhyay wrote:
> > > > > >
> > > > > >
> > > > > > On 6/30/2021 7:38 PM, Liu Song wrote:
> > > > > > > From: Liu Song <liu.song11@zte.com.cn>
> > > > > > >
> > > > > > > In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> > > > > > > pointers. This patch adjusts a few codes that have not done so.
> > > > > > >
> > > > > >
> > > > > > Minor: Can we also add below statement?
> > > > > > "This patch doesn't introduce any functional change."
> > > > > >
> > > > > > > Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> > > > >
> > > > > Applied with the usual wordsmithing, including adding words to this
> > > > > effect, so thank you all!  I removed the obsolete chunk that Neeraj
> > > > > pointed out as well.
> > > > >
> > > > > Please take a look and check to see if all is well.
> > > > >
> > > >
> > > > Looks good to me
> > > >
> > > Same to me. Looks good.
> > >
> > > There are two dots though in the commit message: "change.." :)
> >
> > Good eyes, fixed, thank you!
> 
> LGTM as well, thanks!
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And one more.  ;-)

Again, thank you all!

							Thanx, Paul
