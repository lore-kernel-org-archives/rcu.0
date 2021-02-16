Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC04AC433DB
	for <rcu@archiver.kernel.org>; Tue, 16 Feb 2021 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDF864E08
	for <rcu@archiver.kernel.org>; Tue, 16 Feb 2021 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhBPRvM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBPRu4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Feb 2021 12:50:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A042164E09;
        Tue, 16 Feb 2021 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613497815;
        bh=fzVxe+956on+kfkrENjiXjJkr69JNcCsiD1xIAA6V0Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TSpwAEJizbvvExyjILalBn8Tet7+cuECBUiv5qnU9O/nrAPM2jtUwYSlP8BCJyOmH
         sF1zHGhS4xhmKCWgmGFw//iVRr1jN8YH3PYxBDMs61O+jPymNBhlLZI1kWWzxhWClc
         eIGBJkQANrPVgfVmY3Ob2g2l8Uk/oTTs1DjSWbb7aVvH/h5n/MwLFFS+4uAOus2Scw
         O1/jID8cEYdB3FeboJk9wBn1HMhJw6oVeNJZGWHRrlsbwUq3LTIVJZlkbYB0SlL4g+
         F3JbFv/DA6Iz7qPUQCgFU9a3FAKb4sWRlLiGHLLruj3taqNbWQ+xDSSgz/0oE3dvsf
         FmXveQBxMQobw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 66EAA35238D3; Tue, 16 Feb 2021 09:50:15 -0800 (PST)
Date:   Tue, 16 Feb 2021 09:50:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210216175015.GZ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CGME20210215090241epcas1p17b1319d38de5a09a9d65a06ebf936866@epcas1p1.samsung.com>
 <20210215085325.5461-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215085325.5461-1-sangmoon.kim@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
> The event allows us to trace the RCU stall when
> sysctl_panic_on_rcu_stall is disabled.
> 
> The first parameter is the name of RCU flavour like other trace
> events. The second one shows us which function detected stalls.
> 
> The RCU stall is mainly caused by external factors such as interrupt
> handling or task scheduling or something else. Therefore, this event
> uses TRACE_EVENT macro, not dedicated one, so that someone interested
> in the RCU stall can use it without CONFIG_RCU_TRACE.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>

The patch looks plausible, but I have to ask...  Why not instead just
get the existing information out of the console log?

							Thanx, Paul

> ---
>  include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
>  kernel/rcu/tree_exp.h      |  2 ++
>  kernel/rcu/tree_stall.h    |  2 ++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..8476f3161bd0 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
>  		  __entry->cpu, __entry->qsevent)
>  );
>  
> +/*
> + * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
> + * and a string identifying which function detected the RCU stall as follows:
> + *
> + *	"StallDetected": Scheduler-tick detects other CPU's stalls.
> + *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
> + *	"ExpeditedStall": Expedited grace period detects stalls.
> + */
> +TRACE_EVENT(rcu_stall_warning,
> +
> +	TP_PROTO(const char *rcuname, const char *msg),
> +
> +	TP_ARGS(rcuname, msg),
> +
> +	TP_STRUCT__entry(
> +		__field(const char *, rcuname)
> +		__field(const char *, msg)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->rcuname = rcuname;
> +		__entry->msg = msg;
> +	),
> +
> +	TP_printk("%s %s",
> +		  __entry->rcuname, __entry->msg)
> +);
> +
>  #endif /* #if defined(CONFIG_TREE_RCU) */
>  
>  /*
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 8760b6ead770..c16618284cb2 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -566,6 +566,8 @@ static void synchronize_rcu_expedited_wait(void)
>  				dump_cpu_task(cpu);
>  			}
>  		}
> +		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> +
>  		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
>  	}
>  }
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 70d48c52fabc..e93df4fac5b1 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -531,6 +531,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	rcu_check_gp_kthread_starvation();
>  
> +	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
>  	panic_on_rcu_stall();
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
> @@ -575,6 +576,7 @@ static void print_cpu_stall(unsigned long gps)
>  			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
> +	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
>  	panic_on_rcu_stall();
>  
>  	/*
> -- 
> 2.17.1
> 
