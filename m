Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269175;
	b=wt9UFwK+fZx4qWJdmHwDdCuH/V4IqXoChlmJSRTQ8rpHuRMxZZuxLjyS/KzNhLaYPcCy
	 FA8t+IrnDE6gJrbp0qBUmXQQN3rTrCTUgajBZwyfIWg3tvyuFWe7WxRaD9PopWyxd3nTf
	 tsGJVi4txP/Hwbn3hCRoVyN8k7MvHxZnuNdA+7wWDnwcueW9DBIB98E0i0QHor1AEAzLc
	 5jWvvvxwisdn4g5DrU9sHgSZ1RSCjOUUFaxFOJysYw6Vx1GTLBLTPv9ZwG6xQQHgAkFnn
	 uzYNiuzxVuuO6ioyF1AU9enzXkpnL3r+fJ6dT+4eu+mq7wbomnhf/B8ZILJ9cjbQSCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269175;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=T3dCovM9ycIm/UpLEj5ZCGqMXiYvmREOE5dGUK2Ea2w=;
	b=dJz+LY54IEdXlvS3yt9AJ93KBDwhOeL2sVAWThRvMSSTSEu6qbL/jg7gockWTtZkv29M
	 Z+u9w4Ym+W31dlwa/MfjWKsFLzT3o76NkeDaGjR9wsLDpywdlpiDdi06seFbgcPV8ejGG
	 3bMjNGxIy7omdLqMRV/Eo1RFOKNMrQBj3kj/RJb5yFnJwSiQTVuXIWUjtmVvTBQQHlWyD
	 rwDKMasD3MHVU+5tUtTvDFQkMJMc7t3GtGJlvv39fnrZJso/86GXqZun8YJnxIzhd0Jwi
	 MH/kj20QjACw/vC4oqy6G349LjJegSm59mhTif6RervpHvNaDqP/m5xWWeYhqE/nwzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Le/w2pDS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32E606A321;
	Tue, 10 Nov 2026 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Le/w2pDS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4581F008A1;
	Tue, 10 Nov 2026 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269175;
	bh=T3dCovM9ycIm/UpLEj5ZCGqMXiYvmREOE5dGUK2Ea2w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Le/w2pDSYHeynIZ6VLXyP59IeHlf+Mt+VVPrZswpaB+0vPLEFfcR4w354hvEg9Paq
	 2wxeJbM3eikc8e5kPmJSrM5f/xp6JWTy3vxXBhLaJIet8yBnS6Hf5RT5Sx+T40NO2J
	 VmlVkdzeoao2/KR/rzncpCI648i1XoNY88+OHz0T1QK0mgDnM1P/Pymt4aZmTacIpR
	 Xx5P6bJ+SD/8FFr9mSMldOxpyYSDvl+x1mTiUmBZ/1xMBUfiSp/9pzOIm4rdECbAkm
	 jYTJXXsNHJH6h8u3skJYBKomYy2czs9gIPa5xVsiXI+Uyo82HESIorjubTHV5bT0L7
	 q0b2Xxa5fRYIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C92B3CE0DDC; Mon,  9 Nov 2026 16:06:14 -0800 (PST)
Date: Mon, 9 Nov 2026 16:06:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH v2 1/5] rcu-tasks: Track barrier callbacks in debugobjects
Message-ID: <086a97a9-60ed-4a7a-88f4-b63f36775b1a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
 <20261109000243.3936824-2-joelagnelf@nvidia.com>
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
In-Reply-To: <20261109000243.3936824-2-joelagnelf@nvidia.com>

On Sun, Nov 08, 2026 at 07:02:37PM -0500, Joel Fernandes wrote:
> rcu_tasks_invoke_cbs() now unqueues each callback from debugobjects.
> However, rcu_barrier_tasks_generic() inserts its per-CPU barrier heads
> directly with rcu_segcblist_entrain(), bypassing the queue hook in
> call_rcu_tasks_generic(). This produces active_state and deactivate
> warnings for untracked objects when a barrier callback runs.
> 
> Activate each barrier head before entrainment and undo that activation
> when there are no callbacks to entrain behind. Successful entrainment
> is balanced by the invocation path, as for ordinary callbacks.
> 
> The existing n_barrier_cbs=2 torture test reproduces the warnings before
> this change and completes without them afterwards.
> 
> This fixes patch "rcu-tasks: Detect duplicate callback enqueue".
> 
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

This looks good to me, but I strongly suggest squashing it into the
original patch for bisectability.  With appropriate attribution,
of course.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d5d060a5c4b6..a20db323612b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -470,9 +470,12 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
>  			break;
>  		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>  		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
> +		debug_rcu_head_queue(&rtpcp->barrier_q_head);
>  		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>  		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
>  			atomic_inc(&rtp->barrier_q_count);
> +		else
> +			debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
>  		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>  	}
>  	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
> -- 
> 2.54.0
> 
