Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF17C433F5
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A88F60F59
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhJDNpE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238453AbhJDNoS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 09:44:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D129B61131;
        Mon,  4 Oct 2021 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633354949;
        bh=/8iZzTtmsHYUkmsxL8GSKc9qVHlbpx/Af92XUl8iCso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvoGvGQOTW9ULseoyvoIXaUUN8QFTb9gvg6l//174Uf4QuP6uP++UlBx7VlAAXELH
         yCCfuA2ozOEq3blvhIXFebe6glcVw6uhQx4L0vdYzrtYEA3/4zGe+BMFwwUA+jDNFF
         IwFy0NNxXf9GxpRk0zB4AC0bSFChKfbAfH2Iq3zNJqag3xNuT0CeDPogIpHnFt245l
         Zm32c61wY6OTNrw6vZJqYmGF52XMjGnv2Wddv5imsWLJIhizqvTu+N8EIye2upxzhm
         8AKQEy6O6rw+IVXIh1XjlgNmWHBk3DvE4cgJUwXDIKbP9Ws0qX5M5BLRoFkSdrQSfn
         qc/pAFlvs0hZQ==
Date:   Mon, 4 Oct 2021 15:42:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 08/11] rcu/nocb: Limit number of softirq callbacks only
 on softirq
Message-ID: <20211004134227.GC273854@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-9-frederic@kernel.org>
 <877dewmy5v.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dewmy5v.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 01, 2021 at 06:51:08PM +0100, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
> > The current condition to limit the number of callbacks executed in a
> > row checks the offloaded state of the rdp. Not only is it volatile
> > but it is also misleading: the rcu_core() may well be executing
> > callbacks concurrently with NOCB kthreads, and the offloaded state
> > would then be verified on both cases. As a result the limit would
> > spuriously not apply anymore on softirq while in the middle of
> > (de-)offloading process.
> >
> > Another issue with the condition is that rcu_is_callbacks_kthread()
> > doesn't check if we are actually running callbacks from rcuc itself or
> > from a softirq interrupting rcuc.
> >
> 
> Doesn't rcutree.use_softirq imply rcuc is never woken, in which case
> RCU_SOFTIRQ can't interrupt rcuc (e.g. while run atop an IRQ exit)?
> I suppose during the (de)offload sequence we could have RCU_SOFTIRQ running
> atop the NOCB CB kthread, but that's not something
> rcu_is_callbacks_kthread() detects.

Yes good point, I don't know if rcuc can be ever be interrupted by
irq_exit() -> do_softirq() -> rcu_core() itself after all.

Paul can probably confirm your point?

> 
> Also, why is rcu_is_callbacks_kthread() hardcoded to false for
> !CONFIG_RCU_BOOST? Isn't it relevant for do_rcu_batch() ratelimiting
> regardless (at least before your patches)?

I believe rcuc is only used on CONFIG_RCU_BOOST?
