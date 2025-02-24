Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20318B482;
	Mon, 24 Feb 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416874; cv=none; b=GnKqIVXiZKH1YZgThPk7jDE64y74j5/4whJo5b9tsA8x1B1lrnQZ3JFg2c+39OB6Y7ozwEgt9fHiMQjZmgilI4gRiSf1ogdWg+f6SN4/LkTO3DwvcNw5VcYaadGlVmeNH83+cDWFs/B3tZlUqLoT9+53/TzVtqCO2sGrjt5Nsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416874; c=relaxed/simple;
	bh=cEYAY+iSio8M0SXczMwaWtZ7QZYtbIkXjLE/+/NOXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpJyWvBecLj15XXC/xrYo6m6R7SN00vUkLP+KhWTvF6ucYsZeE/YjMbxwncHn2qHxngu1+K4JsW/2dFdajpYrXSpQSUUkXWfs+Ut4ecwK7vI55PwhFbxcBPJP7iyylYtnsjq7eXDkjra4yXfWCMrB5MoVxt0D8ku4aV8elfQuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAbsISiy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAbsISiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46185C4CED6;
	Mon, 24 Feb 2025 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740416873;
	bh=cEYAY+iSio8M0SXczMwaWtZ7QZYtbIkXjLE/+/NOXqs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XAbsISiyxjMmCJOnCbEriub41yNiEf7rAJHLD9FUOhN7tvD5m7zbS33EGXWsAInJs
	 n2ySvoRFSPRAfBpOZ4EFCAgcXnRjzHiSuTqQgsW6zf9236aSJlyOudcBwBiElNCBDf
	 ZUe/OGDE4s8EzlwMOsYdM5kPV2/OIzHKh1S17jzAumFFjSvKPyO4b3eOaOl2pl7SXw
	 s9yL97sLp6zFFwbzyXx3kdRyVXFRg8qph2AmavJ2Q68YqoLJd8WC6hb8eKgLkyy8cz
	 vFAYdtROxVteJwDMoprLjzZNIBj8IVaqfG9z4QUUt9W8+jIGtW38dBC5ISBmydPxOS
	 aAMvr4aIQhIng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7D61CE0B34; Mon, 24 Feb 2025 09:07:52 -0800 (PST)
Date: Mon, 24 Feb 2025 09:07:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>,
	Ankur Arora <ankur.a.arora@oracle.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rcutorture: Update ->extendables check for lazy
 preemption
Message-ID: <d43d929a-d17c-4f11-9048-b9ddf08f713c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z7v4MytjhhBZkG4S@Mac.home>
 <20250224044310.14373-1-boqun.feng@gmail.com>
 <20250224044310.14373-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224044310.14373-2-boqun.feng@gmail.com>

On Sun, Feb 23, 2025 at 08:43:10PM -0800, Boqun Feng wrote:
> The rcutorture_one_extend_check() function's second last check assumes
> that "preempt_count() & PREEMPT_MASK" is non-zero only if
> RCUTORTURE_RDR_PREEMPT or RCUTORTURE_RDR_SCHED bit is set.
> 
> This works for preemptible RCU and for non-preemptible RCU running in
> a non-preemptible kernel.  But it fails for non-preemptible RCU running
> in a preemptible kernel because then rcu_read_lock() is just
> preempt_disable(), which increases preempt count.
> 
> This commit therefore adjusts this check to take into account the case
> fo non-preemptible RCU running in a preemptible kernel.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcutorture.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 280bff706017..4cae119dece8 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1901,8 +1901,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  	WARN_ONCE(cur_ops->extendables &&
>  		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
>  		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
> -	WARN_ONCE(cur_ops->extendables &&
> -		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
> +
> +	/*
> +	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
> +	 * as rcu_read_lock().
> +	 */
> +	mask = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> +		mask |= RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> +
> +	WARN_ONCE(cur_ops->extendables && !(curstate & mask) &&
>  		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
>  
>  	/*
> -- 
> 2.39.5 (Apple Git-154)
> 
