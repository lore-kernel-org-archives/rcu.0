Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B6C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BD1207DD
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592503041;
	bh=CpFWwPudG4VycBDt9MHz0afTFmGzYGQJeQyidiFbwYs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vg/j5gvECBaUTDsKS4oXDN9uSHf23YzlabvDKzdbBJtBzs1zBOiTaFFNZ/OarwQXs
	 ys1exEASdSJ339Mcyq5kBfPiOpZ0LSeV0xEaU6ONfsPxZJvaYu1SC0+0p+xAuUoNKF
	 wJUIejHVqOkdW4vMKHn5ici3NtcXG0q95PW8Fx+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFRR5V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgFRR5U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 13:57:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C6620734;
        Thu, 18 Jun 2020 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592503040;
        bh=CpFWwPudG4VycBDt9MHz0afTFmGzYGQJeQyidiFbwYs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0DoXDyQAFSO+Ybw3F297GmKIj0ze8moUADsxYo/i5hyigIMYA14F8u0iRPJX1xyFV
         mnGcnaVHDXnobaD3k540slOUnK1d89LPoVmU/04UASXSNgXJilT/bmZ4vHjSH5psPj
         mXCZwTnOR2HEQl/UlYjIaXWleUuHqz8AqdbPBXMc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0309B35229B4; Thu, 18 Jun 2020 10:57:20 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:57:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618175719.GT2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618173520.GC14613@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 07:35:20PM +0200, Uladzislau Rezki wrote:
> > > 
> > > I don't think that replacing direct function calls with indirect function
> > > calls is a great suggestion with the current state of play around branch
> > > prediction.
> > > 
> > > I'd suggest:
> > > 
> > >  			rcu_lock_acquire(&rcu_callback_map);
> > > 			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> > > 				bkvhead[i]->nr_records, bkvhead[i]->records);
> > >  			if (i == 0) {
> > >  				kfree_bulk(bkvhead[i]->nr_records,
> > >  					bkvhead[i]->records);
> > >  			} else {
> > >  				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > >  					vfree(bkvhead[i]->records[j]);
> > >  				}
> > >  			}
> > >  			rcu_lock_release(&rcu_callback_map);
> > > 
> > > But I'd also suggest a vfree_bulk be added.  There are a few things
> > > which would be better done in bulk as part of the vfree process
> > > (we batch them up already, but i'm sure we could do better).
> > 
> > I suspect that he would like to keep the tracing.
> > 
> > It might be worth trying the branches, given that they would be constant
> > and indexed by "i".  The compiler might well remove the indirection.
> > 
> > The compiler guys brag about doing so, which of course might or might
> > not have any correlation to a given compiler actually doing so.  :-/
> > 
> > Having a vfree_bulk() might well be useful, but I would feel more
> > confidence in that if there were other callers of kfree_bulk().
> >
> Hmm... I think replacing that with vfree_bulk() is a good idea though.

In other words, get rid of kfree_bulk() in favor of vfree_bulk()?

> > But again, either way, future work as far as this series is concerned.
> > 
> What do you mean: is concerned?

Apologies for the strange English.  How about this?

"This series is OK as is.  Any comments above did not prevent me from
taking these patches, but instead discuss possible future work."

> We are planning to implement kfree_rcu() to be integrated directly into
> SLAB: SLAB, SLUB, SLOB. So, there are plenty of future work :)

And I am glad that this is still the goal.  ;-)

							Thanx, Paul
