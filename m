Return-Path: <SRS0=LAXB=AD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA60CC433DF
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B75F2076E
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592855610;
	bh=Pk37DB5gTmRlkyLSKbdhMhYz8yBgnO8vdFTIo8FufqI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dPzf+E5LepZMv/yIbV/uq3RObmpLtwFFT/PiKHEpxm7jp5oNg8wnvW7qCdN3n1SIe
	 Qp1neZq11AEZEPvbK6xELN3t45eD27E0Ig1y2JnqsZt6J2Tlb6u4EZyXuejX3tysgN
	 0QKFXabVkKUUG9oOZXelsVCWUMdXI9ZeEhiyM6sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFVTxa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgFVTx3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 15:53:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A452075A;
        Mon, 22 Jun 2020 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592855609;
        bh=Pk37DB5gTmRlkyLSKbdhMhYz8yBgnO8vdFTIo8FufqI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=102LvjAaeM5gEuJmFB+TgfaS9hA+iL2XSR7pm+FE0WNX58jHaMZXGsyFOE/N6F/oT
         L7fSEXLmnTsTquoUUnQsbwWy0xG8XPvs434WkXHUPRVjCYKOEzEKKrvOWjPZ0ka4uq
         yJbRq9dYRqMRY/CecHiuxMgIzKa1N4GOxQh3xDhg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5CCF63522FA9; Mon, 22 Jun 2020 12:53:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:53:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200622195329.GN9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
 <20200618211709.GA17263@pc636>
 <20200618213427.GV2723@paulmck-ThinkPad-P72>
 <20200619154652.GA19990@pc636>
 <20200619162555.GJ2723@paulmck-ThinkPad-P72>
 <20200622190406.GA3787@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622190406.GA3787@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 09:04:06PM +0200, Uladzislau Rezki wrote:
> > > > 
> > > > Very good.  When does kfree_rcu() and friends move out of kernel/rcu?
> > > > 
> > > Do you mean to move the whole logic of kfree_rcu() from top to down to mm/?
> > 
> > I do mean exactly that.
> > 
> > That was my goal some years back when Rao Shoaib was making the first
> > attempt along these lines, and it remains my goal.  After all, if this
> > effort is at all successful, the coupling between kfree_rcu() with
> > slab/slob/slub will become much tighter than that between kfree_rcu()
> > and RCU.
> > 
> > There will need to be some additional RCU APIs used by kfree_rcu(),
> > for example, something to tell RCU how many blocks are awaiting a
> > grace period.  But these are narrow and easily defined APIs.
> >
> I also think that k[v]free_rcu() should reside somewhere under "mm/".
> Currently they are defined as macros under "linux/rcupdate.h". So i
> am not sure if definitions should stay there or moved also.

I am not as worried about the high-level macros as I am about the code
that does the bulk of the work, but they should still move as well.
Otherwise, changes involving both the macros and the underlying
implementation are harder than needed.

> Implementation of the k[v]free_rcu() is under rcu/tree.c and for tiny
> variant is under rcutiny.h. It can be moved to the mm/slab_common.c
> or independent files can be created. I think, mm people should consult
> what is the best way to go :)
> 
> Any thoughts on it?

I don't have any opinion on exactly where in mm the underlying
implementation code should go.  You suggestion of mm/slab_common.c
seems fine to me.  ;-)

							Thanx, Paul
