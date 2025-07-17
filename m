Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02ED2EBBAE;
	Thu, 17 Jul 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759289; cv=none; b=LJbzEzN5W05TgSN1CtE+UYWQaD6MUncq9XgPXTQYhaRaME4NkwvN79wmFanX8KDbMngcXHijQt6pcMTSX6IWBo6a+zHMqU8nzvU6M3PU10DIvz5qt5aY4MraVQzqhYIQENbb3jpAodkV4hYjLOWo33gYwW501arn8PngaDe7aMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759289; c=relaxed/simple;
	bh=N17lcip5xVPoQD+TFin5urXVNUr0BGOOZWXqfYJOvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD04XYDMX7D+E4f2SD6lPFh4W3dbfns8teMsBhLXoB4fkFOQicutNExLhOHN0BpUAPBeZ+Pr6IQqeowU5VAXpjGd6M0iJzLxOFWc6C5DQWF76mMbN85OM0sxGUEwewbDNDerqxlgi0VIo5sO4/etI22ehaToSLenccfOPEV+rMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw3fmP3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw3fmP3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE04EC4CEE3;
	Thu, 17 Jul 2025 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752759289;
	bh=N17lcip5xVPoQD+TFin5urXVNUr0BGOOZWXqfYJOvDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zw3fmP3Ej/UUXMQw3cQ2bCnSKH21C5fqKi7M1D0iQWcGY/54wxKO6PHcbwnNSAnTk
	 KPiRDPO/ep7Ccb7fC11Tdx/NxAt/uozjeSTLgx50PtZkGu6edDy+1jVgDZqBlezEEC
	 +vWi//koGAJYIsSD940iTETcUrymC2XqBh/NmZ3rrxv5OOFKHYFAKb1O/pQR1VGZAq
	 pUyA02BNZRoAbpQXeR2xI7Pwx5itPB27MXZl488EhZ3rpfmyFXQMWw0oLtCQNOpY4k
	 27Yo+9gsGk72vxU6s1KTcnJ7VRRH46Dtp65dZBEPdsz884klLtO8V0r+yirXhZLz5v
	 s3JDWj0J9hJ9Q==
Date: Thu, 17 Jul 2025 15:34:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc: rcu@vger.kernel.org, bobule.chang@mediatek.com,
	wsd_upstream@mediatek.com,
	Cheng-jui Wang <cheng-jui.wang@mediatek.com>,
	Lorry.Luo@mediatek.com, weiyangyang@vivo.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] rcu: Fix delayed execution of hurry callbacks
Message-ID: <aHj79rtgLm-7tT9E@localhost.localdomain>
References: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>

