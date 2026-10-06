Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327E4A0F01;
	Tue,  6 Oct 2026 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311675; cv=none; b=ERGF2gsDeJ5mSF1P32enA8zhRI6XzXUjAX2NGD7l1Y8DZf04p/R3yZiVBIXCF1UA/2/w3zAgta0m2RgRCZFDZFu9ZH9vPeZeFhYVQdrFTYlJMxoOSI0LFXjf6k2zZBi3lYWX8pqx0ZHiVa8oerT9eJz/h4YNsp881hZr8mYOZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311675; c=relaxed/simple;
	bh=Lo6XuEJWK83L8MNFBRGuFvOBrKkQaaNkgybvpzga4PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7zVuSKAEnPeVmLi/hnBOz9U67h/G+sGhGeHhhRVHh/fSEjubKNde/ceTfVFfKtBRwiJn9Vz8kyUJjBkvdxT0mFtfCgwr37M0RnMexzAuNZCqZjV+bF+/v0pZCAMrsmjAsMkqvt9pVrPqyD4gPdEn0W0IK07z/HMnitbRcjkocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVGehG62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVGehG62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE851F00902;
	Tue,  6 Oct 2026 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311672;
	bh=xu3chdljYk93N4v9mi52eqGaMBxperNhAYuHdfcwsKI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NVGehG62SsigyLbp4m2/jaaY12WpGLFt0Dc+Q7tnJfHCbWmK8yVbXpFeyUUDFvQya
	 H8KtuDzsxI+ahBaroOSZQ4uYND6dV+6eTpe2iyoftQQwLgsxHXUSXX0qwe0bWehazl
	 aiUY4oOYQ0q28vsLfELJWUtdFGeMdmN/CBOnErqwtUY+a2EvLFklCReZrNYKx96u24
	 0ZNVRvZEPD4dNkKx3pEstyBZP1SBoyonoYwVmRxMe/zKZr5RbPBFAVx1w4SxxJ80a6
	 QCaNOOGZvCAhZSN+nrsEJbCJk+ye3ueJvQ5/blv7frkxXqhrHa1KsOO/BC7VJLr4Aq
	 6l+8OSE1SD0JQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59561CE3A08; Tue,  6 Oct 2026 11:34:32 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:34:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/14] rcu-tasks-trace: Let TASKS_TRACE_RCU_NO_MB
 default on without RCU_EXPERT
Message-ID: <c8b467cc-a916-48c7-b969-9b35dd04724c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
 <20260929-b4-rcu-tasks-preempt-qs-v6-1-c111ee02caca@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-1-c111ee02caca@toxicpanda.com>

On Tue, Sep 29, 2026 at 05:07:18PM +0000, Josef Bacik wrote:
> TASKS_TRACE_RCU_NO_MB defaults to ARCH_WANTS_NO_INSTR, on the grounds
> (see 1a72f4bb6f3e) that architectures with noinstr entry code only ever
> run tracing where RCU is watching and so can dispense with the read-side
> smp_mb() in rcu_read_lock_trace() and friends.  But the option also
> depends on RCU_EXPERT, and a Kconfig default is not applied to a symbol
> whose dependencies are unmet, so on an ordinary RCU_EXPERT=n build of
> such an architecture the option is simply absent and every Tasks Trace
> reader pays for two full barriers that the architecture does not need.
> 
> Keep the prompt behind RCU_EXPERT, so that overriding the default in
> either direction remains an expert decision, but let the default itself
> apply unconditionally.  On x86-64 and arm64 defconfig this turns the
> barriers off, as intended; architectures without ARCH_WANTS_NO_INSTR
> are unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 332df7a7a634..e3cfe1fe5592 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -142,8 +142,8 @@ config TASKS_TRACE_RCU
>  	default n
>  
>  config TASKS_TRACE_RCU_NO_MB
> -	bool "Override RCU Tasks Trace inclusion of read-side memory barriers"
> -	depends on RCU_EXPERT && TASKS_TRACE_RCU
> +	bool "Override RCU Tasks Trace inclusion of read-side memory barriers" if RCU_EXPERT
> +	depends on TASKS_TRACE_RCU
>  	default ARCH_WANTS_NO_INSTR
>  	help
>  	  This option prevents the use of read-side memory barriers in
> 
> -- 
> 2.55.0
> 
