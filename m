Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2943A7F46;
	Tue,  8 Sep 2026 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853878; cv=none; b=J3J0M4RmZ95/qr5e6mvvTo3PLbDU9TWP7w7t0Lb89zoi1tUfYWPpgAJt5PrN84i7FZUvfcJ5525Q1U0e3wMmYmH8WkdK2RL91PYW7xQZ8cytP+fp5LUZ2PdyhNwFydQhSRpiqHu3AiOE6qdUklau/InrXR7x4PB6Y69ItH/9eAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853878; c=relaxed/simple;
	bh=WIi78645aQS+BD7vxZ1xIfq9lilvKns8uFwgNsI05M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4ihaDm4Sbaw14LtLndTX6CKfAcsT6kjWbIuBzwf6CNSJROahTFrqpuhSVcg6YnYz2qpYLLZcZF/BGvTeJ6L6KuCsWrUGu09b+018wcFLLHA/vBlI31zr59cUrKDciUy0hg8lPz+T5UJ9t3QAtICrxfvgkMcLusf7L3e3nZ+C/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCS8iecM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCS8iecM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aBoYasvQbq5xoJP4LEh5aZoFUz8WO3/k380GGIEYruU=; b=XCS8iecMLsVrAmCqTKe7ZMk0Yy
	KQ8EmhZTNCZYqR+00BfSi6kUzfw3Ant2d9tILvmlH6QQA66jwSwlhZFFm4d3dIsB5BFUzojnQeeAJ
	BibCl3DKdWBuKGJbXRsMdooxYu2aq3k6zkk07ACHbZGjLNA4KImHVfgT+aGGNtivqg5ik3W1kAjlr
	jwPFdbCZKb4LRuZdmLnFuptyiINIhXQzIIV/wodhB+Vx/Hk9BfQFLKXmjfOZQpfZRQ4N4nC68mr20
	F5/nZVlDZVQQJbsvdmg3r3kdgK9milM217siYOjpJACsBcY+2M+hmhDkV1C8A/GPuitFkQg9xuZFo
	VBGg9/mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qbp-00000006pij-1leh;
	Tue, 08 Sep 2026 07:51:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7E223005AF; Tue, 08 Sep 2026 09:51:12 +0200 (CEST)
Date: Tue, 8 Sep 2026 09:51:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <20260908075112.GX4120091@noisy.programming.kicks-ass.net>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>

On Mon, Sep 07, 2026 at 11:53:51AM -0400, Gregory Price wrote:
> On Mon, Sep 07, 2026 at 04:13:31PM +0800, Ye Liu wrote:
> > From: Ye Liu <liuye@kylinos.cn>
> > 
> > Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> > pairs combined with for_each_process(), for_each_thread() and
> > for_each_process_thread() loops across kernel/ with the
> > for_each_*_rculock() macros, which scope the RCU read lock to the
> > loop body via scoped_guard(rcu).
> > 
> > No functional change.
> > 
> > Signed-off-by: Ye Liu <liuye@kylinos.cn>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Question below
> 
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index 6fcc94ce4ca9..73a5ad3be9a8 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >  		return;
> >  
> >  	this_round_count = 0;
> > -	rcu_read_lock();
> > -	for_each_process_thread(g, t) {
> > +	for_each_process_thread_rculock(g, t) {
> >  		if (!max_count--)
> > -			goto unlock;
> > +			goto out;
> ... snip ...
> > - unlock:
> > -	rcu_read_unlock();
> > -
> > +out:
> >  	if (!this_round_count)
> >  		return;
> >  
> 
> The sunken rcu_read_lock()/unlock() + scoped_guard usage makes this goto
> at a minimum very confusing, if not actually broken.

You can use goto to exit a scope, that's fine. Using goto to enter a
scope is not (clang will error on that).

Just don't use computed goto, that goes sideways real quick.
