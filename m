Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63998C433E0
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4347C20874
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594912833;
	bh=PPJ9m8c9qSJB+p9W3coV52UIGzOiNECbZW1ePPsr2qM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OEm7CTIccOoiUjqiVKleweKGUbUCr9JbiVWIQYVLg5YcBM54hCJWDf2rVtTm+46+E
	 vPJEla5nxhKbM7MGL+2P3FHlWcvjOxJgeT4lhUSdC0RPd2PD3hu5Bvdac4C7YrukSO
	 F0pl6j7RiVDUEgGazqyWHMgCjLNF6NUxIbPyf2Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgGPPU3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgGPPU1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 11:20:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC4520825;
        Thu, 16 Jul 2020 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594912827;
        bh=PPJ9m8c9qSJB+p9W3coV52UIGzOiNECbZW1ePPsr2qM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IJkS2fSEK6rAbF2nOQXWQ+mlBhg91YptiouLkxoGU2kMdnrFnJEtP6mwTKvWJ5p93
         h2jTbQoHNU63OnRgqnNKBPGBmPTZiNB/6qYUEUGx3Eehf5hNky1gGDduO0hIB3gjWz
         ruJegvsRwZeroGPbM7kUVtYwOTYHlK13iETsA++A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0EA4A3522635; Thu, 16 Jul 2020 08:20:27 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:20:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716152027.GQ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
 <20200715193250.axntj7jdt6bw52dr@linutronix.de>
 <20200715221449.GJ9247@paulmck-ThinkPad-P72>
 <20200716141421.fzwf4tedr6rixd6d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716141421.fzwf4tedr6rixd6d@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 16, 2020 at 04:14:21PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-15 15:14:49 [-0700], Paul E. McKenney wrote:
> > 
> > My concern is that some critical bug will show up at some point
> > that requires double-argument kfree_rcu() be invoked while holding
> > a raw spinlock.  (Single-argument kfree_rcu() must sometimes invoke
> > synchronize_rcu(), so it can never be invoked in any state forbidding
> > invoking schedule().)
> 
> So you are saying as of today we are good but in near future the
> following
>    synchronize_rcu() -> kfree_rcu()
> 
> may be needed?

You lost me on this one.  I am instead concerned that something like this
might be needed on short notice:

	raw_spin_lock(&some_lock);
	kfree_rcu(some_pointer, some_field_offset);

In contrast, single-argument kfree_rcu() cannot be invoked from any
environment where synchronize_rcu() cannot be invoked.

> > Yes, dropping to a plain spinlock would be simple in the here and now,
> > but experience indicates that it is only a matter of time, and that when
> > that time comes it will come as an emergency.
> 
> Hmmm.

I point out the call_rcu() experience.

> > One approach would be to replace the "IS_ENABLED(CONFIG_PREEMPT_RT)"
> > with some sort of check for being in a context where spinlock acquisition
> > is not legal.  What could be done along those lines?
> 
> I would rethink the whole concept how this is implemented now and give
> it another try. The code does not look pretty and is looking
> complicated. The RT covering of this part then just added a simple
> return because nothing else seemed to be possible. This patch here
> looks like another duct tape attempt to avoid a warning.

In addition to the possibility of invocation from BH?

							Thanx, Paul
