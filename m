Return-Path: <SRS0=M2zx=DY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C0EC433DF
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32332075E
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602941398;
	bh=/jOzOnevC0r9iXvoxtFpmNaY48IbREcoifzhqB2cABo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Blfe+CGkgX0F+7NKlADpBxb+ANrau+mG6XwcYRXD6uiukzaZwlmZpYzYMWskfwFuD
	 udbNKIKDvzMB23js9dVR8d3k/oAL84ax4RVneRJb4pf+K+kt8ObJiJdssrL/h/ZY0b
	 x467jmEAw4Z1hGKkLPJzQ1vKwOG1lUj8z5E+ew84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438103AbgJQN36 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 09:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438102AbgJQN36 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 09:29:58 -0400
Received: from localhost (eyr76-h01-176-129-22-47.dsl.sta.abo.bbox.fr [176.129.22.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40B22072D;
        Sat, 17 Oct 2020 13:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602941397;
        bh=/jOzOnevC0r9iXvoxtFpmNaY48IbREcoifzhqB2cABo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClcNGfkrT5ktWbYa+HZsP9DbWXId27nFuBiOoAN9SKsgDZxwcTjLjmQ5t15HaUdE9
         Dm9yk0nHwazU5YX+7jPC2H3DJDvvjDW9qW9Zg7TyiJabButVrFUKWGixUFD/7iDF4k
         YmAY0bQzVFTxH3T+pUCqn1bY4oofM9RidY9h1OnY=
Date:   Sat, 17 Oct 2020 15:29:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com, stern@rowland.harvard.edu
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201017132954.GA15657@lothringen>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
 <20201017031941.GD4015033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017031941.GD4015033@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 16, 2020 at 11:19:41PM -0400, joel@joelfernandes.org wrote:
> On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
> [..]
> > > > + *
> > > > + * Memory barrier is needed after adding to length for the case
> > > > + * where length transitions from 0 -> 1. This is because rcu_barrier()
> > > > + * should never miss an update to the length. So the update to length
> > > > + * has to be seen *before* any modifications to the segmented list. Otherwise a
> > > > + * race can happen.
> > > > + * P0 (what P1 sees)	P1
> > > > + * queue to list
> > > > + *                      rcu_barrier sees len as 0
> > > > + * set len = 1.
> > > > + *                      rcu_barrier does nothing.
> > > 
> > > So that would be:
> > > 
> > >       call_rcu()                    rcu_barrier()
> > >       --                            --
> > >       WRITE(len, len + 1)           l = READ(len)
> > >       smp_mb()                      if (!l)
> > >       queue                            check next CPU...
> > > 
> > > 
> > > But I still don't see against what it pairs in rcu_barrier.
> > 
> > Actually, for the second case maybe a similar reasoning can be applied
> > (control dependency) but I'm unable to come up with a litmus test.
> > In fact, now I'm wondering how is it possible that call_rcu() races with
> > rcu_barrier(). The module should ensure that no more call_rcu() should happen
> > before rcu_barrier() is called.
> > 
> > confused
> 
> So I made a litmus test to show that smp_mb() is needed also after the update
> to length. Basically, otherwise it is possible the callback will see garbage
> that the module cleanup/unload did.
> 
> C rcubarrier+ctrldep
> 
> (*
>  * Result: Never
>  *
>  * This litmus test shows that rcu_barrier (P1) prematurely
>  * returning by reading len 0 can cause issues if P0 does
>  * NOT have a smb_mb() after WRITE_ONCE(len, 1).
>  * mod_data == 2 means module was unloaded (so data is garbage).
>  *)
> 
> { int len = 0; int enq = 0; }
> 
> P0(int *len, int *mod_data, int *enq)
> {
> 	int r0;
> 
> 	WRITE_ONCE(*len, 1);
> 	smp_mb();		/* Needed! */
> 	WRITE_ONCE(*enq, 1);
> 
> 	r0 = READ_ONCE(*mod_data);
> }
> 
> P1(int *len, int *mod_data, int *enq)
> {
> 	int r0;
> 	int r1;
> 
> 	r1 = READ_ONCE(*enq);
> 
> 	// barrier Just for test purpose ("exists" clause) to force the..
> 	// ..rcu_barrier() to see enq before len
> 	smp_mb();		
> 	r0 = READ_ONCE(*len);
> 
> 	// implicit memory barrier due to conditional */
> 	if (r0 == 0)
> 		WRITE_ONCE(*mod_data, 2);
> }

I'm not sure what scenario P1 refers to in practice, and to what module?

> 
> // Did P0 read garbage?
> exists (0:r0=2 /\ 1:r0=0 /\ 1:r1=1)
> 


What also scares me is that in rcu_barrier():

	for_each_possible_cpu(cpu) {
		rdp = per_cpu_ptr(&rcu_data, cpu);
		if (cpu_is_offline(cpu) &&
		    !rcu_segcblist_is_offloaded(&rdp->cblist))
			continue;
		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
			rcu_barrier_trace(TPS("OnlineQ"), cpu,
					  rcu_state.barrier_sequence);
			smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
		} else if (rcu_segcblist_n_cbs(&rdp->cblist) &&
			   cpu_is_offline(cpu)) {
			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu,
					  rcu_state.barrier_sequence);
			local_irq_disable();
			rcu_barrier_func((void *)cpu);
			local_irq_enable();
		} else if (cpu_is_offline(cpu)) {
			rcu_barrier_trace(TPS("OfflineNoCBNoQ"), cpu,
					  rcu_state.barrier_sequence);
		} else {
			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
					  rcu_state.barrier_sequence);
		}
	}

I can't find something that makes sure this isn't racy while reading
rcu_segcblist_n_cbs(&rdp->cblist).

I mean what I see sums up to this:

      CPU 0                                CPU 1
      rcu_barrier()                        call_rcu()/rcu_segcblist_enqueue()
      ------------                         --------

                                           smp_mb();
                                           inc_len();
					   smp_mb();
					   queue callback;
      for_each_possible_cpu(cpu)
          if (!rcu_segcblist_n_cbs(&rdp->cblist))
	      continue;

It looks possible for rcu_barrier() to believe there is no callback enqueued
and see rcu_segcblist_n_cbs(&rdp->cblist) == 0 here.

I'm very likely missing something obvious somewhere.
