Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792510242;
	b=qmjTUcE8skHtPLci1GjzAMOu+xr5RUocZD+38Pup1ZwVbhvWZ08hPUkYA9G8Vs5WCrYB
	 X/D5AwqbONCqyllBhbh0afS2uxvbos8jbZ0NOXi7ND96gFcH/CoybyVw/Jz5LcUDz0+6E
	 dpSqbjK1DMQwdVmHgnFveBY9ZfcJvr+Cgtqvpa2MpMQ2Zih0LwXeXQae6C4WGfi4hexCB
	 /BXzfiKyUduWMhSwYk6IRMW5Us3hQRLMAxqE4QzT8yFBV/bkDxiWrM/0DGdtuSJXL6Qb6
	 ImGdq/qaSykYp5h64IrHfM4kuXVZTdWoH92BURE64W4x5WMxDAfWbRo29aCmGUg3nmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CJ/2JjOfv7jKYX1UxnOtzLnNxCxfLnpcbv11NxnLJuM=;
	b=GC1Cz9AMjxsmnc01mZsDMxWXBGMTWv+gbXN7W5XqLYsztyKfe258kVnhm4JqMvdXG+Cv
	 +So9xeJJhel83uG4UNDuwWFj5r6B+FUSvfyScrG4TAkF+5AJZ7UAHX+y8AQ1p/eh3lJI6
	 NwI0JVpSscoIKBfgmEks03T3Al7OD3T4uwNRXa6JPOpiTVZwRVu3YyByzT9o9pChoGbb4
	 76u0blP0UZlVWJ1xY8COr/GQ4TV05Gv1dsqAusSmL0LJDmgwSkqXmtHRxR6HBlJnOR4sK
	 z5xo30TzfjXjIkuTtnmoKuXe1g4c+YitJp5biEUYLjGTccMBlq+hvWL65P16PVA8BuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HHjx68Bd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60860A2614
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 15:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A60860A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HHjx68Bd
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9f6a16afcso60245ad.1
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 08:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792510241; cv=none;
        d=google.com; s=arc-20260327;
        b=WhfuQi/yoLnqJmIKAfKMW0Qv9PP/6QJlksrsHeDQ10JjSsmdbm4GJGHJct0Yxhn6pE
         gyTFLZyoSw5FgVOVcWGlIKKbcQXQ4CPU9iZEPTkNJoSq1JpVXUygDzLMqOpUYJf1dQMH
         qqQDClRytZa5dsGPgmbBsDVyhqSICVENGnXtgeeKKdSD3A49rGtad9jKDoKhXjfBgYWZ
         DJkYDhGs8IE0qvVRr1cjLJ2TwfWRoXfj6cHHmfrXKEv3a8qsP+ge5izTcsDmBDilWnm9
         I15f5BEvUvmrv2sYl0JRjE2MreKe3dgmA6iB8uKp0UDpQhxmEDsNNATXFLB2dYou5FOt
         XKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CJ/2JjOfv7jKYX1UxnOtzLnNxCxfLnpcbv11NxnLJuM=;
        fh=ERhof4NRpGPX0O8JU8eeRUudfZ6EoX0ecITZqBjB1Yw=;
        b=L9gZAcXdYkrAcxKcdjVr1k2mzee6pw/UbwgSQriS2zRrUrGuaQDRAOtYRshXKkZr3y
         ntVZHnpzWeVmGStvP+ON1rDeikGo1BpF5ZKrZckHOXPG3sxKdfRI5AiVjaSrIgBswkrV
         FABnkThRRjq43AyuzNdVG4NWY21z6iJsvcP95BK5Yd+uTQBi53NWefnt2EyZVsCXmG0e
         vr1n34preZV2uMRqMbg0Yx4LleDXyoXu+URXe0pyypXWk32I6ErzDa8RHhmLp61YKIu/
         YvSIaU58kab/n1BkPZcoqua6FiW5nmfcohzwXgxnna3tBr8SftesvoILlPMifheBBhIj
         Nw8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792510241; x=1793115041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJ/2JjOfv7jKYX1UxnOtzLnNxCxfLnpcbv11NxnLJuM=;
        b=HHjx68BdSfsUKb2Ijmp4YWBQ7qCb4HitJ4/z8W1s63pnmzFffQ22nOclBVMvPyYCqa
         zlNfY1Men1BOjbZdq7SmDvpTGWSPC0LtSw12DtgmH3XUOrgjLdQ41WmJGS8Nqae36Okj
         V61h0EBbqsxsfQ0/6uV0JvGS2Hi7XbhnkUCTQl7vkXEDoIDi7tHH32xk2iOJ7gWc6ioU
         6+srm6N2ZguJZCy8hR0yHSKeRkpl5vN/pK96YvszDf49luFYXK+Aj5oopjFRbRih1L3k
         15rZw7PU4yikKQkRQm6P9Rie5EBUpzl/YPlZnTXqBPWedxx8Pcxs+oHjgsywBYGW95ME
         5b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510241; x=1793115041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJ/2JjOfv7jKYX1UxnOtzLnNxCxfLnpcbv11NxnLJuM=;
        b=vZZ1/6pXybwSWLq+kFZoJ9rreg6k/N4oX4iW0R1uGEzb22T6O/bmdJ0j0X/JEOSGdV
         QtiQtk28pQTFbPMcgkSUjdpCkP5xpNfhksjTv/Fb+3a/xaeg6CZOq24q2bSCqXA1iaLT
         YX+NWr0/B/8RUzaOEzYAl9He6KX0cKIaIY+rZ57kETt7crOaNsiVqmyVKO2txAX2iR9p
         pFfF1lgdoI3RWQUJTFy4CnIQ4kAL//Vb/YmrxUxgWhsEzhneGwkfhF6h56tahfbr/6BR
         2paePbw95t2MU3xrk3a/p001KMjL3lymylaz7/kDRDlWe2nxzAFlPfgIWIZss3h2AGlJ
         r/hw==
