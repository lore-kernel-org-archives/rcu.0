Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE4BC433FE
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 16:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJBQYt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJBQYr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 12:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6812ADE
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 09:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCC56B80D6E
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 16:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64625C433D6;
        Sun,  2 Oct 2022 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664727882;
        bh=m1Burxy45O1uFXmq+cfPImJA9bo0tvGoSLMy2JSSnZc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fLndCd3uS4dRntDdk/xjo/uzAz30pesTBW/ZgKANUUppjChisMWzl4o/GdTwNwv7K
         739OV1kMwIwPxxdP/RazJDLxaVVK1yURAFb6e6u1DVHrbOi5/86E3uiYDl/b11OHD3
         Bqb9SDMY5QxH1mg+YhiJQ6ifoPxpQeJfPq/Ky1XkmM6FEu46cTWRihlXcBsb1SEf6G
         EMMmnxRf7Nan/3fXV2WL3Shw4uNyCe8JRTBcsH2BJVhLton/wwQsEvRMltPSL3BqdI
         9kWhkNFSc4gE0iR1WM2tgoQ9Ytbr2K23rMTLcKhMXOdlfnhu+cp9qRTQ4lnxAXSDek
         oeayMumhRmihw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0DB315C086D; Sun,  2 Oct 2022 09:24:42 -0700 (PDT)
Date:   Sun, 2 Oct 2022 09:24:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <20221002162442.GT4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
 <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <CAFgQCTu-oyFMQOSGc=9q_ni=hJQ87oxM0AAU1joftkX36t9ejw@mail.gmail.com>
 <CAEXW_YQ19C-Drh7zVDvGRj-zsdJzhpAUJJVvzA+6SHNbTJoA9w@mail.gmail.com>
 <CAFgQCTvDCVL57JR3XA8UWCaS6aL9RHf=Bit6U0DDF7fqBBangA@mail.gmail.com>
 <552a3507-7d34-70d9-d882-3efed6f7e027@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552a3507-7d34-70d9-d882-3efed6f7e027@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 02, 2022 at 12:11:07PM -0400, Joel Fernandes wrote:
> 
> 
> On 10/2/2022 10:06 AM, Pingfan Liu wrote:
> > On Fri, Sep 30, 2022 at 9:04 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>
> >> On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>>
> >>> On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >>>>
> >>> [...]
> >>>> "
> >>>>
> >>>> I have no idea whether this is related to the reverted commit.
> >>>>
> >>>
> >>> I have started another test against clean v6.0-rc7 to see whether this
> >>> is an issue with the mainline.
> >>
> >> I am not sure what exactly you are reverting (you could clarify that),
> > 
> > commit 96926686deab ("rcu: Make CPU-hotplug removal operations enable tick").
> > But due to conflict, "git revert" can not work directly. So I applied
> > it by hand.
> > 
> >> but if you are just removing the entire TICK_DEP_BIT_RCU, I do
> >> remember (and mentioned on IRC to others recently) that without this
> >> NOHZ_FULL has a hard time ending grace-periods because the forcing of
> >> tick is needed for this configuration if we are spinning in the kernel
> >> with the tick turned off. That seems to align with your TREE04
> >> (NOHZ_FULL) configuration.
> >>
> > 
> > Yes, that is the scenario.
> > 
> >> Also, the commit Frederic suggested to revert seems to be a cosmetic
> >> optimization in the interrupt-entry path. That should not change
> >> functionality I believe. So I did not fully follow why reverting that
> >> is relevant (maybe Frederic can clarify?).
> >>
> > 
> > Leave this question to Frederic.
> 
> I take this comment back, Sorry. Indeed the commits Frederic mentioned will make
> a functional change to CPU hotplug path.
> 
> Sorry for the noise.
> 
> Excited to see exact reason why TICK_DEP_BIT_RCU matters in the hotplug paths. I
> might jump into the investigation with you guys, but I have to make time for
> Lazy-RCU v7 next :)

One historical reason was that a nohz_full CPU could enter the kernel with
the tick still disabled, and stay that way indefinitely.  Among other
things, this can interfere with the grace-period wait in the offlining
code path.

							Thanx, Paul
