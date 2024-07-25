Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1C26281;
	Thu, 25 Jul 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921761; cv=none; b=dIv9VWcCZ38msYavyuLVuApdPqNiDZrnsM4rUVY2YkUfYaxbO2AiqILVX15FlNIgmeYwl1Tl5oL7zDbXwjLjH+YvbcKdoCHMqi/XpKKMYVW7eGR+4nD9bgz9jsn9hq8Om/I+z/OACSQ1XwpNLiaIOjEBNjoTZU4MlHnS9wbG7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921761; c=relaxed/simple;
	bh=lujvGOT+ObFJ8y/vYqyRaP9TJ3/Pnk2Llj5nbE8JiSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI2IgNqZc4ClYv/3Ipd7TN3QlKrMuGtGGfyluHVrgFigHbDoKHhiv2Z52FAyEJ9DsZMKHYPOl5eWCZJUIhGp5qtyy5wBz8bAgijzE5CCqVjxD4wnk8wCAcSvm0IPGxqDsccW4oyC0RN8shlN8VmW2BiH1Z0y/zMO9cdQx/kFuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILNYZzTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILNYZzTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD820C116B1;
	Thu, 25 Jul 2024 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921760;
	bh=lujvGOT+ObFJ8y/vYqyRaP9TJ3/Pnk2Llj5nbE8JiSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILNYZzTTE9EiXX/H6+iXaheodgCDbQjcAxOvHeefSPYH6fMkrwCDdOHpcAqitR9+K
	 TKc88Nntfj4XbhDVVr+NScfw7FUFabdCBM0G5cT6oxKlDzpuoS0e6GKB1MbJheO4Db
	 X2KV9cFTjrhFn7HvXIe7gu8rwq0CIerggtQA/Bl8wOTnVconVYSYLU2YThjDARKuY8
	 M/MpcNlIkhNWIek1s3JTNDOetOLMkfHIagLkGqTpfQ0hvUi4LzKXW1MQuM77YVRNlB
	 Z5aXNBS/621PfSBHfDWmliF9gFzTH2pikPlYXYKhKWGanbkpYKDTfVUK+h6pR7CokW
	 UplNNZng6DLCA==
Date: Thu, 25 Jul 2024 21:05:52 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
Message-ID: <20240725153552.GA927762@neeraj.linux>
References: <20240723181025.187413-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723181025.187413-1-longman@redhat.com>

On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
> It was discovered that isolated CPUs could sometimes be disturbed by
> kworkers processing kfree_rcu() works causing higher than expected
> latency. It is because the RCU core uses "system_wq" which doesn't have
> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
> latency limits by using "system_unbound_wq" in the RCU core instead.
> This will ensure that those work items will not be run on CPUs marked
> as isolated.
> 

Alternative approach here could be, in case we want to keep per CPU worker
pools, define a wq with WQ_CPU_INTENSIVE flag. Are there cases where
WQ_CPU_INTENSIVE wq won't be sufficient for the problem this patch
is fixing?


- Neeraj

> Beside the WQ_UNBOUND flag, the other major difference between system_wq
> and system_unbound_wq is their max_active count. The system_unbound_wq
> has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
> is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.
> 
> Reported-by: Vratislav Bendel <vbendel@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-50220
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/rcu/tasks.h | 4 ++--
>  kernel/rcu/tree.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..494aa9513d0b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3539,10 +3539,10 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  	if (delayed_work_pending(&krcp->monitor_work)) {
>  		delay_left = krcp->monitor_work.timer.expires - jiffies;
>  		if (delay < delay_left)
> -			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> +			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
>  		return;
>  	}
> -	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> +	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
>  }
>  
>  static void
> @@ -3634,7 +3634,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
>  		}
>  	}
>  
> @@ -3704,7 +3704,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
>  		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(system_wq,
> +			queue_delayed_work(system_unbound_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>  		} else {
> -- 
> 2.43.5
> 
