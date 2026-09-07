Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA3426419;
	Mon,  7 Sep 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770156; cv=none; b=Omq8zU0LNqpgXU27i/3Ot+TZheCINSwvQdpMoUlvzQQtBX7fP12bZ9CE6bMPe5+kvuQ8D7emY1sIA5kKtE/ZZqzH059ja+77bZxycJhe9WzDrTKfASddFLofpqnXSA8+FjVhfh9vFLBEKdKkmoP4S+pQ6snRWDcUnRiSm3Iava0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770156; c=relaxed/simple;
	bh=1SvoK9nIIVLBEWhSQV58URD+2Ud08VeuJeXhGxzzOg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DplmXVkHoVb1tBQ69PN4lKyknQW2vi5gpJd/FxtCuORbdbyYeOEuf0/7izmTkfVTP6ryXFOh0pOYqCZXEJtZz0xe56H6BFsd7GHOn/qxP5ks5c3wEK6F3ogcUTc9sIEKJWX2vGzyAbp3BurrAbFxB6Da/dviTchu6nXpJl7ZBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlDV0UdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlDV0UdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC061F00A3D;
	Mon,  7 Sep 2026 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770154;
	bh=AmRDoct7riDtBKsI2KwhHRknGPzx1klC4uVT+9xvqPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GlDV0UdXoMomtP016qtWdfhBcTL8gmddP/0T8F0MWrDwpxDQN2f4ko1Wocil4V+4O
	 HDiMG6LHFKKijrMY/6TKhDx5a+XeTmjTLFpH0R+2E9I8zmfOpIeOP4jpVvD1J6oiqt
	 r4zAGJtuddnX283jMvfQv5eopopQhFXVQCU400y1oiJe42/dF2HXBZZCpIA4/dAma5
	 G+MTqCyVIBxJ6lyqxpV6OxjC1tom5XFf6lhGhYlL8trsEjwuKFseaDN3Hy/1563AfD
	 idwFSfRBZGSexeqpYIZYA+bgizGrZT+uFCrKyDnUZ9DJRIT+UUNAEz6HFLpSLUqWu/
	 NFtqaJWO8/eKg==
Date: Mon, 7 Sep 2026 09:35:39 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, SJ Park <sj@kernel.org>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, tglx@kernel.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, tony.luck@intel.com, 
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org, 
	pmladek@suse.com, longman@redhat.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/8] mm/oom_kill: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap53VD4AW_pWyNcT@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-3-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-3-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:28PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs wrapping
> for_each_process()/for_each_thread() loops with for_each_process_rculock()
> and for_each_thread_rculock(), which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>  mm/oom_kill.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5f372f6e26fa..ef2e1c423c1d 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -94,8 +94,7 @@ static bool oom_cpuset_eligible(struct task_struct *start,
>  	bool ret = false;
>  	const nodemask_t *mask = oc->nodemask;
>
> -	rcu_read_lock();
> -	for_each_thread(start, tsk) {
> +	for_each_thread_rculock(start, tsk) {
>  		if (mask) {
>  			/*
>  			 * If this is a mempolicy constrained oom, tsk's
> @@ -114,7 +113,6 @@ static bool oom_cpuset_eligible(struct task_struct *start,
>  		if (ret)
>  			break;
>  	}
> -	rcu_read_unlock();
>
>  	return ret;
>  }
> @@ -368,11 +366,9 @@ static void select_bad_process(struct oom_control *oc)
>  	else {
>  		struct task_struct *p;
>
> -		rcu_read_lock();
> -		for_each_process(p)
> +		for_each_process_rculock(p)
>  			if (oom_evaluate_task(p, oc))
>  				break;
> -		rcu_read_unlock();
>  	}
>  }
>
> @@ -430,14 +426,12 @@ static void dump_tasks(struct oom_control *oc)
>  		struct task_struct *p;
>  		int i = 0;
>
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rculock(p) {
>  			/* Avoid potential softlockup warning */
>  			if ((++i & 1023) == 0)
>  				touch_softlockup_watchdog();
>  			dump_task(p, oc);
>  		}
> -		rcu_read_unlock();
>  	}
>  }
>
> @@ -894,8 +888,7 @@ static bool task_will_free_mem(struct task_struct *task)
>  	 * are dying as well to make sure that a) nobody pins its mm and
>  	 * b) the task is also reapable by the oom reaper.
>  	 */
> -	rcu_read_lock();
> -	for_each_process(p) {
> +	for_each_process_rculock(p) {
>  		if (!process_shares_mm(p, mm))
>  			continue;
>  		if (same_thread_group(task, p))
> @@ -904,7 +897,6 @@ static bool task_will_free_mem(struct task_struct *task)
>  		if (!ret)
>  			break;
>  	}
> -	rcu_read_unlock();
>
>  	return ret;
>  }
> @@ -960,8 +952,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	 * That thread will now get access to memory reserves since it has a
>  	 * pending fatal signal.
>  	 */
> -	rcu_read_lock();
> -	for_each_process(p) {
> +	for_each_process_rculock(p) {
>  		if (!process_shares_mm(p, mm))
>  			continue;
>  		if (same_thread_group(p, victim))
> @@ -982,7 +973,6 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  			continue;
>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
>  	}
> -	rcu_read_unlock();
>
>  	if (can_oom_reap)
>  		queue_oom_reaper(victim);
> --
> 2.25.1
>

--
Cheers, Lorenzo
