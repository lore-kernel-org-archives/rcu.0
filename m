Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860FC433E1
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B62070E
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594917413;
	bh=az0IyH/7x50ZeNPAUBePv3DYZTSReLjZFD9XTeIEdMg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Gqo2iTdvB7KL094uksr3qXrhdLfODxD7x/f3PajVvf9iNw1DuIevS/194j0Rm9KK8
	 DROmmBnKz5w+WcKpa/RAZSLBqoPGmEvAprk8VPUBtTTXM0Z/1DdGuDWQmPebSJQNcZ
	 z0PFGiM0gIqVYRhqqV4pzFrGxwKS3Tk6eAB/9Cns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGPQgw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQgw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 12:36:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD932065E;
        Thu, 16 Jul 2020 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594917412;
        bh=az0IyH/7x50ZeNPAUBePv3DYZTSReLjZFD9XTeIEdMg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TZBjx7mZCeZ9BIBXrD9gII+gVHCj93c1xcflS6+SWNZ0wLRaxTPUdCajWbQEOTSvF
         l9Kt9BceI6B8WOacBdoI1raEy/zfmGahLNzxFnEOJ3xU6PkUty/6kRqW40aEqF3QLG
         gcUtvjZGj2+6sTZk9/CxBdyjSkn7SxbKysrEfikA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C99A73522635; Thu, 16 Jul 2020 09:36:51 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:36:51 -0700
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
Message-ID: <20200716163651.GT9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
 <20200715193250.axntj7jdt6bw52dr@linutronix.de>
 <20200715221449.GJ9247@paulmck-ThinkPad-P72>
 <20200716141421.fzwf4tedr6rixd6d@linutronix.de>
 <20200716152027.GQ9247@paulmck-ThinkPad-P72>
 <20200716153638.gfh6dzp2h35ygfaa@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716153638.gfh6dzp2h35ygfaa@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 16, 2020 at 05:36:38PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-16 08:20:27 [-0700], Paul E. McKenney wrote:
> > You lost me on this one.  I am instead concerned that something like this
> > might be needed on short notice:
> > 
> > 	raw_spin_lock(&some_lock);
> > 	kfree_rcu(some_pointer, some_field_offset);
> > 
> > In contrast, single-argument kfree_rcu() cannot be invoked from any
> > environment where synchronize_rcu() cannot be invoked.
> 
> I see. We don't have any kfree() in that context as far as I remember.
> We had a few cases in "resize" where you allocate memory, copy content
> and free old memory while under the lock but they are gone.

True, but we also didn't have any calls to call_rcu() prior to the call
to rcu_init() until suddenly we did.  (Yeah, I could have put my foot
down and prohibited that practice, but the workarounds were quite a bit
more complicated than just making call_rcu() work during very early boot.)

And last I checked, there really were calls to call_rcu() under raw
spinlocks, so the potential or calls to double-argument kfree_rcu()
clearly exists and is very real.

> > > > Yes, dropping to a plain spinlock would be simple in the here and now,
> > > > but experience indicates that it is only a matter of time, and that when
> > > > that time comes it will come as an emergency.
> > > 
> > > Hmmm.
> > 
> > I point out the call_rcu() experience.
> > 
> > > > One approach would be to replace the "IS_ENABLED(CONFIG_PREEMPT_RT)"
> > > > with some sort of check for being in a context where spinlock acquisition
> > > > is not legal.  What could be done along those lines?
> > > 
> > > I would rethink the whole concept how this is implemented now and give
> > > it another try. The code does not look pretty and is looking
> > > complicated. The RT covering of this part then just added a simple
> > > return because nothing else seemed to be possible. This patch here
> > > looks like another duct tape attempt to avoid a warning.
> > 
> > In addition to the possibility of invocation from BH?
> 
> Invocation from BH should be possible because network would probably be
> the first user. I don't remember anything wrong with BH if I remember
> correctly.

OK, that is reassuring.  Here is hoping!

							Thanx, Paul
