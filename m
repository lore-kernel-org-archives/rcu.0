Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADBCC3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FC82073B
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588606308;
	bh=A+Wg6eINNCOwpBUPq6wuAXpzjxrFpdtTuyxWoRzfZWo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lXAoDsikKf6f7sSC+17MjdeT7JiMvMZBvdumTxS3wVQQr+xvh2W8oK4WgZ7MNLA84
	 YGnnksY9K3WvXyM9bfeUpg+7cW8Ha9b0pkF0lGdtiaARj+vI4G0/9vga/sbB4jdx1F
	 upoTqIQT4S2uKQLTBJyLs1WvKNGCS4G4uQoVYzqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgEDPbs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 11:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgEDPbs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 11:31:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C2B206B9;
        Mon,  4 May 2020 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588606307;
        bh=A+Wg6eINNCOwpBUPq6wuAXpzjxrFpdtTuyxWoRzfZWo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=izahuf1wNxw8JN6DemPEtNR3xVeeHd63bAVZyT9L5CIqVtDcAx7CQ/kmV8aA2tZCh
         zDNhnDvK3YBK+9+xaaJnanfjpmZ0qKkFv6mw/vpRCifUB8ToVoY85fUVjQYKGnYMXD
         jNZ88FZMBQSrq9ZYfYoWtNm0DG78g+cIsG6/c5ZQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 53FB835226F4; Mon,  4 May 2020 08:31:47 -0700 (PDT)
Date:   Mon, 4 May 2020 08:31:47 -0700
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
Message-ID: <20200504153147.GL2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-20-urezki@gmail.com>
 <20200501223909.GF7560@paulmck-ThinkPad-P72>
 <20200504001258.GD197097@google.com>
 <20200504002855.GF2869@paulmck-ThinkPad-P72>
 <20200504003237.GD212435@google.com>
 <20200504142153.GG17577@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504142153.GG17577@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 04:21:53PM +0200, Uladzislau Rezki wrote:
> > > > 
> > > > If we are not doing single-pointer allocation, then that would also eliminate
> > > > entering the low-level page allocator for single-pointer allocations.
> > > > 
> > > > Or did you mean entry into the allocator for the full-page allocations
> > > > related to the pointer array for PREEMPT_RT? Even if we skip entry into the
> > > > allocator for those, we will still have additional caching which further
> > > > reduces chances of getting a full page. In the event of such failure, we can
> > > > simply queue the rcu_head.
> > > > 
> > > > Thoughts?
> > > 
> > > I was just trying to guess why you kept the single-pointer allocation.
> > > It looks like I guessed wrong.  ;-)
> > > 
> > > If, as you say above, you make it go straight to synchronize_rcu()
> > > upon full-page allocation failure, that would be good!
> > 
> > Paul, sounds good. Vlad, are you also Ok with that?
> > 
> OK, let's drop it and keep it simple :)
> 
> BTW, for PREEMPT_RT we still can do a page allocation for single
> argument of kvfree_rcu(). In case of double we just revert everything
> to the rcu_head if no cache.
> 
> For single argument we can drop the lock before the entry to the page
> allocator. Because it follows might_sleep() anotation we avoid of having
> a situation when spinlock(rt mutex) is taken from any atomic context.
> 
> Since the lock is dropped the current context can be interrupted by
> an IRQ which in its turn can also call kvfree_rcu() on current CPU.
> In that case it must be double argument(single is not allowed) kvfree_rcu()
> call. For PREEMPT_RT if no cache everything is reverted to rcu_head usage,
> i.e. the entry to page allocator is bypassed.
> 
> It can be addressed as a separate patch and send out later on if we
> are on the same page.
> 
> Paul, Joel what are your opinions?

I strongly prefer that it be removed from the series.  I do understand
that this is a bit more hassle right now, but this does help avoid
confusion in the future, plus perhaps also avoiding issues with future
bisections.

							Thanx, Paul
