Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E10C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65170207DD
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592519447;
	bh=vcw1GePvPvCbn7XBKx8sCrewdeL3+ljLnnsZZePyqFo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ipRyMgPvZAY8xoE/AAleb/TMHvLf1E81Ss2zkoMK5tLFc6mJRrgXGwmUe7kB1t2kW
	 kuWRDJUcwO6xlwkONPydeV10dJiknYxbJrLBI7zwlUADF3KXOk66AwdiG1IM5DaEKp
	 Xx5pB35Qm0ZkuuBaRgMAzsK582gQCXtKfGvuUloU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgFRWar (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgFRWaq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 18:30:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F9D20732;
        Thu, 18 Jun 2020 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592519445;
        bh=vcw1GePvPvCbn7XBKx8sCrewdeL3+ljLnnsZZePyqFo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hBGzf1OoJpm+9ruEgbnzi/pYH5kO7lL/OMSIwUAskHGlkvk4q6oARpcjV3abtWdwD
         XNmLMH88TPwpiZH0TTFgfNbNOh4oCIvkPXq3MTNZIANx65aczG/2BoxFYlcGcOTNqh
         AgNtcO69diAcQhNzpOdUPMkVg4xNYTmqCJjEB6cY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 68EB6352264E; Thu, 18 Jun 2020 15:30:45 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:30:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 4/7] rcu/trace: Print negative GP numbers correctly
Message-ID: <20200618223045.GB2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618202955.4024-4-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:29:52PM -0400, Joel Fernandes (Google) wrote:
> GP numbers start from -300 and gp_seq numbers start of -1200 (for a
> shift of 2). These negative numbers are printed as unsigned long which
> not only takes up more text space, but is rather confusing to the reader
> as they have to constantly expend energy to truncate the number. Just
> print the negative numbering directly.

