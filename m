Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB409381BE;
	Tue,  9 Jul 2024 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503273; cv=none; b=k1HyJvbQSN6/GJkhwosj6uHzSCBttpXwA3SPMJabbqMOIcB5P+8UQjsvt0wYb1Dw4abyquoCYMr9oGd3vFxDWOfjkcW+jcDvLCJ8bvgrI9seo76IPBjD3/I0Q/DZQ7N99YJGQbe2QAaIrQZciePm6xIVJOon2pEc28gjpxdeEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503273; c=relaxed/simple;
	bh=OLrGDxVS/AZ8w4mBiU4QW+Uhv6Y1Flmef6JocrFtI5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGyv8fUV1SHJpgjv1XmNsuEuTxMapfaCXm+SxE3m2g6gM0IBB0b0C7Dz2yuy0HU1sZj4ydBgXs956qtSq94/qlledRlH0I4vminuRtE3cscTEB7GkQ9qOD+8QquFvPUcCJhlOPnn4stlnKt9MGD2TKfxcIsW7zP5BflTMj32V8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id C5E48A9D35;
	Tue,  9 Jul 2024 14:34:27 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47VvWRLgAQLL; Tue,  9 Jul 2024 14:34:27 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 90454A98C3;
	Tue,  9 Jul 2024 14:34:27 +0900 (JST)
From: takakura@valinux.co.jp
To: paulmck@kernel.org
Cc: boqun.feng@gmail.com,
	bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mgorman@suse.de,
	mingo@redhat.com,
	neeraj.upadhyay@kernel.org,
	peterz@infradead.org,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	takakura@valinux.co.jp,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH] rcu: Let rcu_dump_task() be used without preemption disabled
Date: Tue,  9 Jul 2024 14:34:26 +0900
Message-Id: <20240709053426.94526-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5528fb77-9249-4223-96fb-8f5e9c3dac7f@paulmck-laptop>
References: <5528fb77-9249-4223-96fb-8f5e9c3dac7f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

On Mon, 8 July 2024, Paul E. McKenney wrote:
>On Fri, Jun 28, 2024 at 01:18:26PM +0900, takakura@valinux.co.jp wrote:
>> From: Ryo Takakura <takakura@valinux.co.jp>
>> 
>> The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
>> in synchronize_rcu_expedited_wait()") disabled preemption around
>> dump_cpu_task() to suppress warning on its usage within preemtible context.
>> 
>> Calling dump_cpu_task() doesn't required to be in non-preemptible context
>> except for suppressing the smp_processor_id() warning.
>> As the smp_processor_id() is evaluated along with in_hardirq()
>> to check if it's in interrupt context, this patch removes the need
>> for its preemtion disablement by reordering the condition so that
>> smp_processor_id() only gets evaluated when it's in interrupt context.
>> 
>> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
>
>Hearing no objections, I pulled this in for further review and testing.
>
>I had to hand-apply this due to a recent conflicting change in the
>-rcu tree, so could you please check the version below in case I messed
>something up?
>
>							Thanx, Paul

Thanks for preparing the patch!
I checked it on the rcu tree and looks good to me.

If possible, could you replace the title with s/rcu_dump_task()/dump_cpu_task()/ 
when applying?
I made a mistake with the title where dump_cpu_task() is the one being modified, 
not rcu_dump_task(). I'm sorry for the confusion.

Sincerely,
Ryo Takakura

>
>------------------------------------------------------------------------
>
>commit ad6647a70f239aa9f2741b2f5a828a4483122a26
>Author: Ryo Takakura <takakura@valinux.co.jp>
>Date:   Fri Jun 28 13:18:26 2024 +0900
>
>    rcu: Let rcu_dump_task() be used without preemption disabled
>    
>    The commit 2d7f00b2f0130 ("rcu: Suppress smp_processor_id() complaint
>    in synchronize_rcu_expedited_wait()") disabled preemption around
>    dump_cpu_task() to suppress warning on its usage within preemtible context.
>    
>    Calling dump_cpu_task() doesn't required to be in non-preemptible context
>    except for suppressing the smp_processor_id() warning.
>    As the smp_processor_id() is evaluated along with in_hardirq()
>    to check if it's in interrupt context, this patch removes the need
>    for its preemtion disablement by reordering the condition so that
>    smp_processor_id() only gets evaluated when it's in interrupt context.
>    
>    Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>index d4be644afb50..c5d9a7eb0803 100644
>--- a/kernel/rcu/tree_exp.h
>+++ b/kernel/rcu/tree_exp.h
>@@ -597,9 +597,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
> 			mask = leaf_node_cpu_bit(rnp, cpu);
> 			if (!(READ_ONCE(rnp->expmask) & mask))
> 				continue;
>-			preempt_disable(); // For smp_processor_id() in dump_cpu_task().
> 			dump_cpu_task(cpu);
>-			preempt_enable();
> 		}
> 		rcu_exp_print_detail_task_stall_rnp(rnp);
> 	}
>diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>index 05afa2932b5e..bdb0e0328f6a 100644
>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -11485,7 +11485,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
> 
> void dump_cpu_task(int cpu)
> {
>-	if (cpu == smp_processor_id() && in_hardirq()) {
>+	if (in_hardirq() && cpu == smp_processor_id()) {
> 		struct pt_regs *regs;
> 
> 		regs = get_irq_regs();
