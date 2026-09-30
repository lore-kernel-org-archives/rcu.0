Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A83B776D;
	Wed, 30 Sep 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794069; cv=none; b=TxlbInasUC3eL1xEHiinyXLbg0HVkJvUDdfGVZS8jyo45lejIU9gxugnhFZMVzKDc3L3/31d3euLhoEpFvV1JyAZdtfzF15sPDEumEmoObI90gPohpLC2KZWWh4Bp/wveyKYwh55sJwvuuzy/Bt6cQSwGLeQfB7n5Jw58yJm+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794069; c=relaxed/simple;
	bh=H5aXeE6WGmp4M62+88TeasrTlkwF06kWvGVgIMQpO6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbGGd6Vdqe9+7lnhcdJkPJXZsP8CYV+iOopq+22GF2nBAtS9WffGeZ67XK1/cbzTk+NCOk16+rdAbkP51rj/f8y6mZ7BRw+3BY578RFgpcEB18FZExjQq4Hoyy0RUv2V3kN9aXKfNX1TT4HWQlLL6gZQZ0+vI5MQAj1lX/owEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL5x368R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL5x368R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82B01F000FF;
	Wed, 30 Sep 2026 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794067;
	bh=+vCnSZvPQg/0u3QKomGRccvP1Y+xplcth0DjFn3jei0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=SL5x368RtQQUYO4NQOxCZL6bmRj8ob9UyNeb/aiJghF/SC9+QXA3/1I1MbaCItet7
	 SwjbuQ/VDveivp7wFoOE6ux30SyTlmmrnSkuU4bRQT/vvCTxynAROhAOJ7f/TUQSv8
	 qdXSwHnbV63evPW+V0Cic2/lICNLh/16gM7tDI5PZYjg2TIlBXtJR3G26z6L+FsDrl
	 G8Ac/wV2gCg+5ryZ7qcQ4b/FOG55Naow37cosdHbM+tUAqhM+E8B7U8Mo5/l4+NYvY
	 mz6J1DwVrHYZWcPlkMsCXHFeQLlV5lWBbw4i9sp8vOTmiFoAuAsWbMENSbsD+/kgcR
	 jtti4iE+fcrTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6A179CE097C; Wed, 30 Sep 2026 11:47:47 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:47:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] fprobe: Use guard(rcu_sched_notrace) and check
 rcu_is_watching()
Message-ID: <1095daf7-fd78-4bbd-87f4-1d487d80fd53@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <179064115227.394389.16910234241400391996.stgit@devnote2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179064115227.394389.16910234241400391996.stgit@devnote2>

On Tue, Sep 29, 2026 at 09:19:12AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> unregister_fprobe() and unregister_fprobe_async() (used by BPF
> kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
> and call_rcu()) to wait until in-flight fprobe handlers complete before
> freeing the fprobe.
> 
> However, if an fprobe handler executes while RCU is not watching (such
> as in the idle loop or nohz_full extended quiescent states), standard
> RCU does not track preemption-disabled sections. Consequently,
> synchronize_rcu() does not wait for those executions, which can lead
> to a use-after-free if the fprobe is freed immediately after
> unregistration. Ensure handlers exit early when !rcu_is_watching().
> 
> Furthermore, fprobe_fgraph_entry() and fprobe_ftrace_entry() previously
> used guard(rcu)() and rcu_read_lock(), which invoke lockdep on every
> hit under CONFIG_PROVE_LOCKING. This adds overhead and can cause lockdep
> recursion if probed functions interact with lockdep.
> 
> Since rhltable_lookup() and rhl_for_each_entry_rcu() use
> rcu_dereference_all_check() (which checks rcu_read_lock_any_held()),
> holding preemption disabled via rcu_read_lock_sched_notrace() is fully
> valid and sufficient so long as rcu_is_watching() is true.
> 
> Define and use guard(rcu_sched_notrace)() across fprobe_ftrace_entry(),
> fprobe_fgraph_entry(), and fprobe_return(). This eliminates fast-path
> rcu_read_lock() and lockdep overhead while guaranteeing safe grace
> period synchronization.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
> Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace period")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

From an RCU perspective:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/trace/fprobe.c |   26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9f2d98181779..da286619c5d8 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -47,6 +47,10 @@ static struct rhltable fprobe_ip_table;
>  static DEFINE_MUTEX(fprobe_mutex);
>  static struct fgraph_ops fprobe_graph_ops;
>  
> +DEFINE_LOCK_GUARD_0(rcu_sched_notrace,
> +		    rcu_read_lock_sched_notrace(),
> +		    rcu_read_unlock_sched_notrace())
> +
>  static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
>  {
>  	return hash_ptr(*(unsigned long **)data, 32);
> @@ -329,16 +333,14 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
>  	struct fprobe *fp;
>  	int bit;
>  
> +	if (!rcu_is_watching())
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
>  
> -	/*
> -	 * ftrace_test_recursion_trylock() disables preemption, but
> -	 * rhltable_lookup() checks whether rcu_read_lcok is held.
> -	 * So we take rcu_read_lock() here.
> -	 */
> -	rcu_read_lock();
> +	guard(rcu_sched_notrace)();
>  	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
>  
>  	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> @@ -353,7 +355,6 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
>  		else
>  			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
>  	}
> -	rcu_read_unlock();
>  	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(fprobe_ftrace_entry);
> @@ -567,10 +568,13 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  	struct fprobe *fp;
>  	int used, ret;
>  
> +	if (!rcu_is_watching())
> +		return 0;
> +
>  	if (WARN_ON_ONCE(!fregs))
>  		return 0;
>  
> -	guard(rcu)();
> +	guard(rcu_sched_notrace)();
>  	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>  	reserved_words = 0;
>  	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> @@ -665,13 +669,16 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  	int size, curr;
>  	int size_words;
>  
> +	if (!rcu_is_watching())
> +		return;
> +
>  	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
>  	if (WARN_ON_ONCE(!fgraph_data))
>  		return;
>  	size_words = SIZE_IN_LONG(size);
>  	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
>  
> -	preempt_disable_notrace();
> +	guard(rcu_sched_notrace)();
>  
>  	curr = 0;
>  	while (size_words > curr) {
> @@ -687,7 +694,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  		}
>  		curr += size;
>  	}
> -	preempt_enable_notrace();
>  }
>  NOKPROBE_SYMBOL(fprobe_return);
>  
> 
