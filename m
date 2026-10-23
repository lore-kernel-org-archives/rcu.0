Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792732600;
	b=HvTLd2/HulnJfPTSm5jqa/R7W7LEz0lZC4Hfl46IN90Wv1r2gvC5r4DlNWrg8YKd3YkQ
	 gGOMLDY9U1+oC+BJ18t+KE66CkZly1MoRDwsOb1Q1lY9wy3NDWmF0ia0uncgxcvWzKqew
	 tqfPr9YBkxqxlTTDvzwV59QVzVYQk0Qb9bwRSn8q3OmTItPZ6w+uNlwsTOXQaHrR0ww1b
	 hepqz+Qyv56va518h0/IrfTQVJChPustF9R8Ap7JWm5NwXO5Z0UCpjRRDJ0lf9lRl0fr3
	 4pG0V2Yy5OZadyp0L2rEXLPxAQPo0RM+adYKECVrhYio6R+Fi8YwTfbVaNQwDOUiLyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
	b=kKvMpovtYhfv6lkxY3/Np1lc7UGsxzav7/YQsZuBFU6q7Iy4Fzhr2BExUqJDfteTqmL5
	 qxdotGV+Lh9BY89sVDbMYGPNrql0PUpp6WUtHFMuU5BiXKONSs/O7yVSX8aqqPAwC6viZ
	 McXRwIAEZ/loGbrbrI+pHRi6BeK1jeZEOr1ROGYzXHpiw3/9SdcayOUlrKYfHGVfiXj6t
	 VCMZBaQ6ecNwtQZGV2AG1aXECmTLEX1o19axoOwGYi7Voa9pSwYEaq+9QEugbhWM7ykAc
	 T6yyyd06W4as0QvkoytgdQqMD7xzxMNFoW1GKSfLuvouaTXOEi3XCOT4y+o63O8BFtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="qk/Edkvs";
	arc=fail smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E7606A31A
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 05:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qk/Edkvs
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337fa12431so126851cf.1
        for <rcu@vger.kernel.org>; Thu, 22 Oct 2026 22:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792732599; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfbsMsRC28MQdpf250wim0lP2AKurln/9wET4UTGni9mfZpF+VqRLOQy1IKklczW3Q
         W5Y2WpvFIn3Obz2uuMwPnMQaS5fB6jVI39npfXWQsu39vzazo77gYQgOgrVS7+jAtO3O
         bS7ZTHRvAUb9hP1vvH5fV9QbnN+GHeDarvyxlYUXXGcJgoV4DAOnAJ27hwy/Oes983cU
         S/7YrT5nDqCAsvLG7BOXkhMGH1Lo/bxZxST3Hur0LW45ssM+a8s4fYF0j8NBPvT/H5j0
         lxG6wMv5TA1AYSSvBVG0ob1L31nllO0JHHu1T26fjHxaMHoYfmWbZbDGySQu66gAywL1
         uX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
        fh=oDXLmPVU0EvOeymv/LJtG5wwEscOoooXQCToMouFoWg=;
        b=pp0+c3LOf2kCp6ihlcf1/bJ8v+UQamb1OHupv5bVvMPXBymBoF9IfT4dWv+y16SS12
         SwGgLb9VXNpskYGSzj3pGCTuSkd29MdOt7BaYPuZhQpwKWSTJBm/4UhuOViLS1yzBviJ
         AGfjOE9Ac4gehYNLKGezRl8KRqA0KFM2PcRYkD8OAluwDMfZBCn7JTLPifxIqDKXGzfB
         aEwcEPBb1K63hZt92BEYppYLGqFXqf/WjU2z4vSKH4MpDkQlf9xiqJSUfM6f8LO6LMbU
         0APbRyjCzLO05WA5msMR5qZ38zqq/fetwmAzn+mr9fnAR9PrDYII6lpzuH/gpZQaIfvI
         +XiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792732599; x=1793337399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
        b=qk/EdkvsHRAnmnorDQKg1s+yWQL9hzjOOpTzQqcpTHHNE4+D3aq49Z0GG1r50IJ8c/
         lONFb5BfwTJ3b/eb5h3y3/ivGtjHXxCwh77N6byYEsTf99Wp/GeGZA2H6qR1/85ORowe
         BUc1fXIcECLjlrHuGmFZTBxzOZnOpWzwBJDNNCX/zc+StwRW2s2UN/zQgkrx+zDgZZbf
         FeTSKNODJ8RtQgUADfG9CYTUa6AbiKRkmLeqijY5U95nre7ZVCtKdUps5uxcALCOqJNX
         WZt0WIy4d1858mhO6BbparV0C0i9GPAZhbAP5D88LztwEJimGi2EZndfCtJfuRwbVm8L
         736w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732599; x=1793337399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
        b=y2Ks3g2+dsW2tdYkD/+aD67DIWv2z2OE5cF4u2erEmGdTaGlrCB4ZG5uFSj9MrPD7V
         UI0hvgRiA4DS35RnKzm7zRJeH8lDLzShs/rCqVAxQTr/DteKheEz1Fp83YTxspK1RD9s
         Bz8CchygraIt7EFi2FFlQOBjwA51gr6fJn1lVLsF8qX3MbL8XcI1gGJrLaqIcMJrMytz
         ni1c0oSBirGLL8zf9EPTRQQQ3Wc175jrWBwmNU6DP1+x6WR+cEKUff8XSWXiGkrK/3uY
         JsFXZv+HEj3nHZObJzJxnhYHisUEJd418WMMrdnvXvAN910eubsnOvyQQQwBAh04lNS9
         ACeA==
