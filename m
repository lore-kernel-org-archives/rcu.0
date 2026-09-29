Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171082AEEB;
	Tue, 29 Sep 2026 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640826; cv=none; b=sYIH32M159thkv+I4fVLJDQl8xnpN9GJKzEuKIqiOU530GCnBjR3hxb61FtMVVLxoCg8glFDLOKtgUiFOnJXfrfThZ2ngtIxPBm8nJcJkB2X14U5urIvMdpkl8GDwAT/pNkz1/01hT744gTogM53ZmY1YEvIo2pbsJgi29/8yhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640826; c=relaxed/simple;
	bh=q6Amrpzcs+pPIKhuhzv79d5INvSYcKLlmlQbb0pLAD8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GjcM8rTzd01Czsbr1KHAiV9vaRIQdAN8J+Lajt42DO6Xcu2MWU7CG6u8OxlY9vXy20laNm9WGAGshoPO23PTVi/hCsl0Cro1JKoLz5djamA9/61e4EXMLY/SOyd6cSzJPuk+8s00mjc3OHAUXFyQm86KX87gPEqIpn8Vt4pPonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk+aPYHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk+aPYHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2EB1F000FF;
	Tue, 29 Sep 2026 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640824;
	bh=j49xaGsGy2twAzmXe3ZozmMuRWN3oLxvd9EP8vDBGA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nk+aPYHop+a6FGy1wV3/K58Fm+b99ZG3F/S0E+UzbloqNAyiFCYqrOo5/XwXh8BUi
	 oj+bqkzw9nWN4KyAnGpSYrdrjV+DEr/duj9Xx8/hsQJUgPERovRo+EkCTsh33dJ6su
	 3x1Vi3CPMnV0tYjuCE9KBor0MxlJBZdRIgoj6SyPi2hEOQeZ/dAElYCXzN8yvsDebK
	 wFJASH6xn2eF0F5xW9LhoZYCe2GkYEfFtlJ8Ul2n/nzjNB+LwnWGWuVJujvifoyTq3
	 WVr7eqZidrLN1n1uEe1ltKD6/l2hofJw8oZI3qv4cy80i14H7c+8wgkzD81RLqUC8i
	 B27RPfzUiXrIg==
Date: Tue, 29 Sep 2026 09:13:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josef Bacik
 <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Message-Id: <20260929091340.2a3832ebd5089cb30dfb83f0@kernel.org>
In-Reply-To: <1c2a58be-0c8d-45b1-a803-85480e976e11@paulmck-laptop>
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
	<179055575973.241711.6618845269004184577.stgit@devnote2>
	<1c2a58be-0c8d-45b1-a803-85480e976e11@paulmck-laptop>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 09:10:10 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Sep 28, 2026 at 09:35:59AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In fprobe_return(), the shadow-stack iteration and exit_handler
> > invocations were protected by preempt_disable_notrace().
> > However, unregister_fprobe() and unregister_fprobe_async() (used
> > by BPF kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
> > and call_rcu()) to wait until the fprobe is no longer in use before
> > freeing it.
> > 
> > In preemptible kernels (CONFIG_PREEMPT_RCU=y), standard RCU grace
> > periods do not wait for pure preempt_disable_notrace() critical
> > sections. Consequently, an unregistered fprobe may be freed while
> > a concurrent CPU executing fprobe_return() is still running
> > fp->exit_handler(), causing a use-after-free.
> 
> Actually, standard RCU grace periods wait for preemption-disabled regions
> of code regardless of kernel configuration.  So if the original code
> below was broken, that indicates a bug in RCU.

Thanks for pointing, this was my mistake. Sorry about that.
And I still think we need a fix to add rcu_is_watching() check.

Thank you,

> 
> So do you have a reproducer for this?
> 
> 							Thanx, Paul
> 
> > To resolve this, protect fprobe_return() with guard(rcu)() matching
> > fprobe_fgraph_entry(). This ensures both synchronous unregister_fprobe()
> > and asynchronous unregister_fprobe_async() safely wait for in-flight
> > exit_handlers to complete via standard RCU grace periods.
> > 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
> > Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace period")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 9f2d98181779..c3e1580bc648 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -671,7 +671,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
> >  	size_words = SIZE_IN_LONG(size);
> >  	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
> >  
> > -	preempt_disable_notrace();
> > +	guard(rcu)();
> >  
> >  	curr = 0;
> >  	while (size_words > curr) {
> > @@ -687,7 +687,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
> >  		}
> >  		curr += size;
> >  	}
> > -	preempt_enable_notrace();
> >  }
> >  NOKPROBE_SYMBOL(fprobe_return);
> >  
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
