Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5FC4742C
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 04:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE422284
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 04:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="diIfe/kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKPEOL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Nov 2020 23:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgKPEOL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Nov 2020 23:14:11 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7919322284;
        Mon, 16 Nov 2020 04:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605500050;
        bh=+YnyHUfAnTHt3k30OBRWRX4tBtpQ8icOnsVJvj4//OQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=diIfe/kSCi/Bp2k8P952sDEoLYlfI8EPRvfOzW/8aoAgdVi0mCjskdGP+PgWaLvsl
         h+1oOWx2jx+hN1EAmbBfARLCn7KUBfkYiKTNFTgAsMPJsS4+39rziywLVfzN1sZ+Bf
         Ar/YL5oHcxwnsu2AaOKEUw17Deasg0uTk4PM8R5w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 313713522ABD; Sun, 15 Nov 2020 20:14:10 -0800 (PST)
Date:   Sun, 15 Nov 2020 20:14:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: SRCU question
Message-ID: <20201116041410.GP3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201112201547.GF3365678@moria.home.lan>
 <20201115201124.GL3249@paulmck-ThinkPad-P72>
 <20201115202017.GA8197@paulmck-ThinkPad-P72>
 <20201115203551.GA3655723@moria.home.lan>
 <20201115205339.GN3249@paulmck-ThinkPad-P72>
 <20201116012525.GB3655723@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116012525.GB3655723@moria.home.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 15, 2020 at 08:25:25PM -0500, Kent Overstreet wrote:
> On Sun, Nov 15, 2020 at 12:53:39PM -0800, Paul E. McKenney wrote:
> > On Sun, Nov 15, 2020 at 03:35:51PM -0500, Kent Overstreet wrote:
> > > Yeah. My one quibble is, instead of having to call poll_state_synchronize_srcu()
> > > on every cookie - would it be possible to get function that returns a cookie we
> > > can compare against (i.e. with time_after())? I'm going to be use this in the
> > > shrinker where we have to walk and check potentially tens of thousands of
> > > objects.
> > 
> > If the cookies compare equal, poll_state_synchronize_srcu() will treat
> > them the same.  If that does not help, could you please show me a code
> > snippet illustrating what you would like to do?
> > 
> > (Yes, even if equality comparison works, I probably need to give you
> > an API member just in case the nature of grace-period sequence numbers
> > changes in the future.)
> 
> Having just looked at your code - I think it's fine as is. I wouldn't complain
> if it was a static inline, though.

Thank you for taking a look!

My guess is that given the required memory-barrier instructions, the
overhead of the external call is way down in the noise.  But let's see
how the performance and scalability looks in your particular use case,
and if it needs help, base the changes on your actual experience.

							Thanx, Paul

> > > > Oh, and due to historical inertia, Tiny SRCU's grace-period sequence
> > > > number is only 16 bits.  I can change this easily, but I need to know
> > > > that it is a real problem for you before I can do so.
> > > > 
> > > > The potential problem for you is that if you let a given cookie lie
> > > > dormant for 16384 grace periods, it will take another 16385 grace
> > > > periods for get_state_synchronize_srcu() to say that a grace period
> > > > has elapsed.
> > > > 
> > > > In contrast, Tree SRCU's grace-period sequence number is either 32 bits
> > > > or 64 bits, depending on the size of unsized long.
> > > 
> > > It's not something I'd lose sleep over, but I think it could be. If there isn't
> > > memory pressure, then the shrinker won't be running and we won't be freeing the
> > > objects with the oldest cookies, but freeing them internally will be creating
> > > new grace periods - but if I make sure we're reusing objects in LIFO order would
> > > also work against the shrinker actually being able to free any objects, so not
> > > sure I want to do that...
> > 
> > OK, I will leave it, at least until you tell me otherwise.
> > 
> > I probably need to add a warning to the header comment, though...
> > 
> > 							Thanx, Paul
> 
> Thanks! 
