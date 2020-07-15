Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E9BC433EB
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 22:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB59B2072E
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594851301;
	bh=CUZJ25Szi3C99xPXb1iXVJJARRC12tD/b1ygd9NAdUQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jE6H6LU1oau7wOj9+gL73V02fCfNf1kKONDAktrctaydEay434BRPtFLRfZS62MnC
	 K4p0mNQ7O29lqh4DIN+p/U+Ek+DvrBpTy70Ym5yFvLuHCGZv0AlO6DBs8FrY0DRAam
	 MAYcNuULtZ19zWB1rHWFyFPRYC2wJXT6YB+IEjvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGOWOv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgGOWOu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 18:14:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83FE72065F;
        Wed, 15 Jul 2020 22:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594851289;
        bh=CUZJ25Szi3C99xPXb1iXVJJARRC12tD/b1ygd9NAdUQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dY5oTNj0X17RH9aW4Nv23OmusgZCXcHgxD5lbUTTasH6D9BhuT9n1DJHeiAYIRmBM
         d9gOnEiKmvaiv2isIrQaDOsJuu8TQfOp6SH/VjECxcfwo1q5M/BOkYeAAKYjqyAc4N
         iVwx8IHOXCPCMqCeZWrr6V/ytkn+pk8b5GCQ+584=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 65E8935229F4; Wed, 15 Jul 2020 15:14:49 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:14:49 -0700
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
Message-ID: <20200715221449.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
 <20200715193250.axntj7jdt6bw52dr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715193250.axntj7jdt6bw52dr@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 15, 2020 at 09:32:50PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-15 21:02:43 [+0200], Uladzislau Rezki wrote:
> > 
> > <snip>
> >     spin_lock();
> >     __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >     spin_unlock();
> > <snip>
> > 
> > Also, please note we do it for regular kernel.
> 
> ach right okay then.
> 
> > >
> > > What happened to the part where I asked for a spinlock_t?
> > > 
> > What do you mean?
> 
> Please drop that raw_spinlock_t for the kfree_rcu() based locking and
> use just a plain spinlock_t for the locking. Then you can keep the same
> code flow for RT and !RT without any special cases and everything.

My concern is that some critical bug will show up at some point
that requires double-argument kfree_rcu() be invoked while holding
a raw spinlock.  (Single-argument kfree_rcu() must sometimes invoke
synchronize_rcu(), so it can never be invoked in any state forbidding
invoking schedule().)

Yes, dropping to a plain spinlock would be simple in the here and now,
but experience indicates that it is only a matter of time, and that when
that time comes it will come as an emergency.

One approach would be to replace the "IS_ENABLED(CONFIG_PREEMPT_RT)"
with some sort of check for being in a context where spinlock acquisition
is not legal.  What could be done along those lines?

							Thanx, Paul
