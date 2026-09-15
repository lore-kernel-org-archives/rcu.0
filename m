Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A43AE1BC;
	Tue, 15 Sep 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472591; cv=none; b=sds65VYpqeFBo0XBMUL5+EQunOzcPuDXLiD7lmMlb70agP9eEtkAMof1sZNywtWrUYU/Kd1mIE2HdKYgVsJUiPYWlljpZ6kE8mrGCNrBe2I2/NwL7KgB/ETO/HSehEkmfeUCd6OezpaTAG7G4J+fWmGPDtuWYeMbKtT7Ks5EHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472591; c=relaxed/simple;
	bh=IKfSkdVMbEES87MQd9Yw64zeGrnFupPu1TXrfukV9gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+Y50qy3EYxwtrM2kREqUtaJwomJj0Rv+nPILpTitppZeN3MzsrC4lgrWr9QAqV/2iM8cFJjQ5HJ0ljYqPqcSv74IVcUdi0xM8kdeiSWI9iDVO5Ejoz/P8l53LlS2P1hdLc6tjU55l8GBx+LxpC9CEKANDAtkUUhIHzk9UE0UFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVFklsy9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVFklsy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821AB1F000FF;
	Tue, 15 Sep 2026 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472589;
	bh=yBJZSfiMqUwy3b/qvQ6AA5k98IhpghsRD0XuyVA8J8c=;
	h=From:To:Cc:Subject:Date;
	b=FVFklsy9YDaEbBs8w9aHTIep6au/trNrV0IWGBL4EKzVLwNSV9F443XZMyHC/yDeE
	 tJFv9m8MmmpW3/243ZBAwvxQ121g/J+nF6c70/qD6dOHjOQSW6cByVSegaliodYshA
	 QVL2PMVLPpZTD7IiD5/cz+8/MU96pT7fcXMGj+53fhrYNb0AWy3hOGzZGnsNm6DNvs
	 8SlpARNHfoDvd3/4+/jY6dvU5pGEtkgbJ1a4ulNVCeBrAyLKz8aaigVWsvgdl9tKS7
	 s16veh2xK6xJqwYGzztwatbjSKdKOBS4JbjIc/WzWx8nTQjD/YvpB8xHvaZKUXGmaF
	 4QYbGWN7nw5uA==
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
Subject: [PATCH bpf-next v2 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
Date: Tue, 15 Sep 2026 04:42:33 -0700
Message-ID: <20260915114240.3269184-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
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
 kernel/bpf/helpers.c                          | 102 +++++++++
 kernel/bpf/map_in_map.c                       |   4 +
 kernel/bpf/map_iter.c                         |   6 +
 kernel/bpf/syscall.c                          |  11 +-
 kernel/bpf/verifier.c                         |  84 ++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/call_rcu.c       | 216 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/call_rcu.c  |  89 ++++++++
 .../selftests/bpf/progs/call_rcu_fail.c       | 114 +++++++++
 12 files changed, 648 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
-- 
2.53.0-Meta

