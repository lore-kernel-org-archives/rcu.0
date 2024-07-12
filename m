Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E090173343;
	Fri, 12 Jul 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797633; cv=none; b=aC5jxQ0pNvBQjR/AGdcht35ZtGlcOmUu4Pf5pXSfqagsC1Px11et8cc8i+mW3NgqYUmSxRyEMENtFd+ypbgVJrlsMrQjRkS8/p5rYlvbiDNWhK5OLVnx5laRb37zliJKz5IZm3jhoea/HIVUesNuu/cf/44BaVMLSwjUW57GdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797633; c=relaxed/simple;
	bh=nvcLfmmtRTNLzyLmqu+KOrZedlfhy3Um77GnvO0gRMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQe/7snQ4sevbmQAuBrmdtAFnlaaHuUaP+ypebcZRWvMmHZuP9wC1K+Iwyq6haMDLESvFUDd70ojIbFlLJRdbaZqZQJ0jqWqUVBWhObjnxPI+fnoF7QKVNZg/DqsAyUZKpwPqSq0u6X7vavz9B+8MXrniXgRicOk2GmT7bdSsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qcBtCw+v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcBtCw+v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yFOSfw59CiTTN0H3xVZks2pDZosjWrgrRj4r2pLl3K8=; b=qcBtCw+vAhRixTf52pCIhw1Irt
	TDVPz0nNUzGGMN7qmh+4dmGtzwt0jX6fJdH4AIFykCTVTPPyytKfh8pdwOT9vvliqBJDb4TNlQuJv
	Oi12YUIASAYOVPDSFEENyaBpMl+G0pJ9jE9XewES1GdaUN4TCwBjD4NWhi6OflP0UTyY2gePTyY8B
	1k4zNmjVy3W4bXvToPJ9YeQHFnnOoySeSr1SywX2Pp2DQ8IRSv4KyBXc2G47D5TYQZfpANo9CKtku
	ztLS0APDqgMuSntG0i7pbtrxtnRzEowvP0fRvauoFmMoSpvWSDzGmQEb0oxcsVhwCEfhgmedEdbmH
	kO4OFg9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSI4M-0000000Cbbg-1OIy;
	Fri, 12 Jul 2024 15:20:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7D1B30050D; Fri, 12 Jul 2024 17:20:21 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:20:21 +0200
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
Subject: Re: [RFC PATCH v3 03/10] task_work, sched: Add a _locked variant to
 task_work_cancel()
Message-ID: <20240712152021.GR27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-4-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-4-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 02:59:57PM +0200, Valentin Schneider wrote:
> Later commits will need to issue a task_work_cancel() from within the
> scheduler with the task's ->pi_lock held.
> 
> Add a _locked variant that expects p->pi_lock to be held. Expose it in a
> separate scheduler header file, as this really is a scheduler-only
> interface.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/task_work_sched.h | 14 +++++++
>  kernel/task_work.c             | 67 ++++++++++++++++++++++++++--------
>  2 files changed, 66 insertions(+), 15 deletions(-)
>  create mode 100644 kernel/sched/task_work_sched.h
> 
> diff --git a/kernel/sched/task_work_sched.h b/kernel/sched/task_work_sched.h
> new file mode 100644
> index 0000000000000..e235da456427f
> --- /dev/null
> +++ b/kernel/sched/task_work_sched.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Scheduler internal task_work methods
> + */
> +#ifndef _KERNEL_TASK_WORK_SCHED_H
> +#define _KERNEL_TASK_WORK_SCHED_H
> +
> +#include <linux/task_work.h>
> +#include <linux/sched.h>
> +
> +struct callback_head *
> +task_work_cancel_locked(struct task_struct *task, task_work_func_t func);
> +
> +#endif


Do we really need that exposed? Can't we squirrel that way in
kernel/sched/sched.h and forget about it?


> @@ -74,33 +76,20 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  	return 0;
>  }
>  
> -/**
> - * task_work_cancel_match - cancel a pending work added by task_work_add()
> - * @task: the task which should execute the work
> - * @match: match function to call
> - * @data: data to be passed in to match function
> - *
> - * RETURNS:
> - * The found work or NULL if not found.
> - */
> -struct callback_head *
> -task_work_cancel_match(struct task_struct *task,
> +static struct callback_head *
> +task_work_cancel_match_locked(struct task_struct *task,
>  		       bool (*match)(struct callback_head *, void *data),
>  		       void *data)
>  {
>  	struct callback_head **pprev = &task->task_works;
>  	struct callback_head *work;
> -	unsigned long flags;
>  
> -	if (likely(!task_work_pending(task)))
> -		return NULL;
>  	/*
>  	 * If cmpxchg() fails we continue without updating pprev.
>  	 * Either we raced with task_work_add() which added the
>  	 * new entry before this work, we will find it again. Or
>  	 * we raced with task_work_run(), *pprev == NULL/exited.
>  	 */
> -	raw_spin_lock_irqsave(&task->pi_lock, flags);
>  	work = READ_ONCE(*pprev);
>  	while (work) {
>  		if (!match(work, data)) {
> @@ -109,6 +98,32 @@ task_work_cancel_match(struct task_struct *task,
>  		} else if (try_cmpxchg(pprev, &work, work->next))
>  			break;
>  	}
> +
> +	return work;
> +}

> @@ -136,6 +151,28 @@ task_work_cancel(struct task_struct *task, task_work_func_t func)
>  	return task_work_cancel_match(task, task_work_func_match, func);
>  }
>  
> +/**
> + * task_work_cancel - cancel a pending work added by task_work_add()
> + * @task: the task which should execute the work
> + * @func: identifies the work to remove
> + *
> + * Find the last queued pending work with ->func == @func and remove
> + * it from queue.
> + *
> + * RETURNS:
> + * The found work or NULL if not found.
> + */
> +struct callback_head *
> +task_work_cancel_locked(struct task_struct *task, task_work_func_t func)
> +{
> +	lockdep_assert_held(&task->pi_lock);

I'm thinking that lockde_assert wants to live in your _locked function
above.

> +	if (likely(!task_work_pending(task)))
> +		return NULL;
> +
> +	return task_work_cancel_match_locked(task, task_work_func_match, func);
> +}
> +
>  /**
>   * task_work_run - execute the works added by task_work_add()
>   *
> -- 
> 2.43.0
> 
