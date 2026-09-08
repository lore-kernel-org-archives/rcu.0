Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22F4B0C99;
	Tue,  8 Sep 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894947; cv=none; b=sqtdMXgKISlS6rXqnk+m+8t7cuM6+fP4kPFPgfWNQUTbd6/4iJCpqDs3B7Ic1TqxO0m6+oIweslWeSoVJjFztdMhYCXH+2achw3/kOE2uJJzssK8G6G2v9TPTY7ewVE9SyrUEfxuhh6+8Ic01vGejyu/q14OUB9B7nF/R6+DEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894947; c=relaxed/simple;
	bh=y7iTOwHAjjvTMMKlN6GePGgcnZ6oCoo4dXl1SIdmKyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWgsfeQ3CS6blo1AQG/iqfqzcPVMhQXzzp6D8/qlYzFbGTPO42770HBMFY0sjQhLkNSX4fEUpoRIDpG85DBDi5mVaylJI3EpFkkXoOaW8OdQ13Zg25XgiDR7BBbbpSOhWVCu4cLVDcDXDVYdlcu9btn2/e79meQwmCdA2U8w+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzIOuAcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzIOuAcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599B71F00A3A;
	Tue,  8 Sep 2026 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788894946;
	bh=xlb+EB+7H4FuMFNVE0BdRiSD30EDF7wtwbydJ1Rdyoc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=VzIOuAcJZfI6Y3Z/0Y9JhjOysmnJS+S+IZOXAbX2XBpRnMGoTCSzIvVIzYHdVirNV
	 qThFG4p7SFIp+CNKW0N0fpPeOng6gRtgjY9Bekl2ZZKXHN+E5ixqIPNgdFU3X9zoNq
	 PWpCvk8DkQXUXP9clca+zVPKJc4HJRQVHvNRMYGSZStxIlA87d5CtewnUrTLD2EhpQ
	 TVR0aSSQ2EDiPplsxDLj1D+Ysl4kCKBjJcL9KqpDZSPqN2FEtwsTIG/Pttvi1g7qg8
	 cGlTO14XEO19cQsjvOFz+0bZVBeVEQTkiWfft1GqYXXjQ+y85PJIZPd8z5tDYxSBqk
	 cYzcVP6/J6/8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1B59FCE1902; Tue,  8 Sep 2026 12:15:46 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:15:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: fix typo "upto" in comment
Message-ID: <14910411-e497-48a8-a447-d3876e40b1e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907063622.24824-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063622.24824-1-hemanth.selam@gmail.com>

On Mon, Sep 07, 2026 at 12:06:22PM +0530, Hemanth Selam wrote:
> Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ed204b3f4b84..01f19bb17dd6 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -624,7 +624,7 @@ module_param(srcu_retry_check_delay, ulong, 0444);
>  #define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
>  #define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
>  #define SRCU_UL_CLAMP(val, low, high)	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO((val), (low)), (high))
> -// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
> +// per-GP-phase no-delay instances adjusted to allow non-sleeping poll up to
>  // one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
>  // called from process_srcu().
>  #define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
> -- 
> 2.48.1
> 
