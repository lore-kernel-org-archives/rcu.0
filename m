Return-Path: <SRS0=ktYI=AL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171FC433E1
	for <rcu@archiver.kernel.org>; Tue, 30 Jun 2020 18:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7045A206C3
	for <rcu@archiver.kernel.org>; Tue, 30 Jun 2020 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593542138;
	bh=RYKTZT8L2YCF69DV1EdcAmR1v9iwHZlvoOwk9RIUBfI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jPAlhHy1c/4JMgHxBQXmd4MJDc/LfsWcIdvKQj/LCoPptfvKmjGw34jXhrX/nm/+Y
	 F1utDa3hgJQQPxBMB3RbtN++E/sdTqOL4XrCIgjvRVQ62WO6L9kKeBv/KAfSszoQPk
	 ZyKv2HIYGWvGyIs9q4qpr3qN9M6Pe6FUlh5JITKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgF3Sff (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgF3Sff (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jun 2020 14:35:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66392068F;
        Tue, 30 Jun 2020 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593542134;
        bh=RYKTZT8L2YCF69DV1EdcAmR1v9iwHZlvoOwk9RIUBfI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jo7cYQcSnqavmJu3py5reMUEBjHqYsP72S5+fGaXFuuliQXf7MQYLdi8xzpH6+94s
         yOpBKjGschI641wSf53+P5BFQnemkANvqB/pnhkl8YlF25Q+M5ykes5xA3/hcfIss2
         1gLogO1nUHFCaKYCML6eGu8CDKtrccY50qPfZMmw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74B173522640; Tue, 30 Jun 2020 11:35:34 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:35:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200630183534.GG9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 30, 2020 at 06:45:43PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-24 13:12:12 [-0700], paulmck@kernel.org wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > To keep the kfree_rcu() code working in purely atomic sections on RT,
> > such as non-threaded IRQ handlers and raw spinlock sections, avoid
> > calling into the page allocator which uses sleeping locks on RT.
> > 
> > In fact, even if the  caller is preemptible, the kfree_rcu() code is
> > not, as the krcp->lock is a raw spinlock.
> > 
> > Calling into the page allocator is optional and avoiding it should be
> > Ok, especially with the page pre-allocation support in future patches.
> > Such pre-allocation would further avoid the a need for a dynamically
> > allocated page in the first place.
> > 
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 64592b4..dbdd509 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3184,6 +3184,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> >  		if (!bnode) {
> >  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> >  
> > +			/*
> > +			 * To keep this path working on raw non-preemptible
> > +			 * sections, prevent the optional entry into the
> > +			 * allocator as it uses sleeping locks. In fact, even
> > +			 * if the caller of kfree_rcu() is preemptible, this
> > +			 * path still is not, as krcp->lock is a raw spinlock.
> > +			 * With additional page pre-allocation in the works,
> > +			 * hitting this return is going to be much less likely.
> > +			 */
> > +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +				return false;
> 
> This is not going to work together with the "wait context validator"
> (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> printk() which is why it is still disabled by default.

Fixing that should be "interesting".  In particular, RCU CPU stall
warnings rely on the raw spin lock to reduce false positives due
to race conditions.  Some thought will be required here.

> So assume that this is fixed and enabled then on !PREEMPT_RT it will
> complain that you have a raw_spinlock_t acquired (the one from patch
> 02/17) and attempt to acquire a spinlock_t in the memory allocator.

Given that the slab allocator doesn't acquire any locks until it gets
a fair way in, wouldn't it make sense to allow a "shallow" allocation
while a raw spinlock is held?  This would require yet another GFP_ flag,
but that won't make all that much of a difference in the total.  ;-)

							Thanx, Paul

> >  			bnode = (struct kfree_rcu_bulk_data *)
> >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >  		}
> 
> Sebastian
