Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB135B125
	for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813655; cv=none; b=bpbOggubnphCegE9mZiJa0EE/43DFHouhE2EtGSUtYZ5AEaoY7KfIdYxEK9Cbfrs6buwxMd/CvarmFddzKV+pKMndDRUynRmqgPly4wpktq/Y9kRvlym9ZA8yWzShgx4Vli2zADdtOkUqpzu+MO8epk/lAu7nW4JbKN2LcmdIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813655; c=relaxed/simple;
	bh=inTzn9r8OxooFE9zFzpvgtf0dolsjxr3pSWDIiq/R/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj6a9+bRaH0x52uTBoy5MBOi+fsCbBNnBmJJEvNmhhqki5N5DwaSowAtTG5O/6GkaQVmCdYqH+ctb0WMfWjPWX7dUT0WbdUcYWzauv2mczQqlfYP82zsSx037x6Lz00eLwZ2fQ70XYm8aDEAj1AEkkEOeWh5EFRM3x04Lpi3u3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EozpqNyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EozpqNyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0A6C2BCB0;
	Tue, 21 Apr 2026 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813655;
	bh=inTzn9r8OxooFE9zFzpvgtf0dolsjxr3pSWDIiq/R/I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EozpqNyl/nl+PvuFNZeNgzLUJjUOuLkmHfUNQ2rZ8qO+DiKFutW2/owmFMYwzU9sp
	 SjfbA+81bRGHAQ82IE0yWsl8N+4YqcPsuLquTsczU3S9zwLoF4leP52fsEjnFlpQO1
	 oNTINhsCW3Znk7uBAKIJRKXwlZsOPFV9vDOBk7ZzHaXoTMI4bs4CFt5/w90pO2e8EA
	 HxtmE7K24lJHlToymjtWfyMdrYGsDvzMTCHusy2z/p5Ai49kKPeySBm7FTluSbn2LB
	 zVLYIIhLAou4accqEESmf2LWcTjNhHvy5iglJ4mZ3/iLsh1B5SWBZWxPu9k3ZdWvrD
	 nT29xYh2/72uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90493CE0C56; Tue, 21 Apr 2026 16:20:54 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:20:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: Re: [PATCH] rcu: use NMI to dump backtrace of blkd-task running on
 other cpu
Message-ID: <7a46efa3-3d11-45df-8d73-5af8b87a4b84@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260417013816.3653-1-jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417013816.3653-1-jqqlijiazi@gmail.com>

On Fri, Apr 17, 2026 at 09:38:13AM +0800, Jiazi Li wrote:
> sched_show_task cannot dump backtrace of blkd-task running on other
> cpu:
> [117421.286553][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [117421.286579][    C0] rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-7): P2280
> [117421.286595][    C0] rcu:    (detected by 0, t=5252 jiffies, g=751845, q=66318 ncpus=8)
> [117421.286604][    C0] task:android.imms2   state:R  running task     stack:0     ...
> [117421.286617][    C0] Call trace:
> [117421.286622][    C0]  __switch_to+0x1a0/0x318
> [117421.286636][    C0]  0x0
> 
> So use NMI to dump backtrace:
> [  390.584143] rcub/0: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  390.585156] rcub/0: rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-7): P6816
> [  390.586207] rcub/0: rcu:     (detected by 5, t=52532 jiffies, g=7405, q=63942 ncpus=8)
> [  390.587320] rcub/0: Sending NMI from CPU 5 to CPUs 4:
> [  390.588111] rcu_stall_threa: NMI backtrace for cpu 4
> [  390.588116] rcu_stall_threa: CPU: 4 UID: 0 PID: 6816 Comm: rcu_stall_threa Tainted: P...
> [  390.588120] rcu_stall_threa: Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
> [  390.588122] rcu_stall_threa: Hardware name: MT6858 (DT)
> [  390.588123] rcu_stall_threa: pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  390.588125] rcu_stall_threa: pc : _raw_spin_unlock_irqrestore+0x1c/0x44
> [  390.588131] rcu_stall_threa: lr : ___ratelimit+0xd4/0x110
> [  390.588134] rcu_stall_threa: sp : ffffffc08464bdf0
> [  390.588135] rcu_stall_threa: x29: ffffffc08464bdf0 x28: 0000000000000000 x27: 0000000000000000
> [  390.588138] rcu_stall_threa: x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000004e2
> [  390.588140] rcu_stall_threa: x23: ffffffd82ae77000 x22: ffffffd82af1fae8 x21: 000000000000000a
> [  390.588142] rcu_stall_threa: x20: 0000000000000000 x19: 0000000000000000 x18: ffffffc08456d020
> [  390.588144] rcu_stall_threa: x17: 000000008c623181 x16: 000000008c623181 x15: 0000000000000010
> [  390.588146] rcu_stall_threa: x14: 0000000000000100 x13: ffffffc084648000 x12: ffffffc08464c000
> [  390.588148] rcu_stall_threa: x11: 5e2da9f91a08d800 x10: ffffffd8299b39fc x9 : 0000000100005874
> [  390.588150] rcu_stall_threa: x8 : 0000000000000000 x7 : 0000000000000001 x6 : fffffffebea2b0a0
> [  390.588152] rcu_stall_threa: x5 : 0000000000000000 x4 : 0000000000000402 x3 : 0000000000000000
> [  390.588154] rcu_stall_threa: x2 : ffffff81ca8d9680 x1 : 0000000000000000 x0 : 0000000000000001
> [  390.588156] rcu_stall_threa: Call trace:
> [  390.588157] rcu_stall_threa:  _raw_spin_unlock_irqrestore+0x1c/0x44
> [  390.588159] rcu_stall_threa:  ___ratelimit+0xd4/0x110
> [  390.588161] rcu_stall_threa:  rcu_thread_func+0x90/0xa8
> [  390.588164] rcu_stall_threa:  kthread+0x110/0x1a4
> [  390.588167] rcu_stall_threa:  ret_from_fork+0x10/0x20
> 
> Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
> Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>

This looks like an arm64 stack trace.  Are there any arm64 systems in
production that do real NMIs?  (Don't get me wrong, it would be nice if
there are!)

> ---
>  kernel/rcu/tree_stall.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..5806f9a43579 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -289,7 +289,12 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
>  		 * Avoid triggering hard lockup.
>  		 */
>  		touch_nmi_watchdog();
> -		sched_show_task(t);
> +		if (unlikely(t->on_cpu && t != current) &&

What if task t blocks or migrates to some other CPU at this point?

> +				trigger_single_cpu_backtrace(task_cpu(t))) {
> +			/*Successfully triggered remote backtrace*/

Wouldn't inverting the condition save a couple of lines of code here?
And make it a bit more straightforward?

							Thanx, Paul

> +		} else {
> +			sched_show_task(t);
> +		}
>  	}
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
> -- 
> 2.49.0
> 
