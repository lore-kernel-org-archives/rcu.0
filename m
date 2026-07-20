Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C642FCA8;
	Mon, 20 Jul 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563019; cv=none; b=vF8w+uYHeVpyArV1JdTP8Uc81EiEf87mc/9VQSWN3Up/wDGDGR4rYu0XsT0mnxipPqxjB3zfoxISxJv9mwg/uYhYymu/8Akui+Z2Sf2hXqG8MLQry7h6eDfNNQOnRtH7xSrAL5XcY2p6dz5vEYPw7C2fBUc0c+dh/My5tuxQVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563019; c=relaxed/simple;
	bh=bQFX+FSJfMUlX09wSG16ks7gLtPLTBnmHos4OCwzd2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIusXutHtemCJDOpDa5iKQNJ9bUV2be/owep2dDGBA6IlbHIyOkBgmFEDs+lUHfRQAvphqJDxHfvwUoab8aj/xFnvDWXsJS/61N4cadTz6SNC7HAZETOxtGrV8yV1YbxKfBo032topmHhHGY1OtHj/LPCF8BLeLOMbZJkKF9GxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfqbYtAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfqbYtAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520E1F000E9;
	Mon, 20 Jul 2026 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563017;
	bh=oD2OOLbFQt+Z55cwC5BPgSUpDiKdgZxysmq2/lq7YwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RfqbYtAQ/Rjw6ReztLY9SF6ski6EGjTGAVgtvTEY1iRKUTNh8OELLu8hC4//4Wi6I
	 3xjq6mB7jx4LXwEYB3RKZ5/66qwYegADV/Ux3OmgL/I5J/NvYMZXdh7aWtjC4AD7zr
	 kdQZWcPkvBc5g8QdZFN+HWrz+wyUMABuzI+vbmz+dnqDrrXb7OemqmzsdmOVjOyN/n
	 6vVRkAT1gneLFhXEaKIw+i1ZA9jiT9Fabh6zy5o4XDr691IASgfppgR3DJQi7zz6ft
	 nLFx2+QVBuPsE2+w93PnBDoklXUOjV3u7sMp8QmCo8Yux8+yE1NiGIx0zuSOAtXa+V
	 VDj/5PtHAXHlA==
Date: Mon, 20 Jul 2026 17:56:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 08/11] rcu: Wake NOCB rcuog kthreads on expedited
 grace period completion
Message-ID: <al5FRi7Sl5FXPjON@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-9-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-9-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:50AM -0700, Puranjay Mohan a écrit :
> When an expedited grace period completes, rcu_exp_wait_wake() wakes
> waiters on rnp->exp_wq[] but does not notify the NOCB rcuog kthreads.  An
> rcuog kthread that is waiting for a grace period sleeps on the leaf
> rcu_node's ->nocb_gp_wq[] with a wait condition based on the grace-period
> state, so without a wakeup, callbacks on offloaded CPUs that could
> benefit from the expedited GP wait until the rcuog kthread wakes for some
> other reason (e.g. the next normal GP or a timer).
> 
> Make the rcuog grace-period wait honour expedited GPs and wake it when
> one completes:
> 
>  - nocb_gp_wait() now records the grace period to wait for as a struct
>    rcu_gp_seq (both normal and expedited), tracks the earliest pending
>    normal and expedited sequence across the group, and releases the wait
>    via poll_state_synchronize_rcu_full() so it wakes for whichever
>    completes first.  ->nocb_gp_seq is widened to struct rcu_gp_seq
>    accordingly.
> 
>  - rcu_exp_wait_wake() calls the new rcu_nocb_exp_cleanup() on leaf
>    nodes, which wakes both ->nocb_gp_wq[0] and ->nocb_gp_wq[1] (the
>    expedited sequence does not share parity with the normal ->gp_seq the
>    waiter indexed with).  Both this path and rcu_nocb_gp_cleanup() use
>    the shared rcu_nocb_cleanup_wake() helper, which checks swait_active()
>    first; the smp_mb() in rcu_gp_cleanup()/rcu_exp_wait_wake() orders the
>    grace-period state update before that check.
> 
> A stub rcu_nocb_exp_cleanup() is provided for CONFIG_RCU_NOCB_CPU=n.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