X-Forwarded-Encrypted: i=1; AKwUvByRcDqEssd+aC/Nj3Fi5mJxcvkjzIHWq3L6gDoYoKXWkRhKK8iFpiC9UEzFS/8KGcxmhIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwPOrz8B8DyBUt9fC26vf0Uau/gQobqSVFL3S1FFfRCqGpm6Ri
	+RY480eN+iaK7ioNfcJFCUQk0KXDtzRFSyiLAR5wAe0oBg9Saejgb4lqZzvU+/hVbVfAjCp+Ye9
	pqZ8sGcEEAItfGnXUnz30Ir1ehM9S0i/lbcjo78Ys
X-Gm-Gg: AYBFou0KdLdw8QpuiISPfC+Ry1FC2fX6hNFP5U5uSvcBdmm3cFUZvzG4WHxXyMnlles
	pd9jBAlJAkUe4ACHsYKfPLOgqFBQvWjfRTa7iVV/uqiFua/b4myWt5ZX8B1qhIdy8eSjl2aUnb1
	/sujUW0MjejFt8P7aaji/7DCHk2o3KkukFKKiDDporhl6npCAzDr953/mC7JwIazzOW197JeSTd
	PbzGHS993eTDGaDqkutxpxDtMJ8NTtGvg8P0W59pT3S99kIFCx/w8f6oOXvJkQrkYKV6sgh1Vy4
	z4s0/zBheQzEw4bDWjyY39Ml9zwu/PtEobDoFGRKvY1e4ovLItJMjch7+KYiO1d/OAsJ0w/AkdS
	kzZ+ILEL3to5AEWNbQfu/Hcmm5qMWxB8m2GHT2yqmXH7OaGHnBcLB6a4ecPg=
X-Received: by 2002:a05:622a:4d4f:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-536c274d0e2mr8214441cf.4.1792732598813; Thu, 22 Oct 2026
 22:16:38 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-6-irogers@google.com> <atqUSrmtsfCojGcA@google.com>
In-Reply-To: <atqUSrmtsfCojGcA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 22:16:27 -0700
X-Gm-Features: AclHuK-FispLLEYasalxplr3JlR7dLX32HrZh2qbDugEADtQ2Lp3Wc6zv5VHb3M
Message-ID: <CAP-5=fWFbSP48GDQFuUXsTMJ6sN8hYEYrMPmM8tb_o44AxwCQg@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] perf bpf-filter: Add lock_held() sample filter
 for global mutexes
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com, 
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 22, 2026 at 01:29:57PM -0700, Ian Rogers wrote:
[snip]
> > +static int resolve_lock_expr(struct perf_bpf_filter_expr *expr,
> > +                          struct perf_bpf_filter_entry *entry)
> > +{
> > +     const char *name =3D expr->lock_name;
> > +     char base[128];
> > +     bool has_amp;
> > +     unsigned int mode;
> > +     u64 addr =3D 0;
> > +     int ret;
> > +
> > +     ret =3D normalize_lock_expr_op(expr, &entry->op);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (split_lock_name_mode(name, expr->part, base, sizeof(base),
> > +                              &has_amp, &mode) < 0 || has_amp) {
> > +             pr_err("Error: Invalid kernel lock filter '%s'\n", name ?=
: "");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (str_ends_with(base, "mutex") &&
> > +         !str_ends_with(base, "rt_mutex") &&
> > +         !str_ends_with(base, "rtmutex")) {
>
> Is it just checking the symbol name ends with "mutex" or so?  It seems
> risky and limited, can we check BTF to verify if it's really a mutex?

Agreed, a suffix check is only a heuristic. The catch is that kallsyms
gives an address for a global or static variable but not its type. And
vmlinux BTF normally only has BTF_KIND_VAR entries for per-CPU
variables: scripts/Makefile.btf passes "--btf_features=3D...,var,..."
but not "global_var". So on most kernels there's no BTF type for
something like cgroup_mutex to check.

Patch 6 in this series adds classify_lock_sym(), which uses BTF where
it can and falls back to the name suffix otherwise. It checks:
1. for a __percpu_rwsem_rc_<name> BTF var. DEFINE_PERCPU_RWSEM()
always emits one, and as a per-CPU variable it's always in BTF;
2. the symbol's BTF_KIND_VAR type (struct mutex, rt_mutex,
rw_semaphore, semaphore, ...), when the kernel was built with global
variables in BTF;
3. otherwise, the name suffix.

In any case a wrong guess is harmless. The direct owner check only
reads lock->owner with bpf_probe_read_kernel(), and only at an address
already confirmed to be in kernel .data/.bss (function symbols are
rejected via kallsyms and BTF). The worst case is that the filter
doesn't match.

Patch 5 adding a suffix check that patch 6 then replaces isn't
intuitive, so in the next version I'll move classify_lock_sym() into
patch 5 and use it from the start.

Thanks,
Ian

> Thanks,
> Namhyung
