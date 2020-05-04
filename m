Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2060C47257
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C550C2063A
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615719;
	bh=qSSPanwBoB9/JQpMTRvAt64HeB1Nngc7+wt849hUqt8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WpEx+IzCK3cAtf7WcGUh3NyCM674/fEJaOyR2mAX+WQjIeCw4ydFE/wdcutLc3pQl
	 MeNaRYQTc6SlFwz6c01Z+e4PYx7UkSOB5h5Tj20tTdmiaATL8gjfxu7X5jjYUEKObS
	 EyIoGdkQ3qmwHJ7xSK/6T7tCKZfjdAf9VbhWdZrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbgEDSHi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 14:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731094AbgEDSHi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 14:07:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620EA206B8;
        Mon,  4 May 2020 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615657;
        bh=qSSPanwBoB9/JQpMTRvAt64HeB1Nngc7+wt849hUqt8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gOJg6N0Wp5t9LhWqGYLQdlvrM4KGIMDVXHt5MuhbymoZ/3c9ufbSMdZ4v7ElfUGP2
         bk4lSTe5mv4yys6Jv2pdJpujGo7i2Mv6UTmnts5leniCOTcyRKUWKg+dq0yhHyBISZ
         AGUsWGxPfyMCmb4hywnL0NSJq1KaBwv2pWOsU0ww=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 437E535226F4; Mon,  4 May 2020 11:07:37 -0700 (PDT)
Date:   Mon, 4 May 2020 11:07:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504180737.GT2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504174822.GA20446@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 07:48:22PM +0200, Uladzislau Rezki wrote:
> On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
> > On Mon, May 04, 2020 at 02:43:23PM +0200, Uladzislau Rezki wrote:
> > > On Fri, May 01, 2020 at 02:27:49PM -0700, Paul E. McKenney wrote:
> > > > On Tue, Apr 28, 2020 at 10:58:48PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > Cache some extra objects per-CPU. During reclaim process
> > > > > some pages are cached instead of releasing by linking them
> > > > > into the list. Such approach provides O(1) access time to
> > > > > the cache.
> > > > > 
> > > > > That reduces number of requests to the page allocator, also
> > > > > that makes it more helpful if a low memory condition occurs.
> > > > > 
> > > > > A parameter reflecting the minimum allowed pages to be
> > > > > cached per one CPU is propagated via sysfs, it is read
> > > > > only, the name is "rcu_min_cached_objs".
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 60 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 89e9ca3f4e3e..d8975819b1c9 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -178,6 +178,14 @@ module_param(gp_init_delay, int, 0444);
> > > > >  static int gp_cleanup_delay;
> > > > >  module_param(gp_cleanup_delay, int, 0444);
> > > > >  
> > > > > +/*
> > > > > + * This rcu parameter is read-only, but can be write also.
> > > > 
> > > > You mean that although the parameter is read-only, you see no reason
> > > > why it could not be converted to writeable?
> > > > 
> > > I added just a note. If it is writable, then we can change the size of the
> > > per-CPU cache dynamically, i.e. "echo 5 > /sys/.../rcu_min_cached_objs"
> > > would cache 5 pages. But i do not have a strong opinion if it should be
> > > writable.
> > > 
> > > > If it was writeable, and a given CPU had the maximum numbr of cached
> > > > objects, the rcu_min_cached_objs value was decreased, but that CPU never
> > > > saw another kfree_rcu(), would the number of cached objects change?
> > > > 
> > > No. It works the way: unqueue the page from cache in the kfree_rcu(),
> > > whereas "rcu work" will put it back if number of objects < rcu_min_cached_objs,
> > > if >= will free the page.
> > 
> > Just to make sure I understand...  If someone writes a smaller number to
> > the sysfs variable, the per-CPU caches will be decreased at that point,
> > immediately during that sysfs write?  Or are you saying something else?
> > 
> This patch defines it as read-only. It defines the minimum threshold that
> controls number of elements in the per-CPU cache. If we decide to make it
> write also, then we will have full of freedom how to define its behavior,
> i.e. it is not defined because it is read only.

And runtime-read-only sounds like an excellent state for it.

> > > > Presumably the list can also be accessed without holding this lock,
> > > > because otherwise we shouldn't need llist...
> > > > 
> > > Hm... We increase the number of elements in cache, therefore it is not
> > > lockless. From the other hand i used llist_head to maintain the cache
> > > because it is single linked list, we do not need "*prev" link. Also
> > > we do not need to init the list.
> > > 
> > > But i can change it to list_head. Please let me know if i need :)
> > 
> > Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> > callback processing, the operations were open-coded, but they have been
> > pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> > 
> > Maybe some non-atomic/protected/whatever macros in the llist.h file?
> > Or maybe just open-code the singly linked list?  (Probably not the
> > best choice, though.)  Add comments stating that the atomic properties
> > of the llist functions aren't neded?  Something else?
> >
> In order to keep it simple i can replace llist_head by the list_head?

Fine by me!

> > The comments would be a good start.  Just to take pity on people seeing
> > the potential for concurrency and wondering how the concurrent accesses
> > actually happen.  ;-)
> > 
> Sounds like you are kidding me :) 

"Only those who have gone too far can possibly tell you how far you
can go!"  ;-)

							Thanx, Paul