Le Thu, Jul 17, 2025 at 01:53:38PM +0800, Tze-nan Wu a écrit :
> We observed a regression in our customer’s environment after enabling
> CONFIG_LAZY_RCU. In the Android Update Engine scenario, where ioctl() is
> used heavily, we found that callbacks queued via call_rcu_hurry (such as
> percpu_ref_switch_to_atomic_rcu) can sometimes be delayed by up to 5
> seconds before execution. This occurs because the new grace period does
> not start immediately after the previous one completes.
> 
> The root cause is that the wake_nocb_gp_defer() function now checks
> "rdp->nocb_defer_wakeup" instead of "rdp_gp->nocb_defer_wakeup". On CPUs
> that are not rcuog, "rdp->nocb_defer_wakeup" may always be
> RCU_NOCB_WAKE_NOT. This can cause "rdp_gp->nocb_defer_wakeup" to be
> downgraded and the "rdp_gp->nocb_timer" to be postponed by up to 10
> seconds, delaying the execution of hurry RCU callbacks.
> 
> The trace log of one scenario we encountered is as follow:
>   // previous GP ends at this point
>   rcu_preempt   [000] d..1.   137.240210: rcu_grace_period: rcu_preempt 8369 end
>   rcu_preempt   [000] .....   137.240212: rcu_grace_period: rcu_preempt 8372 reqwait
>   // call_rcu_hurry enqueues "percpu_ref_switch_to_atomic_rcu", the callback waited on by UpdateEngine
>   update_engine [002] d..1.   137.301593: __call_rcu_common: wyy: unlikely p_ref = 00000000********. lazy = 0
>   // FirstQ on cpu 2 rdp_gp->nocb_timer is set to fire after 1 jiffy (4ms)
>   // and the rdp_gp->nocb_defer_wakeup is set to RCU_NOCB_WAKE
>   update_engine [002] d..2.   137.301595: rcu_nocb_wake: rcu_preempt 2 FirstQ on cpu2 with rdp_gp (cpu0).
>   // FirstBQ event on cpu2 during the 1 jiffy, make the timer postpond 10 seconds later.
>   // also, the rdp_gp->nocb_defer_wakeup is overwrite to RCU_NOCB_WAKE_LAZY
>   update_engine [002] d..1.   137.301601: rcu_nocb_wake: rcu_preempt 2 WakeEmptyIsDeferred
>   ...
>   ...
>   ...
>   // before the 10 seconds timeout, cpu0 received another call_rcu_hurry
>   // reset the timer to jiffies+1 and set the waketype = RCU_NOCB_WAKE.
>   kworker/u32:0 [000] d..2.   142.557564: rcu_nocb_wake: rcu_preempt 0 FirstQ
>   kworker/u32:0 [000] d..1.   142.557576: rcu_nocb_wake: rcu_preempt 0 WakeEmptyIsDeferred
>   kworker/u32:0 [000] d..1.   142.558296: rcu_nocb_wake: rcu_preempt 0 WakeNot
>   kworker/u32:0 [000] d..1.   142.558562: rcu_nocb_wake: rcu_preempt 0 WakeNot
>   // idle(do_nocb_deferred_wakeup) wake rcuog due to waketype == RCU_NOCB_WAKE
>   <idle>        [000] d..1.   142.558786: rcu_nocb_wake: rcu_preempt 0 DoWake
>   <idle>        [000] dN.1.   142.558839: rcu_nocb_wake: rcu_preempt 0 DeferredWake
>   rcuog/0       [000] .....   142.558871: rcu_nocb_wake: rcu_preempt 0 EndSleep
>   rcuog/0       [000] .....   142.558877: rcu_nocb_wake: rcu_preempt 0 Check
>   // finally rcuog request a new GP at this point (5 seconds after the FirstQ event)
>   rcuog/0       [000] d..2.   142.558886: rcu_grace_period: rcu_preempt 8372 newreq
>   rcu_preempt   [001] d..1.   142.559458: rcu_grace_period: rcu_preempt 8373 start
>   ...
>   rcu_preempt   [000] d..1.   142.564258: rcu_grace_period: rcu_preempt 8373 end
>   rcuop/2       [000] D..1.   142.566337: rcu_batch_start: rcu_preempt CBs=219 bl=10
>   // the hurry CB is invoked at this point
>   rcuop/2       [000] b....   142.566352: blk_queue_usage_counter_release: wyy: wakeup. p_ref = 00000000********.
> 
> This patch changes the condition to check "rdp_gp->nocb_defer_wakeup" in
> the lazy path. This prevents an already scheduled "rdp_gp->nocb_timer"
> from being postponed and avoids overwriting "rdp_gp->nocb_defer_wakeup"
> when it is not RCU_NOCB_WAKE_NOT.
> 
> Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
> Co-developed-by: Cheng-jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-jui Wang <cheng-jui.wang@mediatek.com>
> Co-developed-by: Lorry.Luo@mediatek.com
> Signed-off-by: Lorry.Luo@mediatek.com
> Tested-by: weiyangyang@vivo.com
> Signed-off-by: weiyangyang@vivo.com
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> ---
> The regression is first observed by wyy in the Update Engine scenario
> with  CONFIG_LAZY_RCU enabled. there is an additional delay of 4–5
> seconds during the heavy ioctl API call, waiting for
> percpu_ref_switch_to_atomic_rcu (RCU hurry CB) to complete.
> 
> Initially, we suspected that the percpu_ref_switch_to_atomic_rcu
> function itself was taking too long. However, after enabling some
> custome and the following trace events: rcu_do_batch, rcu_nocb_wake, and
> rcu_grace_period. we found that the root cause was that rcuog was not
> being woken up in time to request a new GP. This led to the delay in
> invoking the hurry RCU callback (percpu_ref_switch_to_atomic_rcu).
> 
> Environment:
>   Android-16, Kernel: 6.12, 8 CPUs (ARM)
> 
> Configuration:
>   CONFIG_TREE_RCU=y
>   CONFIG_PREEMPT_RCU=y
>   CONFIG_LAZY_RCU=y
>   CONFIG_RCU_NOCB_CPU=y
>   CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
>   rcu_nocb_gp_stride = -1 (default is 4 for 8 cores)
>   jiffies_lazy_flush = 10 * HZ
> 
> Contributions:
> Tze-Nan Wu:
> Collaborated with Cheng-Jui to discuss which tracepoints needed to be
> added, jointly analyzed the trace logs, identified the root cause, and
> proposed this upstream change.
> 
> Cheng-Jui Wang:
> Provided many valuable suggestions during the debugging process,
> repeatedly found breakthroughs when we were stuck, and helped identify
> the root cause.
> 
> Lorry Luo:
> Assisted in verifying whether rcu-hurry-callback was executed too long
> or deferred, supported with testing, and helped with communication.
> 
> Weiyangyang:
> Main tester who discovered the regression scenario, confirmed that
> enabling CONFIG_LAZY_RCU caused the regression, and verified that this
> patch resolves the issue

Nice team work :-)

> 
> Note:
> With my limited understanding of lazy RCU, I am not fully confident that
> this is a real issue. In my opinion, hurry callbacks should not be
> delayed by other events such as firstBQ trace event.
> If my understanding is incorrect, I would greatly appreciate any
> guidance or clarification from the maintainers.

Your understanding looks quite right!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Since the issue is there for 3 years now and was introduced with
the CONFIG_LAZY_RCU new feature, it can probably wait a few weeks
for the next merge window.

-- 
Frederic Weisbecker
SUSE Labs
