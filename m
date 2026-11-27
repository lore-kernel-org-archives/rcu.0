Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795844;
	b=pSxN7WCOqanki6ziwTBOhpAJOPxsexvmt1Gf1cj+HOMJ4mT/bE1Z8nGiRDa8/wRiC4FN
	 aAUqli7g4dMDeSoXM6GJGUdGCd9ci2AvT8238PrbzIWQAIOsF/ZyJAQKMw01RTq4pJZVl
	 M3EsWr9NDQ7JNv4NAv+fiDjMevoY4TxEdjv+pP4m1ssl3UpGhyaE57G0+90+NO6Q+9OBj
	 KaUPoyWUt4FE07tZCYPIf3G096Ryan4zb2t+pS3koFHl/ofe000nxghDtQuwNCKmrngF4
	 vQjf0cyKu/btHr61V+ydFW8Ne0boVGKrg0l7prqSoxYMqOt6YEApMesIoSusCMDZBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iVhsmly2cOT49BUGNNoiSt8eC/rvBwIir2jFZoGobdk=;
	b=FTNbiAtTWh7bzU3b1iTaiVFM+IwO3cD2ax7XqGGPXoaFqVqsavW7gQbaJZdiS9tBYFLM
	 woINk9LY3nClO40IBObWnaaKXJqFTktzQRtvI1BZQzAl/ibWSiXYfwr48IQehGKceMUWX
	 AURtRSBf+xITJ+RzLDo3wy5NcOJDlw6A1mW3feJEkdXHosrONOh9K8CmCz62PlPGv/Hzt
	 t11Xnkk9widW9kN9eN5i/VYRGlxzDFZEfL/Vt2r4LnUx4cj7ubW8LlcTi83hwj3/HEEKz
	 9RW8Azd+HRWiPyCQX4qYU7nUQs1o3rhY8KNflD4Vb5HNmaK7MMAhq1iTcm8PZ4uqkGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GisTdvnI;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A2606A31F
	for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 16:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE9A2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GisTdvnI
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso64238405e9.0
        for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795795842; x=1796400642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVhsmly2cOT49BUGNNoiSt8eC/rvBwIir2jFZoGobdk=;
        b=GisTdvnIDRCUhv3R+I2OJ0AwssL5m38E6DNw06NjxXL9Rt2ti1b5mU01ujDGI39Wch
         dI/SW4E4vevX5f3TxBlg8fUsT312YaEiUyl1R3ulTQadSYfBbl2bOByJnjkOoPGMfg+c
         xTo7vvZ+MEFNWDt5xJ05IPOLT+hBTG1JLadCU4mH7FH6oMNkRt3/lq1FxzzlVxtaBYAs
         xQmRKPQpd7dd9gXi5cer2vjteUh/4trlioaMxreIlG5SRyaWT1dIcpZ0H2FFLl9EiFr9
         xMYYi8bqixWie4TzIOcHbscp1pQGiJXKQ0EtTBaNEBCqlBqhwbGX5kr2+KEQMjUB00qT
         YOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795795842; x=1796400642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVhsmly2cOT49BUGNNoiSt8eC/rvBwIir2jFZoGobdk=;
        b=YtuphJCFa8AzBdUXHbRaOMV0lTaDzcIOaYShJrIOQQg+uW3NZ2ul4WDUM9QpMhq22t
         4pZlJUewrHMTkvmDQXTCX/yYLtTesuPZZfmbVUPcPWehIpHOolFyt+yDVaPDZxxLgAvL
         ySoa6Ban3rXIpnMHXA+aptP2VIbruhNsXdZYLurDlfhPDD/WVeXKm8qguKVEaD7spoOZ
         QUmXXb+46/ja/VAzsqoBHfFWuotPmyiVIGltwB+xf1BQlUhBatM+9cJCsGo8YwaJb0nX
         3DPgLRcNm2XTpYHRyoS+a6SZkAoYD5hmegQcw2t/869iWccPSyxTKb4A93z6oXCLP9Yx
         fQhA==
X-Forwarded-Encrypted: i=1; AL+hErG+80Uqnoiy9Qgc6Gxqis+FjuiSY6TO5NHCLFlntfwvDhISE9wTVxxnetsIFPTorRudnuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ehLG9bhematS1HF46vk1lFNSiPjEPuh/s3w0A8HxqpDdiBJwE
	j+Xv6jY2EALXvOucQU0WdYFvSg0wbtvEJJQbW3LHAX7pSvNHa2uDxqt20aBXK7OsYV4=
