Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F936C433F5
	for <rcu@archiver.kernel.org>; Tue,  9 Nov 2021 14:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A261027
	for <rcu@archiver.kernel.org>; Tue,  9 Nov 2021 14:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhKIOzV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Nov 2021 09:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhKIOzV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Nov 2021 09:55:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42FB860F6E;
        Tue,  9 Nov 2021 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636469555;
        bh=2wCF/vXVwMATKmiQt0OtS+R6byTCRWgcCEjKTvJDZoQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dGlEhDQL0ZdowIyZQvg1cmRoq7W1ew1Gc5E3571c9O34824aD2UMQoAZOR8lRb6pc
         lcYrB4QO40ck14u9rv3UAplI018r0DnJGB3y6FHSXI+wgpC3m7AZiO2HRcj8Opjwjs
         zL2C6f/zLCydNukqalR0o1NC/8+Ee3VmX5a7SuGl6TOea910nTvWqLcuCvpKFTJqGT
         SAImWH2VzyjzF++cTDeuFcT3qTFJkmTJXwhhvo6COvc82/9wRrGtMeK3SUS+wBBsyY
         +GzvW2BNAudkTz009iKwN6T/sFAjUFalhJFnGQtud82YFZJL/OgrgZ89eddJlNr6Lu
         Qfl/WuDQNLa1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D3A45C0154; Tue,  9 Nov 2021 06:52:35 -0800 (PST)
Date:   Tue, 9 Nov 2021 06:52:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] rcu-tasks: Inspect stalled task's trc state in locked
 state
Message-ID: <20211109145235.GV641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211109112214.19618-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109112214.19618-1-quic_neeraju@quicinc.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 09, 2021 at 04:52:14PM +0530, Neeraj Upadhyay wrote:
> On RCU tasks trace stall, inspect the RCU-tasks-trace specific
> states of stalled task in locked down state, using try_invoke_
> on_locked_down_task(), to get reliable trc state of a non-running
> stalled task.
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Queued for further review and testing, thank you!

Along those lines, what did you do to test this?  I would like to
add that to the commit message.  (The usual approach is to use the
rcutorture.stall_cpu module parameter, in case I have not yet passed
that along.)

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e4a32db9f712..4e49b847971b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1073,25 +1073,50 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
>  	// Any tasks that exit after this point will set ->trc_reader_checked.
>  }
>  
> +/* Communicate task state back to the RCU tasks trace stall warning request. */
> +struct trc_stall_chk_rdr {
> +	int nesting;
> +	int ipi_to_cpu;
> +	u8 needqs;
> +};
> +
> +static bool trc_check_slow_task(struct task_struct *t, void *arg)
> +{
> +	struct trc_stall_chk_rdr *trc_rdrp = arg;
> +
> +	if (task_curr(t))
> +		return false; // It is running, so decline to inspect it.
> +	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
> +	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
> +	trc_rdrp->needqs = READ_ONCE(t->trc_reader_special.b.need_qs);
> +	return true;
> +}
> +
>  /* Show the state of a task stalling the current RCU tasks trace GP. */
>  static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
>  {
>  	int cpu;
> +	struct trc_stall_chk_rdr trc_rdr;
> +	bool is_idle_tsk = is_idle_task(t);
>  
>  	if (*firstreport) {
>  		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
>  		*firstreport = false;
>  	}
> -	// FIXME: This should attempt to use try_invoke_on_nonrunning_task().
>  	cpu = task_cpu(t);
> -	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
> -		 t->pid,
> -		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) >= 0],
> -		 ".i"[is_idle_task(t)],
> -		 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
> -		 READ_ONCE(t->trc_reader_nesting),
> -		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
> -		 cpu);
> +	if (!try_invoke_on_locked_down_task(t, trc_check_slow_task, &trc_rdr))
> +		pr_alert("P%d: %c\n",
> +			 t->pid,
> +			 ".i"[is_idle_tsk]);
> +	else
> +		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
> +			 t->pid,
> +			 ".I"[trc_rdr.ipi_to_cpu >= 0],
> +			 ".i"[is_idle_tsk],
> +			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
> +			 trc_rdr.nesting,
> +			 " N"[!!trc_rdr.needqs],
> +			 cpu);
>  	sched_show_task(t);
>  }
>  
> -- 
> 2.17.1
> 
