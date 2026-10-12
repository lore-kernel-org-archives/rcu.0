Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A23B6360
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838509; cv=none; b=ThtJeHMATnm7xbedS0PpwOxYcXpMcA1MLFQxs8BXM5IdB4E8PISRyrmpNzwBAwABsWaIkfyw6RHWJNUR/5DXLwciP2uAVr/nVEiSfWGo8C1N4R1EECfnRH44I5v+cHUacRI/5rAcQEYvpHYjg3aBkQAPV/IHffk3O7n/ICE25rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838509; c=relaxed/simple;
	bh=x6MdrwCfK+njhs/mtkxd6db4v8mpuvG44E4rQK4adeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fv2K54bNYxvh0Jq2K0lsmqLaNIfJosaiFdrO+jlQr9IoDGrovnTR7dM8fGl2rkvDHdh7DNxGGZlr6N8XRjdqxsDHS0kC2xYZ6FkI1JDMKFaxV/Q4Dn5GN0z1112jn/slX1GbDTFPoQHO1SHsWE37RTLgdFaVN475Ya3+w2D91ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EoC1TIXu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EoC1TIXu"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2184804f8f.1
        for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791838505; x=1792443305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bb8VrY2RstmYtS1K9jrAWH7oBDyhwk1ph8H2PIO6csc=;
        b=EoC1TIXuT1KQYnCfS2EB7AcorowEReBIucrKz+gGCOoiK3l+BNUlIXan4nf5zluxFF
         lJkW3d/HHSnpsy78FHY4BnmUfXdvpKKJXIhj+aIBmYXdDgHX6ewv4eCxzkhuQ+fEZwb6
         frdZEYNOsPENerZqRV4k0Jj+h1nLJ3qUNbbYbW2ERahaFhT4MsHXDv9XSrXsN3yG3RoM
         Tse8qYir6gBx59O+cdvHjvpJKvJBSgq8nCXM+dWhfc8zWfdD1zj3JPueLR0OJ7O9swBw
         FfDm9KKR5XihU9n+FyrXJk5sVooAxmfB3tmHfESe3gI0Dkm9ZhIecoT4b8jfef6G1rkw
         ibIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838505; x=1792443305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bb8VrY2RstmYtS1K9jrAWH7oBDyhwk1ph8H2PIO6csc=;
        b=sHRtPgQ36PfRl9cX/lR1c0qiUdlJaQbgRRRD4wJnEs4yaq6vEvBpRj/LfY1RpmRry+
         OzNO+usOCd5xfr1rKAHscl2TChsX+eLYGoGiMhz22IPpkrFKZv259CPlVz9bHaAL6NVu
         dfd8FnUthfxiHlR+KOtmg7NIbvl0yO08li9OVzTWRd/o6zQvNatDguMzCF8OfIEHnCZ3
         RMBiXu/CxYRf7mj7oVG3YymKYAwe6tZ1JD3DTYc0re4Q2uunfyopLrWWf1C8dusSzcLz
         s5AfuSADUsd4EVSfZX84hCOuqm2rnX6sbJuA9F8OFFNz1CKmHoqU0/JNAbPChI6j5uIo
         Vmjg==
X-Forwarded-Encrypted: i=1; AKwUvBwkF2P9hcuuxN+5KEpmh/W+6KGypyiMFJRpByyuGRIGddwFp8QLPOg1Xl5CR/CoJiUurKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvJh3OQf7BTd1xQ85EsinRyjBy4+gyIueF/ciRzr/xmgSruU2z
	Rh7vkbukpLSNH5zSYtWtSTz+pzlkHqo9LVP3n+uh994b3LI2xGAyMzIg7uFmR99E0h4=
X-Gm-Gg: AYBFou0VxyAQQvymVAFxpS9J8eYfhqjl6nzu3LHLs3veCYUFfAqinZVM+TOCzj57HIk
	7YmWaUMEou14DpXYAjCLZ9/pf6Ab1MqPIXh1zwJM9bjcbAEqGymRCQwCSivQeaBtXKVvgAdOrvL
	+IhMy8dm63QpvXsJww5zDL6OxEfbhVsVSWl0CvXfr1cMxYGybC5+VtjWAoHt0NhCw5X/EE/CWOC
	B9wUwQ0DzykFzuz59Fs19LUZdXXMBHovPoygI32eeccAdfDlLFgUKKMdniaxG4AiDJMzfMvpFoU
	ciGc1Pxg5JIjTl96rmwFTnGvWjfokVz/BVZU/hVMKClODjTgC6gCMCRT+BPBZP4PGUt5AKSlQLD
	wuTKnBSfLwS0Qc5qm09AJj7hUIb+xZpaGtT01PvoIsvqhKL2QtMV1ivq7LIQqVBCOuG2kqBp93N
	dKrSNlX9SPC823BHbizO2ut7UxMrmO1xm6S9KEGDuxfnzSXpXn1y8tD0oTSmHaB9zqFYL+dQQXU
	pqUdcr3dUgpNCVSdOfzW1b5d3pFbA+taakvMdsp6rHe8Gw4in0ixDMsfLYXYRLHRbm9yvrfyMJh
	FXGPWy5gEg==
X-Received: by 2002:a05:6000:2907:b0:48d:c18b:d644 with SMTP id ffacd0b85a97d-48dc18bd66dmr16906977f8f.26.1791838505418;
        Mon, 12 Oct 2026 13:55:05 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm1895744f8f.0.2026.10.12.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:55:05 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 0/5] mm: multi-gen LRU: reduce memcg rotation overhead
