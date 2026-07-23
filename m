Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AC484229;
	Thu, 23 Jul 2026 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821489; cv=none; b=rFRKm0ajzAMkO+nvM58fFuXFsbKjiLPCCFgHWq0eBYNEpnsfwd6oEu6fFEYzNDb6DVH1CJNQ/2YLTzIGscauTXjiDjvpHlTyPqtennhwq4z3t9NFCeP9mIY3uJSykvxAMZ1xbwMctASZsFCKY6QXkTJIKXSmEyCWCwa0n9SX9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821489; c=relaxed/simple;
	bh=3Ilx7IKRJQVktOxUOgvBSJeBliObNzj07juzRscbYbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEAQ37epYk4hdzQ85oWPgYtS68FSwMLLCjIy5rEWCuBx7TBGAohLNbuTNRc+G7gFop6aO8NlLLhYSOs50JzYCvxZxtH18w1r2UyHztwTm32wHIDQWuPX8h8Su57hPLO6M4ZPJGpM1VwF2NW7yaHeU5djMD8lk9nRr+X+tUssmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688821F000E9;
	Thu, 23 Jul 2026 15:44:48 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1EF17CE0AD8; Thu, 23 Jul 2026 08:44:48 -0700 (PDT)
Date: Thu, 23 Jul 2026 08:44:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Itai Handler <itai.handler@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Mark accesses to ->rcu_urgent_qs and
 ->rcu_need_heavy_qs
Message-ID: <3b09c9c4-f457-41f3-bcf2-3011feaab8c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260723074138.3093927-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723074138.3093927-1-itai.handler@gmail.com>

On Thu, Jul 23, 2026 at 10:41:38AM +0300, Itai Handler wrote:
> rcu_all_qs() and rcu_note_context_switch() read/clear the per-CPU
> ->rcu_urgent_qs and ->rcu_need_heavy_qs flags with plain raw_cpu_read()
> and this_cpu_write(), while the RCU core clears them with WRITE_ONCE() in
> rcu_disable_urgency_upon_qs().  KCSAN flags the resulting same-CPU race:
> 
>   BUG: KCSAN: data-race in rcu_all_qs / rcu_disable_urgency_upon_qs
> 
> It is benign -- the flags are advisory and rcu_all_qs() re-reads
> ->rcu_urgent_qs with smp_load_acquire() before acting on it -- but these
> are the last unmarked accesses to the two flags; every other access
> already uses READ_ONCE()/WRITE_ONCE()/smp_*.  Mark them to match.  No
> functional change.
> 
> Reproduced on a PREEMPT_NONE, CONFIG_KCSAN_INTERRUPT_WATCHER=y kernel with
> a pthreads program whose threads (two per CPU) loop reading a large file:
> 
> 	for (;;) {
> 		int fd = open("/proc/kallsyms", O_RDONLY);
> 		while (read(fd, buf, sizeof(buf)) > 0)
> 			;
> 		close(fd);
> 	}
> 
> The read()s drive cond_resched() -> rcu_all_qs() while the busy CPUs keep
> the grace period urgent, so the RCU core clears the flags concurrently.
> 
> Fixes: 2dba13f0b6c2 ("rcu: Switch urgent quiescent-state requests to rcu_data structure")
> Signed-off-by: Itai Handler <itai.handler@gmail.com>

Nice!!!  Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 95ad967adcf3..608f73286647 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -970,7 +970,7 @@ void rcu_all_qs(void)
>  {
>  	unsigned long flags;
>  
> -	if (!raw_cpu_read(rcu_data.rcu_urgent_qs))
> +	if (!READ_ONCE(*raw_cpu_ptr(&rcu_data.rcu_urgent_qs)))
>  		return;
>  	preempt_disable();  // For CONFIG_PREEMPT_COUNT=y kernels
>  	/* Load rcu_urgent_qs before other flags. */
> @@ -978,8 +978,8 @@ void rcu_all_qs(void)
>  		preempt_enable();
>  		return;
>  	}
> -	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> -	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
> +	WRITE_ONCE(*this_cpu_ptr(&rcu_data.rcu_urgent_qs), false);
> +	if (unlikely(READ_ONCE(*this_cpu_ptr(&rcu_data.rcu_need_heavy_qs)))) {
>  		local_irq_save(flags);
>  		rcu_momentary_eqs();
>  		local_irq_restore(flags);
> @@ -999,8 +999,8 @@ void rcu_note_context_switch(bool preempt)
>  	/* Load rcu_urgent_qs before other flags. */
>  	if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs)))
>  		goto out;
> -	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> -	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
> +	WRITE_ONCE(*this_cpu_ptr(&rcu_data.rcu_urgent_qs), false);
> +	if (unlikely(READ_ONCE(*this_cpu_ptr(&rcu_data.rcu_need_heavy_qs))))
>  		rcu_momentary_eqs();
>  out:
>  	rcu_tasks_qs(current, preempt);
> -- 
> 2.34.1
> 
