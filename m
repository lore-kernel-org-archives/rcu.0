Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60294C4338F
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE6361029
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhHCQAc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Aug 2021 12:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237135AbhHCQAc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Aug 2021 12:00:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 545D260F45;
        Tue,  3 Aug 2021 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628006421;
        bh=cn21b26xb0ddfDtkJ/ZSGanqT6OffWbsd/0X6amzDzo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DIu/sT9tsRLLSAkcqEJj9LJGX0c4tK3dROCaLYdbbGyoNF3WdFyoc44o/K8cbIwMy
         CHt5fkZrSaa2DmhDAEtNrnnhHqgR2NQFmUDvv5Lrqzwqc+DUOapW+CaSEbLf43pUvr
         +CbEByvv6UtgweVoKOPzzbVraOFZLAt9zTngpaVmibWK1acOjfgUaQxelZhF9sj20m
         ugCSoFRJkMwirvqc1IQfPfQF1cssQUGi2cNofG+m2w1/oJoTNNILfoCOvMfz3dNHlt
         Ap5WZxpGZoH7VeKRHenyWZ322ucmWUSA+swZnz97OFPOKL2hJnD6afmCsJARICDNqK
         1UdcwjYj1P1PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F7555C04D4; Tue,  3 Aug 2021 09:00:21 -0700 (PDT)
Date:   Tue, 3 Aug 2021 09:00:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 31/38] rcu: Replace deprecated CPU-hotplug functions.
Message-ID: <20210803160021.GR4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-32-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-32-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 03, 2021 at 04:16:14PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: rcu@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I have queued this one and 35/38 (rcutorture) for v5.16.  If you would
prefer to send them some other route, please let me know and:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 51f24ecd94b26..f116ce58f4e68 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4050,7 +4050,7 @@ void rcu_barrier(void)
>  	 */
>  	init_completion(&rcu_state.barrier_completion);
>  	atomic_set(&rcu_state.barrier_cpu_count, 2);
> -	get_online_cpus();
> +	cpus_read_lock();
>  
>  	/*
>  	 * Force each CPU with callbacks to register a new callback.
> @@ -4081,7 +4081,7 @@ void rcu_barrier(void)
>  					  rcu_state.barrier_sequence);
>  		}
>  	}
> -	put_online_cpus();
> +	cpus_read_unlock();
>  
>  	/*
>  	 * Now that we have an rcu_barrier_callback() callback on each
> -- 
> 2.32.0
> 
