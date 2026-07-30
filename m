Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92243DC4D8
	for <rcu@vger.kernel.org>; Thu, 30 Jul 2026 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450465; cv=pass; b=Xpg/Kplxjc6scfmDydhd0lXLv5/+hb5gVSKdAMtWwE6z8WTl2AipX4dh/ihD9AVOCd7dIxFnJNdTKFJdBJFgG2uhkLJQ3/7YiEiVN+qQVZaD3T+BoSvz+dRUiEfB3GX2fOSoEL9IxK213q7yuBnC4pf3oHDbMdBTvUF5dJuIG2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450465; c=relaxed/simple;
	bh=mxR6zo1uzVmlCvrVVTNLSNdWhxzrwV7OGrG+Af4HFoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBiDg4U0hvA7EtYer9fSQCAEUpsei6swV/61gmALWtBwKnFoQJkCcWRVGC69YWT69N9YXHPg/25bTDJpvhxvRH7UWZVgZodZj8JtaNoewJ1ZhaL4okBAWymU1OEIsExKsuXKGji8SmAG3XwTXhTqsxeS+joUzoVS76NVzvX4et0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAVr1pfw; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAVr1pfw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84864086bfeso449377b3a.1
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2026 15:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450462; cv=none;
        d=google.com; s=arc-20260327;
        b=cA2FzTbPE3flG2z0J6qM/vkGJAao4EcBo+NZMqQ4JVaVUd//VbQZP4SkgkT91WB9fW
         N8AEHA8BGFCr8RsCI2fld8NTjdg+rhN8+zHdvsYI/X8+mpaypbzP1JozRuFstUnvBrNN
         AfEPQiPBXNW0zwbneLDd+bW80fraW+KgrjtwenPTXScrWAvfLXl288YOqgp7ntX2yyau
         cek94/sqF3Wa3sz42HvH4KQfX0PbFG5Pv8LF1qLWTi1KdqGpLFNuJXz8WG11xOdLGchY
         pNjhu4bu1p0J5co2fNVOA2k+k5cyk9V7ioZmKy66B9itBKMqxGS+iOepdTjzMEAdQB0T
         Hexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        fh=sCTmb4NAYlmsd2o4yJM8fsS0d/u6UcTjFOQqWSB1mT4=;
        b=drQlfkNoTCHLpmO0FJqcLkFQKnmv/En3XiTx2rzXOrzpPHOsgwrG5f/FYiOUX6jXjh
         VDYvQ1gRilTKiiRO7od4HWm+8JaY/84rTOTJKTJd7ag6jA20tNb6KqexAs0xaRLtIDq9
         pGiz5zpyODp3xZhLPXEm+6mwm1Mo1zx4GCn+3cDdMxU6j+zaaj8upkXUjQRIoLfswdeT
         gyABGdByfcgHInk7E0vgg7JLEd8CnwYS0E4keZZfy1NSmfj0RXS9xoIMsMd/VoG8oVa4
         0Aqp4cMO0d+3r3bia49qrt6Bl743ociPoQxA/OoI7Bcsa0THvX5jx6eRM97NmmjEyB06
         arEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450462; x=1786055262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=kAVr1pfwLotij0D/D1LNuSSV7eWURHJKJ9ODxzZVVUGFEJkqaFm+LPBTf4faSM0vOY
         9fNS4/9fB4691cD4z+w0fTFJetWOtE6FTN5yN8WqQh5EZJIqHHKaUjatResq//qoYEN0
         hVXUQ3w/1i+6u8aipLwJZXTDPc4bFRaVFC033swyS9R18K35kYCsKyHRf95dqELAuzLT
         nGnaw3ZwL10yE7cLYjWA7+E1FJiVyucawHXoy6+aQcRsczQOnezCxO9WwqxmAsGyg3JY
         SdTHxbiujsnADkJiN+8mxrtKpubgkfZ982rI2V+9fm797IGmsaxzASE8Q9V8dMHNI+xb
         s9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450462; x=1786055262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=JABfXN6Jq4JkTWQAhPPPELvn+fb4eylMcF4OG0hCt0/VgSXTAjM+R1JyaY6DJk/IzQ
         Z0FSi67JHlDqnt0bzCX75G0GNb7zXtyaeZWMbNWeUZUYq0HJCPkkvKdMh7FQVIQqxBxk
         ZrrakNtfBBQGfbK6Q0MEw5dmEwJSjCC5ZVbPaQK14CHcRpHmxdMCGWoCkSXHKaHesGuK
         wPnYq7+QI3vs50GzBOFqpCm7aDg6nBh8CFuhQAw720CUGHsb630EJTiOBpkLsFLZR+Ex
         xMlosVlcQB6MdfOUE6MLTs+ltqx50nZcM3zyLPqmgQfUB1kCIzqiKmFCwpJ5vYsGnBWy
         txfQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+FlONeX8TcURsnnkJRf10YhWtUri34hSNcMtYMG5fx0YjaneiJW1ANHCJFJIyWSfAgDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepUYE3yQO/cCx8DnsB4wxR3EkZQBEsLH3CZZMuu+s+E9mmqcz
	M3JNTtZOAfd5ZQiGBXy7lk/N6DJrP7jV0pwZ+1DDsy6MO6JPObgUv/hW4XYRDF2fxcnjY4SB33X
	No8SNw+KXgSCd3Ta9rQNlrAjC8gIM7X0=
