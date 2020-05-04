Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941BC28CBC
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4CF2073B
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588552018;
	bh=W6t3E4EZJAnQ4nVRYsdBeojJbKvYJRy93rI6IDIiy4c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=l1RGgMST9d/La74jFtq1qqTEnlk/UsZIOtdd8OAQbK2uLQvNlmLznrMLKs+9xuCY3
	 nKhGWtsTZ1VwcXfBEhuH1b1mqaaYeuaxO3QPYhEYVWh/9penoNJd3oNxSamWWQCRwC
	 JO0A2dxRAjqFEbU+L2eOsfe/pHPw7gH8yRVfVDS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEDA05 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgEDA05 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 3 May 2020 20:26:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A9A20735;
        Mon,  4 May 2020 00:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588552016;
        bh=W6t3E4EZJAnQ4nVRYsdBeojJbKvYJRy93rI6IDIiy4c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cWo5gYokFtgi+jPhd48Yh9ZFJ5Jf2Pc5T4QxayhrbPoo4GFSLIaqfMxwHLQC3Vt9k
         dn3GUV3GHT2HI39opOpDmuv+HwbawDxMAVlCd7layBR95viYKAiV3r1R76otGHXl+j
         zVOxAoO6sCo7enlCIjtAlGQbXmQaWIXp8nItjFQk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 416433520D7D; Sun,  3 May 2020 17:26:56 -0700 (PDT)
Date:   Sun, 3 May 2020 17:26:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
Message-ID: <20200504002656.GE2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-4-urezki@gmail.com>
 <20200501190555.GB7560@paulmck-ThinkPad-P72>
 <20200503235213.GC197097@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503235213.GC197097@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 07:52:13PM -0400, Joel Fernandes wrote:
> On Fri, May 01, 2020 at 12:05:55PM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > > with majority of commenting styles.
> > > 
> > > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > Hmmm...
> > 
> > Exactly why is three additional characters per line preferable?  Or in
> > the case of block comments, either one or two additional lines, depending
> > on /* */ style?
> 
> I prefer to keep the code consistent and then bulk convert it later. Its a
> bit ugly to read when its mixed up with "//" and "/* */" right now. We can
> convert it to // all at once later but until then it'll be good to keep it
> consistent in this file IMO. When I checked the kfree_rcu() code, it had more
> "/* */" than not, so this small change is less churn for now.

Please just drop this patch along with the other "//"-to-"/* */"
regressions.

If you want to convert more comments to "//" within the confines of the
kfree_rcu() code, I am probably OK with that.  But again, a big-bang
change of this sort often causes problems due to lots of potential
rebase/merge conflicts.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 
> > I am (slowly) moving RCU to "//" for those reasons.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/tree.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index cd61649e1b00..1487af8e11e8 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3043,15 +3043,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > >  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > >  					  unsigned long flags)
> > >  {
> > > -	// Attempt to start a new batch.
> > > +	/* Attempt to start a new batch. */
> > >  	krcp->monitor_todo = false;
> > >  	if (queue_kfree_rcu_work(krcp)) {
> > > -		// Success! Our job is done here.
> > > +		/* Success! Our job is done here. */
> > >  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > >  		return;
> > >  	}
> > >  
> > > -	// Previous RCU batch still in progress, try again later.
> > > +	/* Previous RCU batch still in progress, try again later. */
> > >  	krcp->monitor_todo = true;
> > >  	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > @@ -3151,14 +3151,14 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	unsigned long flags;
> > >  	struct kfree_rcu_cpu *krcp;
> > >  
> > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > +	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
> > >  	krcp = this_cpu_ptr(&krc);
> > >  	if (krcp->initialized)
> > >  		raw_spin_lock(&krcp->lock);
> > >  
> > > -	// Queue the object but don't yet schedule the batch.
> > > +	/* Queue the object but don't yet schedule the batch. */
> > >  	if (debug_rcu_head_queue(head)) {
> > > -		// Probable double kfree_rcu(), just leak.
> > > +		/* Probable double kfree_rcu(), just leak. */
> > >  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > >  			  __func__, head);
> > >  		goto unlock_return;
> > > @@ -3176,7 +3176,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  
> > >  	WRITE_ONCE(krcp->count, krcp->count + 1);
> > >  
> > > -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > > +	/* Set timer to drain after KFREE_DRAIN_JIFFIES. */
> > >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > >  	    !krcp->monitor_todo) {
> > >  		krcp->monitor_todo = true;
> > > @@ -3722,7 +3722,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> > >  
> > >  	rcutree_affinity_setting(cpu, cpu);
> > >  
> > > -	// nohz_full CPUs need the tick for stop-machine to work quickly
> > > +	/* nohz_full CPUs need the tick for stop-machine to work quickly */
> > >  	tick_dep_set(TICK_DEP_BIT_RCU);
> > >  	return 0;
> > >  }
> > > -- 
> > > 2.20.1
> > > 