X-Gm-Gg: AZFdTZdrxgxszgbEAIExQoZg72XHuq9ozAgFf+Ox2nR6PijB14JKcuOwlNu48Pv8iIs
	lWDBJld7PjDTvWFZ/UNw/aGA8xVj0hgrF9x/xjkiivdlvx39wubQ31fqOBKoljr/iOBnm8xpuJz
	zipLSPnea7fcJ/frRAvrGdRn2H9EhB7WzZwBfUWzrkwNpvdr/YMYZEu21/LxxBSXwlNUpEfiDuw
	gEsVNe26pI9j3UwEyRmJVKqf3yptJxo9tkfuWL0ggAInAFkEHhQEFKyP0R9K3x74XrEn+Gauq3a
	jylHFzGzAhAAVg89Uw4KsEs6AW4z4DBhp1U5qw/nBbRidX+x9XvgOGaZNyZKWxtrbagoFn1bwAH
	VwGFMnxktP6Inmi4Jja4E1M7AT3t0tjt/LxUA52nh3HiaSSEbuoHfEJS0+uDzx9zajibv1QjzXZ
	kikDhAe+OwLhOLPhiL2GJdRLjUBzhauS5EZhCdxyiF3BY0yww0G3COb/Fege1hKBiWZIoTTZcw3
	xaaVIZtdHElUV2FUI/9wDiNuyuuegxHs9bcJTiiBiImjbDe+gcGwZ8hYIeQKWjJCPY9xCOXcU7D
	Afwc0t7gZMjwNoZNJEtuIYq0JKR7xQo=
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4bb88820687mr578562595e9.29.1795795841986;
        Fri, 27 Nov 2026 08:10:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm733027025e9.8.2026.11.27.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:10:41 -0800 (PST)
Date: Fri, 27 Nov 2026 17:10:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: binoy@vt.edu
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
	Jaidev Shastri <jaidevshastri@vt.edu>
Subject: Re: [PATCH v4 2/3] livepatch: Include exiting tasks in the transition
Message-ID: <awmrfuzTlVWgGgEM@pathway.suse.cz>
References: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
 <20261126-klp-series-v3-v4-2-2ad73e9c9254@vt.edu>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-klp-series-v3-v4-2-2ad73e9c9254@vt.edu>

On Thu 2026-11-26 11:41:33, Binoy Ravindran via B4 Relay wrote:
> From: Binoy Ravindran <binoy@vt.edu>
> 
> The transition walks tasks with for_each_process_thread(). A
> self-reaping task is unhashed in exit_notify() but keeps running the rest
> of do_exit(), so the walk never sees it. The transition can then
> complete, and with atomic replace the previous patch module can be
> freed, while that task is still executing, or about to return into, the
> previous module's copy of a patched function. This is the race discussed
> in the thread linked below.

I would use [1] to reference the discussion, see below.

> An exiting task is on an RCU-tasks exit list from exit_tasks_rcu_start(),
> before exit_notify(), until exit_tasks_rcu_finish(). Make every step of
> a transition also visit the tasks on these lists, using the helpers from
> the previous patch.

I would start another paragraph here.

> klp_init_transition(), klp_start_transition(),
> klp_complete_transition(), klp_reverse_transition() and
> klp_force_transition() only set fields and flags. They walk the exit
> lists in place, under tasklist_lock, and skip tasks that are still
> hashed, so that each task is visited exactly once.

I was confused by the meaning of "tasks still hashed".

Later I realized that it pointed to __unhash_process() function.
I heard about this function for the first time. I have never
met a term "hashed process" before. I never needed to study pids this
deeply.

Honestly, I think that "hashed task" is a term invented by LLMS.
It does not mean much. It is just a "poorly" chosen helper
function name in kernel/exit.c. There is no counter part
in kernel/fork.c...

Instead, I would write something like: "skip tasks which are still
accessible via the for_each_process_thread() walk, so that each
task is visited only once."

BTW: Would it hurt to process the same task twice?

     I think that it should not be a big deal. It looks like an
     optimization. But the dependence between pid_alive(),
     for_each_process_thread(), and task_list lock is pretty
     tricky. I am not sure if it is worth relying on it.

Also I would start another paragraph here.

> klp_try_complete_transition() may inspect a task's stack, so it takes a
> snapshot with a reference on each task. If the snapshot cannot be
> allocated, or more tasks start exiting than it has room for, the
> transition is treated as incomplete and retried. An exiting task must
> therefore switch, like any other task, before the transition can
> complete.
> 
> Fixes: d83a7cb375ee ("livepatch: change to a per-task consistency model")
> Link: https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/

This points to the cover letter of a patchset. Many things were
discussed there. It might be better to mention here the mail
where the discussion about livepatching do_exit() started.

Also I would use:

[1] https://lore.kernel.org/...

instead of "Link: " so that [1] can be used as a reference in
the text above.

