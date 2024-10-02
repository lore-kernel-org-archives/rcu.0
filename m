Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32B1D094D;
	Wed,  2 Oct 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881207; cv=none; b=OJwYowYI4tdbwNK92aGCjW3AjblrTo8m31loY9SwuDeH7svMFJQboiIHVvKHeB7XTkj5B+nuTNEeuqCh6rFDnPg/0Tq/gBUbh0kWbKFlbdmzAM0OolfyGVUO43vjpLST7sMNcJqd43BPRv16bNazmGGikDv68q748AApfpdbA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881207; c=relaxed/simple;
	bh=6QZUMGQY/DShAlCUPc63QDD1uXMxVsCOq2SySToayjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnnkMz6Y9Sn40wnwxUtflw6PQmx+7kJsjNLL4GgPurT2O3TyNhKs8avzU3xs/puJTtVoOVqySQevZgr+oFHPC+ryFg+MgYbCYJtZf/qnNwQu3FBooNdM7cqkEOQIUu6VLowSm5N75vlimb7fr85wIQ9ACku9MB4mxzd4VDxZ3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIVYFEST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIVYFEST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2117DC4CEC2;
	Wed,  2 Oct 2024 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881206;
	bh=6QZUMGQY/DShAlCUPc63QDD1uXMxVsCOq2SySToayjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIVYFESTRa9z85FbSw7I/pFjH68PXQz3MgXRo0qiXnpRP5nInkXSnSOtMdWgvMh+f
	 IKbHTrjt9xv6IvAOV1Et1THsbUwJ+mkpqJkqavilVW2gRa4FqerpF+lg7q+NPFadOP
	 w2BkYVUeTITo1sxuBe32RcUSQdoRZZMOBECfoHWGFcFA3itb6EvMGPg2YQDccI6x+Y
	 bg9TytAVEu2qQJTd7cfqQ9G+ZiD1dX3sI7RLgkGCFQhbcSqYYsSoKzudpGSBBPsYNb
	 qcTcUgtWH2Y91h/8B8JWsNOEc1GPQN0Ev+/WFZnzNwKpLX1j98TAvlea4y+1fl/9cK
	 1SGvhBKHMvWIg==
Date: Wed, 2 Oct 2024 17:00:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu: Report callbacks enqueued on offline CPU blind
 spot
Message-ID: <Zv1f8-1tLd-r1cyu@localhost.localdomain>
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002145738.38226-4-frederic@kernel.org>

Le Wed, Oct 02, 2024 at 04:57:38PM +0200, Frederic Weisbecker a écrit :
> Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU barrier
> blind spot. Report any potential misuse.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a60616e69b66..36070b6bf4a1 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  	head->func = func;
>  	head->next = NULL;
>  	kasan_record_aux_stack_noalloc(head);
> +
>  	local_irq_save(flags);
>  	rdp = this_cpu_ptr(&rcu_data);
> +	RCU_LOCKDEP_WARN(rcu_rdp_cpu_online(rdp), "Callback enqueued on offline
> CPU!");

This should be !rcu_rdp_cpu_online(rdp)

Sigh...

> +
>  	lazy = lazy_in && !rcu_async_should_hurry();
>  
>  	/* Add the callback to our list. */
> -- 
> 2.46.0
> 
> 