X-Gm-Gg: AR+sD12xFkH3ZKXE3CI0Bu34swjz2krDo0V5uLnovZ0H+doeCxXGS4VNeMtyEY5pUsZ
	NReQcH2bMxYBCAUmDBKXInkCt2UV8pbv9+SKDCMu/c/juI74js5NPunNrIvf7WnXHaZQQ2wQ/Vs
	xF9upjq8hjT2gqukYM5YY6q2tnNStJ00ZnXbPk1wRSLjrm32uGSKuj1kfeeBcHNAcpW7fjOKUMi
	fub2hXW98TA0jWroydailjbErK+sSNqBQfErdRj1A7j1NUUUwf4MVysBw30Zsr/wleBv5JflEp1
	ESfgNLP1tITPB1x23zlat0xRKwJCBAaAS6tLMlrLoc2gFArAtiK/5v9z68TpyKM9vqTnZXKSET8
	6foVSXwxwXT7oNIWgJ3/9Txl3xe5oR/UhL23uibX7vo3AdkEowMPmzVkwJalx0Bz9
X-Received: by 2002:a05:6a00:c82:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-84ebc1fdaa9mr3988166b3a.16.1785450462053; Thu, 30 Jul 2026
 15:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
 <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com> <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
In-Reply-To: <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 15:27:27 -0700
X-Gm-Features: AUfX_mwDesWtdCLE-1Fw6wnAI4608m7zqiXpKFs0ROJhEZiKm1s5xaCdqqVAUCY
Message-ID: <CAEf4Bza3LeVB-z3jwMdnBGLdjpPr9tZFhGHt5pUwui64ZX66Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Tue, Jul 21, 2026 at 12:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri Jul 10, 2026 at 11:23 PM CEST, Andrii Nakryiko wrote:
> > On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> uretprobes_srcu currently uses normal SRCU, which issues
> >> two smp_mb() per read lock/unlock pair. This overhead is
> >> paid on every uretprobe hit.
> >>
> >> Switch to SRCU-fast-updown, which eliminates the per-reader
> >> memory barriers by moving the ordering cost to the
> >> grace-period side (synchronize_rcu() instead of smp_mb()).
> >> This is acceptable because grace periods (uprobe
> >> unregistration) are infrequent compared to reader-side
> >> uretprobe hits.
> >>
> >> The updown flavor is required because the SRCU read lock is
> >> taken in prepare_uretprobe() when a return instance is
> >> created and is held until that return instance is finalized.
> >> The traced thread returns to user space in between, so the
> >> lock is inherently released in a different context from
> >> where it was acquired: on the normal return path via
> >> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> >> ri_timer() (expiry) or dup_utask() (fork) via
> >> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> >> are designed for this acquire-here / release-elsewhere
> >> pattern and, unlike the same-context srcu_read_lock_fast()
> >> variant, do not carry the lockdep read-side tracking that
> >> would warn on it.
> >>
> >> The short, same-context SRCU sections in ri_timer() and
> >> dup_utask() (which guard the uprobe against reuse across the
> >> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> >> for proper lockdep coverage.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  include/linux/uprobes.h |  5 +++--
> >>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
> >>  2 files changed, 20 insertions(+), 14 deletions(-)
> >>
> >
> > Very straightforward replacement and will improve performance, thanks!
> > LGTM. Peter or Mingo, I assume you guys will want to route this
> > through your tip tree, right?
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
>
> Hi Peter, Ingo,
>
> Gentle ping for this.
>

Another ping, please consider applying, thanks!

> > [...]
>
