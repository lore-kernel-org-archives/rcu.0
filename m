Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC103B7779
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718635; cv=pass; b=JWuMQrSdK7nP6tsI40hWtEP70+2wDZLVdMFjf7kGbIGyeb6va9jwFgaPOAdcqhbk65XjckrLNA4fZmAKeaTMeqRD/M3eumryFM9lO8jgfDjSNZb4tiz/mnoWgHA+OXt/vy6TKCAb/dM+6qU5qwq7GrrNPBJ3PX+PcAHJhAjp5Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718635; c=relaxed/simple;
	bh=ZffsXEKRzy6BPrYFDZBFjLeefjvojwkwyzHgCSgBeJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaDA4huW7fXBhOEtlXKiRLG+d+lRlbpdaqiYM5Z/VdiLurE6bWIPe59fOYDtG6sa5QwwLY4GU0cNuUT3OWAHWB/rzIY1oqUGcO/ls834LvbLWYRMfWPLRL5KGQe1NSMXtcYpQWhl/2uei5Y5VsU0F+tQNKjDuWWuW4I+uGt2e9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfiEZkVR; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfiEZkVR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38101f85591so1875696a91.1
        for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 14:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718632; cv=none;
        d=google.com; s=arc-20260327;
        b=azk8HGNtNEZ/iBGue/hwoppto82/r0d07UraL+zyGr0jMPawWHCxpmkLW4+U43uRmy
         NhU2DoCGtOge14Z6jZ5qv6a3z3u/1HwiiErXcYAM174IIv4he9GSjMobERgHvZeD0715
         9wIly2i6/yoU7EjDRpwUeonXtGIPvjYRqzgSn48mF1OSu7rWVeu7YPJ9JTuXc94Ee2RB
         6Uqr7u3Sgz3hy2vz4Uwvfe9JPM+K64WK2MVHnTDCCKMP+jCjttIMo8tscKos4ttX4MhU
         1KDdRdn6SvuTGnbCWdrxMu43VOd5mk7C1OWFtPprd0m9pvzdQqV15T3GSJfbkcCfIZ6Q
         IEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        fh=LSJzE8PpkiAgHO2k2cRhVDJmsuOntARUuZj/IMNsl+g=;
        b=riH0Z8dtOgQSVjJFZ9oHmtB8KBxvDNMtTv21+of+/pE9lY0Lz2krph8AT/8NCVN05D
         5xArEhqtKpwoFkxofX6qYICIhu6CGrgcTfmyjPuwI9mylSwNnz9ck5Jgm4FsOe8PwDSl
         mr2GV9rfmUkwepbo90mF3HWSta8S/4JNGI5Esuykxf/oBMkdrakazQVxW1Q6dh+8j0We
         qMIDXRbu3FEFW64/VlWkc4Z3re067SIS2cjnny+0qYAIR3J2Z6KJI4X2FnaLNvyPp9sk
         xFkL+/gFjgSs4m0aREHldvJl8x05vb5yJ5qDWywgkmkfmvvHsItj6a0pPBPNqmcQ8IbI
         B2WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718632; x=1784323432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=gfiEZkVRkxY3zvcQlPbas/3Cycw47n3fcFyJ5mfu46UrrgcTvkI0356jgCEZcaZafW
         X6cbSUJanZS0Mo6YOChyU/8CzukJyrdbK3RXgTB3KdWymKLh2qd67PwMA3WpUcZFIW10
         r6wgLSZ8WUnZACqQ8DlT2qkuqJSTPx1a/HQ0pI4+wbP48h1SofJJoDlHNaEiGr+1iRpp
         oSALXPlMh62CoSf+dubbQCWTGgAZMRWYEEfE+hs9vLnezx0k6tktUQL31TPkHk/465HC
         I7VEdO3fKkg/syWpwHvbBCjr2Ykni/j2Zgp9pmCrXJssapi1k2eceXGm5OYVZMRwLIcE
         ioQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718632; x=1784323432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=djdl7oB1PmQ6UHws3EZJgDJ8ntYIHtdp48P9YhllNUDhi9fkEAcmLiET4gYAi74d4k
         xYev0tbq24vIkiBVVWiwl/8DyEt5030xn1kruWNs/2lr0PI3az4X+C4b/rrzLJkbSvVP
         NlL4vcIGvY9QoeAa9LGXVIg4gXl/s02vMrj2yhd8dx7A3KiGHiySwBySChT5R0rQ3Y6F
         2wFWxuW/4l9/9VB4btUlsx9jc0J8Gdl+U+UmQJLceyad8WMwGL/TUwW2ZC4jtEJXYKfZ
         awLViYy8zhlxOY1Uj/Y9XDMwmSs8A+9dHchDrKs4I2fDqzANbMftHuGUO/zPmMaj1QLe
         cT/w==