> Assisted-by: Claude:claude-opus-5-5

This is not needed.

> Signed-off-by: Binoy Ravindran <binoy@vt.edu>
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -74,6 +75,54 @@ static void klp_synchronize_transition(void)
>  	schedule_on_each_cpu(klp_sync);
>  }
>  
> +/*
> + * Tasks past exit_notify() are off the task list but still run do_exit() and its
> + * callees, possibly from this patch's or a replaced patch's code, so the
> + * transition must cover them too. The try step inspects stacks, which needs a
> + * reference on each task, so klp_try_switch_exiting_tasks() works on a
> + * snapshot of the exit lists.
> + *
> + * The other steps run with tasklist_lock held and skip tasks that are still
> + * hashed, so every task is visited exactly once: an exiting task can be on
> + * both lists until release_task() unhashes it.

I would be more explicit here.

  * Important: Both for_each_process_thread() and rcu_tasks_exit_list
  *	must be traversed under tasklist_lock. It prevents calling
  *	__unhash_process() so that pid_alive() can be used to detect
  *	whether the task has already been proceed in
  *	for_each_process_thread() cycle.

But as I have said, I am not sure of it is worth it.

> + */
> +static void klp_exiting_init(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	t->patch_state = *(int *)arg;
> +}
> +
> +static void klp_exiting_start(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	if (t->patch_state != klp_target_state)
> +		set_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +}
> +
> +static void klp_exiting_complete(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +	t->patch_state = KLP_TRANSITION_IDLE;
> +}
> +
> +static void klp_exiting_clear_pending(struct task_struct *t, void *arg)

The name of other callbacks seems to follow the name of the function
where they are called. This one is called in klp_reverse_transition()
so I would call it:

	klp_exiting_reverse();

> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +}
> +
> +static void klp_exiting_force(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	klp_update_patch_state(t);
> +}

That said, the names look a bit confusing. It feels like these
callbacks are initializing, starting, completing, ... some exit.

I would use:

   + prefix: "klp_exit_task_*" to make it more clear
	that it is manipulating a task in some exit state.

   + same suffix as the caller, .e.g "init_transition" to
	make it clear which stage of the transition it
	manipulates.

So, rename:

  + klp_exiting_init	 -> klp_exit_task_init_transition
  + klp_exiting_start	 -> klp_exit_task_start_transition
  + klp_exiting_complete -> klp_exit_task_complete_transition
  ...


> +
>  /*
>   * The transition to the target patch state is complete.  Clean up the data
>   * structures.
> @@ -123,6 +172,7 @@ static void klp_complete_transition(void)
>  		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
>  		task->patch_state = KLP_TRANSITION_IDLE;
>  	}
> +	rcu_tasks_visit_exiting(klp_exiting_complete, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	for_each_possible_cpu(cpu) {
> @@ -419,6 +469,35 @@ static void klp_send_signals(void)
>  	read_unlock(&tasklist_lock);
>  }
>  
> +/*
> + * Try to switch every task on the exit lists. Returns false if one of them
> + * could not be switched yet, or if the snapshot could not be taken in full.
> + */
> +static bool klp_try_switch_exiting_tasks(void)
> +{
> +	struct task_struct **xt;
> +	bool complete = true;
> +	int i, n, max;
> +
> +	/*
> +	 * Size the array from a count taken now, plus slack for tasks that
> +	 * start exiting before the copy is made. If even more arrive, report
> +	 * an incomplete walk: klp_try_complete_transition() runs again later.
> +	 */
> +	max = rcu_tasks_snapshot_exiting(NULL, 0) + 64;
> +	xt = kvmalloc_array(max, sizeof(*xt), GFP_KERNEL);
> +	if (!xt)
> +		return false;
> +	n = rcu_tasks_snapshot_exiting(xt, max);
> +	for (i = 0; i < min(n, max); i++) {
> +		if (!klp_try_switch_task(xt[i]))
> +			complete = false;
> +		put_task_struct(xt[i]);
> +	}
> +	kvfree(xt);
> +	return complete && n <= max;
> +}

I did not check this function. I think that we will do it another way,
see my reply to the 1st patch.

