Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DAC433C1
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2CB6193E
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 23:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCSXrw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCSXrb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Mar 2021 19:47:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F28B76196E;
        Fri, 19 Mar 2021 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616197651;
        bh=CPvFu6lE8r2JWmPnLhaUaaNvLziifLOCQg1LPV24JZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhHAfyZo+XDJtkRzqZjcRfiucmfHBqgqnEZsZf5vpCxN2F7bkAVj8EDfc3vctqFdV
         3KaXqOvqBFpy/cD0rgEfyeGLyuf+xlLoY7zg9Y2GSqD3dSrgPZWIYTb4n7ZDQRH70/
         LxQDBDTe9m6mcx6kNcPn/VNpvM3V5rm0RxHQJrlubhRzV+9ooXV8xKPwLVZpW030Dg
         hNCH7D7Y8XNJssnoqVExpJU36D6nDLoHOqSGp7PmTYMp8GUCYi2b1jC4kNIMorhig3
         XvlQCXDSXGDeDoL8shQeiMyWjHwySw9nvGG+s2SjYxGAEDqShR+U+fNDNviC6c9NgD
         ZKyPijWi0hcnA==
Date:   Sat, 20 Mar 2021 00:47:28 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210319234728.GD814853@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
 <20210319135854.GA814853@lothringen>
 <20210319175116.GO2696@paulmck-ThinkPad-P72>
 <20210319221040.GC814853@lothringen>
 <20210319233848.GV2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319233848.GV2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 19, 2021 at 04:38:48PM -0700, Paul E. McKenney wrote:
> > I didn't even think that far.
> > My scenario was:
> > 
> > 1.	cookie = start_poll_synchronize_rcu()
> >  
> >  
> > 2.	cond_synchronize_rcu() checks the cookie and sees that the
> > 	grace period has not yet expired. So it calls synchronize_rcu()
> > 	which queues a callback.
> > 
> > 3.	The grace period for the cookie eventually completes.
> > 
> > 4.	The callback queued in 2. gets assigned a new grace period number.
> > 	That new grace period starts.
> > 
> > 5.	The new grace period completes and synchronize_rcu() returns.
> > 
> > 
> > But I think this is due to some deep misunderstanding from my end.
> 
> You mean like this?
> 
> 	oldstate = start_poll_synchronize_rcu();
> 	// Why wait?  Beat the rush!!!
> 	cond_synchronize_rcu(oldstate);
> 
> This would be a bit silly (why not just call synchronize_rcu()?),
> and yes, this would unconditionally get you an extra RCU grace period.
> Then again, any call to cond_synchronize_rcu() before the desired grace
> period has expired will get you an extra grace period, and maybe more.
> 
> So a given use case either needs to not care about the added latency
> or have a high probability of invoking cond_synchronize_rcu() after
> the desired grace period has expired.

Fair point!

Thanks.
