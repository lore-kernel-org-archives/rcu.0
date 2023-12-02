Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDB2917
	for <rcu@vger.kernel.org>; Sat,  2 Dec 2023 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuoOK1Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFBAC433C7;
	Sat,  2 Dec 2023 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701555867;
	bh=SXHC0x0+GI/myrZriQvLJwxGk27i20x6fkxa1/3/bpM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VuoOK1Wjn8FfBN+hGBnOMYLJZWL9lC0XOMzRyyx7NM9Jxn3/End/IN5zCy1Ji06Fs
	 rhNsNyWn/yanHCsbBYzo1g/ccueP+EHWUYYZQa1MBCuQEAjfWshj5sX6RsondAnVu4
	 GgpyPJJezNvFHb8A4jDmuGAISCVzA8+Z9dMwTE565NTFzXUbSul1YI782yuZopJRT5
	 3dGR33R7fRg/Vqz1q2lZS60phJggbA/N/PLLmqqOEvTrAWHrSdYyjXM7NuCsJPrFEn
	 QBtpece4r12j4uIiUlCjMTWmTWa7avqi6v3pED4kzXPGB1+1OEwwgfFprv2sjSWQDv
	 azSkmE7JCPe7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F16EFCE10DA; Sat,  2 Dec 2023 14:24:26 -0800 (PST)
Date: Sat, 2 Dec 2023 14:24:26 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231201154932.468d088b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201154932.468d088b@gandalf.local.home>

On Fri, Dec 01, 2023 at 03:49:32PM -0500, Steven Rostedt wrote:
> Paul,
> 
> I just started running my branch tracer (that checks all branches and also
> gives likely and unlikely correctness). And I found this:
> 
>  correct incorrect  %        Function                  File              Line
>  ------- ---------  -        --------                  ----              ----
>        0  1217713 100 rcu_softirq_qs                 tree.c               247
> 
> Which comes down to this:
> 
> 
> # define rcu_tasks_trace_qs(t)							\
> 	do {									\
> 		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
> 										\
> 		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
> 		    likely(!___rttq_nesting)) {					\
> 			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
> 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
> 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
> 			rcu_tasks_trace_qs_blkd(t);				\
> 		}								\
> 	} while (0)
> 
> 
> I added just before the likely/unlikely to my test box and I see this:
> 
> 		trace_printk("need qs? %d %d\n", READ_ONCE((t)->trc_reader_special.b.need_qs), ___rttq_nesting); \
> 
>           <idle>-0       [005] d.h1.     2.482412: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [002] d.h1.     2.482464: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [000] d.h1.     2.482766: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [001] d.h1.     2.482951: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [007] d.h1.     2.482958: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [005] d.h1.     2.483600: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [002] d.h1.     2.483624: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [000] d.h1.     2.483927: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [007] d.h1.     2.484068: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [001] d.h1.     2.484127: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [002] d.h1.     2.484723: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [005] d.h1.     2.484745: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [000] d.h1.     2.485015: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [007] d.h1.     2.485202: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [001] d.h1.     2.485258: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [002] d.h1.     2.485818: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [005] d.h1.     2.485929: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [000] d.h1.     2.486224: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [007] d.h1.     2.486370: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [001] d.h1.     2.486399: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [002] d.h1.     2.486895: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [005] d.h1.     2.487049: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [000] d.h1.     2.487318: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [007] d.h1.     2.487472: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [001] d.h1.     2.487522: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [002] d.h1.     2.488034: rcu_sched_clock_irq: need qs? 2 0
>           <idle>-0       [005] d.h1.     2.488220: rcu_sched_clock_irq: need qs? 2 0
> 
> 
> Note, that "2" is the READ_ONCE() without the "!" to it. Thus:
> 
> 		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
> 
> Is unlikely to be true.
> 
> Was this supposed to be:
> 
> 		if (!likely(READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
> 
> Or could it be converted to:
> 
> 		if (unlikely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
> 
> ?
> 
> Note, the unlikely tracing is running on my production server v6.6.3.
> 
> The above trace is from my test box with latest Linus's tree.

Nice tool!!!

My kneejerk reaction is that that condition is suboptimal.  Does the 
(untested) patch below help things?

							Thanx, Paul

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index aa87c82236dd..1df1dc9e8620 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -184,9 +184,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 	do {									\
 		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
 										\
-		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
+		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
 		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
