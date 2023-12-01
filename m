Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1B1BDC7
	for <rcu@vger.kernel.org>; Fri,  1 Dec 2023 20:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECFFC433C7;
	Fri,  1 Dec 2023 20:49:10 +0000 (UTC)
Date: Fri, 1 Dec 2023 15:49:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, Frederic
 Weisbecker <fweisbec@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <20231201154932.468d088b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Paul,

I just started running my branch tracer (that checks all branches and also
gives likely and unlikely correctness). And I found this:

 correct incorrect  %        Function                  File              Line
 ------- ---------  -        --------                  ----              ----
       0  1217713 100 rcu_softirq_qs                 tree.c               247

Which comes down to this:


# define rcu_tasks_trace_qs(t)							\
	do {									\
		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
										\
		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
		    likely(!___rttq_nesting)) {					\
			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
			rcu_tasks_trace_qs_blkd(t);				\
		}								\
	} while (0)


I added just before the likely/unlikely to my test box and I see this:

		trace_printk("need qs? %d %d\n", READ_ONCE((t)->trc_reader_special.b.need_qs), ___rttq_nesting); \

          <idle>-0       [005] d.h1.     2.482412: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.482464: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.482766: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.482951: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.482958: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.483600: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.483624: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.483927: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.484068: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.484127: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.484723: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.484745: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.485015: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.485202: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.485258: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.485818: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.485929: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.486224: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.486370: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.486399: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.486895: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.487049: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.487318: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.487472: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.487522: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.488034: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.488220: rcu_sched_clock_irq: need qs? 2 0


Note, that "2" is the READ_ONCE() without the "!" to it. Thus:

		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\

Is unlikely to be true.

Was this supposed to be:

		if (!likely(READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\

Or could it be converted to:

		if (unlikely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\

?

Note, the unlikely tracing is running on my production server v6.6.3.

The above trace is from my test box with latest Linus's tree.

-- Steve
