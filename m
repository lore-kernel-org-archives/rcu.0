Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535358;
	b=xgz3MtNVoQiBmkeSIRb/AiAMjQ8qoczHg60XZJG9236kc72gg1NTeHwf6AgMxwcNoNqp
	 5NlHad24BrisEtv3PacIS1oSn7qBxefLjwp0oqyBOYAF0lmpjS+P3t45ckIwe2ewmjkQz
	 limAWyctlJlUgHM4QdWtUgZtAxmCSEA7Ki2G1ZMtjuW5hUFNUYZqmSxUV3p46+1JstZD5
	 Zqwn+/NoJWfnKAUSynW/tkU7xmTFReqjms6PrxBhND+VuBFmlxZK+I2NpSGuKGtUS13oP
	 ELJgG789ETeor68dkwBoH4XpMw+PHcBgR2Gmdv+TS5/SB0sQrsC20m9gO0wQGSOKw7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535358;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=d1UCMcaF/RdYW+qLX7aDFkPu2b7n4KE2fpdqcmChgsw=;
	b=XIuqOVcBTmmCab/EOta4fFES99MYuN0PW0Kpv4Qxaw0nGYab/6G6kPxwvK42j5UNW16m
	 3hnZikauKsp3SaXlMVvsqrvITcHtfLR3a85VEWIxPD+tG5zhi1tOh97lzLXYANKriq5wz
	 +R8vEfro/+5IAL6oUNCBdefEutQlHZ25tw9YisdHU8kA1pB6Zw6RHG1T2R7lKwsfX6qM7
	 OqWBTPpq/7jd/SFzfuxK7jtAD8GYSjtfY6Kq/tXdmaodcZ3dhuxzJp1oBEHadUgmCLruS
	 fAIuE8p+yHC9pJcCmFAKH8HVZVzSP86aMpP/TpFlzS4WDednkXzFmXwXtSyFxB+2Bhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3ImwVYv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39807606A31A;
	Tue, 20 Oct 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3ImwVYv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D61F000C9;
	Tue, 20 Oct 2026 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535357;
	bh=d1UCMcaF/RdYW+qLX7aDFkPu2b7n4KE2fpdqcmChgsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H3ImwVYvtWzBMbclGX6YYXrI4FOexOUSmsRTV42pAX8JKPSTCB/0h3oSJFyAwy9yt
	 dvUxiypk1Bi27D46HHznbhylD4Xrr50i+hIcujEA+y4ASZ0ixM14C5zwy+AhbmjG0x
	 HGlTawJyaEFLS7PiRr4+BNwtDW3Ib28Gu4RmARiOcQqb9AZamX+NI2npvi2MHGUNX9
	 pcoeLiBmY+xe771+ufaWbtOAkt2zgVptHhyBxQnNL7kYmHqk64IE+nSyX6V7S4rRsX
	 fpqgYwsSzqX0i4mOMr9zjkRwAxbmbXRiwko+mRzk+W2UKdZH3Lpa28OGqgF3NNBjB3
	 Z6MSw9T8klMBw==
Date: Tue, 20 Oct 2026 15:29:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, eranian@google.com, ddhariwal@google.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH v4 2/7] perf bpf-filter: Support BPF sample filters on
 tracepoint events
Message-ID: <atfrPEPxU-dxv7Oj@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-3-irogers@google.com>
 <atb-9j8tLZ2rFtOm@z2>
 <CAP-5=fUbsiir_4K1rhpy=TxWpgGLzuR7-fvMiiQ9htTUM3ibng@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUbsiir_4K1rhpy=TxWpgGLzuR7-fvMiiQ9htTUM3ibng@mail.gmail.com>

