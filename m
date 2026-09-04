Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596913E639E
	for <rcu@vger.kernel.org>; Fri,  4 Sep 2026 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510623; cv=none; b=op8Rc0LHHrYK+sWbUZW219Npc1cIsJuA4hMpl+goIYearImJDXqt/ThCJ+OWAiw8puFNGLSe/Zuhi6+tsOGapmlPfkj+SJEYUcTMLQ4ggaNL/6vaYurp2NEO/pD20c26jA8BSirOblEaWWKADhRcF4RyG5I/NoinQwCXgqB+GrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510623; c=relaxed/simple;
	bh=L8pOajLjq6OOGJ6hOdj/9J4YnLULNmgvV3Ddj6iBbVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u5vHbzqKKeux3UAVYpBH7skkX/W0XlE4sdgubhPQoGoI2eu8fKGFhHTflUefibDVk+e7l2gTlpwKCDFSvLkP/6xljIWBb/AaARbQV/Pw1WelRvVsMuk4wR+ycCCQnALCWNfIaWdJPxIRMD/2meUqVb1pp4EvTz1rxG2yf9MLiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SwyJQPQ/; arc=none smtp.client-ip=91.218.175.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SwyJQPQ/"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L8pOajLjq6OOGJ6hOdj/9J4YnLULNmgvV3Ddj6iBbVU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788510619; v=1; x=1789115419;
 b=SwyJQPQ/JsqB0G+VQvAHfhOqVMDhSiAIC4wNpuayZfNUeVrLxXBB47YPlyrxfXF8weTMjmWD
 zMtG0x5ODFmBJzGTVqVb61iOkElSJupyRY8r1iV16nqYAs4x+/s4D9BsqoaCZ/mEJaMkYbOwXPG
 MHZyIm6+6Ci6OKgaWZX8Yb0g=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c4aafd7d2505d2d3;
	Fri, 04 Sep 2026 08:30:11 +0000
X-Mizu-Trace-ID: c4aafd7d2505d2d3
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Ye Liu <liuye@kylinos.cn>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH 0/8] mm: introduce for_each_process_rcu and for_each_thread_rcu
Date: Fri,  4 Sep 2026 16:29:52 +0800
Message-Id: <20260904083001.553587-1-ye.liu@linux.dev>
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

Introduce for_each_process_rcu(), for_each_thread_rcu() and
for_each_process_thread_rcu() macros that combine the existing
iteration macros with scoped_guard(rcu), so that the RCU read lock
is automatically acquired before iteration and released when the
loop exits — including via break, goto, or return.

The rest of the series converts manual rcu_read_lock()/
rcu_read_unlock() and guard(rcu)() pairs across mm/, kernel/, fs/,
lib/ and security/ to use the new macros.

Patch 1 may trigger checkpatch "Macros with complex values should be
enclosed in parentheses" errors.  These are false positives — the
scoped_guard() pattern is a control-flow construct, not a multi-
statement macro, and the same idiom is used elsewhere in the kernel.

Suggested by Michal Hocko for the oom_kill path [1].

[1] https://lore.kernel.org/all/20260813092933.562028-1-ye.liu@linux.dev/

Ye Liu (8):
  mm: introduce for_each_process_rcu and for_each_thread_rcu
  mm/oom_kill: convert process/thread iterators to for_each_*_rcu
  mm/ksm: convert process iterator to for_each_process_rcu
  mm/memory-failure: convert process iterator to for_each_process_rcu
  kernel: convert process/thread iterators to for_each_*_rcu
  fs: convert process/thread iterators to for_each_*_rcu
  lib: convert process iterator to for_each_process_rcu
  security/landlock: convert thread iterator to for_each_thread_rcu

 fs/proc/base.c               |  4 +---
 fs/resctrl/rdtgroup.c        |  8 ++------
 include/linux/sched/signal.h | 19 +++++++++++++++++++
 kernel/cpu.c                 |  4 +---
 kernel/freezer.c             |  4 +---
 kernel/hung_task.c           |  7 ++-----
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
 17 files changed, 46 insertions(+), 79 deletions(-)

Signed-off-by: Ye Liu <liuye@kylinos.cn>

--
2.25.1
