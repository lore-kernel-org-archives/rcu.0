Return-Path: <SRS0=r/zf=DZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36DFC433E7
	for <rcu@archiver.kernel.org>; Sun, 18 Oct 2020 00:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FC7208E4
	for <rcu@archiver.kernel.org>; Sun, 18 Oct 2020 00:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MM+a9bqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440028AbgJRAf7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440025AbgJRAf6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 20:35:58 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AB8C061755
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2020 17:35:58 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w17so6799803ilg.8
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2020 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AmhFcnM2ta3F2zfSBB4loyXslkWWIa2GP1KcDkrxLco=;
        b=MM+a9bqzDnqkQ8EXpB/nPEjTGQiK6hrU5mrbSL484V2YecAqzHRJyjy1Evmmiv0i4u
         rk1IuhH5FkfIk0e0bdBWxwtTSfH/nJMAI9oMZUO4zz36i445bvNNG9qvJNquTkLyzVBE
         9XWnAdxVOlYVioJSHYQp/1QJIxRX2f0T9sFb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AmhFcnM2ta3F2zfSBB4loyXslkWWIa2GP1KcDkrxLco=;
        b=GS78O1dD2nzB01S84h8WCr5LDzkBF5zqHjRlZKj6BZleyd8qesDZ91K26hslyCX5l/
         vcwAL4FZh6H1kmCrPtluw+NAnywxJlYROpEyRPK02DyJwjxXxJ1nz38baXe4H4ytLoEE
         i7C2qzIYce++gQ2oMD23Mpilc0nAjRZ0Aj3AaJ4WU5IjOoJ6omAzf7ODO/uL5IQIgns9
         YLgq9UMVSJqVo8K2QSTbNmsXeAIHvasspJ4xPo3+bt3dRQUMC43MNFKpsWBLwVsC4LPV
         OgqlnPFiIyuWzKhU5MwiECtZIqrhe7tTFt5kycHBEAvC8nMWZ00NjHEe9U12ecMNFkX4
         HAog==
X-Gm-Message-State: AOAM530XpPYdfQWBZ4remGbDEjuxsqngih+Iq496a0RCQ4JQjFr+4/VT
        UpmOIRQQEcJtfsF5m0hyT7Omng==
X-Google-Smtp-Source: ABdhPJzdRiQ1eG59A6A1kOfP0e+RZq59r0uWrFS40cxw/v3mEezIZH9L8XSuA3Ob5WX5HFYOpagDVw==
X-Received: by 2002:a92:cbd2:: with SMTP id s18mr6730192ilq.34.1602981357842;
        Sat, 17 Oct 2020 17:35:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id m2sm6036076ion.44.2020.10.17.17.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 17:35:57 -0700 (PDT)
Date:   Sat, 17 Oct 2020 20:35:56 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20201018003556.GA1034551@google.com>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
 <20201017031941.GD4015033@google.com>
 <20201017132954.GA15657@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017132954.GA15657@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 17, 2020 at 03:29:54PM +0200, Frederic Weisbecker wrote:
> On Fri, Oct 16, 2020 at 11:19:41PM -0400, joel@joelfernandes.org wrote:
> > On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
> > [..]
> > > > > + *
> > > > > + * Memory barrier is needed after adding to length for the case
> > > > > + * where length transitions from 0 -> 1. This is because rcu_barrier()
> > > > > + * should never miss an update to the length. So the update to length
> > > > > + * has to be seen *before* any modifications to the segmented list. Otherwise a
> > > > > + * race can happen.
> > > > > + * P0 (what P1 sees)	P1
> > > > > + * queue to list
> > > > > + *                      rcu_barrier sees len as 0
> > > > > + * set len = 1.
> > > > > + *                      rcu_barrier does nothing.
> > > > 
> > > > So that would be:
> > > > 
> > > >       call_rcu()                    rcu_barrier()
> > > >       --                            --
> > > >       WRITE(len, len + 1)           l = READ(len)
> > > >       smp_mb()                      if (!l)
> > > >       queue                            check next CPU...
> > > > 
> > > > 
> > > > But I still don't see against what it pairs in rcu_barrier.
> > > 
> > > Actually, for the second case maybe a similar reasoning can be applied
> > > (control dependency) but I'm unable to come up with a litmus test.
> > > In fact, now I'm wondering how is it possible that call_rcu() races with
> > > rcu_barrier(). The module should ensure that no more call_rcu() should happen
> > > before rcu_barrier() is called.
> > > 
> > > confused
> > 
> > So I made a litmus test to show that smp_mb() is needed also after the update
> > to length. Basically, otherwise it is possible the callback will see garbage
> > that the module cleanup/unload did.
> > 
> > C rcubarrier+ctrldep
> > 
> > (*
> >  * Result: Never
> >  *
> >  * This litmus test shows that rcu_barrier (P1) prematurely
> >  * returning by reading len 0 can cause issues if P0 does
> >  * NOT have a smb_mb() after WRITE_ONCE(len, 1).
> >  * mod_data == 2 means module was unloaded (so data is garbage).
> >  *)
> > 
> > { int len = 0; int enq = 0; }
> > 
> > P0(int *len, int *mod_data, int *enq)
> > {
> > 	int r0;
> > 
> > 	WRITE_ONCE(*len, 1);
> > 	smp_mb();		/* Needed! */
> > 	WRITE_ONCE(*enq, 1);
> > 
> > 	r0 = READ_ONCE(*mod_data);
> > }
> > 
> > P1(int *len, int *mod_data, int *enq)
> > {
> > 	int r0;
> > 	int r1;
> > 
> > 	r1 = READ_ONCE(*enq);
> > 
> > 	// barrier Just for test purpose ("exists" clause) to force the..
> > 	// ..rcu_barrier() to see enq before len
> > 	smp_mb();		
> > 	r0 = READ_ONCE(*len);
> > 
> > 	// implicit memory barrier due to conditional */
> > 	if (r0 == 0)
> > 		WRITE_ONCE(*mod_data, 2);
> > }
> 
> I'm not sure what scenario P1 refers to in practice, and to what module?

