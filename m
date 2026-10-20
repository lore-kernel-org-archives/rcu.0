Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470847;
	b=t1PwRVFG40IwdmWtgUc2U9tTNMbXkghK8TvXHZrmiivKINrXMQ/bvfnbTOUKKX5EMqt5
	 eMpX9mRDAvjQz9Jh2YS/nZimVIGv8hzouoVxapu0vVdFanV7r91bld8MfAzSeQIY6ZSqB
	 Tq0vkPggvaVRirz7mJZCj79RrsKhOV+sXvBCKZZJeM+ywmWItVG3GK6lWmbIaF9Nha4Q9
	 403MZxgxOQ7WAwwzw58mqnkU7/DmwH4rnIZU3jJEjnYoxVLe4klUL541ar+dzuHBKNSFD
	 qxtmR/f02KmAt5Wwl3Uvd+PNz/0fyLi1GtowkWopBW+U+nMfv1DdTfdkilF+lALc66A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470847;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KU43JrB4sHceuJ7hxjxKyQGNGizWRpkp5MD2RPNgxy8=;
	b=v68L/EoT6Ul7MbRpB95+e5NEKGAa5RjkgV0isbUJjvdYutm+xZnYYoeCa2DY+bIljt+b
	 CRjBTuqAf3ssN0Fj9lfY3Ge6TVJip8y+8LCd4PGIY+AR/cDQlpxhI4Vp98f5iGj02j9QO
	 rTJoobq8dmJbCdDYX3KC4YiRSY9UxAWeOEDsvv6IuuLR6JWC4wRca5K5PHlLE6haB1QEj
	 qWBcQYUq7oxVX2fxk75sWURii+sQPfrBzw5bwhAe2sd6olALMF4KRckuT02cPXaE4bkeN
	 zQav3cQCx9jg2I3v2E3aRD6i0VKt551muvg81B7MVt8P3gjIEACZm8GS39ZAE46h/dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjknbsX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE1606A31B;
	Tue, 20 Oct 2026 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjknbsX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190A81F000C4;
	Tue, 20 Oct 2026 04:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792470846;
	bh=KU43JrB4sHceuJ7hxjxKyQGNGizWRpkp5MD2RPNgxy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HjknbsX7WUs2730NjTF+FkASFb1HE5scMTjwlwS3xpu2GtR2hFTEkP6zipg+HVIK7
	 SvfJtz1MY4/gcVtXAR3fkhyYZZFP+Xj1nsDmjzT70hMjQj8/OgxzyO+jqvzxiUFl1W
	 ehS7BQDgjPRnwDd5yzuHdEQZYF3p2UUZXny5RH+citp0KT1tA8saHIzRDTyzeIn72t
	 VWkxtIjto6eyJqxeGCHVm4RZOY5gvllvpg41ng53x/YQ7tFUO8JXDOOZUP+N6ia6xu
	 7o1phBOZeO13HkXtc/knb5RVuZBCt4Go8Ik/eDjeYGPkqLNY53vooeTSkqhI1SXiSK
	 10JxyLONb98dw==
Date: Mon, 19 Oct 2026 21:34:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, eranian@google.com, ddhariwal@google.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH v4 1/7] perf lock contention: Filter events before
 creating lock_stat
Message-ID: <atbvPNZcoxUtRxez@z2>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-2-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019220915.3943592-2-irogers@google.com>

On Mon, Oct 19, 2026 at 03:09:09PM -0700, Ian Rogers wrote:
> In report_lock_contention_begin_event(), lock_stat_findnew() was
> called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
> and match_callstack_filter() (-S).
> 
> When a filtered-out lock event (such as a mutex contention when
> running with -Y spinlock) shared the same aggregation key as a
> subsequent matching event (for example, contention on the mutex's
> internal wait_lock spinlock from the same caller), the first event
> created the lock_stat entry with the filtered-out lock's flags and the
> second event reused that entry, causing non-spinlock entries to appear
> in -Y spinlock output.
> 
> Check the type, address, and callstack filters before looking up or
> creating the lock_stat entry.
> 
> Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-lock.c | 61 +++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index d5c0d55cb82d..778923c92f42 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -975,6 +975,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
>  	struct machine *machine = &session->machines.host;
>  	struct map *kmap;
>  	struct symbol *sym;
> +	u64 *callstack = NULL;
>  
>  	ret = get_key_by_aggr_mode(&key, addr, sample);
>  	if (ret < 0)
> @@ -1010,33 +1011,6 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
>  		}
>  	}
>  
> -	ls = lock_stat_find(key);
> -	if (!ls) {
> -		char buf[128];
> -		const char *name = "";
> -
> -		switch (aggr_mode) {
> -		case LOCK_AGGR_ADDR:
> -			sym = machine__find_kernel_symbol(machine, key, &kmap);
> -			if (sym)
> -				name = sym->name;
> -			break;
> -		case LOCK_AGGR_CALLER:
> -			name = buf;
> -			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
> -				name = "Unknown";
> -			break;
> -		case LOCK_AGGR_CGROUP:
> -		case LOCK_AGGR_TASK:
> -		default:
> -			break;
> -		}
> -
> -		ls = lock_stat_findnew(key, name, flags);
> -		if (!ls)
> -			return -ENOMEM;
> -	}
> -
>  	if (filters.nr_types) {
>  		bool found = false;
>  
> @@ -1066,7 +1040,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
>  	}
>  
>  	if (needs_callstack()) {
> -		u64 *callstack = get_callstack(sample, max_stack_depth);
> +		callstack = get_callstack(sample, max_stack_depth);
>  		if (callstack == NULL)
>  			return 0;
>  
> @@ -1074,7 +1048,38 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
>  			free(callstack);
>  			return 0;
>  		}
> +	}
> +
> +	ls = lock_stat_find(key);
> +	if (!ls) {
> +		char buf[128];
> +		const char *name = "";
> +
> +		switch (aggr_mode) {
> +		case LOCK_AGGR_ADDR:
> +			sym = machine__find_kernel_symbol(machine, key, &kmap);
> +			if (sym)
> +				name = sym->name;
> +			break;
> +		case LOCK_AGGR_CALLER:
> +			name = buf;
> +			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
> +				name = "Unknown";
> +			break;
> +		case LOCK_AGGR_CGROUP:
> +		case LOCK_AGGR_TASK:
> +		default:
> +			break;
> +		}
> +
> +		ls = lock_stat_findnew(key, name, flags);
> +		if (!ls) {
> +			free(callstack);
> +			return -ENOMEM;
> +		}
> +	}
>  
> +	if (callstack) {
>  		if (ls->callstack == NULL)
>  			ls->callstack = callstack;
>  		else
> -- 
> 2.56.0.212.g129ede20d9-goog
> 