X-Forwarded-Encrypted: i=1; AKwUvBwCnwUANuJe2/hlyRcqRRhqtgIBHVsfbLAwNAsIwq4rPKxY+CYJjIS8lsxLzO3pfiPbMWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcV8NHDlvSa6HIcUycGZfHSBWmmgZxx2OwNoWpITcrGm3llu8W
	S79DLbFiK/bnDAFw6DZRCyG0MD99Qru0kmp29rBIyD40iaRQ6ZGUE/cY6BwARuhZeLnYI5nbIta
	UmsSS2hN9hIseuG0+eH24KVGR+yUQghRD94uMnBDB
X-Gm-Gg: AYBFou2QttDyo62Gtr8nexuTJmX0PqOa+5B+x07V1e+wVHP76IfvhT1xAxjygQBr61b
	bt5Tkb2XuUPVsD45AZHN8+7rs9jy6W6LMBm5vfbaF4fQMCfetksH0txfX/yD8wfb/HLFz66TB4e
	f/JPy7hEGV69im2Nmbg6J0RNYmQOLoj34r985dB8kb9QbNF2QN38HN6ERf0kAgPs7vJDvc8kfAI
	Nxg8v1qB53VHeaeSHBscbuKTtGt3392LKyh86a0KGUj8pxj2FoLKCvnCEP3gTP/XSMzIv28ASQx
	6jDeEhTCrjFp7GMbucdwxWvv5yHSsDPJhDUfiVe9gCE1qK05UTLqzezm/U+MPxYt0qJr1AOhBur
	HzI8LuGrvCktxT7HZ0qe70SV7ldue1v2jVjRBsYuaNZfwYwwFiomlV2yQ3Z4th8ezHKo=
