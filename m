Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706786;
	b=yKyySUJCazdXMN9vN46ygTr+otk0hkPkofeg3Hf87t8FDqAOoIap9GTrNNbEiPU8YHAh
	 tTPA4dpVx0+F329Kz1Zlv5E8tqWdhlzFaaqaqzwa464rob5NCPTeb5KgbBOL/3IRwW4uF
	 yLnw14mE/hmgkelH2tQH1ISAAfCBufWFf+dUB9gE0l59iYWw6Wq46IDw0/Ms/nbUC7T7Q
	 WF8jgrE65wohrxVa1zd/2q+84bngSOufk8dkeLJmMAb/Rdr6jISQeJlzaXunxCC+1ZM/t
	 Tp8QFKC04lKoCoxTJ2Oil/rkQv4ICcIK1Na3H7IPK4LOP0bmld2JC2Hp05zGfp9moNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DuuEmolNIksJIaXwKMZXcCzc6YzS5L3u1RtkIZidfjg=;
	b=xb17xJ9jh+Kw2nw6h8Q8IQPShDAeiZuvsAoqosxNoB6bXAFxU4guesu2KzVQI6jvAOmj
	 0MGcbPYPRw6IK5f6f/KwAcNrW5Y+vm3CXqaZUT09W2xC/ttYf7LjGfwdtlh3OcwWkC3bJ
	 d+W1J+lD2bEQWyNlLigkSbKolq5GZicKVB3Orrl1Xvdc1jBzrd8hAMb6Ag7UmGUyuNNxq
	 xTHRutAqRCe0J089xJYsHeLEJ9qCjFKH8cfQJVLmW6w394wmfIcr3rQBd0KgyCIK8M8dD
	 E7xiZNjv6L8Zuc5hNCtV6a6/lFpQhPnFrxfu31eoo2MZAZYOhXXS9aY7liKE48aVDeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSCaVuYh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC0606A31A;
	Thu, 22 Oct 2026 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSCaVuYh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371E1F01825;
	Thu, 22 Oct 2026 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706785;
	bh=DuuEmolNIksJIaXwKMZXcCzc6YzS5L3u1RtkIZidfjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSCaVuYhb5G3HhTuHZG9YiYabRoSvqsleuUdAjreI+OqeGysMUq2+DUuaeVcTuhz8
	 XdEuUV+5F+KF2WvcsPccXm7mXaB6TZY4Is+aDqlLIqivBuv9JuMdcQ8oo9GBmvmcAv
	 m9qiYckjAIqbHWD6v/E4GihMusqU8nkDJpZG2Vw4lkAddGlpZt5eZL1EBp71kMAiIv
	 gAgvtgPZKWKCF9GDjX2MmITYm4az/Asux3034lsnyDtkBCqfuzu7gNvjTUkfJNizkd
	 d/WPdUIYsuvQAE8WZvxIkxhm8RRXx/nzRnZVbI4sWgNxyX7fNac2q2cFWT0s2VjRda
	 uoa38yyQF8MtQ==
Date: Thu, 22 Oct 2026 15:06:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com,
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 01/11] perf bpf-filter: Fix bpf_link leak by using
 PERF_EVENT_IOC_SET_BPF
Message-ID: <atqI3_hai_P5d80q@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-2-irogers@google.com>
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
In-Reply-To: <20261022203003.1779152-2-irogers@google.com>

