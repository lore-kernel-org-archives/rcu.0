Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F259C4363C
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86E723A5D
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 20:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oW++ioxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIUU4y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:56:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46302 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgIUU4y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 16:56:54 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 16:56:53 EDT
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72A582D7;
        Mon, 21 Sep 2020 22:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600721812;
        bh=0ufRJd15vYVOMYf2643FoPvs/mz3t46PJ2prwsZl1DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW++ioxIzAreehCCQJKUn1cD6I/Wv7SUWXEKp9GkaAE93ShinuiFXxahNlgoMkZQl
         EyVlBKtm0n8roED3mSuWgg7CPf5vCRvZqhcYKPZttF2Gc04hqHEY5ndprAVE36Ptg0
         HTkcHM8aCQJz9Ql3+rBnV2irFdp6LSKsnfzcyPWg=
Date:   Mon, 21 Sep 2020 23:56:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
Message-ID: <20200921205620.GD18343@pendragon.ideasonboard.com>
References: <20200921193703.GA20208@paulmck-ThinkPad-P72>
 <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
 <20200921203534.GJ29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921203534.GJ29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 21, 2020 at 01:35:34PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 12:46:22PM -0700, Linus Torvalds wrote:
> > On Mon, Sep 21, 2020 at 12:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > This bug was reported by Laurent Pinchart (CCed),
> > > who would like it fixed sooner rather than later.
> > 
> > I'm assuming that sentence and me being cc'd means that you'd prefer
> > to get this merged directly rather than go through the usual -tip
> > shenanigans.
> 
> I was good either way, but I have reason to believe that Laurent deeply
> appreciates the direct merge.  ;-)

It fixed a compilation breakage introduced in v5.9 for one of my boards,
so yes :-) Thank you.

> > I've pulled it.
> 
> Thank you!

-- 
Regards,

Laurent Pinchart
