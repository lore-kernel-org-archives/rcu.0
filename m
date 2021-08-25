Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C96FC4338F
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544D061076
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhHYRJl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhHYRJl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Aug 2021 13:09:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5884161058;
        Wed, 25 Aug 2021 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629911335;
        bh=UtxyPyMT37B3hC/Zps+12oz+PHhGWMUtosdIzv2AlJI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CUIR+LzgUQUS/73QoYREpFX/k17oouO/BV0xZ/iYPiMVJI1yzsG2/g7VmpogGvWnQ
         DsGTfQI1X3XPqgDITcKJMbNMA8o2HljIqjerv6uVCyoD7IBMKkLyX91EQthbPDGTIz
         T5W3nzHqwRsA/Vo+wgQxgY6MhBo5tbbakyFXOXRbZnL5c+vhkqsWMYfrPvnRgY+FK+
         RXbBDT5BK54EMhmLUGBH871+TW1HO8bd+pNn6zbr3sOcyFMtrqv2FQSXhQ5LC8nONh
         gXkmg0ALPNr8ds/UV4A7yHHozoDoqXINZE6/0f4T3Bob7+X0XaNQp/a/x4hdnX01ZP
         9BstLZQZyQCZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14DB35C0399; Wed, 25 Aug 2021 10:08:55 -0700 (PDT)
Date:   Wed, 25 Aug 2021 10:08:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 4/5] rcu-tasks: Fix read-side primitives comment for
 call_rcu_tasks_trace
Message-ID: <20210825170855.GJ4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
 <1629875451-20628-5-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629875451-20628-5-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 25, 2021 at 12:40:50PM +0530, Neeraj Upadhyay wrote:
> call_rcu_tasks_trace() does have read-side primitives - rcu_read_lock_trace()
> and rcu_read_unlock_trace(). Fix this information in the comments.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Queued for v5.16, thank you very much!

(The other four patches are already queued.)

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 244e06a..c5f1c2f 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1212,15 +1212,11 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
>   * @rhp: structure to be used for queueing the RCU updates.
>   * @func: actual callback function to be invoked after the grace period
>   *
> - * The callback function will be invoked some time after a full grace
> - * period elapses, in other words after all currently executing RCU
> - * read-side critical sections have completed. call_rcu_tasks_trace()
> - * assumes that the read-side critical sections end at context switch,
> - * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
> - * there are no read-side primitives analogous to rcu_read_lock() and
> - * rcu_read_unlock() because this primitive is intended to determine
> - * that all tasks have passed through a safe state, not so much for
> - * data-structure synchronization.
> + * The callback function will be invoked some time after a trace rcu-tasks
> + * grace period elapses, in other words after all currently executing
> + * trace rcu-tasks read-side critical sections have completed. These
> + * read-side critical sections are delimited by calls to rcu_read_lock_trace()
> + * and rcu_read_unlock_trace().
>   *
>   * See the description of call_rcu() for more detailed information on
>   * memory ordering guarantees.
> @@ -1236,7 +1232,7 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
>   *
>   * Control will return to the caller some time after a trace rcu-tasks
>   * grace period has elapsed, in other words after all currently executing
> - * rcu-tasks read-side critical sections have elapsed.  These read-side
> + * trace rcu-tasks read-side critical sections have elapsed. These read-side
>   * critical sections are delimited by calls to rcu_read_lock_trace()
>   * and rcu_read_unlock_trace().
>   *
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> hosted by The Linux Foundation
> 
