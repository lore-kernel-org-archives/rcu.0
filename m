Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E91476CDC;
	Thu, 30 Jul 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454655; cv=none; b=tO/hoHmOAzalU7Zr9o8r4ZiHUTDOCRqYbsNXURfaqWZnDAQYq32vwaSnIfMeHDQIWnYNx9xKcdvAUU81/irmW1YQfnp+lhmQaXzuAKzYEIFK7XbriYePyB77Vx8HxCucVarUorWXIekuPvMsI4WGrZd/F/86boL5NC9G+7RSJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454655; c=relaxed/simple;
	bh=CHae/PQNyGnK+cAwdETrjX+TvDIGQh4fuLvoP+AlPlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRsHMQViD+kPIlNeplGog035/ihNjM4dow6xHMckzLtUW57rEh6nPgkOKyNLeRvBb5MILicHt8nhu+DB/SZMal9acyE33ys3PimjFKu55erSp1i4nuzLVlcTfTH+X0T9HVFe+iZvxBhzWRDsm5RhYBjyXQVp115NJ0yQarBJW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gLAtWP2Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gLAtWP2Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CAtKSI6m+4Gh/IO7Lr6iBocpHFoEfkL6KKgxA4beTgg=; b=gLAtWP2ZiiTF5jaWCra5e/pq8h
	0CXiMcbEcrBaokrjOC9e5/zFgU2ADom77GKb7KUNm/ayEyf9H0gIsg5aFPAd1lIloek+6RDMIQkDu
	jFM+EeGiHejlCeIGaZFwj+GTB/sQHGzDneDBnSWQjJS8eREfWFpjPLNy4SIAXCbIKfEjP49br+DmF
	tpnBD+HYhX2tx8OT/k4I9sWUfRrw3kmo8jHKJAafKTyGGk0rhpzWcYDL2mnKsyE2HAxxpYox3/L2d
	qdl+w6Kk9vSNumwm2ldLTxQ27yPjw/PDMlNoqGkmWGbUYcPKIXsv1/5AC6QaJeTUMzSPPsPfh+7uu
	bt1ADutg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaJW-00000004bEg-1els;
	Thu, 30 Jul 2026 23:37:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF7BF3004C9; Fri, 31 Jul 2026 01:37:20 +0200 (CEST)
Date: Fri, 31 Jul 2026 01:37:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
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
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to
 SRCU-fast-updown
Message-ID: <20260730233720.GC776954@noisy.programming.kicks-ass.net>
References: <20260706172744.3920417-1-puranjay@kernel.org>
 <20260706172744.3920417-3-puranjay@kernel.org>
 <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>
 <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
 <CAEf4Bza3LeVB-z3jwMdnBGLdjpPr9tZFhGHt5pUwui64ZX66Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza3LeVB-z3jwMdnBGLdjpPr9tZFhGHt5pUwui64ZX66Lw@mail.gmail.com>

On Thu, Jul 30, 2026 at 03:27:27PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 21, 2026 at 12:44 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri Jul 10, 2026 at 11:23 PM CEST, Andrii Nakryiko wrote:
> > > On Mon, Jul 6, 2026 at 10:28 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> > >>
> > >> uretprobes_srcu currently uses normal SRCU, which issues
> > >> two smp_mb() per read lock/unlock pair. This overhead is
> > >> paid on every uretprobe hit.
> > >>
> > >> Switch to SRCU-fast-updown, which eliminates the per-reader
> > >> memory barriers by moving the ordering cost to the
> > >> grace-period side (synchronize_rcu() instead of smp_mb()).
> > >> This is acceptable because grace periods (uprobe
> > >> unregistration) are infrequent compared to reader-side
> > >> uretprobe hits.
> > >>
> > >> The updown flavor is required because the SRCU read lock is
> > >> taken in prepare_uretprobe() when a return instance is
> > >> created and is held until that return instance is finalized.
> > >> The traced thread returns to user space in between, so the
> > >> lock is inherently released in a different context from
> > >> where it was acquired: on the normal return path via
> > >> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> > >> ri_timer() (expiry) or dup_utask() (fork) via
> > >> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> > >> are designed for this acquire-here / release-elsewhere
> > >> pattern and, unlike the same-context srcu_read_lock_fast()
> > >> variant, do not carry the lockdep read-side tracking that
> > >> would warn on it.
> > >>
> > >> The short, same-context SRCU sections in ri_timer() and
> > >> dup_utask() (which guard the uprobe against reuse across the
> > >> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> > >> for proper lockdep coverage.
> > >>
> > >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > >> ---
> > >>  include/linux/uprobes.h |  5 +++--
> > >>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
> > >>  2 files changed, 20 insertions(+), 14 deletions(-)
> > >>
> > >
> > > Very straightforward replacement and will improve performance, thanks!
> > > LGTM. Peter or Mingo, I assume you guys will want to route this
> > > through your tip tree, right?
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> >
> > Hi Peter, Ingo,
> >
> > Gentle ping for this.
> >
> 
> Another ping, please consider applying, thanks!

Got them, thanks!
