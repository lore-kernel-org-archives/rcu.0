Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15B3B38BC;
	Wed,  9 Sep 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990414; cv=none; b=XWhDCqXpz/0q7tlvf7tVUEo1njuMrLRxAWrob9snTyzSALG7/PHvc1CRSX6M2J2CdAE6fq21snvoMpxTVef5hfIHhDQE49YTMxJljLi/ZPUJX+mUVzJcvkVzi4JT0em0rwDSA/ZFoafVkl4p/SNZHV5bf7SxUO9ASnI9mIlyQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990414; c=relaxed/simple;
	bh=ZHl08cqEOBKSJmhhtJEkeOTc5gq+R7I+L0XkKJK3IUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MheYwmTWHWy2a60SdmsoBgOF5fceKXjHYtpbCSNfCtjtxZw3PO//AMPjFGjBCV60m75e9kYYx0BvG4zN4xLOzZSNcfVxUuNboznLDJBn7+MTcGsCJBp5d3iR7mk88idExFSThpbagmtVXR2mPzALcXi6XFD0vRIgDfqIBbjltHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bfg77qhx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bfg77qhx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f6WNUc7+ccLtCGhgxedehU0mIM9y5RDc0/iE/jkmqtI=; b=Bfg77qhxtGC5hNL12v7G11D26v
	PcgN347bttFKmlJs3saw2LMy5Dm9HZ05mQKT4Vs6Ewcvz/Ja6XyCuqW7bnmza0oHiIiUquT49JFek
	UNZgChWp72DD5/QTWqEPXZg4k5HYipU+4t6dPPCfT61eCUjWZFeXAz8nBGnuzKRKqxgV9bq8rKVnl
	SYZnDvMQXYlvoeSqpnTB9MCP5IJX1mfyOWWn64+h0dEMVcs2OUCEUS2ozbF65MZw5fMy4NWQPCTds
	VIBdAjzRtxCqZHgpDwoJARhg2Nwetd3qJ2h0mCP5IVnKGjlksK8muVBthSusdvJBPwpXSeWHmYSof
	c3f14PAA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Q7m-00000001iSF-2woe;
	Wed, 09 Sep 2026 21:46:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D25F300A9A; Wed, 09 Sep 2026 23:46:33 +0200 (CEST)
Date: Wed, 9 Sep 2026 23:46:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ye Liu <ye.liu@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
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
Message-ID: <20260909214633.GN776954@noisy.programming.kicks-ass.net>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <20260908074228.GW4120091@noisy.programming.kicks-ass.net>
 <20260909120911.39032d13@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909120911.39032d13@gandalf.local.home>

On Wed, Sep 09, 2026 at 12:09:11PM -0400, Steven Rostedt wrote:
> On Tue, 8 Sep 2026 09:42:28 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >  kernel/cpu.c             |  4 +---
> > >  kernel/freezer.c         |  4 +---
> > >  kernel/hung_task.c       | 11 ++++-------
> > >  kernel/locking/lockdep.c |  4 +---
> > >  kernel/rcu/update.c      |  4 +---
> > >  kernel/sched/core.c      |  3 +--
> > >  kernel/sched/debug.c     |  4 +---
> > >  kernel/trace/fgraph.c    |  8 ++------
> > >  kernel/unwind/deferred.c |  3 +--
> > >  9 files changed, 13 insertions(+), 32 deletions(-)  
> > 
> > This is not something that can be applied.
> 
> I believe you mean to break it up into individual subsystems. kernel/ is
> not its own subsystem, it contains many different ones.

Just so.
