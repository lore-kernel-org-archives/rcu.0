Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEC29E0F9;
	Wed,  9 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060472; cv=none; b=FT6P+W/y7lP/+kZshVzFk7jrZPuEnBvo1qcVFxkkiW4z20pECwP2jxKFhhZHETz3ZQyod60XIP4esxNQIUI4zxrKdQFPqpkZ4Wv5YZ5b8/vm+IsieJIIBI/MIpblWqjRx6+PeW3UwAkVNZ9sJPtPC6vXXrosagxbi7y4Mh8uqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060472; c=relaxed/simple;
	bh=HhFX0RfL+sP2Um7Qtfv4Vig0hKSodNaNvx4L1cYbfvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=audKyN+4hmVZhj6v7FmFg6DB9tBw5/PB8Nx0mlK043kV0/2E5JY92BNBoP7ys6wFawQN6iwwUouh6SzYkb5CP3YijmPYWOX3WM1vbX/6ZDG4co91LuNoHkmpp9mqTPSF2+NEeBFbvUp1lFTh/jWFlXy17by5RDbztAKIGnaBi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et+FLqWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et+FLqWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108BAC4CEEF;
	Wed,  9 Jul 2025 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752060471;
	bh=HhFX0RfL+sP2Um7Qtfv4Vig0hKSodNaNvx4L1cYbfvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Et+FLqWXFP09TYCJoCHwJOIOkHlm6h8Fy5CtahYOJ7SxLK0uorMPQP4D/ryjED6lY
	 lan7U/lkvkM8aE6vR0jCKhx47JIMwc6wvRfKompMdHwzDmXdR0aCEJnCDw2+q/wzs/
	 QeUuqGjvWgLVSV4pai/dwofK3gjgYdxiDuH9mhfo98ocFBoSwdHjoQZ6qMeQpySsou
	 8Olt4UowWOh0Z+LCcL7fmM8CVkrJLFYuAhPajpTcUnaYxvKyEzx4Q/Ki8bZQTdyk6M
	 krU9MQU2mbSicrIj7Aw8OjmNMNvpW6TbvyfTU498deuhG1sSwLWkavitcoFyief60t
	 Cj4Cg12mo0SqA==
Date: Wed, 9 Jul 2025 13:27:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com, neeraj.upadhyay@amd.com
Subject: Re: [PATCH rcu 2/5] rcu: Protect ->defer_qs_iw_pending from data race
Message-ID: <aG5SNJpn60Sz9px3@localhost.localdomain>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
 <20250709104118.15532-3-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709104118.15532-3-neeraj.upadhyay@kernel.org>

Le Wed, Jul 09, 2025 at 04:11:15PM +0530, neeraj.upadhyay@kernel.org a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> On kernels built with CONFIG_IRQ_WORK=y, when rcu_read_unlock() is
> invoked within an interrupts-disabled region of code [1], it will invoke
> rcu_read_unlock_special(), which uses an irq-work handler to force the
> system to notice when the RCU read-side critical section actually ends.
> That end won't happen until interrupts are enabled at the soonest.
> 
> In some kernels, such as those booted with rcutree.use_softirq=y, the
> irq-work handler is used unconditionally.
> 
> The per-CPU rcu_data structure's ->defer_qs_iw_pending field is
> updated by the irq-work handler and is both read and updated by
> rcu_read_unlock_special().  This resulted in the following KCSAN splat:
> 
> ------------------------------------------------------------------------
> 
> BUG: KCSAN: data-race in rcu_preempt_deferred_qs_handler / rcu_read_unlock_special
> 
> read to 0xffff96b95f42d8d8 of 1 bytes by task 90 on cpu 8:
>  rcu_read_unlock_special+0x175/0x260
>  __rcu_read_unlock+0x92/0xa0
>  rt_spin_unlock+0x9b/0xc0
>  __local_bh_enable+0x10d/0x170
>  __local_bh_enable_ip+0xfb/0x150
>  rcu_do_batch+0x595/0xc40
>  rcu_cpu_kthread+0x4e9/0x830
>  smpboot_thread_fn+0x24d/0x3b0
>  kthread+0x3bd/0x410
>  ret_from_fork+0x35/0x40
>  ret_from_fork_asm+0x1a/0x30
> 
> write to 0xffff96b95f42d8d8 of 1 bytes by task 88 on cpu 8:
>  rcu_preempt_deferred_qs_handler+0x1e/0x30
>  irq_work_single+0xaf/0x160
>  run_irq_workd+0x91/0xc0
>  smpboot_thread_fn+0x24d/0x3b0
>  kthread+0x3bd/0x410
>  ret_from_fork+0x35/0x40
>  ret_from_fork_asm+0x1a/0x30
> 
> no locks held by irq_work/8/88.
> irq event stamp: 200272
> hardirqs last  enabled at (200272): [<ffffffffb0f56121>] finish_task_switch+0x131/0x320
> hardirqs last disabled at (200271): [<ffffffffb25c7859>] __schedule+0x129/0xd70
> softirqs last  enabled at (0): [<ffffffffb0ee093f>] copy_process+0x4df/0x1cc0
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> 
> ------------------------------------------------------------------------
> 
> The problem is that irq-work handlers run with interrupts enabled, which
> means that rcu_preempt_deferred_qs_handler() could be interrupted,
> and that interrupt handler might contain an RCU read-side critical
> section, which might invoke rcu_read_unlock_special().  In the strict
> KCSAN mode of operation used by RCU, this constitutes a data race on
> the ->defer_qs_iw_pending field.
> 
> This commit therefore disables interrupts across the portion of the
> rcu_preempt_deferred_qs_handler() that updates the ->defer_qs_iw_pending
> field.  This suffices because this handler is not a fast path.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
