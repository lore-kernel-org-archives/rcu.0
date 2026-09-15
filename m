Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE63C1D65;
	Tue, 15 Sep 2026 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483007; cv=none; b=Lp/HdRLpVA2nwoyq3v/YYIcUES6yieLBchJaS4wq5+rCousd7ZkLUBq3NxKM1RE1eIcEgqY1EfmtAnDlgtF+E276N4XWKo0KOpakCQ2Of8IHBNFZEK4z4ixucrqdnaBlTyg8qfDbxio/4G1W1LmXWZPVrXxTMaVM8EJ19gtdSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483007; c=relaxed/simple;
	bh=bwyJyi6CfYi5E8dzVCKRC/kIx/HUd1x5lOVaz5HbkRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0DzFmu21nt9xko9z8QeQRX8D+3tKNc8X/zqTS5fAQUFAHiV13TbQWG0g59Pr2xAo83LmChP6QV6K2UP1XKrF9BWccDZ152BnUTSHtkdxGRshyvDdd3mQ9N3+sCHW3u0gLjIgj2b8fMn5RPSCUPkEWEDN72jijwa5rZMzGTQ9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea3oBm1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea3oBm1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0121F00893;
	Tue, 15 Sep 2026 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483005;
	bh=/jA1u2yP/XVG+JRqTDYsiyod65lWx6jO2/SklnCOUMU=;
	h=From:To:Cc:Subject:Date;
	b=Ea3oBm1V+tW7HE0FGlpkbByQLTRkYfHZpC9U/DayZwplrDcAeuQHrl5Fhbtlwq+YF
	 OE41IOz9MjpVYvpT0SNjpvnMZL8wSRlNhgyVK/BEIbzhw+Ooh+vH7N7V2u3XiOx4Gk
	 PV5TbMKAFe3SCKgSUE7Vbh5VTEaQ898K0EpMhmMNBTV1rvNcmjFthYDuk6/pEByNLK
	 xgJo8cRcYkOq3zD0PcBk/1NT7s4JpP/1aLt41kJFsTyVtiwLMsOwDTeI6L4b4RL0us
	 QUDtfc+GijLnCbX2IfbL/EkDbtoaK9bu//Bd3qEdbYrZUFBpuAmTAaeGhSZl1aukg7
	 OINc3PikxSvOg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH bpf-next v3 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
Date: Tue, 15 Sep 2026 07:36:34 -0700
Message-ID: <20260915143640.36292-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay@kernel.org/
Changes in v3:
- Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 to
  patch 3; patch 1 alone emitted "resolve_btfids: unresolved symbol
  bpf_call_rcu_tasks_trace" (Sashiko)
- Poll the callback counter with an acquire load (Sashiko)
- teardown: v2 only checked that the program was eventually freed, which
  passes even if nothing was ever armed.  Also assert that the chain ran,
  and read the -EPERM back through an independent .bss fd
- Use kern_sync_rcu() instead of open coding the grace-period wait
- Return -EBADF rather than -ENOENT when the calling program is going
  away, matching bpf_task_work_schedule()
- mismatch_map now pins the bpf_rcu_head label the new code emits; it
  passed with that branch removed.  Add a two_heads test, and wait for
  each grace period separately in the chain test
- Commit messages: correct the -EPERM parity claim, explain the inline
  callback state and the struct size, motivate the tasks trace flavour
v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@kernel.org/
Changes in v2:
- Rebase on bpf-next/master
- Use rcu_read_lock_dont_migrate() over open coding (Alexei)
- Improve re-arming selftest to detect failure (Sashiko)

BPF programs that manage their own objects have no way to run their own
logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
free, but returning an index to an allocator or unpinning a resource
once readers are done has no equivalent.  sched_ext's BPF library works
around this today by pushing freed nodes onto a list and having a
userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
BPF program to reclaim them; it is the first intended user.

Add:

	int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
			 int (*callback)(struct bpf_map *map, void *key,
					 void *value));

and bpf_call_rcu_tasks_trace(), same signature, which also waits for
sleepable programs.

@rh is a struct bpf_rcu_head embedded in a value of @map, so the
callback runs as callback(map, key, value) for the element it lives in
and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARRAY,
and arming holds a reference on the calling program until the callback
has run.  Patch 1 covers the lifetime rules.

This needs

  https://lore.kernel.org/all/20260810122758.183765-1-puranjay@kernel.org/

for call_rcu() and call_srcu() to be safe from the contexts a BPF
program can be called in.

Puranjay Mohan (4):
  bpf: Add bpf_call_rcu() kfunc
  selftests/bpf: Add tests for bpf_call_rcu()
  bpf: Add bpf_call_rcu_tasks_trace() kfunc
  selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()

 include/linux/bpf.h                           |  10 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/btf.c                              |   7 +
 kernel/bpf/helpers.c                          | 104 ++++++-
 kernel/bpf/map_in_map.c                       |   4 +
 kernel/bpf/map_iter.c                         |   6 +
 kernel/bpf/syscall.c                          |  11 +-
 kernel/bpf/verifier.c                         |  84 +++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/call_rcu.c       | 275 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/call_rcu.c  | 109 +++++++
 .../selftests/bpf/progs/call_rcu_fail.c       | 114 ++++++++
 12 files changed, 728 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
-- 
2.53.0-Meta

