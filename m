Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0621CC51;
	Mon,  5 Jan 2026 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767588395; cv=none; b=U4PBQLLUflNW3HvMsfmmvFWCzg5OQCU+8EWjTv9Ijig7i1d+TUAXFVVvkStsDO7qbyGWZG7x1VFsOc1D9faRGqkd8q6sfqEcXwYIedrhg2g9sVgc1oJpy4LiKfTnWonUKgLpy4dZfo0YDaUng3isu1CRleSv4vviYiTrjsb0RXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767588395; c=relaxed/simple;
	bh=cUXBO2uTCJbjKo3AqJ7+AEMuom5qjVUwDbH5rB3ImrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nydWrLPmHIMp0w+FmhEi+IsiS8G+4AwrCdYqc6ARC/YiB1z+7s9wsp4NdbBrewPxaw6QGm4Oj1stXpIt/J/egm6DPjNO9BKMLzEVuWgirIe6qnJL+A8U5c7AeJf4ovGeZberNkKepv2YvxJXstCyr+KwSgecYnMx4pHszLPXZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5r1Ic3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5r1Ic3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666ABC16AAE;
	Mon,  5 Jan 2026 04:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767588394;
	bh=cUXBO2uTCJbjKo3AqJ7+AEMuom5qjVUwDbH5rB3ImrU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y5r1Ic3ALe6JvBQ5+u+hkbeTUg77bslbKHKeCavFP/uoZf6757hjc70Xb0+lpKJJU
	 SfReFey9bFSNunnhregLsi+8H47mrMLXEeyqOKKz9b59oTqaXa4BncpnSMKhudyWsn
	 anuvrGBwoUKN9/gZ6AIqFZ0Fby8+8DwenI5ab7L8Z+kqhCONJw8ywj/1vHJyxe23Lz
	 u+zxFWgRLwZb5nD2krgKzBiikwdUMsxw3uXTzSeOD1marY691C6sJTw+rBhReqpt27
	 zHcqVwtl/tjbnAxBuXuAbs0o8ePWM+vz78tIpnXNIfLPDm6Trq4f/1LfspGAvJwq5x
	 lxZkUwwtn+IHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7663CE0CFD; Sun,  4 Jan 2026 20:46:33 -0800 (PST)
Date: Sun, 4 Jan 2026 20:46:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Reset stall detection after ftrace dump
Message-ID: <f1e35209-7f31-44f8-afd1-6f7ea974002a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260104203642.3171854-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104203642.3171854-1-joelagnelf@nvidia.com>

On Sun, Jan 04, 2026 at 03:36:42PM -0500, Joel Fernandes wrote:
> During some recent expedited RCU testing with rcutorture, I noticed RCU
> stalls when using ftrace_dump() to analyze traces. The issue that since
> ftrace_dump() can take a long time, any accumulated issue can show up
> just after the stall is unsupressed.  Due to this a stall can be
> detected and reported.
> 
> The problem is something like this:
> 
>   1. rcu_ftrace_dump_stall_suppress() sets suppression value.
> 
>   2. ftrace_dump() runs for a long time.
> 
>   3. rcu_ftrace_dump_stall_unsuppress() clears suppression.
> 
>   4. Immediately later, stall is detected.
> 
> Fix this by calling rcu_cpu_stall_reset() when clearing suppression.
> This resets jiffies_stall to ULONG_MAX, preventing the issue.
> 
> Tested with gp_exp=true enabled with rcutorture and ftrace_dump() and no
> stall is reported, with only clean traces in the output.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> This is a non-urgent fix and could go in either this or the next merge
> window (Boqun's call).
> 
>  kernel/rcu/rcu.h        | 5 ++++-
>  kernel/rcu/tree_stall.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 9cf01832a6c3..87fcf528b9ac 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -288,6 +288,7 @@ extern int rcu_cpu_stall_cputime;
>  extern bool rcu_exp_stall_task_details __read_mostly;
>  int rcu_jiffies_till_stall_check(void);
>  int rcu_exp_jiffies_till_stall_check(void);
> +void rcu_cpu_stall_reset(void);
>  
>  static inline bool rcu_stall_is_suppressed(void)
>  {
> @@ -302,8 +303,10 @@ do { \
>  
>  #define rcu_ftrace_dump_stall_unsuppress() \
>  do { \
> -	if (rcu_cpu_stall_suppress == 3) \
> +	if (rcu_cpu_stall_suppress == 3) { \
>  		rcu_cpu_stall_suppress = 0; \
> +		rcu_cpu_stall_reset(); \
> +	} \
>  } while (0)
>  
>  #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..9a036fc27fed 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -192,6 +192,7 @@ void rcu_cpu_stall_reset(void)
>  	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
>  	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
>  }
> +EXPORT_SYMBOL_GPL(rcu_cpu_stall_reset);
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
> -- 
> 2.34.1
> 
