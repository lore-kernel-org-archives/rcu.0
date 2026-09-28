Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB0366575;
	Mon, 28 Sep 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611812; cv=none; b=iY5o0Kc0Y2psCyw0iKNh9MTdMxuLosRvt1noSR+ansWr9k0cdCFJPPY46SYx4d0jzBGBd5Z/jvmZDcro6Aroakb26a5HrApqqY7uE7axKAc2iVET5+MIjnFrVecDhp2+/cKrOiTXJ1yK7+QIzGqyjssSsSmExwZmGCDsQ3asvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611812; c=relaxed/simple;
	bh=olNMz5YZQDlY1bi55VVy7KXyye4u3+GKfiXGVCkelC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGrr92k4o8GgOJKnoBdKB08OKn7sCRNqH4vL93jHxMTg158nlKixG+DpI92OgVPmb8n89XzQH1sDU01gptkCEINACalC0+hcx3MZafvFDIoh5xL7BckcQ5Diafckowz0NIz4IKlUmI5U4gRruHNzFtDSHEDXegoqIsRrYi4XkN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICso0gr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICso0gr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285321F000FF;
	Mon, 28 Sep 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790611811;
	bh=39jJMoh2t7NHIz08n8lMVjXlTS/HZlmaisj6W0jHknw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ICso0gr+BVEr54WZEqW/7K+E5OkfbRgp4i22aHPIoyftRw+URJb5lWscZabIsH5CV
	 tGxNVK9LgA+MWq/ZH6A0hxaeB2572AP2uVCBNNsNkUCml+TWwaxZHMHK8PYO7kK3P8
	 d7n8gEw14cCge6LrkPZ5KDuVN5XRhfRGFHeEqpgbIp/5WEIolBflftwFX9FJ0ePtW1
	 DRVgNCCQqWmFKtomDH8BfuEJmOrsph/Xposbt0K3Ld7gudxlKJk8RVY9APOrSDZvNz
	 1Z3awJdITNWJ/xFKkSUgp4ElCIbYfFtGyAaY7PJm/XWtpUbseoV+rYxw6NokTcNU/D
	 mmYFJ1tYkmrJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7551CE0832; Mon, 28 Sep 2026 09:10:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 09:10:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Message-ID: <1c2a58be-0c8d-45b1-a803-85480e976e11@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
 <179055575973.241711.6618845269004184577.stgit@devnote2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179055575973.241711.6618845269004184577.stgit@devnote2>

On Mon, Sep 28, 2026 at 09:35:59AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In fprobe_return(), the shadow-stack iteration and exit_handler
> invocations were protected by preempt_disable_notrace().
> However, unregister_fprobe() and unregister_fprobe_async() (used
> by BPF kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
> and call_rcu()) to wait until the fprobe is no longer in use before
> freeing it.
> 
> In preemptible kernels (CONFIG_PREEMPT_RCU=y), standard RCU grace
> periods do not wait for pure preempt_disable_notrace() critical
> sections. Consequently, an unregistered fprobe may be freed while
> a concurrent CPU executing fprobe_return() is still running
> fp->exit_handler(), causing a use-after-free.

Actually, standard RCU grace periods wait for preemption-disabled regions
of code regardless of kernel configuration.  So if the original code
below was broken, that indicates a bug in RCU.

So do you have a reproducer for this?

							Thanx, Paul

> To resolve this, protect fprobe_return() with guard(rcu)() matching
> fprobe_fgraph_entry(). This ensures both synchronous unregister_fprobe()
> and asynchronous unregister_fprobe_async() safely wait for in-flight
> exit_handlers to complete via standard RCU grace periods.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
> Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace period")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9f2d98181779..c3e1580bc648 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -671,7 +671,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  	size_words = SIZE_IN_LONG(size);
>  	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
>  
> -	preempt_disable_notrace();
> +	guard(rcu)();
>  
>  	curr = 0;
>  	while (size_words > curr) {
> @@ -687,7 +687,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  		}
>  		curr += size;
>  	}
> -	preempt_enable_notrace();
>  }
>  NOKPROBE_SYMBOL(fprobe_return);
>  
> 
