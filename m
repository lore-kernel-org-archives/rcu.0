Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198713AEF49;
	Wed, 22 Jul 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757210; cv=none; b=MqJJjDjDEn15gHhsa8onWU/HmmKs/8mGXrsuPuGnl7K/U3obWT9fvUqwWhKosaNcrm4SM42zIn+dDI9XmShb+2iPRLc8wZpKvFLg/fRNZ4oXq1NzDc6LvqpzrpqtM5047vD4YV6DXu0l8MuMAxOxLBk+NAoYetYvXw2Hptq/YJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757210; c=relaxed/simple;
	bh=uRaQ9nUJpJ+uYP2Yg1Z/5iVH9gDbdUHU7WpvaCArxUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVtJWqi+FTXURFuteTTwMwMNz3U4kDbEciC0EF/LI57j1e/X+kjStY/yken5uQraUNQoUytQRJu2WF9hhLW9wBFNKLSg5SalgSIuDKnIWgpl9UQ2Sg8r7sMfaChHTqkbxqwiQ5gh/A6XP3kdnXPb8krCNbmOnlUAY5hWYEcGvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq2UP+5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq2UP+5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D8B1F000E9;
	Wed, 22 Jul 2026 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784757208;
	bh=1udDMHdVK3m2HyTsXb1e3TKymOkYiU7RNpACKHip6wk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Sq2UP+5S/NgZGMyMWgPWaEU8v72UZkTJl7TGvWTwN9lN2yqM5x5qg5L4kAtVHA+y6
	 epr59mRF6Z1eHRu+8ru7oC2DDvBUy00yW+JUd+/UzNKS7LYuVp8ijHJqmmLT61O3Q5
	 9sr6QzJSrSliIT/IeJJC9BxPe5hvp+DQWHWY9Egm+txRvAdSPrqxS/UroiAyvbQm08
	 pAfZXpZuRC3my+z57v858RVfmYl1IAeG/WWSZlO6e89mtzTVJ6nbT82a61qYQsctka
	 NyrLhnU3RPZJjtH+P/nPUcpgHZPNAaxi9JZFUQIdtLSTFCxkmbUUUQKTfe2Bm4yAmj
	 wq1f7g3JEvjRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6311BCE08CF; Wed, 22 Jul 2026 14:53:28 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:53:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Rename tasks_rcu_exit_srcu_stall_timer to
 tasks_rcu_exit_stall_timer
Message-ID: <a29d33bd-98db-4fff-b2b0-c5b4db0d5f4a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260720094958.30587-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720094958.30587-1-qiang.zhang@linux.dev>

On Mon, Jul 20, 2026 at 05:49:58PM +0800, Zqiang wrote:
> This 'commit 1612160b9127 ("rcu-tasks: Eliminate deadlocks involving
> do_exit() and RCU tasks")' has reimplemented the rcu_tasks_postscan(),
> and the synchronize_srcu() has been removed, this commit therefore
> rename tasks_rcu_exit_srcu_stall_timer to tasks_rcu_exit_stall_timer.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Looks good, thank you!

I have pulled in this one and these two for further review and testing:

d5dc5dcbb734 ("rcu-tasks: Fix some comments for call_rcu_tasks() and call_rcu_tasks_rude()")
2e0af5dcb796 ("rcu: Remove unused rdp parameter from rcu_check_gp_start_stallZ()")

There is some chance of these making the upcoming v7.3 merge window,
but no promises.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index ff803871b577..23c6a2fed487 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -155,8 +155,8 @@ static struct rcu_tasks rt_name =							\
>  #ifdef CONFIG_TASKS_RCU
>  
>  /* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
> -static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
> -static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
> +static void tasks_rcu_exit_stall(struct timer_list *unused);
> +static DEFINE_TIMER(tasks_rcu_exit_stall_timer, tasks_rcu_exit_stall);
>  #endif
>  
>  /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
> @@ -1032,8 +1032,8 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  	int rtsi = READ_ONCE(rcu_task_stall_info);
>  
>  	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
> -		tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
> -		add_timer(&tasks_rcu_exit_srcu_stall_timer);
> +		tasks_rcu_exit_stall_timer.expires = jiffies + rtsi;
> +		add_timer(&tasks_rcu_exit_stall_timer);
>  	}
>  
>  	/*
> @@ -1086,7 +1086,7 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  	}
>  
>  	if (!IS_ENABLED(CONFIG_TINY_RCU))
> -		timer_delete_sync(&tasks_rcu_exit_srcu_stall_timer);
> +		timer_delete_sync(&tasks_rcu_exit_stall_timer);
>  }
>  
>  /* See if tasks are still holding out, complain if so. */
> @@ -1158,7 +1158,7 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
>  	synchronize_rcu();
>  }
>  
> -static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
> +static void tasks_rcu_exit_stall(struct timer_list *unused)
>  {
>  #ifndef CONFIG_TINY_RCU
>  	int rtsi;
> @@ -1168,8 +1168,8 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
>  		__func__, rcu_tasks.kname, rcu_tasks.tasks_gp_seq,
>  		tasks_gp_state_getname(&rcu_tasks), jiffies - rcu_tasks.gp_jiffies);
>  	pr_info("Please check any exiting tasks stuck between calls to exit_tasks_rcu_start() and exit_tasks_rcu_finish()\n");
> -	tasks_rcu_exit_srcu_stall_timer.expires = jiffies + rtsi;
> -	add_timer(&tasks_rcu_exit_srcu_stall_timer);
> +	tasks_rcu_exit_stall_timer.expires = jiffies + rtsi;
> +	add_timer(&tasks_rcu_exit_stall_timer);
>  #endif // #ifndef CONFIG_TINY_RCU
>  }
>  
> -- 
> 2.17.1
> 
