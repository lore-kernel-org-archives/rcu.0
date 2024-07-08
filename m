Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5531514C3;
	Mon,  8 Jul 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479452; cv=none; b=atNL82I/yD8s7r/FMagQ/xGZeq3uR1cicYkpkyfUh6E01+3uKsR1T9Mgi//vAF7f3vEkXt7Kr1iz+zF+goLVsKtLhNnNE7txlQMzjx0egsRA4bCF8ZPNO898P+Cm0Non7y2bl/LL30Tq4ug2k34/XKgmHp5+agbrgdF/RyfPeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479452; c=relaxed/simple;
	bh=eWy9hO2CI59D5W7kd1LpWsVxFoxV8v6aYjkfCqsTwgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfmH+5/YigYOdHQdPYyqcJIE6FrJz7/Urahme3BBZhgUJgWQpQqY5iXdKMBi3tYNiFMSCSor1b3CiIB1ZyQOxwN+Z7Fx3Ra8r+iJzSIwR9prrprQRGiO9fwV6YoCBJd8rT7VLDdQ1S2nhVfeRj8ce7mW916mZJm0GGo9vxQq7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN2sO8L5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN2sO8L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E558C116B1;
	Mon,  8 Jul 2024 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720479450;
	bh=eWy9hO2CI59D5W7kd1LpWsVxFoxV8v6aYjkfCqsTwgM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CN2sO8L5i8Ys9LVdGGny1cNzXJyhIrAb1wGd2V3fMG1Qz8zcMbYtSoLJV5ugSGzUR
	 94DxWu64sFmipegrag+CAe1sz//XMjsieklYJWXg9gj4UGN4lOrO61GKWVZ0A1rRfQ
	 b3H1KRFJJWijt3stGn0taG1iiAOMroFBw7ju2n9H0hXVAd4iCXvzt9wINAAne5I1q7
	 swwv42RJyUmpJO8EReponHzx3s/F9fVxqjvYbxTdWCX+iWbjcxMbzzedge7FeW/eEY
	 ME6NOktlDd1hB0j3yXhlsqtnCvR9sxPBqRTwc84jDok+NKLAQmj4aWsXO0l58nc8Yz
	 BLtFPsZE742Ug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C640CE09D8; Mon,  8 Jul 2024 15:57:30 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:57:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: takakura@valinux.co.jp
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Let rcu_dump_task() be used without preemption
 disabled
Message-ID: <5528fb77-9249-4223-96fb-8f5e9c3dac7f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240628041826.68587-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628041826.68587-1-takakura@valinux.co.jp>

On Fri, Jun 28, 2024 at 01:18:26PM +0900, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
> in synchronize_rcu_expedited_wait()") disabled preemption around
> dump_cpu_task() to suppress warning on its usage within preemtible context.
> 
> Calling dump_cpu_task() doesn't required to be in non-preemptible context
> except for suppressing the smp_processor_id() warning.
> As the smp_processor_id() is evaluated along with in_hardirq()
> to check if it's in interrupt context, this patch removes the need
> for its preemtion disablement by reordering the condition so that
> smp_processor_id() only gets evaluated when it's in interrupt context.
> 
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>

Hearing no objections, I pulled this in for further review and testing.

I had to hand-apply this due to a recent conflicting change in the
-rcu tree, so could you please check the version below in case I messed
something up?

							Thanx, Paul

------------------------------------------------------------------------

commit ad6647a70f239aa9f2741b2f5a828a4483122a26
Author: Ryo Takakura <takakura@valinux.co.jp>
Date:   Fri Jun 28 13:18:26 2024 +0900

    rcu: Let rcu_dump_task() be used without preemption disabled
    
    The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
    in synchronize_rcu_expedited_wait()") disabled preemption around
    dump_cpu_task() to suppress warning on its usage within preemtible context.
    
    Calling dump_cpu_task() doesn't required to be in non-preemptible context
    except for suppressing the smp_processor_id() warning.
    As the smp_processor_id() is evaluated along with in_hardirq()
    to check if it's in interrupt context, this patch removes the need
    for its preemtion disablement by reordering the condition so that
    smp_processor_id() only gets evaluated when it's in interrupt context.
    
    Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d4be644afb50..c5d9a7eb0803 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -597,9 +597,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 			mask = leaf_node_cpu_bit(rnp, cpu);
 			if (!(READ_ONCE(rnp->expmask) & mask))
 				continue;
-			preempt_disable(); // For smp_processor_id() in dump_cpu_task().
 			dump_cpu_task(cpu);
-			preempt_enable();
 		}
 		rcu_exp_print_detail_task_stall_rnp(rnp);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 05afa2932b5e..bdb0e0328f6a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11485,7 +11485,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 void dump_cpu_task(int cpu)
 {
-	if (cpu == smp_processor_id() && in_hardirq()) {
+	if (in_hardirq() && cpu == smp_processor_id()) {
 		struct pt_regs *regs;
 
 		regs = get_irq_regs();
