Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269C3A9850;
	Tue,  8 Sep 2026 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853361; cv=none; b=KvbZpHwHBOfXBA3iLrPt47eZX5uOMTQVTgJ7BQ0PGc2rBDLZbzw6mBgAMYEIFAccDs739CTEKYyEy7NP9H/37m8NipuTFDB8NFQpo7OjUOFaFzVt+o+8/z0Stn7SYqVs32ivU/yRc5JmdFXuusuFgYJ8od2LurfGGO9KLzlff6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853361; c=relaxed/simple;
	bh=gqCy451RogHwWAWs/5Pzh822czFIXxvSEv2LlvcTmh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2YyN4Jvtne070aUvHQFtUB0eWF4E5cGYzDQ2kp6AYcGvjLxgwc5G3NLE9N54KAiJGJrAPDkKwpjBUYvbsJH1mm2BFpuylYsHoEHuQhi0UxOHIiNydPGifwnSIdJha7Pw1TlSqma5CX60SCHoN8iRuammBIuPHLODkZWYkkDvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eh4sqniW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eh4sqniW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ITKIR/SP3MZPnGUhR4LXjkgAnNpOrsRWnH2rgnYP3QY=; b=eh4sqniWZeE3YRU+SJi9F0y7YD
	05mJTtjzX+NgbqCMm5O18Sw7waDe3W9pVUUBKaCioirTGvApWjZH8r4G1la+EFB5wFi5fHv6PLXdT
	fkih5RQnAfldrNhepI2xLlxDYzzoc9V+v8GrY4UPiwauhFtbT/BcxeMt6oXH8y0cNY8p/0uJaS0Rx
	s2ZAtsfPTTE+J+Me8AaG/g520HOB+z+CaGSf7cAY5VXpXjGcrW7D+dVxRVLSojGMpIuLzMgwrvbsF
	y/zn6jpykbQGRlvz3LKeDXk8ca9BdoD5mKMiPzM0xBdaLMnUySbaPaf2Zyf5p0S/31zd5pKfkS+Up
	K6TURICA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qTN-00000006lil-3OkO;
	Tue, 08 Sep 2026 07:42:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE6E33005AF; Tue, 08 Sep 2026 09:42:28 +0200 (CEST)
Date: Tue, 8 Sep 2026 09:42:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, oleg@redhat.com,
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org,
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, tony.luck@intel.com,
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <20260908074228.GW4120091@noisy.programming.kicks-ass.net>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907081334.1152889-6-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:31PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> pairs combined with for_each_process(), for_each_thread() and
> for_each_process_thread() loops across kernel/ with the
> for_each_*_rculock() macros, which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>   - Rename stale 'unlock:' label to 'out:' in hung_task.c (Günther Noack)
>  kernel/cpu.c             |  4 +---
>  kernel/freezer.c         |  4 +---
>  kernel/hung_task.c       | 11 ++++-------
>  kernel/locking/lockdep.c |  4 +---
>  kernel/rcu/update.c      |  4 +---
>  kernel/sched/core.c      |  3 +--
>  kernel/sched/debug.c     |  4 +---
>  kernel/trace/fgraph.c    |  8 ++------
>  kernel/unwind/deferred.c |  3 +--
>  9 files changed, 13 insertions(+), 32 deletions(-)

This is not something that can be applied.
