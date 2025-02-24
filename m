Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D52F3B;
	Mon, 24 Feb 2025 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373098; cv=none; b=Quay7z7QITT8NG8eGwe5doaqbuD3sAyqJUH0j9uHUbCm2JhDULhQlCBFxIDwsuj4IG+4boFRdFEmDLpsIK87g8cSVVhaxm/S5ycTPJhTghc4pyZ8JXboUew5VelUVhwXM7x3I/JpgDHHIz2iXXFARryKgT1tNC3zIBJT0Yt6Ggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373098; c=relaxed/simple;
	bh=RRl8JWzS4fnY6sz2AycfSbZ5IQp14oLxvfAE+unks8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxXZn+g9ON/FBKc0/u1jQ+WqSnlEgs0WrwdR9kJe9HfZ0j3cHUKeimtL7+T6vdPEpV1/FsU/V5tjT174hUCTIlj6ZCdfPdhS5Zqw2t+Qr+oNkE/aIrd5tWIq9rQ0iDsPqQkNCXie9ERYVv0Tu4gjOlo8Ojfih0oZMXX/HpErM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3GZyIf4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3GZyIf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F00C4CED6;
	Mon, 24 Feb 2025 04:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740373097;
	bh=RRl8JWzS4fnY6sz2AycfSbZ5IQp14oLxvfAE+unks8Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=c3GZyIf4QyMVJ12icnbqouqPM5Mp5bt0VfSfdUK62FZBDMY/nroKf8TG/7URdZlnE
	 d7BG9n7Ech7+EY03xMKyHtqWD9MP44vBbCWm3Dy6JyTJYKP8+M2axBx6a527OsBn2E
	 W4Z5oBLtu7WgzBiH/kN/pkm+uzatzU3jRc1Hnhjqlmprrx+7sTvuj1/THcAFJrm2UG
	 3LPz89GlBvlkHwlZLz8HsL+YUszDMshzhYw7TvhxHHqdroGGzCD3ZQbmy2pV7xd17v
	 oYsHKn0Nml77xh+3GiNg2No4ubvK+a+9E9UBHGgiOfKVmPZy1LWkgXe45MoeYu+Gpv
	 gv9JyX2Zj3Mlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B13ECCE0BC5; Sun, 23 Feb 2025 20:58:16 -0800 (PST)
Date: Sun, 23 Feb 2025 20:58:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>,
	Ankur Arora <ankur.a.arora@oracle.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2 1/2] rcutorture: Update rcutorture_one_extend_check()
 for lazy preemption
Message-ID: <07c31e33-4720-4204-9066-e57a708f5ae7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z7v4MytjhhBZkG4S@Mac.home>
 <20250224044310.14373-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224044310.14373-1-boqun.feng@gmail.com>

On Sun, Feb 23, 2025 at 08:43:09PM -0800, Boqun Feng wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The rcutorture_one_extend_check() function's last check assumes that
> if cur_ops->readlock_nesting() returns greater than zero, either the
> RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
> is, there must be at least one rcu_read_lock() in effect.
> 
> This works for preemptible RCU and for non-preemptible RCU running in
> a non-preemptible kernel.  But it fails for non-preemptible RCU running
> in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
> function, which is rcu_torture_readlock_nesting(), will return
> the PREEMPT_MASK mask bits from preempt_count().  The result will
> be greater than zero if preemption is disabled, including by the
> RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.
> 
> This commit therefore adjusts this check to take into account the case
> fo non-preemptible RCU running in a preemptible kernel.
> 
> [boqun: Fix the if condition and add comment]
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d26fb1d33ed9..280bff706017 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
>  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
>  static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
>  {
> +	int mask;
> +
>  	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
>  		return;
>  
> @@ -1902,8 +1904,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  	WARN_ONCE(cur_ops->extendables &&
>  		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
>  		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
> -	WARN_ONCE(cur_ops->readlock_nesting &&
> -		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> +
> +	/*
> +	 * non-preemptible RCU in a preemptible kernel uses "preempt_count() &
> +	 * PREEMPT_MASK" as ->readlock_nesting().
> +	 */
> +	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))

Good catch, thank you, and it looks good to me!

Oliver, you are right, I was looking at the wrong console output.
One of those days, I guess...  :-/

							Thanx, Paul

> +		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +
> +	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
>  		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
