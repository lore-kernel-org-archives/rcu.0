Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C71D270A;
	Fri, 25 Oct 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896947; cv=none; b=Bm+Is0A+HvRw5J2qIRwSq4lK3DV82lh273UpdMjW3f279I1MQtI0tYESSS/A/C4ABc/UWEU854UaghqmaFg1HmvDfD4AEvXqJlnfJbyNTbTH+PX/Knliph7Xua4JBqEJPYvGlfuImKNlIaNVlGhlvtkGiaIE1V8lMa+7oYgs8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896947; c=relaxed/simple;
	bh=IHkS8BTrqxwHtztrBN/xoBUkJLXL+FDXRMjX5jjYfPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrQXmVrPgrO/ndMIrnVXBaQRfjNd+wEMzbmPWGow28LeklnGgBuhE2AnL9bRMD0SfqK4LBhm7U+XjnmSiKtTOQLkzizn4+QwCcYJMmfJtP5oIeodiTvq7g9o3GRkUUCsO/Qr7NBp7+aeDk+5Bg2nuz1tWAEqEK6dXMJvcnbh0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHZm9cF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHZm9cF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3357CC4CEC3;
	Fri, 25 Oct 2024 22:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729896947;
	bh=IHkS8BTrqxwHtztrBN/xoBUkJLXL+FDXRMjX5jjYfPU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SHZm9cF91BRtU2TDY138Df20qEaWVv72Eviv+RR3DsqHFdwFcr8gL5KXqKL5jq+Q1
	 PHYeZJfKx/44QkVvrXSGR1WqaZ5CBtI6BQYkXu+GyMNdSnWhhfPJj133ZezE0Pcmb3
	 73LWHE1bK9sAdCTIaUm7gB9FBnSpJ1v5PuSgkha+chZdv0Xqgb1/K1z5Axg56sxSo9
	 TPsS8t89TTU7vUT1F6K1zvWn2hduGiO3acEE9CetA3UO7BbMH8dsU8B4tmfTZsBFBC
	 yW1nQjRKzhzqDl3bY2sp521WFfJbwXhvzpLo8IgvE4ZgV2Q0djkuBEk6dx3X9TIvuw
	 p6f1YMBg6HCRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7E8ACE0D99; Fri, 25 Oct 2024 15:55:46 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:55:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] rcu: Unlock correctly in rcu_dump_cpu_stacks()
Message-ID: <cdc3a34a-9533-4f0c-bd2a-3796aeed161c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b3b2a438-92d8-4b63-a71e-ad3a155b96d4@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b2a438-92d8-4b63-a71e-ad3a155b96d4@stanley.mountain>

On Fri, Oct 25, 2024 at 10:06:43AM +0300, Dan Carpenter wrote:
> The unlock needs to be outside the } close curly braces for this if
> statement.  Otherwise it leads to a deadlock.
> 
> Fixes: 744e87210b1a ("rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

This is a regression from this past merge window, if I am keeping track.
So it is a candidate for going in before the next merge window opens.

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 8994391b95c7..925fcdad5dea 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -357,8 +357,8 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
>  					pr_err("Offline CPU %d blocking current GP.\n", cpu);
>  				else
>  					dump_cpu_task(cpu);
> -			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  			}
> +			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		}
>  		printk_deferred_exit();
>  	}
> -- 
> 2.45.2
> 
