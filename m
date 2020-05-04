Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97775C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6761E206C0
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588618899;
	bh=MZvTpriQkDCS6yqRxLTUdYn57GHFlfAnULhcVOgTV0s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=oOOOWFdzBrHNfHVO0oEH5bMYBHOY994gAvfdcEEwPwBh2gZGc549qvdeGWLOWy2OS
	 Vpq/zLRV/Q77p7sOcPC7ouTUqby11HaaizJac4U5a24YPtDtzBpQ9CwHgqxHAGNGdM
	 rRN9YGDI9+lwhC5T+9FS6m5jhwF/qhcCLZSQatlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEDTBj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 15:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgEDTBj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 15:01:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98170206B8;
        Mon,  4 May 2020 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588618898;
        bh=MZvTpriQkDCS6yqRxLTUdYn57GHFlfAnULhcVOgTV0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kKX+YspymTx4EdBCAjxYqJiqU8K7q7vqO/bLVWsljkl8gg1324SGBiQnFFnAt6yVj
         Nfbe3D+4NtCAhkzP+5un/QtJ/7hC1Xrq80QVrBavvHpcz2Bd+aghzWi4q1nfwgzx0F
         zkik0pTJmG3rLaLcP5FxyylUsIDhx5jEYkQsqqtE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7989F35226F4; Mon,  4 May 2020 12:01:38 -0700 (PDT)
Date:   Mon, 4 May 2020 12:01:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504190138.GU2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
 <20200504180805.GA172409@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504180805.GA172409@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 02:08:05PM -0400, Joel Fernandes wrote:
> On Mon, May 04, 2020 at 07:48:22PM +0200, Uladzislau Rezki wrote:
> > On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
> [..] 
> > > > > Presumably the list can also be accessed without holding this lock,
> > > > > because otherwise we shouldn't need llist...
> > > > > 
> > > > Hm... We increase the number of elements in cache, therefore it is not
> > > > lockless. From the other hand i used llist_head to maintain the cache
> > > > because it is single linked list, we do not need "*prev" link. Also
> > > > we do not need to init the list.
> > > > 
> > > > But i can change it to list_head. Please let me know if i need :)
> > > 
> > > Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> > > callback processing, the operations were open-coded, but they have been
> > > pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> > > 
> > > Maybe some non-atomic/protected/whatever macros in the llist.h file?
> > > Or maybe just open-code the singly linked list?  (Probably not the
> > > best choice, though.)  Add comments stating that the atomic properties
> > > of the llist functions aren't neded?  Something else?
> > >
> > In order to keep it simple i can replace llist_head by the list_head?
> 
> Just to clarify for me, what is the disadvantage of using llist here?

Are there some llist APIs that are not set up for concurrency?  I am
not seeing any.

The overhead isn't that much of a concern, given that these are not on the
hotpath, but people reading the code and seeing the cmpxchg operations
might be forgiven for believing that there is some concurrency involved
somewhere.

Or am I confused and there are now single-threaded add/delete operations
for llist?

> Since we don't care about traversing backwards, isn't it better to use llist
> for this usecase?
> 
> I think Vlad is using locking as we're also tracking the size of the llist to
> know when to free pages. This tracking could suffer from the lost-update
> problem without any locking, 2 lockless llist_add happened simulatenously.
> 
> Also if list_head is used, it will take more space and still use locking.

Indeed, it would be best to use a non-concurrent singly linked list.

							Thanx, Paul

> Thoughts?
> 
> thanks,
> 
>  - Joel
> 
> > > 
> > > The comments would be a good start.  Just to take pity on people seeing
> > > the potential for concurrency and wondering how the concurrent accesses
> > > actually happen.  ;-)
> > > 
> > Sounds like you are kidding me :) 
> > 
> > --
> > Vlad Rezki
