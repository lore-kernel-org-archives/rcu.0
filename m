Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AE23C8C7;
	Thu, 25 Dec 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701227; cv=none; b=IJBJVIKTE5mu2cvVrDoNU0dMEax30mN8elaV5lI10XgRbOPR3KJY7xeYq4I33OOrSDTO6is1Zj7HRpQjhA68lKBmnWeQu5nE9fcITBFiSh+4+CiWPZzG8qrsFr/6HxMUIon3C2KwJgtrSGUM4nU6Fh9yvsIpBbl4CmfJv/Ex6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701227; c=relaxed/simple;
	bh=Gc7xLt5DvCtIzvP4Rt3W3ITMFXQnqwMtjc3FuMfIMi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oynQ7UIBjsNorPbKzQy/lEMKEA1dIeMfsFV4wtH0pZhjK+7Q3VvBA5e+ESFzgKIsEs8hA3gOOnQvP59Y7kX1qrrv/gv0vVVd1mW/tDV5AKHiVEslTb3wTykapi2bO7pEXKRzucvGCPjWQdhM0cDLOdSGWOsFDb8D5xEQjFtIpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdBCudla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdBCudla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489D8C4CEF1;
	Thu, 25 Dec 2025 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766701226;
	bh=Gc7xLt5DvCtIzvP4Rt3W3ITMFXQnqwMtjc3FuMfIMi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdBCudla65A3LTNQDs1ozTy4YG7W4jiml84QmuiNFSJaQGb6sBsJ5xAlD0ozWZSjL
	 mkIZnlaEQ1xJWvuyl8Jm2xG1Znxk2D1qmXEjyFNTQ+P3ClrOst05Jy/NSSUFNwvLEN
	 H6EhhWvtremt6fk6J9mBZq/R8/vxhfhc3ZmWCrYwKPvgP/iyGJAsceJcewECWascDA
	 vc42+d5wc4nqL34aE/aTTua0a86yU39tCLA96h/EIwjTW/+UZN7zZgs8b5kSq845jC
	 XU16+Mbyvl0gKD56peDlVcL15dcttpenBGKtzZUaEQikOWuyvursPhSeqiLAhYvlI6
	 Ec13I1UHKzsOw==
Date: Thu, 25 Dec 2025 23:20:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake
 path
Message-ID: <aU24p7he1T63Qeke@pavilion.home>
References: <20251225074451.2405584-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251225074451.2405584-1-joelagnelf@nvidia.com>

Le Thu, Dec 25, 2025 at 02:44:50AM -0500, Joel Fernandes a écrit :
> The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
> wake rcuog when the callback count exceeds qhimark and callbacks aren't
> done with their GP (newly queued or awaiting GP). However, a lot of
> testing proves this wake is always redundant or useless.
> 
> In the flooding case, rcuog is always waiting for a GP to finish. So
> waking up the rcuog thread is pointless. The timer wakeup adds overhead,
> rcuog simply wakes up and goes back to sleep achieving nothing.
> 
> This path also adds a full memory barrier, and additional timer expiry
> modifications unnecessarily.
> 
> The root cause is that WakeOvfIsDeferred fires when
> !rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
> accelerate GP completion.
> 
> This commit therefore removes this path, which also adding some rdp
> counters to ensure we don't have lost wake ups.

There should be two patches: one that removes the useless path and the
other that adds the debugging.

> 
> Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
> configurations) - all pass. Also stress tested using a kernel module
> that floods call_rcu() to trigger the overload conditions and made the
> observations confirming the findings.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Cool! Just a few comments:

> @@ -549,24 +546,26 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  	lazy_len = READ_ONCE(rdp->lazy_len);
>  	if (was_alldone) {
>  		rdp->qlen_last_fqs_check = len;
> +		rdp->nocb_gp_wake_attempt = true;
> +		rcu_nocb_unlock(rdp);
>  		// Only lazy CBs in bypass list
>  		if (lazy_len && bypass_len == lazy_len) {
> -			rcu_nocb_unlock(rdp);
>  			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
>  					   TPS("WakeLazy"));
>  		} else if (!irqs_disabled_flags(flags)) {
>  			/* ... if queue was empty ... */
> -			rcu_nocb_unlock(rdp);
>  			wake_nocb_gp(rdp, false);
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("WakeEmpty"));
>  		} else {
> -			rcu_nocb_unlock(rdp);
>  			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
>  					   TPS("WakeEmptyIsDeferred"));
>  		}
> +
> +		return;
>  	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> -		/* ... or if many callbacks queued. */
> +		/* Callback overload condition. */
> +		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt && !rdp->nocb_gp_serving);

With this test, the point of ->nocb_gp_serving is unclear given that both
states are cleared in the same place but ->nocb_gp_serving is set later by
the gp kthread. ->nocb_gp_serving implies ->nocb_gp_wake_attempt so the above
test is the same as WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt).

In fact ->nocb_gp_wake_attempt alone probably makes sense?

>  		rdp->qlen_last_fqs_check = len;
>  		j = jiffies;
>  		if (j != rdp->nocb_gp_adv_time &&
> @@ -575,21 +574,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>  			rdp->nocb_gp_adv_time = j;
>  		}
> -		smp_mb(); /* Enqueue before timer_pending(). */

You need to remove the pairing smp_mb__after_spin_lock() in
do_nocb_deferred_wakeup_timer().

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
