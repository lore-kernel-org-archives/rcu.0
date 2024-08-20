Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7312F5E;
	Tue, 20 Aug 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176104; cv=none; b=G1/n8i8rhSgVMKaCPapeph6I8aekBcwbH/cGM4iCHwnmoTapHqJlvs4Y+SV4b7I5+mJygMMeie2UBcUVmeAuUbKR6w8iRfOnzDtZu6I9KV5Oy67sL++sJiTwMz6b/hpQ6z4JQK6+HWBjZyBUNfYKQOTJhBcGRhvjuqFHyLhkvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176104; c=relaxed/simple;
	bh=vigai3oJ1Up8QCsiijpfre1KMDVwuYWLfRPfZEDr2WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiZ0BNn+nzD/xl2AonqBy0iCl92pHFTCyptFy7qSfXQrigX8BClPDv7NuqNtwRuSiqwXMKJ8X/RDivzsh23R0X/ltXfinzbgDRYwPVspfDCYkPz/NcyzViKoRrIu7RcrIWv/BClyF67CEn289VFQCCcAEQtkRVFU/ueHzvWWdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3DQ9xFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3DQ9xFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B58FC4AF0C;
	Tue, 20 Aug 2024 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724176104;
	bh=vigai3oJ1Up8QCsiijpfre1KMDVwuYWLfRPfZEDr2WQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=c3DQ9xFwlA67ODnk9n9Fyi5DS89RVHnuLblkJHcfCGYcKZBZo/EjvBPPMKVuzUctm
	 7fX/iQ1tS/AqNSTKQz5K0lK14cyabcuzMhg2LM25t+5UGW9BwG3g1yif/vEsvUJ5Yg
	 FwbaFs94ZfMKM1NhLzAZJn/rRKeOhZ9ZQqYF1ZKXGWyljMmjzacNaHxv7uju6PtuDc
	 0pssa2JQTHvOCC9Bu+unWmB2B/JHudvkruFEcHkxJXz7KwoLZBUbppdg55ETTovCD7
	 pwvsRw1xj/HHg271q0vV212rIoB71ldpr8z5n5mH1ZNs19LoaOrvcYsGacYfHiubHc
	 WSn4k26VYy3Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00F65CE0D72; Tue, 20 Aug 2024 10:48:23 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:48:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v8 34/35] rcu: Mark emergency sections in rcu
 stalls
Message-ID: <46a4c63c-510e-455e-aad6-805e4b519736@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-35-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820063001.36405-35-john.ogness@linutronix.de>

On Tue, Aug 20, 2024 at 08:36:00AM +0206, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section, every printk() call will attempt to directly
> flush to the consoles using the EMERGENCY priority.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

I am guessing that this should go with the rest of this series, so:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_exp.h   | 7 +++++++
>  kernel/rcu/tree_stall.h | 9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 4acd29d16fdb..f6b35a0585a8 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -7,6 +7,7 @@
>   * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> +#include <linux/console.h>
>  #include <linux/lockdep.h>
>  
>  static void rcu_exp_handler(void *unused);
> @@ -590,6 +591,9 @@ static void synchronize_rcu_expedited_wait(void)
>  			return;
>  		if (rcu_stall_is_suppressed())
>  			continue;
> +
> +		nbcon_cpu_emergency_enter();
> +
>  		j = jiffies;
>  		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
>  		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> @@ -643,6 +647,9 @@ static void synchronize_rcu_expedited_wait(void)
>  			rcu_exp_print_detail_task_stall_rnp(rnp);
>  		}
>  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
> +
> +		nbcon_cpu_emergency_exit();
> +
>  		panic_on_rcu_stall();
>  	}
>  }
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 4b0e9d7c4c68..b3a6943127bc 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -7,6 +7,7 @@
>   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> +#include <linux/console.h>
>  #include <linux/kvm_para.h>
>  #include <linux/rcu_notifier.h>
>  
> @@ -605,6 +606,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	nbcon_cpu_emergency_enter();
> +
>  	/*
>  	 * OK, time to rat on our buddy...
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
> @@ -657,6 +660,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
>  
> +	nbcon_cpu_emergency_exit();
> +
>  	panic_on_rcu_stall();
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
> @@ -677,6 +682,8 @@ static void print_cpu_stall(unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	nbcon_cpu_emergency_enter();
> +
>  	/*
>  	 * OK, time to rat on ourselves...
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
> @@ -706,6 +713,8 @@ static void print_cpu_stall(unsigned long gps)
>  			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
> +	nbcon_cpu_emergency_exit();
> +
>  	panic_on_rcu_stall();
>  
>  	/*
> -- 
> 2.39.2
> 