Date: Mon, 12 Oct 2026 22:54:42 +0200
Message-ID: <20261012205447.2717801-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses excessive time spent rotating memcgs during
MGLRU reclaim on systems with a large number of memcgs.

On some servers with tens of thousands of cgroups, we had repeated
soft lockups and RCU stalls:

 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:         60-...!: (1118 ticks this GP) idle=ca74/1/0x4000000000000000 softirq=140067260/140067260 fqs=10
 rcu:         (t=2101 jiffies g=180256409 q=94266 ncpus=96)
 rcu: rcu_sched kthread starved for 2073 jiffies! g180256409 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=53
 rcu:         Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
 rcu: RCU grace-period kthread stack dump:
 task:rcu_sched       state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000010
 Call trace:
  __switch_to+0xc4/0x108 (T)
  __schedule+0x2b4/0x978
  schedule+0x2c/0xc0
  schedule_timeout+0x7c/0x110
  rcu_gp_fqs_loop+0xec/0x4e8
  rcu_gp_kthread+0x12c/0x160
  kthread+0x118/0x1e0
  ret_from_fork+0x10/0x20
 rcu: Stack dump where RCU GP kthread last ran:
 Sending NMI from CPU 60 to CPUs 53:
 NMI backtrace for cpu 53
 CPU: 53 UID: 3758108211 PID: 4052395 Comm: php-cgi8.3 Tainted: G        W    L      6.18.52-i1-ampere #1203 NONE
 Tainted: [W]=WARN, [L]=SOFTLOCKUP
 Hardware name: Supermicro ARS-110M-NR/R12SPD-A, BIOS 1.1b 10/17/2023
 pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : handle_softirqs+0xa4/0x2e8
 lr : __do_softirq+0x18/0x20
 [...]
 Call trace:
  handle_softirqs+0xa4/0x2e8 (P)
  __do_softirq+0x18/0x20
  ____do_softirq+0x14/0x28
  call_on_irq_stack+0x30/0x48
  do_softirq_own_stack+0x20/0x38
  __irq_exit_rcu+0xc0/0x100
  irq_exit_rcu+0x14/0x28
  el1_interrupt+0x3c/0x58
  el1h_64_irq_handler+0x14/0x20
  el1h_64_irq+0x6c/0x70
  lru_gen_rotate_memcg+0x210/0x280 (P)
  shrink_node+0xb14/0xcc8
  do_try_to_free_pages+0xd0/0x508
  try_to_free_pages+0x11c/0x230
  __alloc_frozen_pages_noprof+0x4f8/0xe00
  get_free_pages_noprof+0x20/0x60
  ceph_alloc_readdir_reply_buffer+0xa4/0x160
  ceph_readdir+0x248/0xeb0
  wrap_directory_iterator+0x54/0x88
  shared_ceph_readdir+0x1c/0x28

The problem was lru_gen_rotate_memcg().  Its memcg tail insertion
walked the destination bin while holding the per-node `memcg_lru.lock`
with interrupts disabled.  With so many cgroups, the lock duration
grew too long and thousands of concurrent reclaimers were contending
for the spinlock all the time.

Reclaim can also repeatedly promote memcgs that are already in the
young generation, and scans of empty or protected memcgs can bypass
the rescheduling points in page reclaim.

This patch set contains three parts:

The first 3 patches add a cache for each bin's tail to make tail
insertion constant time.

The fourth patch skips redundant YOUNG rotations when the memcg is
already in the default segment of the current young generation.

The last patch adds rescheduling points between memcg reclaim attempts
and at bin/retry boundaries to avoid potential remaining soft lockups
under extreme pressure.

I ran a micro benchmark on branch 6.18 on a 12-core Xeon 5118: 8
concurrent workers repeatedly write `1024M swappiness=0` to the root
cgroup's `memory.reclaim` for 60 seconds, against a previously
prepared set of 1500 memory cgroups.  Each worker issues its next
request when the previous one returns. The test measures request
throughput and latency under concurrent MGLRU reclaim.  All requests
returned EAGAIN, indicating that the requested reclaim target was not
met; the reported throughput counts completed reclaim attempts, not
reclaimed bytes.

Results:

                  Requests/sec  Mean latency  Maximum latency
 Unpatched               4.56     1739.85 ms       4083.55 ms
 Patches 1-3            43.42      183.53 ms        393.15 ms
 Patches 1-4            59.22      134.03 ms        393.44 ms
 Patches 1-5            57.80      137.63 ms        412.72 ms

Constant-time insertion increases request throughput by 9.5x.
Avoiding redundant YOUNG rotations adds another 36.4%.  The full patch
series improves the unpatched throughput by a factor of 12.7.

All requests returned EAGAIN.  These results measure reclaim attempts
that did not meet their requested target.

I did not measure scheduling-latency improvements of the last patch.

Max Kellermann (5):
  include/linux/rculist_nulls: add hlist_nulls_add_behind_rcu()
  mm/vmscan: move code to lru_gen_{add,del}_memcg()
  mm/mglru: cache the last memcg node, make tail insertion constant time
  mm/mglru: avoid redundant rotations of young memcgs
  mm/mglru: reschedule between memcg reclaim attempts

 include/linux/mmzone.h        |  4 ++
 include/linux/rculist_nulls.h | 36 ++++++++++++++---
 mm/vmscan.c                   | 76 ++++++++++++++++++++++++++++++-----
 3 files changed, 101 insertions(+), 15 deletions(-)

-- 
2.47.3

