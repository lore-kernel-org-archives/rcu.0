Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F43230270;
	Wed, 23 Jul 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304091; cv=none; b=Ql9Cmnl4urxbNF+mtLhkjXmhXGzJNIOs9gAdK79NiiBKnaHlpHOLUcIpa6KhRzJTNgDOBmR0zK6C4DoI9Elazo4qr2TdfHSljiE2e3gBKfFwq36SNfirJI2R0Rrq7rkIzmgIPwDs0f5nN/IKYpa40fNRbYYkMPdMBMRzvZImW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304091; c=relaxed/simple;
	bh=dPa79KWYct9kVmKfofQQgfo0Z29u9ItYnNZhchD9kc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWnT/kQq93a56tQCVwDH7jU3mDd8OJpnSHgox7iO/cI0OieKaes9oQ2QvtzsCkvUP+DT+YQAnm8cTXyvbWjpIxUHJRYn0nF1q6za7bJ8CFnhrM3taQecO/VEapEbGsGtMNUd2rVeSscsw8ir6HX2jjZqBNxGV0fwdRJ3fgmaSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzJROxQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzJROxQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40ABC4CEE7;
	Wed, 23 Jul 2025 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753304090;
	bh=dPa79KWYct9kVmKfofQQgfo0Z29u9ItYnNZhchD9kc0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CzJROxQ3PhXI79L4yE/NSSWtkTV8a/o/aq05MulcJg4gUXmFN4cKx1TBsesDZsihZ
	 T4eZs+tPViiTHvJaljW6WCI/Pc22fFdNoH51VAB1RyMmCzfJWsIyuhIRkYKfw6tb/H
	 xnA53heMkQFviIbDrP63oSkBahCUHLlIAdu68MBDkmWskZtnxoN5XcsVvq0qp6bK7I
	 Y6otzDzdtSm09hcy1Wun3T+jVcgoT6lIynh9Nw9JGlKo/CJNiIe70RZ1CNl6GZlImE
	 P7LjmJoFCZEaOTAitU2+W/3tzH3P9h1QH2fbF/+HI4agM83HlpUa9HrezwFHj+uLAC
	 TP1R95KLNaGEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48685CE08DF; Wed, 23 Jul 2025 13:54:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:54:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/6] Switch __DECLARE_TRACE() to new notrace variant of
 SRCU-fast
Message-ID: <f3d100b4-d849-4fd5-a9ef-8fb0cc78a884@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
 <20250723163450.02bc299b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723163450.02bc299b@gandalf.local.home>

On Wed, Jul 23, 2025 at 04:34:50PM -0400, Steven Rostedt wrote:
> On Wed, 23 Jul 2025 13:27:54 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This triggers continues to trigger a kernel test robot report of a
> > "using smp_processor_id() in preemptible" splat.  I looked for issues
> > with explicit preemption disabling, and, not finding any, will next turn
> > my attention to accesses to per-CPU variables.  Any and all insights
> > are welcome.
> 
> Currently perf and ftrace expect the tracepoints to be called with
> preemption disabled. You may need this:
> 
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index a1754b73a8f5..1b7925a85966 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -71,7 +71,9 @@ perf_trace_##call(void *__data, proto)					\
>  	u64 __count __attribute__((unused));				\
>  	struct task_struct *__task __attribute__((unused));		\
>  									\
> +	preempt_disable_notrace();					\
>  	do_perf_trace_##call(__data, args);				\
> +	preempt_enable_notrace();					\
>  }
>  
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 4f22136fd465..0504a423ca25 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -436,7 +436,9 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
>  static notrace void							\
>  trace_event_raw_event_##call(void *__data, proto)			\
>  {									\
> +	preempt_disable_notrace();					\
>  	do_trace_event_raw_event_##call(__data, args);			\
> +	preempt_enable_notrace();					\
>  }
>  
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> 
> 
> But please add it with the change, as there's "preempt_count" accounting to
> report to the user that accounts that preemption was disabled when called.

Thank you, Steve!  I suspect that it would have taken me one good long
time to find that one, like maybe forever.  ;-)

I am doing local testing, then will expose it to the kernel test robot,
and if all goes well, fold it in with attribution.

							Thanx, Paul
