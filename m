Received: from mta1.migadu.com (out-95.mta1.migadu.com [95.215.58.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471A409273
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768833; cv=none; b=uiSrfqf36fgLrK1vMWWMyUKY2D84Q3FhO5gyZ2dhGcUjhJglfbu4urqnrL5m8242Afxrp5TE0nOn9LxbUzTB0Ao0w+RMqwInBWbn4gWNhQNoCm8MlXgficf6QRYOWV2vLyzGMeMDfginKoByJrTyWaZrY+VM6r3kUdzZkG3uXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768833; c=relaxed/simple;
	bh=WPjsFkKr6FEYMnlHhMl1nDBxkpUdBFsa1ndkFSmZ/0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qAFaAfhUV3h7ZNQ9R3MLI1rYY5W+k7A5MFZJ/BilH6WaelP0KicB/UwGX6vLkQlVSJVc5Ji6qswJaZn4feJ/ukAwQixKgYa+R6sQzgo89+h7nbBHxemCh+Clj2jc31waBQbySMGgZrimJYO/JTxTKlTeuY/pmPI+wRmxDUW2SOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=crrNKirS; arc=none smtp.client-ip=95.215.58.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="crrNKirS"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WPjsFkKr6FEYMnlHhMl1nDBxkpUdBFsa1ndkFSmZ/0Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768828; v=1; x=1789373628;
 b=crrNKirSqCWRXtMKzcMLrd5Pr+KEL469evIyIDu0TuNSSltuuZgJPHpt1rJogB6oRN0/99hM
 nQnFgQYvjoiAgHCnf1L6IQynfj3mqIKlj4TLcxUCRfXwXHPGzd8tS0xRmj5V3wnp1uj3vngbMc2
 wo/yPRoS2cZswZPb4rm8udr0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2103926bec6903fd;
	Mon, 07 Sep 2026 08:13:48 +0000
X-Mizu-Trace-ID: 2103926bec6903fd
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com
Subject: [PATCH v2 0/8] sched: introduce for_each_process_rculock and for_each_thread_rculock
Date: Mon,  7 Sep 2026 16:13:26 +0800
Message-Id: <20260907081334.1152889-1-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Introduce for_each_process_rculock(), for_each_thread_rculock() and
for_each_process_thread_rculock() macros that combine the existing
iteration macros with scoped_guard(rcu), so that the RCU read lock
is automatically acquired before iteration and released when the
loop exits — including via break, goto, or return.

The rest of the series converts manual rcu_read_lock()/
rcu_read_unlock() and guard(rcu)() pairs across mm/, kernel/, fs/,
lib/ and security/ to use the new macros.

Changes since v1 [1]:
  - Rename macros from *_rcu to *_rculock, as suggested by Steven
    Rostedt and acked by Thomas Gleixner, to avoid confusion with
    existing *_rcu() list iterators that expect the caller to hold
    the RCU read lock.
  - Improve the comment on for_each_process_thread_rculock() to
    document that 'break' only exits the inner loop and 'goto' is
    needed to exit both loops (Thomas Gleixner).
  - Rename the stale 'unlock:' label to 'out:' in hung_task.c, as
    noted by Günther Noack.
  - Clarify in patch 4 that page_pgoff() is safe outside the RCU
    read-side critical section (SJ Park).
  - CC all relevant maintainers on every patch (Lorenzo Stoakes).
  - Drop the mm: prefix from patch 1, as the macros are in
    include/linux/sched/signal.h (Michal Hocko).

Patch 1 may trigger checkpatch "Macros with complex values should be
enclosed in parentheses" errors.  These are false positives — the
scoped_guard() pattern is a control-flow construct, not a multi-
statement macro, and the same idiom is used elsewhere in the kernel.

Suggested by Michal Hocko for the oom_kill path [2].

[1] https://lore.kernel.org/all/20260904083001.553587-1-ye.liu@linux.dev/
[2] https://lore.kernel.org/all/20260813092933.562028-1-ye.liu@linux.dev/

Ye Liu (8):
  sched: introduce for_each_process_rculock and for_each_thread_rculock
  mm/oom_kill: convert process/thread iterators to for_each_*_rculock
  mm/ksm: convert process iterator to for_each_process_rculock
  mm/memory-failure: convert process iterator to for_each_process_rculock
  kernel: convert process/thread iterators to for_each_*_rculock
  fs: convert process/thread iterators to for_each_*_rculock
  lib: convert process iterator to for_each_process_rculock
  security/landlock: convert thread iterator to for_each_thread_rculock

 fs/proc/base.c               |  4 +---
 fs/resctrl/rdtgroup.c        |  8 ++------
 include/linux/sched/signal.h | 25 +++++++++++++++++++++++++
 kernel/cpu.c                 |  4 +---
 kernel/freezer.c             |  4 +---
 kernel/hung_task.c           | 11 ++++-------
 kernel/locking/lockdep.c     |  4 +---
 kernel/rcu/update.c          |  4 +---
 kernel/sched/core.c          |  3 +--
 kernel/sched/debug.c         |  4 +---
 kernel/trace/fgraph.c        |  8 ++------
 kernel/unwind/deferred.c     |  3 +--
 lib/is_single_threaded.c     |  5 +----
 mm/ksm.c                     |  4 +---
 mm/memory-failure.c          | 16 ++++------------
 mm/oom_kill.c                | 20 +++++---------------
 security/landlock/tsync.c    |  8 ++------
 17 files changed, 54 insertions(+), 81 deletions(-)

Signed-off-by: Ye Liu <liuye@kylinos.cn>

--
2.25.1
