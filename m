Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDDA30E0F8;
	Thu,  1 Oct 2026 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816244; cv=none; b=X9uR4R2uN4eGmQ2Uc12QWzf2VpC8EGMFGUNXAFtbl2u0en7yJOPWHqH1f9KBlg2LdFNOX3QdZBL/HJsOoXMOnFM9pEqLWs0zqzFJXLxOPEfZpcg+C3UNeHjXnGl+pY47xGFCjQAy5Gg+BdFNP8Gwv4C5JMBjG/hvRK6TLouQi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816244; c=relaxed/simple;
	bh=YbikIasQmrmWSK/D7xj5oCxCOLx7N0wR5T+swhhBxyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF3V8HMNf17dqbSiLaabuWay2HTly6C5Ww/p3QuM2K6k7ojznLkuAMZtiTMQRKecM8yP8MNtcMRP+/7DVHTxFqZfpk5aYMKH7hFchYbbRQXiGPxeCGyd9gQQ0YcbICb4OC5WG/Uv6kKB6Oe147uF5CfzDfRnGwFFggw7pReRRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmWdBfLE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmWdBfLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C1A1F000FF;
	Thu,  1 Oct 2026 00:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816242;
	bh=eJLcecphKzjRHbY4IdAuCTvM0WGj9dGRXdkRNC9wPgw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TmWdBfLEPl+YtbTtDtxelDSZNo1lCkjIFSE2pAOQiMkstselgsVkqsDcefafwGdv5
	 D5LlwX4dhI5t9sDTaezohdKu7FsuZincV3n4F5QABgIEzCfvGUEHPIOT/d8HeFOPpj
	 0MmbcA+KzG5ywz7If2I2h/ztjeJyGPgS4ndkpffYnwNEQPJN5kkIjNkABRSg6WaLn8
	 LqqdwLBKyV+82eZxHCb2AuraABOY+N3gqwFpPGjD+2QFW6co+cmleDXxyBJbkJDh9v
	 k0ltv0Qe0ISyOaPHUFAlNNuzA9mwfFtPjwogzhxEds9brWnLGsuiVXi6Gsn7ce+u25
	 p/ou8THn3w56g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A8E62CE097C; Wed, 30 Sep 2026 17:57:21 -0700 (PDT)
Date: Wed, 30 Sep 2026 17:57:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Sunho Park <shpark061104@gmail.com>,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH 09/19] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in
 cleanup_srcu_struct()
Message-ID: <a79c83e1-a7ae-407b-8b11-0a031be2faf1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
 <20260919003521.3134552-9-paulmck@kernel.org>
 <ar2o5yyB-o12pAos@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar2o5yyB-o12pAos@google.com>

On Wed, Sep 30, 2026 at 05:27:19PM -0700, Sean Christopherson wrote:
> On Fri, Sep 18, 2026, Paul E. McKenney wrote:
> > From: Sunho Park <shpark061104@gmail.com>
> > 
> > The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
> > when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
> > to detect callbacks that srcu_barrier() failed to wait for. However, the
> > ->len counter is decremented only at the end of srcu_invoke_callbacks(),
> > after the invoking loop has finished. Since srcu_barrier() can return
> > right after the barrier callback is invoked, cleanup_srcu_struct() can see
> > a non-zero n_cbs even though the cblist is already physically empty,
> > falsely triggering the WARN_ON() together with a still-pending delay_work
> > timer.
> > 
> > This can be triggered as follows, as seen in the syzbot report against
> > kvm_destroy_vm() -> cleanup_srcu_struct(&kvm->srcu):
> > 
> > 1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) starts SRCU grace
> >    period GP1.
> > 
> > 2. GP1 ends: a delay timer is armed and sdp->work is queued, but
> >    sdp->work has not run yet.
> > 
> > 3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) call invokes
> >    srcu_segcblist_advance(), which moves the GP1 callback to
> >    RCU_DONE_TAIL, and starts SRCU grace period GP2.
> > 
> > 4. srcu_barrier() is called. It queues its barrier callback after the
> >    GP2 callback and waits for srcu_invoke_callbacks() to invoke it.
> > 
> > 5. GP2 ends: another delay timer is armed, and the sdp->work queued in
> >    step 2 begins to run. Its srcu_invoke_callbacks() call invokes
> >    srcu_segcblist_advance() again, moving the GP2 and barrier callbacks
> >    to RCU_DONE_TAIL as well, and then invokes all of them. However,
> >    rcu_segcblist_add_len(), which updates srcu_cblist's ->len, has not
> >    run yet at this point.
> > 
> > 6. srcu_barrier() returns once its callback has been invoked, and
> >    cleanup_srcu_struct() starts running. It finds the delay timer
> >    armed in step 5 still pending and srcu_cblist's ->len still
> >    non-zero (because step 5 has not reached rcu_segcblist_add_len()
> >    yet), and WARN_ON() fires even though every callback has actually
> >    been invoked.
> > 
> > Use rcu_segcblist_empty(), which checks the actual head of the cblist,
> > instead of rcu_segcblist_n_cbs(), which checks the racy ->len counter.
> > Callbacks that have genuinely not been invoked yet still leave the list
> > non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
> > or queue callbacks after it.
> > 
> > Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
> > Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
> > Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Signed-off-by: Sunho Park <shpark061104@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> Is this going to be grabbed for 7.3?  It shows up relatively frequently in KVM.
> Not so much that it's truly problematic/alarming, but enough that it definitely
> stands out.
> 
> Tested-by: Sean Christopherson <seanjc@google.com>

I wasn't thinking in terms of doing so, figuring that the almost-here
merge window would be good enough.  But it does seem to apply cleanly.
Any other votes for pushing it into 7.3?  If I do so, it must be soon.

Either way, I will of course apply your Tested-by.

							Thanx, Paul
