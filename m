Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843A18FDC4
	for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014418; cv=none; b=r/kxLefBhs8TUAKoiz3PqA0sG6Ql4q3E5XDGj/d0z5fTRGPG9qYMs/bpipkfO74jSJQoiYVGG8LePwURm8+/O189RJmN/JKTKIKPvZonCGBdDlpvVG6ikCsmXKQCkOa5HjoduTOYwJXaTNHUR/CcxS9oLely16jA5/CKib5VQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014418; c=relaxed/simple;
	bh=AAMKu1NFdclIrGjzsQCggyfkygwPoGY+XIymbwCUr4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOs60vHJD7SUc0DdfsEAeVzEm97VfcbzItI2CviNhADdVUO8Q91adr/otWUalVt6FNHav8m2O6CllVXmf5nZCUkVSUikclE/I6XUdsVrKw4UHtGJ4sS6FB0nglIApKkD/9qOCyRg8LgzO3OetTr9UvRX0Ad6FLR8TWjkxmnxQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncc0wNY9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncc0wNY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BF8C4CEC2;
	Fri, 30 Aug 2024 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725014417;
	bh=AAMKu1NFdclIrGjzsQCggyfkygwPoGY+XIymbwCUr4s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ncc0wNY9bjFjlslzgY7f6vsRN4FUd5IshaGFFvtNS7Wt6VPPQ+T8+nybkVEGpJrYk
	 a6XPv73dLBehQUdFccwxZE3JhT8JCtmY+UW/RTL0vUbB6ZYXKjCHu+L4ZSxwWIk1yU
	 hwhPEkVf3m0mlOqVCAiQAI5mz551vHu9oltlM0NmPDmE7a0K/Cw2tF1CmDTrByuBhv
	 tq9GbbwXE+ri4GgboU4TQDIuyaTdKcM6FQ2d6vR7MpGgvqF+uViH0I+KqRqE4XoZsj
	 yfSdchGaP36p6NpmFKJNAtPMv7/fnkJLqbhjDx3ZwFGY8X9CrtR5mQvQ0Jkep7Zgzy
	 w3rbe3Lfl17Uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8EEB7CE0FF5; Fri, 30 Aug 2024 03:40:17 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:40:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH -next] rcu: Use bitwise instead of arithmetic operator
 for flags
Message-ID: <a3bd1991-2a4b-495e-8490-c391078d0029@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240823092158.3173241-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823092158.3173241-1-lihongbo22@huawei.com>

On Fri, Aug 23, 2024 at 05:21:58PM +0800, Hongbo Li wrote:
> This silences the following coccinelle warning:
>   WARNING: sum of probable bitmasks, consider |
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_plugin.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1c7cbd145d5e..3927ea5f7955 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -183,9 +183,9 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
>  	switch (blkd_state) {
>  	case 0:
>  	case                RCU_EXP_TASKS:
> -	case                RCU_EXP_TASKS + RCU_GP_BLKD:
> +	case                RCU_EXP_TASKS | RCU_GP_BLKD:
>  	case RCU_GP_TASKS:
> -	case RCU_GP_TASKS + RCU_EXP_TASKS:
> +	case RCU_GP_TASKS | RCU_EXP_TASKS:
>  
>  		/*
>  		 * Blocking neither GP, or first task blocking the normal
> @@ -198,10 +198,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
>  
>  	case                                              RCU_EXP_BLKD:
>  	case                                RCU_GP_BLKD:
> -	case                                RCU_GP_BLKD + RCU_EXP_BLKD:
> -	case RCU_GP_TASKS +                               RCU_EXP_BLKD:
> -	case RCU_GP_TASKS +                 RCU_GP_BLKD + RCU_EXP_BLKD:
> -	case RCU_GP_TASKS + RCU_EXP_TASKS + RCU_GP_BLKD + RCU_EXP_BLKD:
> +	case                                RCU_GP_BLKD | RCU_EXP_BLKD:
> +	case RCU_GP_TASKS |                               RCU_EXP_BLKD:
> +	case RCU_GP_TASKS |                 RCU_GP_BLKD | RCU_EXP_BLKD:
> +	case RCU_GP_TASKS | RCU_EXP_TASKS | RCU_GP_BLKD | RCU_EXP_BLKD:
>  
>  		/*
>  		 * First task arriving that blocks either GP, or first task
> @@ -214,9 +214,9 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
>  		list_add_tail(&t->rcu_node_entry, &rnp->blkd_tasks);
>  		break;
>  
> -	case                RCU_EXP_TASKS +               RCU_EXP_BLKD:
> -	case                RCU_EXP_TASKS + RCU_GP_BLKD + RCU_EXP_BLKD:
> -	case RCU_GP_TASKS + RCU_EXP_TASKS +               RCU_EXP_BLKD:
> +	case                RCU_EXP_TASKS |               RCU_EXP_BLKD:
> +	case                RCU_EXP_TASKS | RCU_GP_BLKD | RCU_EXP_BLKD:
> +	case RCU_GP_TASKS | RCU_EXP_TASKS |               RCU_EXP_BLKD:
>  
>  		/*
>  		 * Second or subsequent task blocking the expedited GP.
> @@ -227,8 +227,8 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
>  		list_add(&t->rcu_node_entry, rnp->exp_tasks);
>  		break;
>  
> -	case RCU_GP_TASKS +                 RCU_GP_BLKD:
> -	case RCU_GP_TASKS + RCU_EXP_TASKS + RCU_GP_BLKD:
> +	case RCU_GP_TASKS |                 RCU_GP_BLKD:
> +	case RCU_GP_TASKS | RCU_EXP_TASKS | RCU_GP_BLKD:
>  
>  		/*
>  		 * Second or subsequent task blocking the normal GP.
> -- 
> 2.34.1
> 
