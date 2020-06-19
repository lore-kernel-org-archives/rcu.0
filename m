Return-Path: <SRS0=nBXm=AA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A0C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 01:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DB620776
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 01:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BFnEgXFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgFSBIR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFSBIP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 21:08:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA82C06174E
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 18:08:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so6048725qtr.7
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 18:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T43iM892TJYjWI03h1BZrB+AAS7AD/T5Jn3ZYH4upFM=;
        b=BFnEgXFb9Ko2ljLPaGQLgTnT5Jq2Bk57+NMsHttdGfrnRHKKPBEy9e3edY8dhCZv7k
         5+TSREfvoh/ZSLBA4UcZa1UCLnBOjchF7KCeFiM1CHD3I6ip5NrdwuSP1b6Zg3B1Y0+m
         ZK2HFDkfABmzq6mmuyhNssodbaA9BwdzZ/yUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T43iM892TJYjWI03h1BZrB+AAS7AD/T5Jn3ZYH4upFM=;
        b=SdGhfsZp8t3iqSMHkidXS3ttPdX4vH4PMxZ6pjHXvRBvAmtHT1yhOOWjgEmbiLw8RX
         cmv2MqqIuPqAHJqz94k1nULDRVSP+iKu/WSDyr+ghmoTSBh+TfRlmI9RtNQ0a3bFDHgH
         fkrBzp+fvTye4Gpo5UlJzqOGjcSSO4VG7oOuL14+SLO6bjSkCkEnpqC4BN/z7Hjc2cSS
         rV6NvvZUwQuVt9PGYDlBfdU0b0++lUjL/sS09Vi6B5dqLSe+rE8LRjmKjlLloVemxoLa
         45DAf2Fq2Kw2QVoxJuXUU2hdU8EDEB+bZ4oqXj1mZLzl7LOqceTs3MNgAJ7mHv3QKZW2
         OD0Q==
X-Gm-Message-State: AOAM532mZIr5ul/7suRrCKrLUvVdlYAecY4f1DHTMuEfZc35MzGu1E2s
        86EgUfL7Zsj9IT3VpHxbPLQDUw==
X-Google-Smtp-Source: ABdhPJwYGgCPhRm8Ma92NTuQNwdllZur0IuoDXHl9RaFu28bQEMMD0y+bha84TJTRT49Rh0eiAk9Gg==
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr1035312qtm.171.1592528894941;
        Thu, 18 Jun 2020 18:08:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x54sm5447689qta.42.2020.06.18.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:08:14 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:08:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 3/7] rcu/trace: Add name of the source for gp_seq
Message-ID: <20200619010814.GI40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-3-joel@joelfernandes.org>
 <20200618221901.GZ2723@paulmck-ThinkPad-P72>
 <20200618235117.GA40119@google.com>
 <20200619001201.GF2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619001201.GF2723@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 05:12:01PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 07:51:17PM -0400, Joel Fernandes wrote:
> > On Thu, Jun 18, 2020 at 03:19:01PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 18, 2020 at 04:29:51PM -0400, Joel Fernandes (Google) wrote:
> > > > The gp_seq value can come from either of rdp, rsp or rnp.
> > > > 
> > > > Only the rsp is the global source of truth (most accurate GP info). The
> > > > rnp can be off by ~1 and the rdp can be off by way more. Add some more
> > > > context to traces to clarify where it comes from.
> > > 
> > > This would be better done in scripting that processes the trace messages.
> > > I must pass on this one.
> > 
> > I don't think so. I think people reading traces would get confused.  Recently
> > I had to talk with someone about this as well when going over traces. I
> > myself struggle with it.
> > 
> > > For future reference, the TPS() around strings is not optional.  Without
> > > it, trace messages from crash dumps are garbled, if I remember correctly.
> > 
> > Ok. I will fix that.
> 
> Then please sort this patch after the others.  I am quite unconvinced
> about this one, but some of the others looked quite valuable.

To summarize what's left for me to do right now:

1 and 7 were pulled.
2 - requires the per-cblist counter I'll work on in the near future.
3 - have to add TPS()
4 - The negative number fixes which I'll resend.
5 - changing to gp_seq_req in this tracepoint.
6 - dropping for now and pushing it to a git tag.

So on top of rcu/dev I'll rework 3 and 5, and resend 4.