X-Forwarded-Encrypted: i=1; AHgh+RrVFSJoxgxUpU2+vpdC6vdVw3X5Otcn6s87bZxPEIhVlmnTWOeWYKgrTHfYD5gtMRPXes0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5P4GL6M9MIFIEAtRGKsNOW0peBdBiFE8cydnB2mz5906DVI4
	Z+naM7vhAoe++L71gKzNZgovsXICb48bS2hRKyUnTwbLrnqSorT1FKQYFNzQjr4e9KP/vZ8LVv0
	ewKNG0KUF64Ut07FE27o/ka9cdCUn8n0=
X-Gm-Gg: AfdE7cm9/kdB+fj7MW3rnf49SJSHWLF7XCKHev57kUlfSiHYauQVbaZ5e65W+/lmHCu
	BuC/oP/jmN8ufRsMjuuVdnWwOoMxkhIZqzRJcXNZig70H+jvfBlOxb2UxcPFkt8yvE/Mu0IBcsU
	mPxCiDQprjiwPHKUTjkBpWs0PaTyAGb3BVs2aCXuBTEcQvFveWvglZnPcCiN4/RBk06ZUN1B8EP
	aY2Y0xt++/HD2nmNv72yoACm4FgK3Cjnh6NmO4Ub0/iX6C/DUB72hGP2A5iJSIyiyVOUzVRa7Op
	bTjlMF8eFMrGN+K5loDAr2YZCXLfXelAWbAPLMBDhdLhtqmf5elD+w==
X-Received: by 2002:a17:90b:5903:b0:37f:9e21:91d8 with SMTP id
 98e67ed59e1d1-38dc834de8fmr359486a91.15.1783718632544; Fri, 10 Jul 2026
 14:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
In-Reply-To: <20260706172744.3920417-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:23:39 -0700
X-Gm-Features: AVVi8CeESE7KrO4SofyyKXRIq0UuNC-RWDudhRYzrwkmSGZKKMPllM8AreG8cCk
Message-ID: <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> uretprobes_srcu currently uses normal SRCU, which issues
> two smp_mb() per read lock/unlock pair. This overhead is
> paid on every uretprobe hit.
>
> Switch to SRCU-fast-updown, which eliminates the per-reader
> memory barriers by moving the ordering cost to the
> grace-period side (synchronize_rcu() instead of smp_mb()).
> This is acceptable because grace periods (uprobe
> unregistration) are infrequent compared to reader-side
> uretprobe hits.
>
> The updown flavor is required because the SRCU read lock is
> taken in prepare_uretprobe() when a return instance is
> created and is held until that return instance is finalized.
> The traced thread returns to user space in between, so the
> lock is inherently released in a different context from
> where it was acquired: on the normal return path via
> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> ri_timer() (expiry) or dup_utask() (fork) via
> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> are designed for this acquire-here / release-elsewhere
> pattern and, unlike the same-context srcu_read_lock_fast()
> variant, do not carry the lockdep read-side tracking that
> would warn on it.
>
> The short, same-context SRCU sections in ri_timer() and
> dup_utask() (which guard the uprobe against reuse across the
> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> for proper lockdep coverage.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++--
>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>

Very straightforward replacement and will improve performance, thanks!
LGTM. Peter or Mingo, I assume you guys will want to route this
through your tip tree, right?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
