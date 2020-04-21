Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F4C38A30
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 01:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502752078C
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 01:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgDUBXB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDUBXA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 21:23:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD512070B;
        Tue, 21 Apr 2020 01:22:59 +0000 (UTC)
Date:   Mon, 20 Apr 2020 21:22:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200420212257.4332734f@oasis.local.home>
In-Reply-To: <20200420201723.GA4192@pc636>
References: <20200420132601.GY17661@paulmck-ThinkPad-P72>
        <20200420160847.GA11451@pc636>
        <20200420162534.GD17661@paulmck-ThinkPad-P72>
        <20200420162900.GA11867@pc636>
        <20200420164657.GE17661@paulmck-ThinkPad-P72>
        <20200420165924.GA12078@pc636>
        <20200420172126.GG17661@paulmck-ThinkPad-P72>
        <20200420174019.GB12196@pc636>
        <20200420175915.GH17661@paulmck-ThinkPad-P72>
        <20200420190650.GA12775@pc636>
        <20200420201723.GA4192@pc636>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 20 Apr 2020 22:17:23 +0200
Uladzislau Rezki <urezki@gmail.com> wrote:



<rant>
I really wish you would crop your email. If I scroll down three pages
without seeing any reply, I usually stop reading there.
</rant>

> > >  
> Paul, i have just measured the time duration of the schedule_delayed_work().
> To do that i used below patch:
> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 02f73f7bbd40..f74ae0f3556e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3232,6 +3232,12 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
>         return ((struct rcu_head *) ++ptr);
>  }
>  
> +static void noinline
> +measure_schedule_delayed_work(struct kfree_rcu_cpu *krcp)
> +{
> +       schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +}
> +
>  /*
>   * Queue a request for lazy invocation of appropriate free routine after a
>   * grace period. Please note there are three paths are maintained, two are the
> @@ -3327,8 +3333,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>                         !krcp->monitor_todo) {
>                 krcp->monitor_todo = true;
> -               schedule_delayed_work(&krcp->monitor_work,
> -                       expedited_drain ? 0 : KFREE_DRAIN_JIFFIES);
> +               measure_schedule_delayed_work(krcp);
>         }
> <snip>
> 
> i have done it for not CONFIG_PREEMPT_RT kernel, i do not have any RT configuration.
> I run rcuperf to apply the load to see the time taken by the actual placing of the work,
> i.e. the time taken by schedule_delayed_work():
> 
> <snip>
> root@pc636:/sys/kernel/debug/tracing# cat trace
> # tracer: function_graph
> #
> # function_graph latency trace v1.1.5 on 5.6.0-rc6+
> # --------------------------------------------------------------------
> # latency: 0 us, #16/16, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #P:4)
> #    -----------------
> #    | task: -0 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #
> #                                       _-----=> irqs-off
> #                                      / _----=> need-resched
> #                                     | / _---=> hardirq/softirq
> #                                     || / _--=> preempt-depth
> #                                     ||| /
> #     TIME        CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
> #      |          |     |    |        ||||      |   |                     |   |   |   |
>   682.384653 |   1)    <idle>-0    |  d.s. |   5.329 us    |  } /* measure_schedule_delayed_work.constprop.86 */

Strange output. Do you have all functions being traced? That could
cause overhead.

Try this:

	# echo measure_schedule_delayed_work > set_ftrace_filter
	# echo function_graph > current_tracer
	# cat trace

That will give you much better timings of the overhead of a single
function.

-- Steve



>   685.374654 |   2)    <idle>-0    |  d.s. |   5.392 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   700.304647 |   2)    <idle>-0    |  d.s. |   5.650 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   710.331280 |   3)    <idle>-0    |  d.s. |   5.145 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   714.387943 |   1)    <idle>-0    |  d.s. |   9.986 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   720.251229 |   0)    <idle>-0    |  d.s. |   5.292 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   725.211208 |   2)    <idle>-0    |  d.s. |   5.295 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   731.847845 |   1)    <idle>-0    |  d.s. |   5.048 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   736.357802 |   2)    <idle>-0    |  d.s. |   5.134 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   738.287785 |   1)    <idle>-0    |  d.s. |   5.863 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   742.214431 |   1)    <idle>-0    |  d.s. |   5.202 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   759.844264 |   2)    <idle>-0    |  d.s. |   5.375 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   764.304218 |   1)    <idle>-0    |  d.s. |   5.650 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   766.224204 |   3)    <idle>-0    |  d.s. |   5.015 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   772.410794 |   1)    <idle>-0    |  d.s. |   5.061 us    |  } /* measure_schedule_delayed_work.constprop.86 */
>   781.370691 |   1)    <idle>-0    |  d.s. |   5.165 us    |  } /* measure_schedule_delayed_work.constprop.86 */
> root@pc636:/sys/kernel/debug/tracing# cat tracing_thresh
> 5
> root@pc636:/sys/kernel/debug/g/tracing# <snip>
> 
> --
> Vlad Rezki