Please do consider again if we can find a place to 6 :) thanks!

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  include/trace/events/rcu.h | 12 ++++++++----
> > > >  kernel/rcu/tree.c          | 32 ++++++++++++++++----------------
> > > >  kernel/rcu/tree_plugin.h   |  2 +-
> > > >  3 files changed, 25 insertions(+), 21 deletions(-)
> > > > 
> > > > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > > > index a6d49864dcc27..cb5363564f7ed 100644
> > > > --- a/include/trace/events/rcu.h
> > > > +++ b/include/trace/events/rcu.h
> > > > @@ -68,24 +68,28 @@ TRACE_EVENT(rcu_utilization,
> > > >   */
> > > >  TRACE_EVENT_RCU(rcu_grace_period,
> > > >  
> > > > -	TP_PROTO(const char *rcuname, unsigned long gp_seq, const char *gpevent),
> > > > +	TP_PROTO(const char *rcuname, const char *gp_seq_src,
> > > > +		unsigned long gp_seq, const char *gpevent),
> > > >  
> > > > -	TP_ARGS(rcuname, gp_seq, gpevent),
> > > > +	TP_ARGS(rcuname, gp_seq_src, gp_seq, gpevent),
> > > >  
> > > >  	TP_STRUCT__entry(
> > > >  		__field(const char *, rcuname)
> > > > +		__field(const char *, gp_seq_src)
> > > >  		__field(unsigned long, gp_seq)
> > > >  		__field(const char *, gpevent)
> > > >  	),
> > > >  
> > > >  	TP_fast_assign(
> > > >  		__entry->rcuname = rcuname;
> > > > +		__entry->gp_seq_src = gp_seq_src;
> > > >  		__entry->gp_seq = gp_seq;
> > > >  		__entry->gpevent = gpevent;
> > > >  	),
> > > >  
> > > > -	TP_printk("%s %lu %s",
> > > > -		  __entry->rcuname, __entry->gp_seq, __entry->gpevent)
> > > > +	TP_printk("%s %s_gp_seq=%lu %s",
> > > > +		  __entry->rcuname, __entry->gp_seq_src,
> > > > +		  __entry->gp_seq, __entry->gpevent)
> > > >  );
> > > >  
> > > >  /*
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index c61af6a33fbfd..81df1b837dd9d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1334,7 +1334,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
> > > >  		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
> > > >  		goto unlock_out;
> > > >  	}
> > > > -	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
> > > > +	trace_rcu_grace_period(rcu_state.name, "rsp", data_race(rcu_state.gp_seq), TPS("newreq"));
> > > >  	ret = true;  /* Caller must wake GP kthread. */
> > > >  unlock_out:
> > > >  	/* Push furthest requested GP to leaf node and rcu_data structure. */
> > > > @@ -1437,9 +1437,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> > > >  
> > > >  	/* Trace depending on how much we were able to accelerate. */
> > > >  	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
> > > > -		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
> > > > +		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccWaitCB"));
> > > >  	else
> > > > -		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
> > > > +		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccReadyCB"));
> > > >  
> > > >  	/* Count CBs for tracing. */
> > > >  	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> > > > @@ -1543,7 +1543,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
> > > >  		if (!offloaded)
> > > >  			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
> > > >  		rdp->core_needs_qs = false;
> > > > -		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
> > > > +		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("cpuend"));
> > > >  	} else {
> > > >  		if (!offloaded)
> > > >  			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
> > > > @@ -1559,7 +1559,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
> > > >  		 * set up to detect a quiescent state, otherwise don't
> > > >  		 * go looking for one.
> > > >  		 */
> > > > -		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
> > > > +		trace_rcu_grace_period(rcu_state.name, "rnp", rnp->gp_seq, TPS("cpustart"));
> > > >  		need_qs = !!(rnp->qsmask & rdp->grpmask);
> > > >  		rdp->cpu_no_qs.b.norm = need_qs;
> > > >  		rdp->core_needs_qs = need_qs;
> > > > @@ -1660,7 +1660,7 @@ static bool rcu_gp_init(void)
> > > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > >  	rcu_seq_start(&rcu_state.gp_seq);
> > > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > -	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > > > +	trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("start"));
> > > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > >  
> > > >  	/*
> > > > @@ -1828,7 +1828,7 @@ static void rcu_gp_fqs_loop(void)
> > > >  			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
> > > >  				   jiffies + (j ? 3 * j : 2));
> > > >  		}
> > > > -		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
> > > >  				       TPS("fqswait"));
> > > >  		rcu_state.gp_state = RCU_GP_WAIT_FQS;
> > > >  		ret = swait_event_idle_timeout_exclusive(
> > > > @@ -1843,7 +1843,7 @@ static void rcu_gp_fqs_loop(void)
> > > >  		/* If time for quiescent-state forcing, do it. */
> > > >  		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> > > >  		    (gf & RCU_GP_FLAG_FQS)) {
> > > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
> > > >  					       TPS("fqsstart"));
> > > >  			rcu_gp_fqs(first_gp_fqs);
> > > >  			gf = 0;
> > > > @@ -1851,7 +1851,7 @@ static void rcu_gp_fqs_loop(void)
> > > >  				first_gp_fqs = false;
> > > >  				gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
> > > >  			}
> > > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
> > > >  					       TPS("fqsend"));
> > > >  			cond_resched_tasks_rcu_qs();
> > > >  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > > @@ -1862,7 +1862,7 @@ static void rcu_gp_fqs_loop(void)
> > > >  			cond_resched_tasks_rcu_qs();
> > > >  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > >  			WARN_ON(signal_pending(current));
> > > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
> > > >  					       TPS("fqswaitsig"));
> > > >  			ret = 1; /* Keep old FQS timing. */
> > > >  			j = jiffies;
> > > > @@ -1945,7 +1945,7 @@ static void rcu_gp_cleanup(void)
> > > >  	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
> > > >  
> > > >  	/* Declare grace period done, trace first to use old GP number. */
> > > > -	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
> > > > +	trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("end"));
> > > >  	rcu_seq_end(&rcu_state.gp_seq);
> > > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > >  	rcu_state.gp_state = RCU_GP_IDLE;
> > > > @@ -1962,7 +1962,7 @@ static void rcu_gp_cleanup(void)
> > > >  	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
> > > >  		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
> > > >  		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> > > > -		trace_rcu_grace_period(rcu_state.name,
> > > > +		trace_rcu_grace_period(rcu_state.name, "rsp",
> > > >  				       rcu_state.gp_seq,
> > > >  				       TPS("newreq"));
> > > >  	} else {
> > > > @@ -1982,7 +1982,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
> > > >  
> > > >  		/* Handle grace-period start. */
> > > >  		for (;;) {
> > > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
> > > >  					       TPS("reqwait"));
> > > >  			rcu_state.gp_state = RCU_GP_WAIT_GPS;
> > > >  			swait_event_idle_exclusive(rcu_state.gp_wq,
> > > > @@ -1996,7 +1996,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
> > > >  			cond_resched_tasks_rcu_qs();
> > > >  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > >  			WARN_ON(signal_pending(current));
> > > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
> > > >  					       TPS("reqwaitsig"));
> > > >  		}
> > > >  
> > > > @@ -2240,7 +2240,7 @@ int rcutree_dying_cpu(unsigned int cpu)
> > > >  		return 0;
> > > >  
> > > >  	blkd = !!(rnp->qsmask & rdp->grpmask);
> > > > -	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> > > > +	trace_rcu_grace_period(rcu_state.name, "rsp", READ_ONCE(rnp->gp_seq),
> > > >  			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
> > > >  	return 0;
> > > >  }
> > > > @@ -3733,7 +3733,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > > >  	rdp->core_needs_qs = false;
> > > >  	rdp->rcu_iw_pending = false;
> > > >  	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
> > > > -	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
> > > > +	trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("cpuonl"));
> > > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >  	rcu_prepare_kthreads(cpu);
> > > >  	rcu_spawn_cpu_nocb_kthread(cpu);
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 982fc5be52698..32f761cf16c33 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -262,7 +262,7 @@ static void rcu_qs(void)
> > > >  {
> > > >  	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
> > > >  	if (__this_cpu_read(rcu_data.cpu_no_qs.s)) {
> > > > -		trace_rcu_grace_period(TPS("rcu_preempt"),
> > > > +		trace_rcu_grace_period(TPS("rcu_preempt"), "rdp",
> > > >  				       __this_cpu_read(rcu_data.gp_seq),
> > > >  				       TPS("cpuqs"));
> > > >  		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
> > > > -- 
> > > > 2.27.0.111.gc72c7da667-goog
> > > > 
