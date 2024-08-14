Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F625762;
	Wed, 14 Aug 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639670; cv=none; b=QzlAvgxVU7vpTyrhU9nypUXD0Kb1aFjS5vHdL0/aFKe4xpKoelkp8xcmUoDksCGh8YqC2dN5uSr4e7fxjf718DthcNF3ur2AKEmByT1Tf0GtY/N9pYmrV8QVWNflsLAg2SuA7ILSRM3K3b4uDjFTrdMPrwKrAq26fpVhD3u0bfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639670; c=relaxed/simple;
	bh=cdea50Dx9ZmaxycbxHe2JgqHseZmZZXeTrngl7tmHJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf6zqYTT5JsbQBgfB+wEjA044YPHaZkDXZmQSVVYQ9DqPt83EpjQWX9/x5yolEvJz0e9LS7o/Ww382DZhnKiEAcmA7LVEAaevJxoOqgjFzcXeJq3meEh+PIzNcYAhZdlQCDngUihH+CsYp4sVYAbbgmq6b7CBBrvHdikIrXxLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6LpNPa4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6LpNPa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73151C32786;
	Wed, 14 Aug 2024 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723639669;
	bh=cdea50Dx9ZmaxycbxHe2JgqHseZmZZXeTrngl7tmHJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6LpNPa4h9yx+mIwkZVdntlltbCAF+o+9SL23pQHh4oa8xy5LtZZ9hmryY6wXYrK2
	 kHwiXBQJsimkT3eR+oLI4vczahBQ+uwBCXEG98zCEqE69VB0h2MsP/9TsSBohPFAYI
	 Sogmo7NuxX6fRf+ndyf+PMK7Gmxz3MSvLf2YjXcLh0Yvf6+E2lxMw8lHlVpgQmTDVE
	 FU7UI5ynYEEiKXcuxLGcXP/IpK1P9RrqR9WmN+aajyq9nA/39f44lk0PaEjPL7yx9/
	 TQmAguxYYwUxiL27F6M8WIeQE8pJA/FJ/zwOKbCap/wGjUcYBZaMj5/il9P4y5tywk
	 i8AYIJ5tdIjrQ==
Date: Wed, 14 Aug 2024 14:47:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joel@joelfernandes.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com
Subject: Re: [PATCH 2/2] context_tracking: Invoke Tasks-RCU enter/exit for
 NMI context
Message-ID: <ZryncuVGyxL1-OX1@localhost.localdomain>
References: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
 <20240807163506.434885-3-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807163506.434885-3-neeraj.upadhyay@kernel.org>

Le Wed, Aug 07, 2024 at 10:05:06PM +0530, neeraj.upadhyay@kernel.org a écrit :
> From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> 
> rcu_task_enter() and rcu_task_exit() are not called on NMI
> entry and exit. So, Tasks-RCU-Rude grace period wait is required to
> ensure that NMI handlers have entered/exited into Tasks-RCU eqs.
> For architectures which do not require Tasks-RCU-Rude (as the code
> sections where RCU is not watching are marked as noinstr), when
> those architectures switch to not using Tasks-RCU-Rude, NMI handlers
> task exit to eqs will need to be handled correctly for Tasks-RCU holdout
> tasks running on nohz_full CPUs. As it is safe to call these two
> functions from NMI context, remove the in_nmi() check to ensure that
> Tasks-RCU entry/exit is marked correctly for NMI handlers.
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/context_tracking.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 152b485a62db..626dd7a173a5 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -239,8 +239,7 @@ void noinstr ct_nmi_exit(void)
>  	ct_kernel_exit_state(CT_RCU_WATCHING);
>  	// ... but is no longer watching here.
>  
> -	if (!in_nmi())
> -		rcu_task_exit();
> +	rcu_task_exit();

And now since it is called by all callers of ct_kernel_exit_state(), you
can call it from it directly.

>  }
>  
>  /**
> @@ -273,8 +272,7 @@ void noinstr ct_nmi_enter(void)
>  	 */
>  	if (!rcu_is_watching_curr_cpu()) {
>  
> -		if (!in_nmi())
> -			rcu_task_enter();
> +		rcu_task_enter();
>  
>  		// RCU is not watching here ...
>  		ct_kernel_enter_state(CT_RCU_WATCHING);

Ditto for ct_kernel_enter_state().

Thanks.

> -- 
> 2.40.1
> 
