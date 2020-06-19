Return-Path: <SRS0=nBXm=AA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE59C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F016B21707
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583964;
	bh=4cT/7aBJ0gbHHMfWq2GsMKBGTtJ30AaC0CtyyiFC1Q0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=B9gwW41GZqNad3X3HtuWyv11ct2AIHSi8cC9QgqhMM+MpNV7QYeJrLXRCXK6WOnPq
	 dCqN4vkIGSbB+wfc05GC5bG5OUJUJtjsdCfJmzZwTBk4zfSKAk4W4pLeT0GQrSKzA3
	 xQlGHOKioLYQKXon7AO6J2WMLUakom7YqOLot3xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394849AbgFSQ0C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394842AbgFSQZz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Jun 2020 12:25:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439A821707;
        Fri, 19 Jun 2020 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592583955;
        bh=4cT/7aBJ0gbHHMfWq2GsMKBGTtJ30AaC0CtyyiFC1Q0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gLEfZuWqzaxnPGvf75NZyqxBXjjXQQvHJzhyKqiNePeBOR8dv1VioaTBtwNe6LEEA
         k6L2pLHcTkkNutWKZKL9Jsbv+/6Q8l5bIbLsFS7AdeRtfT1dPhgTWjZYHSxm2BSxFk
         1OzbXraodv4bk9zyLgE58LlbC8kLLSSgwo2mbc80=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 248AE35229B4; Fri, 19 Jun 2020 09:25:55 -0700 (PDT)
Date:   Fri, 19 Jun 2020 09:25:55 -0700
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
Message-ID: <20200619162555.GJ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
 <20200618211709.GA17263@pc636>
 <20200618213427.GV2723@paulmck-ThinkPad-P72>
 <20200619154652.GA19990@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619154652.GA19990@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 19, 2020 at 05:46:52PM +0200, Uladzislau Rezki wrote:
> On Thu, Jun 18, 2020 at 02:34:27PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 18, 2020 at 11:17:09PM +0200, Uladzislau Rezki wrote:
> > > > > <snip>
> > > > >     trace_rcu_invoke_kfree_bulk_callback(
> > > > >         rcu_state.name, bkvhead[i]->nr_records,
> > > > >             bkvhead[i]->records);
> > > > >     if (i == 0)
> > > > >         kfree_bulk(bkvhead[i]->nr_records,
> > > > >             bkvhead[i]->records);
> > > > >     else
> > > > >         vfree_bulk(bkvhead[i]->nr_records,
> > > > >             bkvhead[i]->records);
> > > > > <snip>
> > > > > 
> > > > > Matthew, what is your thought?
> > > > 
> > > > That was my thinking too.  If we had a kvfree_bulk(), I would expect it to
> > > > handle a mixture of vfree and kfree, but you've segregated them already.
> > > > So I think this is better.
> > > >
> > > Yes, the segregation is done. Having vfree_bulk() is enough then.
> > > We are on the same page :)
> > 
> > Very good.  When does kfree_rcu() and friends move out of kernel/rcu?
> > 
> Do you mean to move the whole logic of kfree_rcu() from top to down to mm/?

I do mean exactly that.

That was my goal some years back when Rao Shoaib was making the first
attempt along these lines, and it remains my goal.  After all, if this
effort is at all successful, the coupling between kfree_rcu() with
slab/slob/slub will become much tighter than that between kfree_rcu()
and RCU.

There will need to be some additional RCU APIs used by kfree_rcu(),
for example, something to tell RCU how many blocks are awaiting a
grace period.  But these are narrow and easily defined APIs.

							Thanx, Paul