>  /*
>   * Try to switch all remaining tasks to the target patch state by walking the
>   * stacks of sleeping tasks and looking for any to-be-patched or
> @@ -450,6 +529,8 @@ void klp_try_complete_transition(void)
>  		if (!klp_try_switch_task(task))
>  			complete = false;
>  	read_unlock(&tasklist_lock);
> +	if (!klp_try_switch_exiting_tasks())
> +		complete = false;
>  
>  	/*
>  	 * Ditto for the idle "swapper" tasks.
> @@ -489,6 +570,13 @@ void klp_try_complete_transition(void)
>  	/* Done!  Now cleanup the data structures. */
>  	klp_resched_disable();
>  	patch = klp_transition_patch;
> +	/*
> +	 * A task can leave the exit lists unswitched after the snapshot. It
> +	 * runs with preemption disabled until its final switch, so wait until
> +	 * every CPU has switched context.

Just imagine that you see this comment 2 years from now without
the fresh context. "exit list" sounds a bit vague. Also "the snapshot"
is a term that was not mentioned anywhere else.

I would be more precise. I suggest something like:

	* There might still be tasks which were already removed from
	* rcu_tasks_exit_list and were not checked above. They run with
	* the preemption disabled until they finally stop in TASK_DEAD state.
	* Make sure that they stopped running and will never run again.

Now the question is why we need to call it here and not,
for example, in klp_start_transition() or klp_reverse_transition().

IMHO, we need it here to avoid removing the ftrace trampolines and
the livepatch module when the code still might be in use.

BTW: Do we need it in all situations, for example, when the 1st
     livepatch gets enabled? In this case, nothing is removed.

Anyway, we should explain in the comment why exactly we need
the synchronization here.

> synchronize_rcu() is not enough:
> +	 * __schedule() reports the quiescent state before switch_to().

I would say that synchronize_rcu() is not enough by definition.
We are waiting for tasks which are not longer visible for RCU.

But I agree that the comment above rcu_tasks_postgp() might be confusing.
I guess that RCU does not care about tracking the rest of __schedule().

So, it makes sense to keep the comment here. I would just add it into
a separate paragraph (after an empty line).

> +	 */
> +	klp_synchronize_transition();

Hmm, I would move this up, above the comment: "/* Done!  Now cleanup
the data structures. */". Let's be on the safe side and
make sure that all tasks are safe before we start the clean up...

Or is there any reason why it is done here?

>  	klp_complete_transition();
>  
>  	/*
> @@ -526,6 +614,7 @@ void klp_start_transition(void)
>  	for_each_process_thread(g, task)
>  		if (task->patch_state != klp_target_state)
>  			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	rcu_tasks_visit_exiting(klp_exiting_start, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	/*
> @@ -579,6 +668,7 @@ void klp_init_transition(struct klp_patch *patch, int state)
>  		WARN_ON_ONCE(task->patch_state != KLP_TRANSITION_IDLE);
>  		task->patch_state = initial_state;
>  	}
> +	rcu_tasks_visit_exiting(klp_exiting_init, &initial_state);
>  	read_unlock(&tasklist_lock);
>  
>  	/*
> @@ -590,6 +680,16 @@ void klp_init_transition(struct klp_patch *patch, int state)
>  		task->patch_state = initial_state;
>  	}
>  
> +	/*
> +	 * A task that has passed exit_tasks_rcu_finish() is on neither list but
> +	 * may still call patched code until its final switch, which it makes
> +	 * with preemption disabled. This returns only after every CPU has
> +	 * switched context, so every such task is gone. synchronize_rcu() is
> +	 * not enough: __schedule() reports the quiescent state before
> +	 * switch_to().
> +	 */
> +	klp_synchronize_transition();

Why exactly do we need the synchronization here, please?

We should not need this for livepatching of do_exit(). We do not care
which do_exit() implementation is used by the about-to-die processes
at this stage.

The only problem might be if we want to livepatch a function which
is called in do_exit() after the process gets removed from the
rcu_tasks_exit_list. It might be only:

  + raw_spin_unlock_irqrestore_rcu_node()
  + lockdep_free_task()
  + do_task_dead()
  + set_special_state()
  + __schedule()

They all might start calling klp_ftrace_handler() and could need to
see consistent state current->patch_state.

But wait! If this is the problem then we might need to call
klp_synchronize_transition() in each stage which calls
rcu_tasks_visit_exiting(). Otherwise, the klp_ftrace_handler()
might see some inconsistence and trigger a WARN() or
use an inconsistent task->patch_state.

>  	/*
>  	 * Enforce the order of the task->patch_state initializations and the
>  	 * func->transition updates to ensure that klp_ftrace_handler() doesn't
> @@ -642,6 +742,7 @@ void klp_reverse_transition(void)
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, task)
>  		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	rcu_tasks_visit_exiting(klp_exiting_clear_pending, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	for_each_possible_cpu(cpu)
> @@ -714,6 +815,7 @@ void klp_force_transition(void)
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, task)
>  		klp_update_patch_state(task);
> +	rcu_tasks_visit_exiting(klp_exiting_force, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	for_each_possible_cpu(cpu)

Best Regards,
Petr

PS: It is an amazing work for a newcomer.