X-Received: by 2002:a17:902:e810:b0:2d5:c090:3810 with SMTP id
 d9443c01a7336-2ea1acd888fmr5174455ad.2.1792510239970; Tue, 20 Oct 2026
 08:30:39 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018053710.2572636-1-irogers@google.com> <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-3-irogers@google.com> <atb-9j8tLZ2rFtOm@z2>
In-Reply-To: <atb-9j8tLZ2rFtOm@z2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Oct 2026 08:30:26 -0700
X-Gm-Features: AclHuK98mcceTeTYd5_ymsTCReegYXkk62EobxKKHMTzqvXMKl2m3o9Szpose10
Message-ID: <CAP-5=fUbsiir_4K1rhpy=TxWpgGLzuR7-fvMiiQ9htTUM3ibng@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] perf bpf-filter: Support BPF sample filters on
 tracepoint events
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	eranian@google.com, ddhariwal@google.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Oct 19, 2026 at 03:09:10PM -0700, Ian Rogers wrote:
> > Commit 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
> > updated set_filter() to route non-tracepoint filter terms (such as uid
> > and gid) on PERF_TYPE_TRACEPOINT events to evsel->bpf_filters instead
> > of the ftrace tracepoint predicate filter.
> >
> > However, in the kernel's __perf_event_set_bpf_prog()
> > (kernel/events/core.c), attaching a BPF program to a perf_event fd
> > branches on perf_event_is_tracing(event):
> > - Non-tracing events (hardware PMU, software events, breakpoints) call
> >   perf_event_set_bpf_handler(), which requires BPF_PROG_TYPE_PERF_EVENT
> >   (SEC("perf_event")).
> > - Tracepoint events (event->pmu =3D=3D &perf_tracepoint) reject
> >   BPF_PROG_TYPE_PERF_EVENT with -EINVAL and instead require
> >   BPF_PROG_TYPE_TRACEPOINT (SEC("tracepoint")), which is attached to
> >   event->tp_event->prog_array and executed in
> >   perf_trace_run_bpf_submit() before perf_tp_event(), dropping the
> >   sample if the BPF program returns 0. Furthermore, the
> >   bpf_cast_to_kern_ctx() kfunc is only permitted in
> >   BPF_PROG_TYPE_PERF_EVENT programs.
> >
> > Add SEC("tracepoint") int perf_tp_sample_filter(void *ctx) in
> > sample_filter.bpf.c to evaluate context-independent filter terms (uid,
> > gid, tid, cpu, time, cgroup) using BPF helpers without calling
> > bpf_cast_to_kern_ctx(). When preparing a BPF filter on a
> > PERF_TYPE_TRACEPOINT evsel, autoload perf_tp_sample_filter instead of
> > perf_sample_filter and attach it once to the shared trace_event_call.
> >
> > Before:
> >   # perf record -e kmem:mm_page_alloc --filter 'uid =3D=3D 0' -- true
> >   libbpf: prog 'perf_sample_filter': failed to attach to perf_event FD =
3: Invalid argument
> >   Failed to attach perf sample-filter program
> >   failed to set filter "BPF" on event kmem:mm_page_alloc with 22 (Inval=
id argument)
> >
> > After:
> >   # perf record -e kmem:mm_page_alloc --filter 'uid =3D=3D 0' -- true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.024 MB perf.data (42 samples) ]
> >
> > Fixes: 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/bpf-filter.c                 | 136 ++++++++++++++++---
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c |  85 ++++++++++++
> >  2 files changed, 201 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.=
c
> > index 72e83ac1d6a4..4e99af4764f1 100644
> > --- a/tools/perf/util/bpf-filter.c
> > +++ b/tools/perf/util/bpf-filter.c
> > @@ -123,15 +123,26 @@ static int check_sample_flags(struct evsel *evsel=
, struct perf_bpf_filter_expr *
> >  {
> >       const struct perf_sample_info *info;
> >
> > -     if (expr->term >=3D PBF_TERM_SAMPLE_START && expr->term <=3D PBF_=
TERM_SAMPLE_END &&
> > -         (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_=
SAMPLE_START))))
> > -             return 0;
> > -
> >       if (expr->term =3D=3D PBF_TERM_UID || expr->term =3D=3D PBF_TERM_=
GID) {
> >               /* Not dependent on the sample_type as computed from a BP=
F helper. */
> >               return 0;
> >       }
> >
> > +     if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
> > +             if (expr->term =3D=3D PBF_TERM_TID || expr->term =3D=3D P=
BF_TERM_CPU ||
> > +                 expr->term =3D=3D PBF_TERM_TIME || expr->term =3D=3D =
PBF_TERM_CGROUP)
> > +                     return 0;
> > +             if (expr->op !=3D PBF_OP_GROUP_BEGIN) {
> > +                     pr_err("Error: %s tracepoint event does not suppo=
rt BPF sample term %d\n",
> > +                            evsel__name(evsel), expr->term);
> > +                     return -1;
> > +             }
> > +     }
> > +
> > +     if (expr->term >=3D PBF_TERM_SAMPLE_START && expr->term <=3D PBF_=
TERM_SAMPLE_END &&
> > +         (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_=
SAMPLE_START))))
> > +             return 0;
> > +
> >       if (expr->op =3D=3D PBF_OP_GROUP_BEGIN) {
> >               struct perf_bpf_filter_expr *group;
> >
> > @@ -427,6 +438,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
> >       struct bpf_link *link;
> >       struct perf_bpf_filter_entry *entry;
> >       bool needs_idx_hash =3D !target__has_cpu(target);
> > +     bool is_tracepoint =3D (evsel->core.attr.type =3D=3D PERF_TYPE_TR=
ACEPOINT);
> >  #if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
> >       DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
> >                           .dont_enable =3D true);
> > @@ -444,9 +456,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, =
struct target *target)
> >               goto err;
> >       }
> >
> > -     if (needs_idx_hash && geteuid() !=3D 0) {
> > +     if (needs_idx_hash && geteuid() !=3D 0 && !perf_cap__capable(CAP_=
BPF)) {
> >               int zero =3D 0;
> >
> > +             if (is_tracepoint) {
> > +                     pr_err("Error: Tracepoint BPF filter requires CAP=
_BPF capability\n");
> > +                     ret =3D -EPERM;
> > +                     goto err;
> > +             }
> > +
> >               /* The filters map is shared among other processes */
> >               ret =3D create_idx_hash(evsel, entry);
> >               if (ret < 0)
> > @@ -484,8 +502,17 @@ int perf_bpf_filter__prepare(struct evsel *evsel, =
struct target *target)
> >               return 0;
> >       }
> >
> > -     skel =3D sample_filter_bpf__open_and_load();
> > +     skel =3D sample_filter_bpf__open();
> >       if (!skel) {
> > +             ret =3D -errno;
> > +             pr_err("Failed to open perf sample-filter BPF skeleton\n"=
);
> > +             goto err;
> > +     }
> > +
> > +     bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tra=
cepoint);
> > +     bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_t=
racepoint);
> > +
> > +     if (sample_filter_bpf__load(skel) < 0) {
> >               ret =3D -errno;
> >               pr_err("Failed to load perf sample-filter BPF skeleton\n"=
);
> >               goto err;
> > @@ -501,15 +528,35 @@ int perf_bpf_filter__prepare(struct evsel *evsel,=
 struct target *target)
> >               goto err;
> >       }
> >
> > -     prog =3D skel->progs.perf_sample_filter;
> > -     for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> > -             for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> > -                     link =3D bpf_program__attach_perf_event_opts(prog=
, FD(evsel, x, y),
> > -                                                                &pe_op=
ts);
> > -                     if (IS_ERR(link)) {
> > -                             pr_err("Failed to attach perf sample-filt=
er program\n");
> > -                             ret =3D PTR_ERR(link);
> > -                             goto err;
> > +     if (is_tracepoint) {
> > +             /*
> > +              * For PERF_TYPE_TRACEPOINT, PERF_EVENT_IOC_SET_BPF attac=
hes the
> > +              * BPF program to event->tp_event->prog_array on the shar=
ed
> > +              * trace_event_call, which perf_trace_run_bpf_submit() ex=
ecutes
> > +              * for all CPUs and tasks before iterating the per-CPU pe=
rf
> > +              * events. Attach once on the first FD so tp_event->prog_=
array
> > +              * does not get duplicate copies for each per-CPU FD.
> > +              */
> > +             prog =3D skel->progs.perf_tp_sample_filter;
> > +             link =3D bpf_program__attach_perf_event_opts(prog, FD(evs=
el, 0, 0),
> > +                                                        &pe_opts);
> > +             ret =3D libbpf_get_error(link);
> > +             if (ret) {
> > +                     pr_err("Failed to attach perf tracepoint sample-f=
ilter program\n");
> > +                     goto err;
> > +             }
> > +             skel->links.perf_tp_sample_filter =3D link;
> > +     } else {
> > +             prog =3D skel->progs.perf_sample_filter;
> > +             for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> > +                     for (y =3D 0; y < xyarray__max_y(evsel->core.fd);=
 y++) {
> > +                             link =3D bpf_program__attach_perf_event_o=
pts(prog, FD(evsel, x, y),
> > +                                                                      =
  &pe_opts);
>
> This link should be saves somewhere.  I've sent a fix for it.

Good catch! I'll follow up on that change.

> > +                             ret =3D libbpf_get_error(link);
> > +                             if (ret) {
> > +                                     pr_err("Failed to attach perf sam=
ple-filter program\n");
> > +                                     goto err;
> > +                             }
> >                       }
> >               }
> >       }
> > @@ -641,6 +688,45 @@ int perf_bpf_filter__parse(struct list_head *expr_=
head, const char *str)
> >       return ret;
> >  }
> >
> > +static int pin_filter_object(struct sample_filter_bpf *skel, const cha=
r *path)
> > +{
> > +     char *prog_path =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D bpf_object__pin_maps(skel->obj, path);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
> > +             bpf_object__unpin_maps(skel->obj, path);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret =3D bpf_program__pin(skel->progs.perf_sample_filter, prog_pat=
h);
> > +     if (ret < 0)
> > +             bpf_object__unpin_maps(skel->obj, path);
> > +
> > +     free(prog_path);
> > +     return ret;
> > +}
> > +
> > +static int unpin_filter_object(struct sample_filter_bpf *skel, const c=
har *path)
> > +{
> > +     char *prog_path =3D NULL;
> > +     int ret, map_ret;
> > +
> > +     if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
> > +             bpf_object__unpin_maps(skel->obj, path);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret =3D bpf_program__unpin(skel->progs.perf_sample_filter, prog_p=
ath);
> > +     free(prog_path);
> > +
> > +     map_ret =3D bpf_object__unpin_maps(skel->obj, path);
> > +     return ret < 0 ? ret : map_ret;
> > +}
> > +
> >  int perf_bpf_filter__pin(void)
> >  {
> >       struct sample_filter_bpf *skel;
> > @@ -655,6 +741,7 @@ int perf_bpf_filter__pin(void)
> >       }
> >
> >       /* pinned program will use pid-hash */
> > +     bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, fals=
e);
> >       bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
> >       bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
> >       bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
> > @@ -674,7 +761,7 @@ int perf_bpf_filter__pin(void)
> >               goto err;
> >       }
> >
> > -     ret =3D bpf_object__pin(skel->obj, path);
> > +     ret =3D pin_filter_object(skel, path);
>
> Why is this change needed?

