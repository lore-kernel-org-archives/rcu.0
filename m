Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422103;
	b=XagMc79b62jc/Q4XGZdbAbqRBpWNy0HyrQvM3lqqcFhaProDE0upWFJYIPnXjlrOZ4kJ
	 UcpLVVFliUA4cRttQQuTjGfByxOGdKl18hMOkhYgMFdSKYu5+Np7N7MyYBJsxe3lNJo/p
	 uQcvdnJ93oTaz55u64CWyYtOVtfCwJ1wkNiPzOffcviEDdm8uSa/rEKwcGLh3xNQHqMW4
	 2eYh3/iUXUpqjSrb2LsqI2+8lwJA8mCpqvkLX3Z4Slqc3yDgA29+h15YzCcJZmLTXnkaZ
	 ncvJm71sv3ebOKtvKlJfW0e3WQUUG1gqqz9pUsGBtnAld+o+M8cpNJwnzDsF9h0YhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422103;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=txTzOaRWJ0n6iUeMWLU8wgCbSKIbOYxdAF2+5N3vgPA=;
	b=e89Aa2ejFr+yzDIlR8LWQy0vQwrmAS/32a8ehh8/ugywgZ+N3QJGeJolADQL9onQZSdq
	 rvP//6be+9kUQ1w9nhWUHXUkHgGE3YXcbvAnA2S682OvRySsI36rA+na9CZdpgtVUXMNC
	 vIfQ/scHs3A7xejMP58VZH85vu0aYSggGOwDq5B1Yj+jUudyYA8XdE8g6VutJLsCQbcyv
	 M8shNaGKAKf8mnWZcChTTDViOP7ePoHCIDq5nwCHZA+kUBdx9dwhf9Cp+bWuk+FLLOit3
	 qrFetH4Wu00WaOeTllz50AHRdHkE12c/H0A1fcSjIgnmtjRMPD0ITENjrmPHqnQXYwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+KiMR07;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1C606A324;
	Wed, 11 Nov 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+KiMR07
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244681F00A05;
	Wed, 11 Nov 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422103;
	bh=txTzOaRWJ0n6iUeMWLU8wgCbSKIbOYxdAF2+5N3vgPA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=N+KiMR07IeSRxWQHs1mdBBBy4QL35adY8IGKON36meVa6m+5hnaOKIQ0lsP3QO7Qr
	 ctkrnWeKf3+N6IZSckBM0nckLVv2+FUcSXaZ+wpZI6tKrGbQHC/TDdtPTwTGHgDQl5
	 tweKu0sTRy65NQ7RrntXhfPGMwHTqeH/PiTSzCF4QcxmfOW0ytija2UF2OLKX55zlo
	 PgtgbCE7GM0GMmU/5i9C9rlO8kZHwO8UY6SKuW/oME8M3mnm0AH49kUxXXhxrxj7SS
	 NsQPvxWmycshPm/REzcE+f/IZMbU1jnTEO/fHBjyyqpVg75+rUQ690QhBUcJ85bozl
	 AIAlD5nAdvm/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D26D4CE0840; Wed, 11 Nov 2026 10:35:02 -0800 (PST)
Date: Wed, 11 Nov 2026 10:35:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 1/7] srcutiny: Do not call synchronize_rcu() from
 synchronize_srcu_atomic()
Message-ID: <c2fe00c8-6234-47ba-b23a-75455ced3ab2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-2-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111145949.70845-2-mathieu.desnoyers@efficios.com>

On Wed, Nov 11, 2026 at 09:59:43AM -0500, Mathieu Desnoyers wrote:
> synchronize_srcu_atomic() never blocks, so that it can be called from
> atomic context.  This includes interrupt handlers, and code within
> rcu_read_lock().
> 
> With CONFIG_PREEMPTION=y, the Tiny SRCU version first calls
> synchronize_rcu().  Tiny synchronize_rcu() does not wait: it only
> advances rcu_ctrlblk.gp_seq.  This is valid where the caller is in a
> quiescent state, in task context and outside of any RCU reader.
> 
> The callers of synchronize_srcu_atomic() need not be in a quiescent
> state.  An interrupt handler may have interrupted an RCU reader.  A
> caller within rcu_read_lock() is itself an RCU reader.  In both cases,
> synchronize_rcu() ends an RCU grace period while an RCU reader is still
> in its critical section.  poll_state_synchronize_rcu() would then
> report a grace period that did not happen.  The caller within
> rcu_read_lock() also gets "Illegal synchronize_rcu() in RCU read-side
> critical section" from lockdep.
> 
> srcu_drive_gp() has the same call.  There, it makes an RCU Tasks
> Trace grace period imply an RCU grace period.  RCU Tasks Trace uses
> call_srcu() and synchronize_srcu(), which are both forbidden on a
> srcu_struct that uses synchronize_srcu_atomic().  And the Tree SRCU
> version of synchronize_srcu_atomic() does not wait for an RCU grace
> period either.
> 
> Fix this by removing the call.
> 
> This was found by reading the code.  An rcutorture test added later in
> this series fails without this change.
> 
> Fixes: a48669f0c49c ("srcutiny: Add an atomic Tiny SRCU")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/rcu/srcutiny.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 63a3f0a8bc53..d58f4160f925 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -367,9 +367,10 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return;
>  
> -	if (IS_ENABLED(CONFIG_PREEMPTION))
> -		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
> -				   // And in Tiny RCU, it is near zero cost and doesn't block.

Good catch!!!

And there was a time when we were thinking on adding preemptible Tiny
SRCU, but this proved to be problematic.  Plus RCU Tasks Trace uses
synchronize_srcu(), not synchronize_srcu_atomic(), so its needs do
not matter.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> +	// No synchronize_rcu() here, unlike in srcu_drive_gp().  The caller
> +	// may be in an interrupt handler or within rcu_read_lock().  Tiny
> +	// synchronize_rcu() would then end an RCU grace period that an RCU
> +	// reader still holds up.
>  
>  	// Usually, there will be no readers.
>  	preempt_disable();  // Guard against lazy preemption and some other grace period.
> -- 
> 2.47.3
> 
