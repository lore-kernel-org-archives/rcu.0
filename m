Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618774;
	b=F1Ndw2Q7zJk2EPXmc5xLLm/5SgUsb1ZWL17ir1Gemgma8Y50JZtqp7Bq8SZFUXQZMDH5
	 9ydf9KkelQqWRcijDZEuUkglWqv/qboMj++CmPTJQjy9PgqUrqiFnMWkT62LXZJNhYPY9
	 a9tX5QBN1K/KSfAC9YPKgpx9qkV8Gya29LFxkul0JhyME9QDYNWZnfN8hcchX1ZJdEoly
	 2uKBoOuW5DHcg4mAHvuilDw9Xb5zGW8hjhIratP8ZE/R1iGi+7rryRKNFWpyExfPIC+x6
	 B3LJ1Cr5notnaz/WOEz9lkhFxFI/6vBTfkPPRKnuRU42QUc0IgyJFZy1ZCgxM6c3tnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FTrydkL7HtkLMgb49aJ3qzS//tJyj29uIWq7iqTrQWE=;
	b=hZJc5ipMQV7sLXqv6kPjEbA4PYXOpIKpenwwCIbLmuoEoCrheye3zF0GRqtCiyRclFwH
	 8wEVh1+MWsgx9iRlo1W2usDOnEHLXgZ0vYYP0erctlgH+FPrbr0ZUP2+4gglg6hJFDj1b
	 u9QxZTPwgfEM8JlhQ/HF+f6iddo1h4drZCnOc+m8nuACTLusMq5SMHw+SzjngMAn0DJhC
	 m+MYhqqyk6LiOgFVV/80UztZYpobYaj8ShMXCQ3fizTzTmAMAuZqAdlMX0ca/zlQzjPVV
	 7ro3kdSML2bW1gso1DP+7QJngKOi703JDN4L8LODf9LCnd43FLubGAa0N59dMBPMFqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVRNRsF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2642606A31A;
	Wed, 21 Oct 2026 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVRNRsF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559BA1F000C1;
	Wed, 21 Oct 2026 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618773;
	bh=FTrydkL7HtkLMgb49aJ3qzS//tJyj29uIWq7iqTrQWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVRNRsF2SyJOiX6MqSC27TY2uf42yZZ+NBCehQgjoI094CwIPepmPo6cLqdWWK4b/
	 0IQY2WDgLIjXE0fq5KZrUdWaZoiKL8K8r/KRcMxFIom5mWHeqh4BhW2hRWuuL40dFJ
	 OzHphNysGcBldV7jUIICF3PvViyvo9zjaP9AWjDQ0sQbXcbFEfr5HzcPV2ZAO6Onau
	 gGssXrAFYhjFf3m4V9hIVmJ7oBm8eziAvlDeXCaSuJE2kbsRFpa3fzCEpN+Sn/mPNK
	 VxNT5xTye1/9W++hyz2U0fYuL/BwuWt5j6FRUl9kP7ZwVMfe1PQNzF7a+x/6aHKiZv
	 3LCTo4bgMn8rg==
Date: Wed, 21 Oct 2026 18:39:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, eranian@google.com,
	ddhariwal@google.com, rcu@vger.kernel.org
Subject: Re: [PATCH v4 1/7] perf lock contention: Filter events before
 creating lock_stat
Message-ID: <atkxErgNUd-o9Cru@x2>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-2-irogers@google.com>
 <atbvPNZcoxUtRxez@z2>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atbvPNZcoxUtRxez@z2>

On Mon, Oct 19, 2026 at 09:34:04PM -0700, Namhyung Kim wrote:
> On Mon, Oct 19, 2026 at 03:09:09PM -0700, Ian Rogers wrote:
> > In report_lock_contention_begin_event(), lock_stat_findnew() was
> > called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
> > and match_callstack_filter() (-S).
> > 
> > When a filtered-out lock event (such as a mutex contention when
> > running with -Y spinlock) shared the same aggregation key as a
> > subsequent matching event (for example, contention on the mutex's
> > internal wait_lock spinlock from the same caller), the first event
> > created the lock_stat entry with the filtered-out lock's flags and the
> > second event reused that entry, causing non-spinlock entries to appear
> > in -Y spinlock output.
> > 
> > Check the type, address, and callstack filters before looking up or
> > creating the lock_stat entry.
> > 
> > Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Cherry picked this one as its the first in the series.

- Arnaldo
