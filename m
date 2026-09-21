Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DF511239;
	Mon, 21 Sep 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018053; cv=none; b=TwfyzXQ+HTkoAb9BHjpDFLMujajW2GfmeK0LDpfw/TlNHCjF4bVTr7Cyho0ovd18ynBc/QoTN6AikTTyQDMuq2XQ7B6y7/GlTWJzA8QwRpw+W8CG1OjT8jmCmWzS+6k1FpqW1K45xdeok8qV1QmRDKu2jPVkTFOWmoeq9IQX2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018053; c=relaxed/simple;
	bh=C7uF4hzH+MlY7IqoBvHWbdkqBBqEiGIA85oq+nh4Ol4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRyJmZZ62HVNz68GLuhzuustAzKw82ruV9Tts8dbikPPjjJSJAfPeMeKB6Dzohjek9d7ixyk2Sl11Li3HV4OeD9j76fPWg1vyUGmYFdFLv+x/HwFY9PVU5xHk1MnoNEc56z9kinmjrjpBA+nnxPBXkWbSzIdH2CHi8NGTE0oUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOUX57yZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOUX57yZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31981F00893;
	Mon, 21 Sep 2026 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018052;
	bh=81jOZj+4d4X4V5/bgmxVSYhfYYhbUzgNRrSHGKFIaiM=;
	h=From:To:Cc:Subject:Date;
	b=SOUX57yZ79fm9/wF85SHPspjk/JWaht8/65qaCT6kkOPtgBvyX2v+qx+7szkwQcGr
	 e0c88JlrOmCPJmqsqUGif7zgXBXP432el3RBef5UU33i9xEJBQxi1oguD9wqYIpkhO
	 RXBCzgtisXzzBcuP/acQAB/TAQk/iDHBuaeBaveOJsj1SLa2YXz3yvTP4cLF6T3Zk9
	 lF4uPCKl/cpfDlsM5Tzi7r6ivLv/46e+16qJU9oUq685gIBr2xT9n1Z6cECCTRbpSz
	 IwjiFYfJBKr5EMmgWAn7U4UqocEzoNoOOwCHROYQKBU2RONzdazx87iURCblvciDJW
	 9F8j9BPHItxqw==
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
Subject: [PATCH bpf-next v5 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
Date: Mon, 21 Sep 2026 12:14:01 -0700
Message-ID: <20260921191407.1742386-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay@kernel.org/
Changes in v5:
- Rename the "hash_map" subtest to "bad_map" so that it matches its
  helper test_call_rcu_bad_map() (bpf-ci)
- Bump the callback counter after chain_err in the selftest callback.
  Userspace polls that counter and then reads chain_err, so it could
  still see the initial value before the re-arm had stored one, which
  let the chain subtest's assertion pass without checking anything
- Say in patch 1 why embedding struct rcu_head in a uapi struct is
  acceptable here (Mykyta, Paul, Alexei)
- Rebase on bpf-next/master
v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@kernel.org/
Changes in v4:
- Drop an unrelated hunk in bpf_async_update_prog_callback() that turned
  PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq path
  and bpf_prog_inc_not_zero() returns -ENOENT, so it would have changed
  the errno bpf_timer_set_callback() and bpf_wq_set_callback() report to
  userspace (Sashiko).  No other changes from v3
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
 kernel/bpf/helpers.c                          | 102 +++++++
 kernel/bpf/map_in_map.c                       |   4 +
 kernel/bpf/map_iter.c                         |   6 +
 kernel/bpf/syscall.c                          |  11 +-
 kernel/bpf/verifier.c                         |  84 +++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/call_rcu.c       | 275 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/call_rcu.c  | 110 +++++++
 .../selftests/bpf/progs/call_rcu_fail.c       | 114 ++++++++
 12 files changed, 728 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c


base-commit: 15972a29ac91dbbf4d33246962b7fcc7b1dea7ed
-- 
2.53.0-Meta

