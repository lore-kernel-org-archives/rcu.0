Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96753ACA65;
	Mon,  6 Jul 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359401; cv=none; b=cCMqvRFAfaP2IYf9pZrFkhNJgHnvms22Ha+Lev4dpF8QHdkTqfPUJLdA2eLdtltCxXh5XISuQlAh2TWn6SxnU9BPBdIfVC/U0lzZflV/ntJVPOpflaj2eoeuQXF713GkExfbd/g7XvQDsfLWycSj4UoFzQwhA34x9ou983Yboqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359401; c=relaxed/simple;
	bh=ti/TCm1z6PBJR8yRQ3m3yQyVD1D6NvxRQXjN6C7kvHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7QHlqPLHrT80yF5jN8jmiClzbBmP0v+kRXdHPD/Wya7kx7DBDeMQIMAiOAHJ3pbXTIsw3uPpSWB9sOX2o2wrNqlgLyPwLr326dabns23HuVWRJn8tFEfsUTCdpsYqAIRYKZcNzQC7rRHMbU3P0lCt5bvU0iCTQrNuy606KMo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOvIvJ33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOvIvJ33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8663E1F000E9;
	Mon,  6 Jul 2026 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359400;
	bh=SJAL2kQaBCSoToztC9FBWr2yuBhtAQr6v0dewB6ngTs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NOvIvJ33f7MRiSQZOiy7PjGGic8Czp9J4gbptjsxqbfxtNYz3fsgilf1LHSkA5ks2
	 NrPzGGqOO6wvLGmFhhjR9ZW5UhjsAveGMy9K1SU+GHMbpU0VuOSyfXIsr/7BvAGbuq
	 ecPP9rOAKEh+zIF1YFk4+v7FTXzan4x9QcDJho9RMpwZgodqH9EsOOX/yfwF8xWPK+
	 6GSx/g/uYtFhvmQyZQYxQfDpmuxqI867dUCIdAhVFTjuFE8c2jPGegd9nrf2a5fOWw
	 6oy+F+VzdNSTnRpPkp2Z/joCxx0Gi5Ye0cpnqfnVGRxXGUlpYgCQAzQF9lsvWWPzGH
	 2AhFBHvuHX54g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48E49CE0774; Mon,  6 Jul 2026 10:36:40 -0700 (PDT)
Date: Mon, 6 Jul 2026 10:36:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] srcu: Add lock guard for srcu_fast_updown
 flavor
Message-ID: <b36e0790-15e8-4ca9-80f5-94119a3b7a3b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260706172744.3920417-1-puranjay@kernel.org>
 <20260706172744.3920417-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706172744.3920417-2-puranjay@kernel.org>

On Mon, Jul 06, 2026 at 10:27:41AM -0700, Puranjay Mohan wrote:
> Add a guard(srcu_fast_updown) definition for scoped
> SRCU-fast-updown read-side critical sections, following the
> existing pattern of guard(srcu) and guard(srcu_fast).
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

(Or I can take it if you would prefer, but it might be easier and faster
for you to send it along with the next patch.)

> ---
>  include/linux/srcu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index a54ce9e808b92..72c86d3b23f2e 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -638,4 +638,11 @@ DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
>  DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
>  #define class_srcu_fast_notrace_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, _T)
>  
> +DEFINE_LOCK_GUARD_1(srcu_fast_updown, struct srcu_struct,
> +		    _T->scp = srcu_read_lock_fast_updown(_T->lock),
> +		    srcu_read_unlock_fast_updown(_T->lock, _T->scp),
> +		    struct srcu_ctr __percpu *scp)
> +DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_updown, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
> +#define class_srcu_fast_updown_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_updown, _T)
> +
>  #endif
> -- 
> 2.53.0-Meta
> 
