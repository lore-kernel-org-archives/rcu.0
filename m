Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8C2BEFF5;
	Tue,  1 Sep 2026 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284345; cv=none; b=DwX7E9JzBkgfwmgQjWKWfhQueGCWDf9717DziKUGkDQg8DUufM/SbQj5s4c64tbdLmSa6RsySiHcmokpQkBj9ZNdcB0g4qW57zGe+Lb7EBQxv7MaTo2kF5/itJ/ypOLhFxAmla+Ho6/IR0fAdo6/HS11DyO8Sdpor4IGh/Cq5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284345; c=relaxed/simple;
	bh=LlF8QlYeHciUuUQzE1d/esXOQXeZNbku/VivTNVfMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeLpavZZXzd9VTf/yKhKuwGNyYcu639Z00KYZCNyJpUSfUsErI6IuNy9Bb27dMDdWYdoUYHB6i3xTF2HbzfBPWVWLmA9i0MGRSpPCngVWua+37wEHwmWCB0elvkiIsFLVmeL8GogW8G6zdIifOyQVndWyejP4Upc9iTH6GlVnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJo3Lg+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJo3Lg+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B221F000E9;
	Tue,  1 Sep 2026 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284344;
	bh=YNDgEdHXvcnDa008oy0P0vrmdKE+BwtoGrUWAusGpmg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=eJo3Lg+T9EboUXHufZ6eTIHXqDz/LW3nV6g3PwSNa/z7DcS7K12XLyOx/hsmpxqP8
	 NqKDZhYNa6FgT5AiXwTt3j4T7TnJIV5YV1Gd1um4N67gB8e7Pc9GcpHdqj8fRkkco9
	 HAgaknb0k2fKh48UiESHTQ2a9Cq5ZbKg0K7KVoK2ouDhyrPpHQIdjJ9BW3eb2A4yCA
	 uof46PHTz2OtOk3J/SO048GVuHShXsa3va3L/ZHIdfiRgx/5wBtwpCB8Vl/dofzZ5u
	 h81hH5zRh7aw72srF52HB8zg0SztFCiARzUvDEP8ofApFxeFrZmoPQxUp5405XbOkE
	 /YiiOG0rkUrqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44470CE09F8; Tue,  1 Sep 2026 10:39:04 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:39:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sunho Park <shpark061104@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, frederic@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in
 cleanup_srcu_struct()
Message-ID: <9df008d8-631a-4a45-b10d-80999d005185@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260830095605.3560267-1-shpark061104@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830095605.3560267-1-shpark061104@gmail.com>

On Sun, Aug 30, 2026 at 06:56:05PM +0900, Sunho Park wrote:
> The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
> when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
> to detect callbacks that srcu_barrier() failed to wait for. However, the
> ->len counter is decremented only at the end of srcu_invoke_callbacks(),
> after the invoking loop has finished. Since srcu_barrier() can return
> right after the barrier callback is invoked, cleanup_srcu_struct() can see
> a non-zero n_cbs even though the cblist is already physically empty,
> falsely triggering the WARN_ON() together with a still-pending delay_work
> timer.
> 
> This can be triggered as follows, as seen in the syzbot report against
> kvm_destroy_vm() -> cleanup_srcu_struct(&kvm->srcu):
> 
> 1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) starts SRCU grace
>    period GP1.
> 
> 2. GP1 ends: a delay timer is armed and sdp->work is queued, but
>    sdp->work has not run yet.
> 
> 3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) call invokes
>    srcu_segcblist_advance(), which moves the GP1 callback to
>    RCU_DONE_TAIL, and starts SRCU grace period GP2.
> 
> 4. srcu_barrier() is called. It queues its barrier callback after the
>    GP2 callback and waits for srcu_invoke_callbacks() to invoke it.
> 
> 5. GP2 ends: another delay timer is armed, and the sdp->work queued in
>    step 2 begins to run. Its srcu_invoke_callbacks() call invokes
>    srcu_segcblist_advance() again, moving the GP2 and barrier callbacks
>    to RCU_DONE_TAIL as well, and then invokes all of them. However,
>    rcu_segcblist_add_len(), which updates srcu_cblist's ->len, has not
>    run yet at this point.
> 
> 6. srcu_barrier() returns once its callback has been invoked, and
>    cleanup_srcu_struct() starts running. It finds the delay timer
>    armed in step 5 still pending and srcu_cblist's ->len still
>    non-zero (because step 5 has not reached rcu_segcblist_add_len()
>    yet), and WARN_ON() fires even though every callback has actually
>    been invoked.
> 
> Use rcu_segcblist_empty(), which checks the actual head of the cblist,
> instead of rcu_segcblist_n_cbs(), which checks the racy ->len counter.
> Callbacks that have genuinely not been invoked yet still leave the list
> non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
> or queue callbacks after it.
> 
> Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
> Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
> Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Sunho Park <shpark061104@gmail.com>

Queued for further review and testing, thank you!!!

							Thanx, Paul

> ---
> v2: Describe the exact interleaving of call_srcu()/srcu_barrier()/
>     srcu_invoke_callbacks() that triggers the false-positive WARN_ON(),
>     per Zqiang. No code change from v1.
> Link: https://lore.kernel.org/rcu/1b9d3ddaa26ba6a8ac2ad4c586c2d19a5c1f927e@linux.dev/T/#t
> ---
> 
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ed204b3f4b84..ad27880dd690 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -704,7 +704,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  		// Call srcu_barrier() before this cleanup_srcu_struct()
>  		// to avoid triggering this WARN_ON().
>  		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> -			    rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> +			    !rcu_segcblist_empty(&sdp->srcu_cblist)) &&
>  		    rcu_cpu_beenfullyonline(sdp->cpu))
>  			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>  		flush_work(&sdp->work);
> -- 
> 2.43.0
> 
