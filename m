Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B52173343;
	Fri, 12 Jul 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798012; cv=none; b=VRHLI5baTT4Z517LcVwcSYElv3lUGJLb81nffWsUERaUPHw76blk+Aq0A9RJ9bmGsWpa9hhLEoMp52WJZ9X0YulRueQ9MTiJykwjNVumcwTXZ0i01avCPHzVOpwXl/3wbDIYmOAmry1Zkq1HwL3lPJmut1q4OKYtxUe8ywdIOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798012; c=relaxed/simple;
	bh=AwR32hI79pq34iLUnplYhEp9KLrM0KNwTOmaqgesFyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=druwHkcF76JsraKll7XubvWZQWA3V/zQh4MWseGTFoTk7hflUKvBXG3EtNZcsvpQJGHdHok2L7qURllA+cFSE/CLK9wi4e/qU3VTaee94EBs+2ST2fPqfBgLRVs8CKFLt19SDekqduEB8fAr5pLQyrN7UhNbRurEvJU3sgjrUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kn9WkQBO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kn9WkQBO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OKzQcMqejI2tskEZBY0hayIN8mjT8vws1907kDbSF9U=; b=kn9WkQBO/GELUNO/D9IlgH23MB
	aFRDcjPSa33oOwJTkRCglZDYqflWbWJ3wW535DVPImxHinud5+MBJqSP7JjoZnbLIC4wO2M5NjkaZ
	m4GjzfSNDAXMVsyxwwOrWK2ZnC4lmstpFBQHuLhG69rdyu+mS2IORLJ7hemVZSJZomfVd1J/F9wxq
	0dB5y+zyCfzkKZ1SBeqXFCaJF2IbzjqLnCrZRLVyIeOy2huem+fLGRm6W9OauaDQL6iPEuFHBbg3m
	/zK8TdqeNMnUpH5nPr7U4dsiceTrGU8hb2ta+v0WgGfYTaDw81VCDnRg7WZARrXks5n6OctaBapCl
	LSkvIr9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSIAU-0000000Cbt9-1Wi4;
	Fri, 12 Jul 2024 15:26:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0335230050D; Fri, 12 Jul 2024 17:26:42 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:26:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 06/10] sched/fair: Prepare switched_from &
 switched_to for per-task throttling
Message-ID: <20240712152641.GT27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-7-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-7-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 03:00:00PM +0200, Valentin Schneider wrote:
> Later commits will change CFS bandwidth control throttling from a
> per-cfs_rq basis to a per-task basis. This means special care needs to be
> taken around any transition a task can have into and out of a cfs_rq.
> 
> To ease reviewing, the transitions are patched with dummy-helpers that are
> implemented later on.
> 
> Add helpers to switched_from_fair() and switched_to_fair() to cover class
> changes. If switching from CFS, a task may need to be unthrottled. If
> switching to CFS, a task may need to be throttled.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/fair.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095357bd17f0e..acac0829c71f3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5694,6 +5694,10 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>  	return cfs_bandwidth_used() && cfs_rq->throttle_count;
>  }
>  
> +static inline bool task_needs_throttling(struct task_struct *p) { return false; }
> +static inline void task_throttle_setup(struct task_struct *p) { }
> +static inline void task_throttle_cancel(struct task_struct *p) { }
> +
>  /*
>   * Ensure that neither of the group entities corresponding to src_cpu or
>   * dest_cpu are members of a throttled hierarchy when performing group
> @@ -6622,6 +6626,10 @@ static inline int throttled_lb_pair(struct task_group *tg,
>  	return 0;
>  }
>  
> +static inline bool task_needs_throttling(struct task_struct *p) { return false; }
> +static inline void task_throttle_setup(struct task_struct *p) { }
> +static inline void task_throttle_cancel(struct task_struct *p) { }
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
>  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
> @@ -12847,11 +12855,15 @@ static void attach_task_cfs_rq(struct task_struct *p)
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>  	detach_task_cfs_rq(p);
> +	if (cfs_bandwidth_used())
> +		task_throttle_cancel(p);
>  }
>  
>  static void switched_to_fair(struct rq *rq, struct task_struct *p)
>  {
>  	attach_task_cfs_rq(p);
> +	if (cfs_bandwidth_used() && task_needs_throttling(p))
> +		task_throttle_setup(p);
>  
>  	set_task_max_allowed_capacity(p);

Other functions seem to have cfs_bandwidth_used() inside them, and not
bother the caller with this detail.
