Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C30C4724C
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 17:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19C5206A5
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588612123;
	bh=ypOPsyYM0K55BJG1G3egFRLHvuXBDVqQU1VVRfu/SmI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zKvn+1sbjT1Nkt/4MbAKQmNYQfaXPMA6sWHSGahxpeZnlgmcvIgFrqR4GHIhaiYTk
	 6t86dAwBG/YsL55gNLSARR9xY9CTlxPP2rmckT7yrj1KlZCtz9F74E9lV/wKr3MLw8
	 L3mHf09HfxY5UOKytjGcf7thcWJqaSKIRVvbBLuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgEDRIg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 13:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbgEDRId (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 13:08:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E098206A5;
        Mon,  4 May 2020 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588612113;
        bh=ypOPsyYM0K55BJG1G3egFRLHvuXBDVqQU1VVRfu/SmI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RKfXMVsYI9cCeE5MKGX2AOl3oY35VW2WB/58+/IOr+d/JQXue/IaiKgqmCgOJGm4B
         i+jF5WKXBlxuVVX6hEYowk7XZ289PQhVgg+ULfZQmrw2XXU2ASjIWgXOdSP+cQ/3F9
         SVOSM/N5viQjLNYhnu2DJrfCMGi/kotafxgWEzDQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3AA7835226F4; Mon,  4 May 2020 10:08:33 -0700 (PDT)
Date:   Mon, 4 May 2020 10:08:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 19/24] rcu/tree: Support reclaim for head-less object
Message-ID: <20200504170833.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-20-urezki@gmail.com>
 <20200501223909.GF7560@paulmck-ThinkPad-P72>
 <20200504001258.GD197097@google.com>
 <20200504002855.GF2869@paulmck-ThinkPad-P72>
 <20200504003237.GD212435@google.com>
 <20200504142153.GG17577@pc636>
 <20200504153147.GL2869@paulmck-ThinkPad-P72>
 <20200504165629.GA20257@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504165629.GA20257@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 06:56:29PM +0200, Uladzislau Rezki wrote:
> > > 
> > > For single argument we can drop the lock before the entry to the page
> > > allocator. Because it follows might_sleep() anotation we avoid of having
> > > a situation when spinlock(rt mutex) is taken from any atomic context.
> > > 
> > > Since the lock is dropped the current context can be interrupted by
> > > an IRQ which in its turn can also call kvfree_rcu() on current CPU.
> > > In that case it must be double argument(single is not allowed) kvfree_rcu()
> > > call. For PREEMPT_RT if no cache everything is reverted to rcu_head usage,
> > > i.e. the entry to page allocator is bypassed.
> > > 
> > > It can be addressed as a separate patch and send out later on if we
> > > are on the same page.
> > > 
> > > Paul, Joel what are your opinions?
> > 
> > I strongly prefer that it be removed from the series.  I do understand
> > that this is a bit more hassle right now, but this does help avoid
> > confusion in the future, plus perhaps also avoiding issues with future
> > bisections.
> > 
> We have already decided to get rid of it, i mean small allocations(dynamic
> rcu_head attaching). I will exclude it from next patch-set version. 

Very good, and thank you!!!

							Thanx, Paul