Kernel module usecase for rcu_barrier. See the docs. P1() in the litmus test
is just a thread of execution which I was using to show the memory accesses
of rcu_barrier.

> > // Did P0 read garbage?
> > exists (0:r0=2 /\ 1:r0=0 /\ 1:r1=1)
> > 
> 
> 
> What also scares me is that in rcu_barrier():
> 
> 	for_each_possible_cpu(cpu) {
> 		rdp = per_cpu_ptr(&rcu_data, cpu);
> 		if (cpu_is_offline(cpu) &&
> 		    !rcu_segcblist_is_offloaded(&rdp->cblist))
> 			continue;
> 		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
> 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
> 					  rcu_state.barrier_sequence);
> 			smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
> 		} else if (rcu_segcblist_n_cbs(&rdp->cblist) &&
> 			   cpu_is_offline(cpu)) {
> 			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu,
> 					  rcu_state.barrier_sequence);
> 			local_irq_disable();
> 			rcu_barrier_func((void *)cpu);
> 			local_irq_enable();
> 		} else if (cpu_is_offline(cpu)) {
> 			rcu_barrier_trace(TPS("OfflineNoCBNoQ"), cpu,
> 					  rcu_state.barrier_sequence);
> 		} else {
> 			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
> 					  rcu_state.barrier_sequence);
> 		}
> 	}
> 
> I can't find something that makes sure this isn't racy while reading
> rcu_segcblist_n_cbs(&rdp->cblist).
> 
> I mean what I see sums up to this:
> 
>       CPU 0                                CPU 1
>       rcu_barrier()                        call_rcu()/rcu_segcblist_enqueue()
>       ------------                         --------
> 
>                                            smp_mb();
>                                            inc_len();
> 					   smp_mb();
> 					   queue callback;
>       for_each_possible_cpu(cpu)
>           if (!rcu_segcblist_n_cbs(&rdp->cblist))
> 	      continue;
> 
> It looks possible for rcu_barrier() to believe there is no callback enqueued
> and see rcu_segcblist_n_cbs(&rdp->cblist) == 0 here.
> 
> I'm very likely missing something obvious somewhere.
> 
>       CPU 0                                CPU 1
>       rcu_barrier()                        call_rcu()/rcu_segcblist_enqueue()
>       ------------                         --------
> 
>                                            smp_mb();
>                                            inc_len();
> 					   smp_mb();
> 					   queue callback;
>       for_each_possible_cpu(cpu)
>           if (!rcu_segcblist_n_cbs(&rdp->cblist))
> 	      continue;
>

>						invoke_callback

If CPU 0 saw the enqueue of the callback (that is the CPU 1's writes to the
segcb_list propagated to CPU 0), then it would have also seen the
effects of the inc_len. I forced this case in my last litmus test by this
code in P1():

        r1 = READ_ONCE(*enq);
        smp_mb();               /* barrier Just for test purpose to show that the.. */
                                /* ..rcu_barrier() saw list modification */

On the other hand, if CPU 0 did not see the enqueue, then there is really no
issue. Since that is the same case where call_rcu() happened _after_ the
rcu_barrier() and there's no race. rcu_barrier() does not need to wait if
there was no callback enqueued.

This is not exactly the easiest thing to explain, hence the litmus.

 - Joel

