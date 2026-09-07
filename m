Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88040911B;
	Mon,  7 Sep 2026 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788765; cv=none; b=cxuEm3lqHaFrVkQxq78HdXujtlFzvb2vT4srb72BVC3xrJx1Z6TS82lrZrSzeqODzS3bqQx4v2XcW5Rv7vKdT+TWwljpkhWGKjka5PwTZ+19Rmr5vmpDI4Dw0vZr3tvpCIW5zi4GV148ZUxvuMuyN1E1RVlzkTkRyzE9ydWf7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788765; c=relaxed/simple;
	bh=nSuMdgmBwloQI31EU0RD/YFKRdL9V3Nl1kng3CrloWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+qwAI0Ft6IQjxCXHzW4bgxDwGZf4A8SstrD5IdPHl1KZ7ZBQT7L1ja5yBS2h1QGEtq1GnDiUxBfYZAeZLHwim6oi5RSnqedlRBVIHHIivVUnX3slf0m/5R3ecZCWB1TWEP7ckW28LbRMVOUb3uiJ24wS2o7W4ZTUwrUcZkrsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1ypcO95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1ypcO95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1D91F00A3D;
	Mon,  7 Sep 2026 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788788758;
	bh=RE4FQ58Xnrvw1EluWyJMlXRPk3pW+o4WrdUEe448vbk=;
	h=From:To:Cc:Subject:Date;
	b=Q1ypcO95/imOVd9j5B76HrWnrtdgc9m/hqEjPtM5dBx+f0FzsNApgmDJ1ZwN9dDaV
	 12tsOKELeUqz9kd4Gl6NfmfCRVd/nicE7D9jxyCeKVjWYY64TX61gM5X1ciWOTV9+F
	 /75m3ktpeATUG16TmP6s6DuBNTIB66pDMRGowtticq57/qspVxpCeuaaozopVnnJ6V
	 SIC7Hh+k6fD0Joy0rbaAdh24AsxukHzyElW1UpbtDlcF5wY1xsRpYOsMpOeRx26qNZ
	 eizMrYX9mdnyyK5kusQBRFNg+OqbZrwnWqUgFbSf9cCT9n94eRXVpkJRwKXOfJzipI
	 FytG7wX2gAjMA==
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
Subject: [PATCH bpf-next 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
Date: Mon,  7 Sep 2026 06:45:47 -0700
Message-ID: <20260907134552.1772405-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 include/linux/bpf.h                           |   9 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/btf.c                              |   7 +
 kernel/bpf/helpers.c                          | 104 ++++++++++
 kernel/bpf/map_in_map.c                       |   4 +
 kernel/bpf/map_iter.c                         |   6 +
 kernel/bpf/syscall.c                          |  11 +-
 kernel/bpf/verifier.c                         |  86 +++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/call_rcu.c       | 191 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/call_rcu.c  |  89 ++++++++
 .../selftests/bpf/progs/call_rcu_fail.c       | 114 +++++++++++
 12 files changed, 626 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c


base-commit: 1b7415bf70be95b9a1e7e87d544867881065613f
-- 
2.53.0-Meta

