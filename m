Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6C44604E
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113501; cv=none; b=p3pMtEx0dmTFpgKPD3EIOBo3Nir3rKgkTl72WhHZX/w6XT4lANB117rLq7/ROo9OCm1LA4xndTXiXE+ecEcJWiKHr2NIkXLVcri733GgJSetQMPhaTtDKpEf8l7dJ2h4Vm+YpiHN6tt+XgIlVDzQFTXFOAhM+WV8Ll0ll1aPQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113501; c=relaxed/simple;
	bh=2z6K28VZFghAvaOC2rxcV8P37YjNcXnY9WqrSWMHQ/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HyQhLPFIw4L5kuV8gwz0gyWTp96o+Y+qKhV4uxdm+TDdyiY+J+JJzj0rRiPfHZQcjCijcxb8CQebHe2Hgp3HX/NBaCpJSQifMveJqbmBjYKs63sQsfxM59/dePUl6ErrFaJuuDQymMQFoKIneTmnYSkZjdlgE0nou7jGOzJFWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=czgAtOF3; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="czgAtOF3"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2z6K28VZFghAvaOC2rxcV8P37YjNcXnY9WqrSWMHQ/k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113497; v=1; x=1789718297;
 b=czgAtOF3JlWxuaKbHd6nJn+3vEEx++yytKytXfhgizpNlKXoBu0iIPbhZbr1uCfHrYUvkPQD
 pkP6XMVK5eXLDp8cDD9X27POKFZ1M6XVUvSlRcXc7oWwe48CfuZxUSc6jmc7O3rXoKS75h0w7Ex
 c/9gvUSCt+YiV0IBUdtl2XfQ=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 08c4df989fc31bb8;
	Fri, 11 Sep 2026 07:58:16 +0000
X-Mizu-Trace-ID: 08c4df989fc31bb8
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
	Gregory Price <gourry@gourry.net>,
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
Subject: [PATCH v3 00/15] sched: introduce for_each_process_rculock and for_each_thread_rculock
Date: Fri, 11 Sep 2026 15:57:45 +0800
Message-Id: <20260911075800.491472-1-ye.liu@linux.dev>
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

Suggested by Michal Hocko for the oom_kill path [2].

Signed-off-by: Ye Liu <liuye@kylinos.cn>

---
Changes since v2 [3]:
  - Split the kernel/ patch into per-subsystem patches, as the
    combined patch could not be applied (Peter Zijlstra, Steven
    Rostedt).
  - Move changelog below the --- separator so it is excluded from
    the commit message (Lorenzo Stoakes).
  - Indent loop body in macro definitions to show scoped_guard
    scope (Lorenzo Stoakes).

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

[1] https://lore.kernel.org/all/20260904083001.553587-1-ye.liu@linux.dev/
[2] https://lore.kernel.org/all/20260813092933.562028-1-ye.liu@linux.dev/
[3] https://lore.kernel.org/all/20260907081334.1152889-1-ye.liu@linux.dev/

Ye Liu (15):
  sched: introduce for_each_process_rculock and for_each_thread_rculock
  mm/oom_kill: convert process/thread iterators to for_each_*_rculock
  mm/ksm: convert process iterator to for_each_process_rculock
  mm/memory-failure: convert process iterator to for_each_process_rculock
  cpu/hotplug: convert thread iterator to for_each_thread_rculock
  freezer: convert thread iterator to for_each_thread_rculock
  hung_task: convert process/thread iterators to for_each_*_rculock
  locking/lockdep: convert process/thread iterators to for_each_*_rculock
  rcu: convert process/thread iterator to for_each_process_thread_rculock
  sched: convert process/thread iterators to for_each_*_rculock
  tracing/fgraph: convert process/thread iterator to for_each_process_thread_rculock
  unwind: convert process/thread iterator to for_each_process_thread_rculock
  fs: convert process/thread iterators to for_each_*_rculock
  lib: convert process iterator to for_each_process_rculock
  security/landlock: convert thread iterator to for_each_thread_rculock

 fs/proc/base.c               |  4 +---
 fs/resctrl/rdtgroup.c        |  8 ++------
 include/linux/sched/signal.h | 26 ++++++++++++++++++++++++++
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
 17 files changed, 55 insertions(+), 81 deletions(-)

--
2.25.1
