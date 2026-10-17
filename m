Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848342E5B2A;
	Sat, 17 Oct 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259738; cv=none; b=EqHuss6MGEy8R8v9UsNmfgeUHag8IwbymyIOELJfVBJBUCwICV6aWbz9ix+5F/w3osNOu/m+fsa1dqVZMMJ5Gbn2fZjm81yVoTQobHCVCg0keZ3m4KS3qfBP75PSqxcPxS4v2+cIz4L8GfSwo+NAeLYuw9gRF/DjGG4Alow1JVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259738; c=relaxed/simple;
	bh=vVh1sAesQSfCuO8Cr9AlBncx/FN9hKlbyz981vg/gug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoLOEbiVDBJ/U8HMuMgFnxG5NvRZxaxNnKu9aM7PeWwOndaY8njwQa/OBAsm8c/r6O5Neh9XYpwJgSYrbtq7O+wKR/NuZye/Ob06U+Pj9zuwLlUbZd4xcjsBMot+6R3Tv4SpaGi51ajjuAI3Zmc5EhHETTZ3PzlWXdesudKtr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpNqFM+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpNqFM+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D441F000C5;
	Sat, 17 Oct 2026 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792259737;
	bh=Y+gTTyd553cDS/lwnykQExR+FaFzBVN8Tep+V8H+cSo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=IpNqFM+cj9I6vCbMme9Od9JkRo3Gzn1g79z6VnYG4iAKQvBVaOOhc/kj1vGZOV8d8
	 IjbjlLlasR69zh0VkIlyzl7+Nkd8gvcmTmWM+B4Q8gd4pYBu76050aE8LjbX120KCZ
	 vOdaaZJvlLD4PE+Uoy2lwz/RinCuba155751Pxd2EBieukD+dOqnZeIsbC77nN5Jwu
	 il5/ehRrWdEg+0uzjWvogryG7dK/A8zTOMwn3VAgP/MizqKszUnLYOYSWNIc6Q6o+3
	 lyz87Myp7MSbqo89tHHjcfGcGjqRbf7+ITmXbnxTQm4hD2vIcawrHEta2jg3yBo7hx
	 LB/YUg9++5DoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08A4ECE0C55; Sat, 17 Oct 2026 10:55:37 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:55:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: qiang.zhang@linux.dev, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tasks: Use static per cpu work_struct for Tasks Rude
 grace periods
Message-ID: <4b456047-62ae-4bc2-8da5-e4e5e603fcbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261017123313.1441679-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017123313.1441679-1-brads@mainlining.org>

On Sat, Oct 17, 2026 at 12:33:13PM +0000, Bradley Morgan wrote:
> Zqiang caught a snafu in the rude grace period, if a too small grace
> period was reached, a UAF could occur. However, his patch used
> a WARN_ONCE() on schedule_on_each_cpu() OOM failures, which would not
> have handled the failure properly.
> 
> Instead of throwing a warning or relying on dynamic alloc_percpu(), replace
> the dynamic allocation with static per cpu work_struct instances. Using
> schedule_work_on() and flush_work() keeps everything in task context,
> guarantees the required context switch on every online CPU, and stays
> zero allocation so it cannot fail under OOM.
> 
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Sorry, Bradley, but no, absolutely not.

Because this not taking a suggestion, but is instead *exactly* Zqiang's
patch.  We do not commit plagiarism in the Linux-kernel community.

Zqiang, please submit a proper patch with appropriate credit to Bradley.
The obvious approach would be to following his example, that is, to
credit him using Suggested-by, but Reported-by or a sentence calling out
his feedback in the commit log would suffice.  However, I will defer to
your best judgment.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 627295396cd9..f81c0ea0b92a 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1348,11 +1348,25 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  {
>  }
>  
> +static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
> +
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> +	int cpu;
> +
> +	guard(cpus_read_lock)();
>  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
> -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work = &per_cpu(tasks_rude_work, cpu);
> +
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(&per_cpu(tasks_rude_work, cpu));
>  }
>  
>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> -- 
> 2.53.0
