Return-Path: <SRS0=q8Vp=D2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F5BC433DF
	for <rcu@archiver.kernel.org>; Mon, 19 Oct 2020 12:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B5B22276
	for <rcu@archiver.kernel.org>; Mon, 19 Oct 2020 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603111055;
	bh=Iiq9JtMOsAzTZh0V4bf3ztUsJiRzQ+KheGJpFKUaSP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VrHWYqUItY5TZW2l33HumkEXKhfR6GEHKGzA9EjRf1tCRF8GOm927FQTAGeX+o5BX
	 1CJD3u+mH1mzKV5UoNDAjuSsl/x6y99xIxtlMWgFdFpXEmyyiSML3mlmbvBmk6R7un
	 WfBdSdN6GYReH6f+GsX6/tkHQ+XP5uOKKycgg/pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgJSMhf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Oct 2020 08:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgJSMhf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Oct 2020 08:37:35 -0400
Received: from localhost (unknown [176.167.103.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40ED521D81;
        Mon, 19 Oct 2020 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603111053;
        bh=Iiq9JtMOsAzTZh0V4bf3ztUsJiRzQ+KheGJpFKUaSP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syCvgVxnNpKL/qRzlhkGd4WZGvKfBQbT7Ye1Ov4mfK1W3lXc+cQw85f/ODtd/11Er
         QaAciK+luw1A6HbC7Pjl/WJcq8+oDTlB88mfAZpuhAVeypEBTLmPciAFoGOEgRVRWH
         3HG6WtupXGc6aT1G8cJIoTvG5R94h2M7APBgcN+Y=
Date:   Mon, 19 Oct 2020 14:37:30 +0200
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
Message-ID: <20201019123730.GA34192@lothringen>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
 <20201017031941.GD4015033@google.com>
 <20201017132954.GA15657@lothringen>
 <20201018003556.GA1034551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018003556.GA1034551@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 17, 2020 at 08:35:56PM -0400, joel@joelfernandes.org wrote:
> On Sat, Oct 17, 2020 at 03:29:54PM +0200, Frederic Weisbecker wrote:
> > > C rcubarrier+ctrldep
> > > 
> > > (*
> > >  * Result: Never
> > >  *
> > >  * This litmus test shows that rcu_barrier (P1) prematurely
> > >  * returning by reading len 0 can cause issues if P0 does
> > >  * NOT have a smb_mb() after WRITE_ONCE(len, 1).
> > >  * mod_data == 2 means module was unloaded (so data is garbage).
> > >  *)
> > > 
> > > { int len = 0; int enq = 0; }
> > > 
> > > P0(int *len, int *mod_data, int *enq)
> > > {
> > > 	int r0;
> > > 
> > > 	WRITE_ONCE(*len, 1);
> > > 	smp_mb();		/* Needed! */
> > > 	WRITE_ONCE(*enq, 1);
> > > 
> > > 	r0 = READ_ONCE(*mod_data);
> > > }
> > > 
> > > P1(int *len, int *mod_data, int *enq)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 
> > > 	r1 = READ_ONCE(*enq);
> > > 
> > > 	// barrier Just for test purpose ("exists" clause) to force the..
> > > 	// ..rcu_barrier() to see enq before len
> > > 	smp_mb();		
> > > 	r0 = READ_ONCE(*len);
> > > 
> > > 	// implicit memory barrier due to conditional */
> > > 	if (r0 == 0)
> > > 		WRITE_ONCE(*mod_data, 2);
> > > }
> > 
> > I'm not sure what scenario P1 refers to in practice, and to what module?
> 
> Kernel module usecase for rcu_barrier. See the docs.

My bad, I'm just reading that documentation now :-s

> > 
> > I'm very likely missing something obvious somewhere.
> > 
> >       CPU 0                                CPU 1
> >       rcu_barrier()                        call_rcu()/rcu_segcblist_enqueue()
> >       ------------                         --------
> > 
> >                                            smp_mb();
> >                                            inc_len();
> > 					   smp_mb();
> > 					   queue callback;
> >       for_each_possible_cpu(cpu)
> >           if (!rcu_segcblist_n_cbs(&rdp->cblist))
> > 	      continue;
> >
> 
> >						invoke_callback
> 
> If CPU 0 saw the enqueue of the callback (that is the CPU 1's writes to the
> segcb_list propagated to CPU 0), then it would have also seen the
> effects of the inc_len. I forced this case in my last litmus test by this
> code in P1():

But then I can't find to which part of rcu_barrier() this refers to.
I see the len read before anything else.

> 
>         r1 = READ_ONCE(*enq);
>         smp_mb();               /* barrier Just for test purpose to show that the.. */
>                                 /* ..rcu_barrier() saw list modification */
> 
> On the other hand, if CPU 0 did not see the enqueue, then there is really no
> issue. Since that is the same case where call_rcu() happened _after_ the
> rcu_barrier() and there's no race. rcu_barrier() does not need to wait if
> there was no callback enqueued.
> 
> This is not exactly the easiest thing to explain, hence the litmus.

Now, reading the documentation of rcu_barrier() (thanks to you!):

    Pseudo-code using rcu_barrier() is as follows:

   1. Prevent any new RCU callbacks from being posted.
   2. Execute rcu_barrier().
   3. Allow the module to be unloaded.


I think with point 1, it is assumed that the caller of rcu_barrier() must have
not only stopped but also sync'ed with the possible enqueuers. Correct me if I'm wrong
here. So for example if a kthread used to post the module RCU callbacks, calling kthread_stop()
does the job as it prevents from further RCU callbacks from being enqueued and it also syncs
with the kthread thanks to the completion implied by any caller of kthread_stop() which then
sees what the kthread has read and written, including RCU callbacks enqueued. So if the caller
of kthread_stop() calls rcu_barrier() right after, rcu_barrier() should see at least the len
corresponding to the last enqueue.

cancel_work_sync() also seem to really sync as well. I'm less sure about del_timer_sync().

Say we have:

expire_timers (CPU 0)                               CPU 1
-------------                                       -----------
detach_timer(timer)
raw_spin_unlock(&base->lock);
call_timer_fn(timer, fn, baseclk);
   -> enqueue callback
//would need at least smp_wmb() here
base->running_timer = NULL;

                                                    del_timer_sync() {
                                                        raw_spin_lock(&base->lock);
                                                        if (base->running_timer != timer)
                                                            ret = detach_if_pending(timer, base, true);
                                                                if (!timer_pending())
                                                                    return 0;
                                                        raw_spin_unlock(&base->lock);
                                                    }
                                                    //would need at least smp_rmb() here
						    //although rcu_seq_start() implies a full barrier
                                                    rcu_barrier() {
						        // Sees rcu_segcblist_n_cbs(rdp(CPU 0)->cblist) == 0
                                                        // So ignore it


But I'm sure I'm missing something obvious. That's my specialism.