On Thu, Oct 22, 2026 at 01:29:53PM -0700, Ian Rogers wrote:
> In perf_bpf_filter__prepare(), the unpinned filter path attaches
> skel->progs.perf_sample_filter to each FD(evsel, x, y) using
> bpf_program__attach_perf_event_opts() and ignores the returned
> struct bpf_link *, leaking the allocated struct bpf_link_perf and its
> BPF_PERF_EVENT link fd.
> 
> Furthermore, bpf_program__attach_perf_event_opts() is designed for
> callers that transfer ownership of the perf_event fd to the returned
> bpf_link: when bpf_link__destroy() is called, bpf_link_perf_detach()
> unconditionally disables and closes perf_link->perf_event_fd. Because
> evsel->core.fd owns FD(evsel, x, y) and closes them in evlist__close(),
> destroying the returned bpf_link would double-close the perf_event file
> descriptors.
> 
> Fix this by attaching the program directly with
> ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd), matching the pinned
> filter path right above it in perf_bpf_filter__prepare(). In the
> kernel, PERF_EVENT_IOC_SET_BPF takes a reference on the BPF program and
> _free_event() -> perf_event_free_bpf_prog() automatically detaches and
> releases it when the perf_event fd is closed. This also avoids enabling
> the event prematurely, allowing pe_opts (.dont_enable = true) and the
> LIBBPF_CURRENT_VERSION_GEQ(1, 7) guard to be dropped.
> 
> Before (built with EXTRA_CFLAGS="-fsanitize=address"):
>   # perf record -e cycles --filter 'period > 1000' -- true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.024 MB perf.data ]
> 
>   =================================================================
>   ==51328==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 1568 byte(s) in 28 object(s) allocated from:
>       #0 0x7ffbe76ef24f in calloc (/lib64/libasan.so.8+0xef24f)
>       #1 0x625df7 in bpf_program__attach_perf_event_opts (tools/perf/perf+0x625df7)
>       #2 0xbeddc0 in perf_bpf_filter__prepare util/bpf-filter.c:507
>       #3 0x8f3def in evlist__apply_filters util/evlist.c:1421
>       #4 0x44bbcf in record__open tools/perf/builtin-record.c:1469
>       #5 0x453f9e in __cmd_record tools/perf/builtin-record.c:2594
>       #6 0x45dadb in cmd_record tools/perf/builtin-record.c:4427
>       #7 0x5df56b in run_builtin tools/perf/perf.c:383
>       #8 0x5dfa0e in handle_internal_command tools/perf/perf.c:436
>       #9 0x5dfddc in run_argv tools/perf/perf.c:480
>       #10 0x5e0333 in main tools/perf/perf.c:581
> 
>   SUMMARY: AddressSanitizer: 1568 byte(s) leaked in 28 allocation(s).
> 
> After (built with EXTRA_CFLAGS="-fsanitize=address"):
>   # perf record -e cycles --filter 'period > 1000' -- true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.024 MB perf.data ]
> 
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20261020053226.55936-1-namhyung@kernel.org/
> Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf-filter.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 72e83ac1d6a4..506414e5c407 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -40,6 +40,7 @@
>   * The 'dropped' map is to keep how many samples it dropped by the filter and
>   * it will be reported as lost samples.
>   */
> +#include <errno.h>
>  #include <stdlib.h>
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
> @@ -423,16 +424,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  {
>  	int i, x, y, fd, ret;
>  	struct sample_filter_bpf *skel = NULL;
> -	struct bpf_program *prog;
> -	struct bpf_link *link;
>  	struct perf_bpf_filter_entry *entry;
>  	bool needs_idx_hash = !target__has_cpu(target);
> -#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
> -	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
> -			    .dont_enable = true);
> -#else
> -	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> -#endif
>  
>  	entry = calloc(MAX_FILTERS, sizeof(*entry));
>  	if (entry == NULL)
> @@ -501,14 +494,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  		goto err;
>  	}
>  
> -	prog = skel->progs.perf_sample_filter;
> +	fd = bpf_program__fd(skel->progs.perf_sample_filter);
>  	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
>  		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
> -			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
> -								   &pe_opts);
> -			if (IS_ERR(link)) {
> +			ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
> +			if (ret < 0) {
> +				ret = -errno;
>  				pr_err("Failed to attach perf sample-filter program\n");
> -				ret = PTR_ERR(link);
>  				goto err;
>  			}
>  		}
> -- 
> 2.56.0.307.g5fe7bd680c-goog
> 
