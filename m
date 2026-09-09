Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761457ED91;
	Wed,  9 Sep 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970105; cv=none; b=soF/vbin5Cbdy/fqcha26BqfWTFk7Qg6l8Yx4a9dOI7majbDw5mI4J151rv3N/qo5mftUhXLn5IUifNXieJ5VYi7P7P9dNrAILopwWWLVejG2sFs8EYH/cuQzC5A7Xej7l8orM+gczTfIGXc8s20tLRyTZFw+Ijszb+FpS4lgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970105; c=relaxed/simple;
	bh=48vJDYQd/DllTLq+3iIQm08kuK2MD2yf5k0t+DLfZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puKTvTJRjD0EmCX2BT9l/DbI1ovCTiRr1tTxwE9EU0DtnQaHkL4v00WPZ6Paz5K+12oGuoxQezy5ysWwHbay5vflasZ7rK6w7mHJkVjMW8Tvnca+3BSANbRR8LeKmrhTgaeI2PM0m1GWG66q1+LxKzAnqey+eJ4DvWvGDqVwz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Ew4HNQfB; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Ew4HNQfB"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C35A112023E;
	Wed,  9 Sep 2026 16:08:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id A212520028;
	Wed,  9 Sep 2026 16:07:54 +0000 (UTC)
Date: Wed, 9 Sep 2026 12:09:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ye Liu <ye.liu@linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko
 <mhocko@suse.com>, mic@digikod.net, oleg@redhat.com, david@kernel.org,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com, gnoack3000@gmail.com,
 ljs@kernel.org, sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev,
 xu.xin16@zte.com.cn, chengming.zhou@linux.dev, tony.luck@intel.com,
 reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
 lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
 babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <20260909120911.39032d13@gandalf.local.home>
In-Reply-To: <20260908074228.GW4120091@noisy.programming.kicks-ass.net>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
	<20260907081334.1152889-6-ye.liu@linux.dev>
	<20260908074228.GW4120091@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A212520028
X-Stat-Signature: 9bhr8mrf9jecgksswrur9snxt487op5c
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19AMuTGL3VW5jagbOlwR+u7MA3F7VHnB+E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/I71CIheSuIDueqiu5rSWBUTO1zgH8vNXvV3i4L+T3M=; b=Ew4HNQfBJAW3QvJxL4xhoiz9d8D5iKxdsh10iXdMiDWG2dDq7BMF05gGgIe33e3EURTU9qshCUIWRI2S0eUCvA/2rIUrCApBNkGcwACOZpOkimIjHL8b/x7tJjeaE7wl5Zs/j2u4aimfyEbEUcr1qeLykOSGUaC1FUfmTB//jiU=
X-HE-Tag: 1788970074-992515
X-HE-Meta: U2FsdGVkX1/sjgIjUTzuszHX70bniX8/y4F8byAYJr5L4Kwf+Pq6SiK2LPgzAD5EmFKiynkAadzXM3x4qLo75WXhyZS59ULjI1qQoL45xrhI1eeT5MQRMQD7bu70iZsc+CglwGOHs01oUY4ZjM52NNgq0CB+kCQa2KO+APJ8kTcl3nqnjNjAlc1JFqBxU4lZ2fyci3LxkzioFG2oL8BkseTKqCeVBDEpzStaNBdD1+0SXhinobD7JBj25O6ZQ2QRX+9EcAaF97Hp+dwm4LQdc9C3AJjaDSrgcaZVEvOum5vPIdIBDcRSXlr1hiTDhVZmnQlEKNFFcUytxpY2d+6lRgiyopEE0T/P2K/3KnRoNxkqh992zUZis1LjkJPZxbAg

On Tue, 8 Sep 2026 09:42:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> >  kernel/cpu.c             |  4 +---
> >  kernel/freezer.c         |  4 +---
> >  kernel/hung_task.c       | 11 ++++-------
> >  kernel/locking/lockdep.c |  4 +---
> >  kernel/rcu/update.c      |  4 +---
> >  kernel/sched/core.c      |  3 +--
> >  kernel/sched/debug.c     |  4 +---
> >  kernel/trace/fgraph.c    |  8 ++------
> >  kernel/unwind/deferred.c |  3 +--
> >  9 files changed, 13 insertions(+), 32 deletions(-)  
> 
> This is not something that can be applied.

I believe you mean to break it up into individual subsystems. kernel/ is
not its own subsystem, it contains many different ones.

-- Steve
