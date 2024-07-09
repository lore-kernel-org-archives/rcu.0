Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1541591F1;
	Tue,  9 Jul 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534966; cv=none; b=urWj6Mwon/bXGazqoJmGcL8/N1sV1VtJdZeFCroTKkku9KLU1+nBMaZwHh6qUumeGwktqUL8Qb6rw4jnzxjML5eOdBmxvFFjWc87G6tU9XrsQt1IzWkuiSdXrNLToAHmlg+hcjQIuKqgYH81uLJMRb1oGyXNfAP4S9HxCPTzMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534966; c=relaxed/simple;
	bh=FWTGpT0uE1WJVBkIi/BrIbSsTltp36GvoROONoB2Dpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKwMS2SHqE6Pgnf8MZNQdT5utLV9Ufb6VnmrW0XxHgjjyuAluptqJ6JOvBGOSwVV203AX0o4Fp1gbzHR7a/PldpcbEfJFXLEbGuCdGQQWX4GR5IEzsKl+ytRzedHRaYYLSiGipZLc7K63Rc6KW6ETx8icwQckPq2eNDhexVExQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAR/3/9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAR/3/9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1ACC32782;
	Tue,  9 Jul 2024 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720534966;
	bh=FWTGpT0uE1WJVBkIi/BrIbSsTltp36GvoROONoB2Dpc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CAR/3/9iQ6zIplQ/QpFyPIrSdLTZS157UiymInXvhe2THRdF8hNEYC913LfnbuDLY
	 7Sypc7AxKf4AsjdJofn4STT4RvGnn2z907DoH3T0sNlALEoD3pWhgB1N8an4OQBvKN
	 f8VQ6uCG0OIjUUXPb2aaPUnemhrz7QDLNWVdTDD6KgduvMAp7ZSrJ3EcTHh09o2358
	 oT005qae+YYwDmY6EXBMdEmR92mmYv5/BZ7VNA1BzT0M+xICVLFyYxondCDOPJKSoW
	 PJ1aRRbsI/bHzsWIAy1E+x51qh4NGwIGUO64+kKJWllbE5PKJrJi5j06TuwZo+w2o7
	 C+NRYZI57TOsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9D27CE09F8; Tue,  9 Jul 2024 07:22:45 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:22:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: takakura@valinux.co.jp
Cc: boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
	dietmar.eggemann@arm.com, frederic@kernel.org,
	jiangshanlai@gmail.com, joel@joelfernandes.org,
	josh@joshtriplett.org, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	mgorman@suse.de, mingo@redhat.com, neeraj.upadhyay@kernel.org,
	peterz@infradead.org, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH] rcu: Let rcu_dump_task() be used without preemption
 disabled
Message-ID: <83446d9b-f6fe-4786-8f84-c2716d03637c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5528fb77-9249-4223-96fb-8f5e9c3dac7f@paulmck-laptop>
 <20240709053426.94526-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709053426.94526-1-takakura@valinux.co.jp>

On Tue, Jul 09, 2024 at 02:34:26PM +0900, takakura@valinux.co.jp wrote:
> Hi Paul,
> 
> On Mon, 8 July 2024, Paul E. McKenney wrote:
> >On Fri, Jun 28, 2024 at 01:18:26PM +0900, takakura@valinux.co.jp wrote:
> >> From: Ryo Takakura <takakura@valinux.co.jp>
> >> 
> >> The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
> >> in synchronize_rcu_expedited_wait()") disabled preemption around
> >> dump_cpu_task() to suppress warning on its usage within preemtible context.
> >> 
> >> Calling dump_cpu_task() doesn't required to be in non-preemptible context
> >> except for suppressing the smp_processor_id() warning.
> >> As the smp_processor_id() is evaluated along with in_hardirq()
> >> to check if it's in interrupt context, this patch removes the need
> >> for its preemtion disablement by reordering the condition so that
> >> smp_processor_id() only gets evaluated when it's in interrupt context.
> >> 
> >> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> >
> >Hearing no objections, I pulled this in for further review and testing.
> >
> >I had to hand-apply this due to a recent conflicting change in the
> >-rcu tree, so could you please check the version below in case I messed
> >something up?
> >
> >							Thanx, Paul
> 
> Thanks for preparing the patch!
> I checked it on the rcu tree and looks good to me.
> 
> If possible, could you replace the title with s/rcu_dump_task()/dump_cpu_task()/ 
> when applying?
> I made a mistake with the title where dump_cpu_task() is the one being modified, 
> not rcu_dump_task(). I'm sorry for the confusion.

Thank you for calling my attention to this.

Done locally, and it will show up on my next rebase.

								Thanx, Paul

> Sincerely,
> Ryo Takakura
> 
> >
> >------------------------------------------------------------------------
> >
> >commit ad6647a70f239aa9f2741b2f5a828a4483122a26
> >Author: Ryo Takakura <takakura@valinux.co.jp>
> >Date:   Fri Jun 28 13:18:26 2024 +0900
> >
> >    rcu: Let rcu_dump_task() be used without preemption disabled
> >    
> >    The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
> >    in synchronize_rcu_expedited_wait()") disabled preemption around
> >    dump_cpu_task() to suppress warning on its usage within preemtible context.
> >    
> >    Calling dump_cpu_task() doesn't required to be in non-preemptible context
> >    except for suppressing the smp_processor_id() warning.
> >    As the smp_processor_id() is evaluated along with in_hardirq()
> >    to check if it's in interrupt context, this patch removes the need
> >    for its preemtion disablement by reordering the condition so that
> >    smp_processor_id() only gets evaluated when it's in interrupt context.
> >    
> >    Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> >index d4be644afb50..c5d9a7eb0803 100644
> >--- a/kernel/rcu/tree_exp.h
> >+++ b/kernel/rcu/tree_exp.h
> >@@ -597,9 +597,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
> > 			mask = leaf_node_cpu_bit(rnp, cpu);
> > 			if (!(READ_ONCE(rnp->expmask) & mask))
> > 				continue;
> >-			preempt_disable(); // For smp_processor_id() in dump_cpu_task().
> > 			dump_cpu_task(cpu);
> >-			preempt_enable();
> > 		}
> > 		rcu_exp_print_detail_task_stall_rnp(rnp);
> > 	}
> >diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >index 05afa2932b5e..bdb0e0328f6a 100644
> >--- a/kernel/sched/core.c
> >+++ b/kernel/sched/core.c
> >@@ -11485,7 +11485,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
> > 
> > void dump_cpu_task(int cpu)
> > {
> >-	if (cpu == smp_processor_id() && in_hardirq()) {
> >+	if (in_hardirq() && cpu == smp_processor_id()) {
> > 		struct pt_regs *regs;
> > 
> > 		regs = get_irq_regs();