Before this patch, sample_filter.bpf.c only contained a single BPF
program (perf_sample_filter), which was always loaded. This patch adds
a second program (perf_tp_sample_filter) to the same skeleton (and
patch 4 adds the lock-tracking programs to it as well), and uses
bpf_program__set_autoload() before loading the skeleton so we can
select only the program(s) needed for a given event.

In perf_bpf_filter__pin() and perf_bpf_filter__unpin() (for 'perf
record --setup-filter pin|unpin'), only perf_sample_filter is used,
because the pinned filter mechanism shares a single program across
privileged sessions by looking up kctx->event->id via
bpf_cast_to_kern_ctx(), which is only available to SEC("perf_event")
programs. So autoload is disabled for perf_tp_sample_filter (and in
patch 4, for the lock-tracking programs) when pinning and unpinning.

A consequence of disabling autoload on any program in the skeleton is
that libbpf's bpf_object__pin() and bpf_object__unpin() fail:
  - bpf_object__pin() calls bpf_object__pin_maps() and
bpf_object__pin_programs().
  - While bpf_object__pin_maps() skips maps that have autocreate
disabled, bpf_object__pin_programs() and bpf_object__unpin_programs()
iterate over every program in skel->obj without checking whether
autoload was enabled.
  - When bpf_program__pin() or bpf_program__unpin() is called on a
program that wasn't loaded (prog->fd < 0), libbpf returns -EINVAL
("prog 'perf_tp_sample_filter': can't pin/unpin program that wasn't
loaded").

pin_filter_object() and unpin_filter_object() avoid this by calling
bpf_object__pin_maps() / bpf_object__unpin_maps() for the maps and
explicitly pinning/unpinning only the loaded perf_sample_filter
program.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >       if (ret < 0) {
> >               pr_err("Failed to pin BPF filter objects\n");
> >               goto err;
> > @@ -683,8 +770,8 @@ int perf_bpf_filter__pin(void)
> >       /* setup access permissions for the pinned objects */
> >       dir_fd =3D open(path, O_PATH);
> >       if (dir_fd < 0) {
> > -             bpf_object__unpin(skel->obj, path);
> > -             ret =3D dir_fd;
> > +             ret =3D -errno;
> > +             unpin_filter_object(skel, path);
> >               goto err;
> >       }
> >
> > @@ -727,6 +814,8 @@ int perf_bpf_filter__pin(void)
> >
> >  err_close:
> >       close(dir_fd);
> > +     if (ret < 0)
> > +             unpin_filter_object(skel, path);
> >
> >  err:
> >       free(path);
> > @@ -740,13 +829,20 @@ int perf_bpf_filter__unpin(void)
> >       char *path =3D NULL;
> >       int ret =3D -1;
> >
> > -     skel =3D sample_filter_bpf__open_and_load();
> > +     skel =3D sample_filter_bpf__open();
> >       if (!skel) {
> >               ret =3D -errno;
> >               pr_err("Failed to open perf sample-filter BPF skeleton\n"=
);
> >               goto err;
> >       }
> >
> > +     bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, fals=
e);
> > +     if (sample_filter_bpf__load(skel) < 0) {
> > +             ret =3D -errno;
> > +             pr_err("Failed to load perf sample-filter BPF skeleton\n"=
);
> > +             goto err;
> > +     }
> > +
> >       if (asprintf(&path, "%s/fs/bpf/%s", sysfs__mountpoint(),
> >                    PERF_BPF_FILTER_PIN_PATH) < 0) {
> >               ret =3D -errno;
> > @@ -754,7 +850,7 @@ int perf_bpf_filter__unpin(void)
> >               goto err;
> >       }
> >
> > -     ret =3D bpf_object__unpin(skel->obj, path);
> > +     ret =3D unpin_filter_object(skel, path);
> >
> >  err:
> >       free(path);
> > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/=
util/bpf_skel/sample_filter.bpf.c
> > index e5666d4c1722..576fbed270e5 100644
> > --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > @@ -192,6 +192,28 @@ static inline __u64 perf_get_sample(struct bpf_per=
f_event_data_kern *kctx,
> >       return 0;
> >  }
> >
> > +static __always_inline __u64 perf_get_common_sample(struct perf_bpf_fi=
lter_entry *entry)
> > +{
> > +     switch (entry->term) {
> > +     case PBF_TERM_TID:
> > +             if (entry->part)
> > +                     return bpf_get_current_pid_tgid() >> 32;
> > +             return (__u32)bpf_get_current_pid_tgid();
> > +     case PBF_TERM_CPU:
> > +             return bpf_get_smp_processor_id();
> > +     case PBF_TERM_TIME:
> > +             return bpf_ktime_get_ns();
> > +     case PBF_TERM_CGROUP:
> > +             return bpf_get_current_cgroup_id();
> > +     case PBF_TERM_UID:
> > +             return bpf_get_current_uid_gid() & 0xFFFFFFFF;
> > +     case PBF_TERM_GID:
> > +             return bpf_get_current_uid_gid() >> 32;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> >  #define CHECK_RESULT(data, op, val)                  \
> >       if (!(data op val)) {                           \
> >               if (!in_group)                          \
> > @@ -295,4 +317,67 @@ int perf_sample_filter(void *ctx)
> >       return 0;
> >  }
> >
> > +/* BPF program to be called for tracepoint perf events */
> > +SEC("tracepoint")
> > +int perf_tp_sample_filter(void *ctx)
> > +{
> > +     struct perf_bpf_filter_entry *entry;
> > +     __u64 sample_data;
> > +     int in_group =3D 0;
> > +     int group_result =3D 0;
> > +     int i, k =3D 0;
> > +     int *losts;
> > +
> > +     entry =3D bpf_map_lookup_elem(&filters, &k);
> > +     if (entry =3D=3D NULL)
> > +             goto drop;
> > +
> > +     for (i =3D 0; i < MAX_FILTERS; i++) {
> > +             sample_data =3D perf_get_common_sample(&entry[i]);
> > +
> > +             switch (entry[i].op) {
> > +             case PBF_OP_EQ:
> > +                     CHECK_RESULT(sample_data, =3D=3D, entry[i].value)
> > +                     break;
> > +             case PBF_OP_NEQ:
> > +                     CHECK_RESULT(sample_data, !=3D, entry[i].value)
> > +                     break;
> > +             case PBF_OP_GT:
> > +                     CHECK_RESULT(sample_data, >, entry[i].value)
> > +                     break;
> > +             case PBF_OP_GE:
> > +                     CHECK_RESULT(sample_data, >=3D, entry[i].value)
> > +                     break;
> > +             case PBF_OP_LT:
> > +                     CHECK_RESULT(sample_data, <, entry[i].value)
> > +                     break;
> > +             case PBF_OP_LE:
> > +                     CHECK_RESULT(sample_data, <=3D, entry[i].value)
> > +                     break;
> > +             case PBF_OP_AND:
> > +                     CHECK_RESULT(sample_data, &, entry[i].value)
> > +                     break;
> > +             case PBF_OP_GROUP_BEGIN:
> > +                     in_group =3D 1;
> > +                     group_result =3D 0;
> > +                     break;
> > +             case PBF_OP_GROUP_END:
> > +                     if (group_result =3D=3D 0)
> > +                             goto drop;
> > +                     in_group =3D 0;
> > +                     break;
> > +             case PBF_OP_DONE:
> > +                     return 1;
> > +             }
> > +     }
> > +     return 1;
> > +
> > +drop:
> > +     losts =3D bpf_map_lookup_elem(&dropped, &k);
> > +     if (losts !=3D NULL)
> > +             __sync_fetch_and_add(losts, 1);
> > +
> > +     return 0;
> > +}
> > +
> >  char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> > --
> > 2.56.0.212.g129ede20d9-goog
> >