On Tue, Oct 20, 2026 at 08:30:26AM -0700, Ian Rogers wrote:
> On Mon, Oct 19, 2026 at 10:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Oct 19, 2026 at 03:09:10PM -0700, Ian Rogers wrote:
> > > Commit 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
> > > updated set_filter() to route non-tracepoint filter terms (such as uid
> > > and gid) on PERF_TYPE_TRACEPOINT events to evsel->bpf_filters instead
> > > of the ftrace tracepoint predicate filter.
> > >
> > > However, in the kernel's __perf_event_set_bpf_prog()
> > > (kernel/events/core.c), attaching a BPF program to a perf_event fd
> > > branches on perf_event_is_tracing(event):
> > > - Non-tracing events (hardware PMU, software events, breakpoints) call
> > >   perf_event_set_bpf_handler(), which requires BPF_PROG_TYPE_PERF_EVENT
> > >   (SEC("perf_event")).
> > > - Tracepoint events (event->pmu == &perf_tracepoint) reject
> > >   BPF_PROG_TYPE_PERF_EVENT with -EINVAL and instead require
> > >   BPF_PROG_TYPE_TRACEPOINT (SEC("tracepoint")), which is attached to
> > >   event->tp_event->prog_array and executed in
> > >   perf_trace_run_bpf_submit() before perf_tp_event(), dropping the
> > >   sample if the BPF program returns 0. Furthermore, the
> > >   bpf_cast_to_kern_ctx() kfunc is only permitted in
> > >   BPF_PROG_TYPE_PERF_EVENT programs.
> > >
> > > Add SEC("tracepoint") int perf_tp_sample_filter(void *ctx) in
> > > sample_filter.bpf.c to evaluate context-independent filter terms (uid,
> > > gid, tid, cpu, time, cgroup) using BPF helpers without calling
> > > bpf_cast_to_kern_ctx(). When preparing a BPF filter on a
> > > PERF_TYPE_TRACEPOINT evsel, autoload perf_tp_sample_filter instead of
> > > perf_sample_filter and attach it once to the shared trace_event_call.
> > >
> > > Before:
> > >   # perf record -e kmem:mm_page_alloc --filter 'uid == 0' -- true
> > >   libbpf: prog 'perf_sample_filter': failed to attach to perf_event FD 3: Invalid argument
> > >   Failed to attach perf sample-filter program
> > >   failed to set filter "BPF" on event kmem:mm_page_alloc with 22 (Invalid argument)
> > >
> > > After:
> > >   # perf record -e kmem:mm_page_alloc --filter 'uid == 0' -- true
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.024 MB perf.data (42 samples) ]
> > >
> > > Fixes: 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
[SNIP]
> > > @@ -674,7 +761,7 @@ int perf_bpf_filter__pin(void)
> > >               goto err;
> > >       }
> > >
> > > -     ret = bpf_object__pin(skel->obj, path);
> > > +     ret = pin_filter_object(skel, path);
> >
> > Why is this change needed?
> 
> Before this patch, sample_filter.bpf.c only contained a single BPF
> program (perf_sample_filter), which was always loaded. This patch adds
> a second program (perf_tp_sample_filter) to the same skeleton (and
> patch 4 adds the lock-tracking programs to it as well), and uses
> bpf_program__set_autoload() before loading the skeleton so we can
> select only the program(s) needed for a given event.
> 
> In perf_bpf_filter__pin() and perf_bpf_filter__unpin() (for 'perf
> record --setup-filter pin|unpin'), only perf_sample_filter is used,
> because the pinned filter mechanism shares a single program across
> privileged sessions by looking up kctx->event->id via
> bpf_cast_to_kern_ctx(), which is only available to SEC("perf_event")
> programs. So autoload is disabled for perf_tp_sample_filter (and in
> patch 4, for the lock-tracking programs) when pinning and unpinning.
> 
> A consequence of disabling autoload on any program in the skeleton is
> that libbpf's bpf_object__pin() and bpf_object__unpin() fail:
>   - bpf_object__pin() calls bpf_object__pin_maps() and
> bpf_object__pin_programs().
>   - While bpf_object__pin_maps() skips maps that have autocreate
> disabled, bpf_object__pin_programs() and bpf_object__unpin_programs()
> iterate over every program in skel->obj without checking whether
> autoload was enabled.

Looks like it needs a fix in the libbpf.


>   - When bpf_program__pin() or bpf_program__unpin() is called on a
> program that wasn't loaded (prog->fd < 0), libbpf returns -EINVAL
> ("prog 'perf_tp_sample_filter': can't pin/unpin program that wasn't
> loaded").
> 
> pin_filter_object() and unpin_filter_object() avoid this by calling
> bpf_object__pin_maps() / bpf_object__unpin_maps() for the maps and
> explicitly pinning/unpinning only the loaded perf_sample_filter
> program.

Thanks for the explanation.  It'd be nice if we can have it in a comment.

Thanks,
Namhyung

