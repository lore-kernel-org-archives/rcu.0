Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423E1C760D;
	Mon,  2 Dec 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150058; cv=none; b=lYfkKpYcj/Ls8vtDvWJzuB1IE7oNimaTGq+ZNXb2Fsb102Rdhn8U/ozR/3DhrUXttj/2LPTSFM2K8GIM683wWqak+VyWMX4bT+4cb0AQRLhm6oRMo8LL1Fh0XWSHFIpuCf05J+40YNCZ3xLL3sYFUKenL6r1iLXBBEEbkr1ToEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150058; c=relaxed/simple;
	bh=eKlA9kXqC1Nb5gGHQhO1cfhM6+Kn5qSE7javDAp4ASQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=KvmQVKRB1dP/UzEYFkWbxPUeZ4dITUMh8XEDydeEAxXhBOVx5BHcqmn4eGc40NgKjqgn036tWNTSH6cD/FJ5ihC9jGcZQAj3LmBCQrHeY0fZCLVRPFwAzA2PLDH3FJN7a5+et83p1S/f5m4uf1JjCXg9imPSilYfzXiazGtqS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ozxyobPX; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ozxyobPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733150052;
	bh=eKlA9kXqC1Nb5gGHQhO1cfhM6+Kn5qSE7javDAp4ASQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ozxyobPX8xflcIzRr+h4Y7J6JckoMvb0SHpUabC/kS1E3ANmSOaPaCtxHz61tCjUK
	 qzu1AYl7d4wYjCZZyZ+/qVP5NzSYoJ9o4L+Bqu3+Lgs22rizTfy4ly45k4tfypEESs
	 zh2ixO/klZ5tPXrszW0JP68IR57hlY/clBlANATVvRthwuf6plL9jTNrU0o5u0hoKc
	 4qE/151yBAaGIC81LARAPyl0rvjJeaWVxmcjb3nMiyEJZ1YMiVd1dWRHuxlf85bE8C
	 wy5h6w51HexBm+do4l9joEYBJW49tJpb05QvYqXULOBeaTkH96ifhTFKrcLJ0QFR/+
	 c129xrDzKU3+w==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y25rg6FcczTpW;
	Mon,  2 Dec 2024 09:34:11 -0500 (EST)
Message-ID: <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
Date: Mon, 2 Dec 2024 09:34:11 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20241202140735.56368-1-gmonaco@redhat.com>
 <20241202140735.56368-3-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
Cc: paulmck <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, "rcu@vger.kernel.org"
 <rcu@vger.kernel.org>
In-Reply-To: <20241202140735.56368-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+= CC RCU maintainers, reviewers and list.
+= RSEQ maintainers.

On 2024-12-02 09:07, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick. This can delay the execution of the
> task for the entire duration of the function.
> 
> This patch runs the task_mm_cid_work in the RCU callback thread rather
> than in the task context before returning to userspace.
> 
> The main advantage of this change is that the function can be offloaded
> to a different CPU and even preempted by RT tasks.
> 
> On a busy system, this may mean the function gets called less often, but
> the current behaviour already doesn't provide guarantees.

I've used the same task work pattern as NUMA here. What makes it
OK for NUMA and not for mm_cid ?

I wonder why we'd want to piggy-back on call_rcu here when
this has nothing to do with RCU. There is likely a characteristic
of the call_rcu worker threads that we want to import into
task_tick_mm_cid(), or change task_work.c to add a new flag
that says the work can be dispatched to any CPU.

> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/sched.h |  1 -
>   kernel/sched/core.c   | 17 ++++++-----------
>   2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..5d141c310917 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1374,7 +1374,6 @@ struct task_struct {
>   	int				last_mm_cid;	/* Most recent cid in mm */
>   	int				migrate_from_cpu;
>   	int				mm_cid_active;	/* Whether cid bitmap is active */
> -	struct callback_head		cid_work;
>   #endif
>   
>   	struct tlbflush_unmap_batch	tlb_ubc;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 57b50b5952fa..0fc1a972fd4f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10520,17 +10520,15 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>   	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
>   }
>   
> -static void task_mm_cid_work(struct callback_head *work)
> +static void task_mm_cid_work(struct rcu_head *rhp)
>   {
>   	unsigned long now = jiffies, old_scan, next_scan;
> -	struct task_struct *t = current;
> +	struct task_struct *t = container_of(rhp, struct task_struct, rcu);
>   	struct cpumask *cidmask;
>   	struct mm_struct *mm;
>   	int weight, cpu;
>   
> -	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
> -
> -	work->next = work;	/* Prevent double-add */
> +	rhp->next = rhp;	/* Prevent double-add */
>   	if (t->flags & PF_EXITING)
>   		return;
>   	mm = t->mm;
> @@ -10574,23 +10572,20 @@ void init_sched_mm_cid(struct task_struct *t)
>   		if (mm_users == 1)
>   			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	}
> -	t->cid_work.next = &t->cid_work;	/* Protect against double add */
> -	init_task_work(&t->cid_work, task_mm_cid_work);
>   }
>   
>   void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
>   {
> -	struct callback_head *work = &curr->cid_work;
> +	struct rcu_head *rhp = &curr->rcu;

Why is it OK to re-use the task struct rcu field ? Where else is it
used, and is there a risk of being inserted twice ?

Thanks,

Mathieu

>   	unsigned long now = jiffies;
>   
>   	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> -	    work->next != work)
> +	    rhp->next != rhp)
>   		return;
>   	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
>   		return;
>   
> -	/* No page allocation under rq lock */
> -	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
> +	call_rcu(rhp, task_mm_cid_work);
>   }
>   
>   void sched_mm_cid_exit_signals(struct task_struct *t)

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