Good!  This also makes the ftrace versions of the grace-period sequence
numbers consistent with those of rcutorture.

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/trace/events/rcu.h | 62 ++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index cb5363564f7ed..bc24862790623 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -76,18 +76,18 @@ TRACE_EVENT_RCU(rcu_grace_period,
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
>  		__field(const char *, gp_seq_src)
> -		__field(unsigned long, gp_seq)
> +		__field(long, gp_seq)
>  		__field(const char *, gpevent)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
>  		__entry->gp_seq_src = gp_seq_src;
> -		__entry->gp_seq = gp_seq;
> +		__entry->gp_seq = (long)gp_seq;
>  		__entry->gpevent = gpevent;
>  	),
>  
> -	TP_printk("%s %s_gp_seq=%lu %s",
> +	TP_printk("%s %s_gp_seq=%ld %s",
>  		  __entry->rcuname, __entry->gp_seq_src,
>  		  __entry->gp_seq, __entry->gpevent)
>  );
> @@ -118,8 +118,8 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gp_seq)
> -		__field(unsigned long, gp_seq_req)
> +		__field(long, gp_seq)
> +		__field(long, gp_seq_req)
>  		__field(u8, level)
>  		__field(int, grplo)
>  		__field(int, grphi)
> @@ -128,16 +128,16 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gp_seq = gp_seq;
> -		__entry->gp_seq_req = gp_seq_req;
> +		__entry->gp_seq = (long)gp_seq;
> +		__entry->gp_seq_req = (long)gp_seq_req;
>  		__entry->level = level;
>  		__entry->grplo = grplo;
>  		__entry->grphi = grphi;
>  		__entry->gpevent = gpevent;
>  	),
>  
> -	TP_printk("%s %lu %lu %u %d %d %s",
> -		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_req, __entry->level,
> +	TP_printk("%s %ld %ld %u %d %d %s",
> +		  __entry->rcuname, (long)__entry->gp_seq, (long)__entry->gp_seq_req, __entry->level,
>  		  __entry->grplo, __entry->grphi, __entry->gpevent)
>  );
>  
> @@ -157,7 +157,7 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gp_seq)
> +		__field(long, gp_seq)
>  		__field(u8, level)
>  		__field(int, grplo)
>  		__field(int, grphi)
> @@ -166,14 +166,14 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gp_seq = gp_seq;
> +		__entry->gp_seq = (long)gp_seq;
>  		__entry->level = level;
>  		__entry->grplo = grplo;
>  		__entry->grphi = grphi;
>  		__entry->qsmask = qsmask;
>  	),
>  
> -	TP_printk("%s %lu %u %d %d %lx",
> +	TP_printk("%s %ld %u %d %d %lx",
>  		  __entry->rcuname, __entry->gp_seq, __entry->level,
>  		  __entry->grplo, __entry->grphi, __entry->qsmask)
>  );
> @@ -201,17 +201,17 @@ TRACE_EVENT_RCU(rcu_exp_grace_period,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gpseq)
> +		__field(long, gpseq)
>  		__field(const char *, gpevent)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gpseq = gpseq;
> +		__entry->gpseq = (long)gpseq;
>  		__entry->gpevent = gpevent;
>  	),
>  
> -	TP_printk("%s %lu %s",
> +	TP_printk("%s %ld %s",
>  		  __entry->rcuname, __entry->gpseq, __entry->gpevent)
>  );
>  
> @@ -320,17 +320,17 @@ TRACE_EVENT_RCU(rcu_preempt_task,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gp_seq)
> +		__field(long, gp_seq)
>  		__field(int, pid)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gp_seq = gp_seq;
> +		__entry->gp_seq = (long)gp_seq;
>  		__entry->pid = pid;
>  	),
>  
> -	TP_printk("%s %lu %d",
> +	TP_printk("%s %ld %d",
>  		  __entry->rcuname, __entry->gp_seq, __entry->pid)
>  );
>  
> @@ -347,17 +347,17 @@ TRACE_EVENT_RCU(rcu_unlock_preempted_task,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gp_seq)
> +		__field(long, gp_seq)
>  		__field(int, pid)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gp_seq = gp_seq;
> +		__entry->gp_seq = (long)gp_seq;
>  		__entry->pid = pid;
>  	),
>  
> -	TP_printk("%s %lu %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
> +	TP_printk("%s %ld %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
>  );
>  
>  /*
> @@ -378,7 +378,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gp_seq)
> +		__field(long, gp_seq)
>  		__field(unsigned long, mask)
>  		__field(unsigned long, qsmask)
>  		__field(u8, level)
> @@ -389,7 +389,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gp_seq = gp_seq;
> +		__entry->gp_seq = (long)gp_seq;
>  		__entry->mask = mask;
>  		__entry->qsmask = qsmask;
>  		__entry->level = level;
> @@ -398,7 +398,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
>  		__entry->gp_tasks = gp_tasks;
>  	),
>  
> -	TP_printk("%s %lu %lx>%lx %u %d %d %u",
> +	TP_printk("%s %ld %lx>%lx %u %d %d %u",
>  		  __entry->rcuname, __entry->gp_seq,
>  		  __entry->mask, __entry->qsmask, __entry->level,
>  		  __entry->grplo, __entry->grphi, __entry->gp_tasks)
> @@ -419,19 +419,19 @@ TRACE_EVENT_RCU(rcu_fqs,
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, rcuname)
> -		__field(unsigned long, gp_seq)
> +		__field(long, gp_seq)
>  		__field(int, cpu)
>  		__field(const char *, qsevent)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->rcuname = rcuname;
> -		__entry->gp_seq = gp_seq;
> +		__entry->gp_seq = (long)gp_seq;
>  		__entry->cpu = cpu;
>  		__entry->qsevent = qsevent;
>  	),
>  
> -	TP_printk("%s %lu %d %s",
> +	TP_printk("%s %ld %d %s",
>  		  __entry->rcuname, __entry->gp_seq,
>  		  __entry->cpu, __entry->qsevent)
>  );
> @@ -520,17 +520,19 @@ TRACE_EVENT_RCU(rcu_segcb,
>  		TP_STRUCT__entry(
>  			__field(const char *, ctx)
>  			__array(int, cb_count, 4)
> -			__array(unsigned long, gp_seq, 4)
> +			__array(long, gp_seq, 4)
>  		),
>  
>  		TP_fast_assign(
> +			int i;
>  			__entry->ctx = ctx;
>  			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
> -			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
> +			for (i = 0; i < 4; i++)
> +				__entry->gp_seq[i] = (long)(gp_seq[i]);
>  		),
>  
>  		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> -			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> +			  "gp_seq: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld)", __entry->ctx,
>  			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
>  			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
>  
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
