Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239643B6CB;
	Mon,  7 Sep 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769582; cv=none; b=j+q+ZC2WFBN7pRVRbIm5ByyJec80qZd+HZrtmXHZIVwBUhwNPCaAGlJeIsuWsni2WuVfLCEISsns1hLnZQQd38H3l0aW5nTjnLTJ+zwAD87jrvxDf+oXiIfB0dqE5G6RaF2lmH/JTQmLNP7jibt7K5xWawGZ3Wi6ZUbrdIp5qy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769582; c=relaxed/simple;
	bh=IHCWs2FUWv6nktxmFOR7SAAPl1K6uOgWaXIqrlKgYWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYS62WdGHqV6WI6PX0K0qT23WzLNgRSZNTpA/XoVHgG0iIYMe/rtMco0fTBoUk8se4VDQAOEdNAUw8ESJllblBJCY32aOAUWqAAEfDVBUkgro2MsLlkZLLqIpGr4CqyjYkR2VBOV0nCGBKg04O2Ylh0bKu6rApvN4916j80vtW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICur1IhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICur1IhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1701F00A3D;
	Mon,  7 Sep 2026 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769580;
	bh=aO6wg0mymQg3x/3sbOQTgRafHt9X06kvzyNxg3k6Uj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ICur1IhMUSpSE6fcJQklY1JjVK0yR4xNQ89iJLicxz+OgQqZ/38m/VMenPeE9Fgjh
	 3zZp4CFJQSZEmg7Cbb3c8Gmr4KKJmPxbjlJ6S91dcleSo3lhxvHVr2q/52m4SVe1hN
	 V0YoGoCpoceNgZJ2iM4e1quy1vUZ3U9jOJIeZ7ws+u8AoiCy33KtG7j7l7erQjRCGh
	 XK/Y37JnMPpsax/4NRvrf6fB7S0+P8MMYA913T2RiBV2xDxmXPXAT24GsFvLbVTay+
	 XQn4yY4wu+PpYTh+CR6uz+68WNVDgYiBNWJ9aW3Mw0l0R7jcdt6C+0lvjItoYHKsB2
	 CXBW4FIWwsdSw==
Date: Mon, 7 Sep 2026 09:26:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Oleg Nesterov <oleg@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ye Liu <liuye@kylinos.cn>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	SJ Park <sj@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, 
	boqun@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com
Subject: Re: [PATCH v2 0/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap5yw-Cwb41FymNd@gremlin>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907081334.1152889-1-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:26PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that combine the existing
> iteration macros with scoped_guard(rcu), so that the RCU read lock
> is automatically acquired before iteration and released when the
> loop exits — including via break, goto, or return.
>
> The rest of the series converts manual rcu_read_lock()/
> rcu_read_unlock() and guard(rcu)() pairs across mm/, kernel/, fs/,
> lib/ and security/ to use the new macros.
>

Andrew - just a note (assuming Ye Liu is in agreement) I think all of the
below should be excluded from the cover letter that goes into the commit
message, including the checkpatch thing.

> Changes since v1 [1]:
>   - Rename macros from *_rcu to *_rculock, as suggested by Steven
>     Rostedt and acked by Thomas Gleixner, to avoid confusion with
>     existing *_rcu() list iterators that expect the caller to hold
>     the RCU read lock.
>   - Improve the comment on for_each_process_thread_rculock() to
>     document that 'break' only exits the inner loop and 'goto' is
>     needed to exit both loops (Thomas Gleixner).
>   - Rename the stale 'unlock:' label to 'out:' in hung_task.c, as
>     noted by Günther Noack.
>   - Clarify in patch 4 that page_pgoff() is safe outside the RCU
>     read-side critical section (SJ Park).
>   - CC all relevant maintainers on every patch (Lorenzo Stoakes).
>   - Drop the mm: prefix from patch 1, as the macros are in
>     include/linux/sched/signal.h (Michal Hocko).
>
> Patch 1 may trigger checkpatch "Macros with complex values should be
> enclosed in parentheses" errors.  These are false positives — the
> scoped_guard() pattern is a control-flow construct, not a multi-
> statement macro, and the same idiom is used elsewhere in the kernel.

While it's useful as a note to reviewers, in general checkpatch is taken
with a pinch of salt - it's a master of false positives so usually no need
to say this :)

>
> Suggested by Michal Hocko for the oom_kill path [2].
>
> [1] https://lore.kernel.org/all/20260904083001.553587-1-ye.liu@linux.dev/
> [2] https://lore.kernel.org/all/20260813092933.562028-1-ye.liu@linux.dev/
>
> Ye Liu (8):
>   sched: introduce for_each_process_rculock and for_each_thread_rculock
>   mm/oom_kill: convert process/thread iterators to for_each_*_rculock
>   mm/ksm: convert process iterator to for_each_process_rculock
>   mm/memory-failure: convert process iterator to for_each_process_rculock
>   kernel: convert process/thread iterators to for_each_*_rculock
>   fs: convert process/thread iterators to for_each_*_rculock
>   lib: convert process iterator to for_each_process_rculock
>   security/landlock: convert thread iterator to for_each_thread_rculock
>
>  fs/proc/base.c               |  4 +---
>  fs/resctrl/rdtgroup.c        |  8 ++------
>  include/linux/sched/signal.h | 25 +++++++++++++++++++++++++
>  kernel/cpu.c                 |  4 +---
>  kernel/freezer.c             |  4 +---
>  kernel/hung_task.c           | 11 ++++-------
>  kernel/locking/lockdep.c     |  4 +---
>  kernel/rcu/update.c          |  4 +---
>  kernel/sched/core.c          |  3 +--
>  kernel/sched/debug.c         |  4 +---
>  kernel/trace/fgraph.c        |  8 ++------
>  kernel/unwind/deferred.c     |  3 +--
>  lib/is_single_threaded.c     |  5 +----
>  mm/ksm.c                     |  4 +---
>  mm/memory-failure.c          | 16 ++++------------
>  mm/oom_kill.c                | 20 +++++---------------
>  security/landlock/tsync.c    |  8 ++------
>  17 files changed, 54 insertions(+), 81 deletions(-)
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>
> --
> 2.25.1

--
Cheers, Lorenzo
