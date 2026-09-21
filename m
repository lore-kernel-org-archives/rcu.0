Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA54A6885;
	Mon, 21 Sep 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006942; cv=none; b=gv5/aPv9QxTECoHxEnv30YOEvUoJNCAG5BIRM/FSH00ntQblaIjTIlwOqkHzCOA0XS5xE1MXc2dXZJx6E5WBRIyNUS0QHj22MkK/DFBK9PYaPvDy0MrhefC+A+lbhxYO0W3lCuYUO5Lp2IMhfF/XCa4vHJHE4h/VvK58HNUu7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006942; c=relaxed/simple;
	bh=+Ca6tglu5oyhC46HUGwjSP8wMmqDs5loib6dloR0A38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joRKh5azkr/peNGsgUUtAhd2Og1PwFwJqGLe3SzeEdkTEwVHUABTfuza5WgvE2ez+REsqA2gfj7bqCZlM80jWSLycCHJz+Smpl3mjFcegMAup9HtoMX72HBjBRUISIbfplzGU/iegOenD2iR8ITvm6oGPoxMlzYqFg8j+EvShwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6lco+9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6lco+9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562381F00893;
	Mon, 21 Sep 2026 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006941;
	bh=FOTV0PHDPjv7T4ZC0QP6/caxtiiGCzPPnekS36QsNyQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=I6lco+9iUwAqO3zjgvumlLA5C/VhfXUwEk6SUo3gSkM4oTj4GvL0t3U4GwpiU+aFj
	 MuMQAuyChxeRaQp9gYkR2DtCDN4T1OrLkPS/ojp2WE1cPoM0iooDGXYr3uoSn+xBaF
	 1C4QW+Ll5f789AvK2JwPuRCnzDwI7zwh/Z6gxDafAIWJqj29JrwN5sDfbpFTNBIxuQ
	 RI0QQS1cRnfDeaKYL1XiMw7v1/N4mZbcxHYmuzsbK6XXOfv/eU0pbJM+zgoumIdeIW
	 Nle6h3WO6Yslfm1dRJRE7tO9hPI5pG+0mtAOpVKKRdAa4lPpCtQWILF8WzQSn3IXYA
	 79HqW3QApVSLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1541ECE086B; Mon, 21 Sep 2026 09:09:01 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:09:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org,
	peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org,
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	rafael@kernel.org, gnoack3000@gmail.com, gourry@gourry.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, will@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, tony.luck@intel.com,
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com,
	longman@redhat.com, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, mark.rutland@arm.com,
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com
Subject: Re: [PATCH v4 09/15] rcu: convert process/thread iterator to
 for_each_process_thread_rculock
Message-ID: <f0c6954c-1e43-4a01-9c9d-11d38edc1e2c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-10-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921092101.89285-10-ye.liu@linux.dev>

On Mon, Sep 21, 2026 at 05:20:55PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process_thread() loop in kernel/rcu/update.c with
> for_each_process_thread_rculock(), which scopes the RCU read lock
> to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/update.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 2a778b8ab4ad..d8e0b5896db9 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -548,15 +548,13 @@ void synchronize_rcu_trivial_preempt(void)
>  	struct task_struct *t;
>  
>  	smp_mb(); // Order prior accesses before grace-period start.
> -	rcu_read_lock(); // Protect task list.
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (t == current)
>  			continue;  // Don't deadlock on ourselves!
>  		// Order later rcu_read_lock() on other tasks after QS.
>  		while (smp_load_acquire(&t->rcu_trivial_preempt_nesting))
>  			continue;
>  	}
> -	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_trivial_preempt);
>  #endif // #if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
> -- 
> 2.25.1
> 
