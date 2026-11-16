Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816857;
	b=Sdf/uIH9TFkptidnm5yMX1hpsz8bjynskPWaSMBLHdHQd9NRU0N2PIdtxlYFzPKLPMjH
	 LnTH4TvtAmdwo0oFKlhn8Fgwb2RFapzLeERVYcqbNFszyivMSmKF5U7Vo5ahm+ChVAq5q
	 vIXDhWwqbKDi0EUH3EGh8ek5N/myOh0R1MtF5J5D+xzTHqsLchaBYtkyw+rW2F3eW6Feh
	 DzO4ngwNrpU6jzl6JEEX2qXn7Z/wq1QuimqKdVTM8AQa7Dnn13eWr1e/ftyID2buE8vGR
	 44zsA7205KwpwiQ9KMgRReTrB2UjRQ05o1HDHTRssLFLlyLHebS8XbgaMTXm76Zf1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AnqFXuidLiaxByYIxjVtd9KzsEjAj9vwLIHGSb6bKLs=;
	b=T31gZC7hrlnsWGQucxUW5KLDmKkZhiWlyG+KBf3Pfxyc/831fBb1AHx6ghA3tJfFHrqg
	 gvEUBvyA/XJE0PMXO9u6IAnVKzEABucyZkeq4B4fh4RUrbOXyEdGMc8hHipU8JeDG+bRT
	 9QlrC3VOt9I0gMDA8ctQXpZx22K4iwQQt11uO2NQBOyLo4b2bKM/3E0nh9TYFvQqzWvWu
	 PvOSVKDQgXBc1VUQG6P0q0cd7EsBZ+/NSTuK6slrYIN0pzpUFPwktJn/eAjW0a1kfexzx
	 53HuP5f6WDHLkaVusylkFNf8M3d9VeRQOi40ZjuMz5mats4H6JZQeKKFYho9xJwUIlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=DMKWOee9;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6C606A33F
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF6C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=DMKWOee9
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490d59c3edaso1803071f8f.1
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816853; x=1795421653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AnqFXuidLiaxByYIxjVtd9KzsEjAj9vwLIHGSb6bKLs=;
        b=DMKWOee9hTNEpjHlQhK01VGdAJzP0AppU2FmVxqsOzEOTSdpZe3TsYpEIynJgdD+gj
         0OgEU47fdVaM5t/L+z1Ys5N6ROnUeHMKehhy6FizHRc8jjUq1+gNJ7WLDBfwe7k7CEwJ
         eLnAVU2bl6zcWVIrBNQ7IHYIJu9Lfuj9684OqmscKf/wz+c8dIHtEjWhbRn5mShnR6He
         Mb1KXgHmpEyxqdm4ZoS3/XuZgqbCnMWFYiDCQuTovhhTkwkc37g5eOnA0oRukxATPmu9
         6b1S72DpTi3pctbbHaGkatd1SMFCOY2rbcqlyvcDc2Lt0APoYByTdoFba9CxMEtIWZEy
         16xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816853; x=1795421653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnqFXuidLiaxByYIxjVtd9KzsEjAj9vwLIHGSb6bKLs=;
        b=zB+Pnx91D+d5eQ1WAPksc/cBpqURc3chL54Vrqjh3S+b/19GhloRxaN1/uuyg6pqus
         wzonukPj3pYZyRbW23t+ZVkgLrz4Q4BoHvMs8lTxB5sH5QvbG+1+D+fV1YUp0nxy50dy
         9dx7XVU7Oy41a4UcFxYVT3cdFIYh2LgUblRFvuabMqfcB2lzenTogVT1RaSZiI+CvM43
         Ha43R96OBUCoibY2MQlB/vuIh081FXtvG7I6uj6TvkRaSjSS2x0mj8xmnM2CKeoVS6FT
         aODGpYkQ2N0Bdq2XYz/nPw3GnU+fQU9ZvJlH29ptncQQcSPGkD0yNe9TGDly04hQGvEG
         6L4A==
X-Forwarded-Encrypted: i=1; AL+hErEu5Z1va3iiBlPQ+3W/Pc69A/c9HQmj0qwdZ1klvFbEnu444U7BC3QIxeqC7Xxnm3fMtHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z84SuMvAxlvFLEG1YrBUqL5uDL2OrjShj5t31vvB1AE+x24EFpA
	aGfr9wow8iGmNC8V3HLZbEIVCVd2symz8pTG/bBAknaBOK9OPn9hge7KSQhnABMl9PA=
X-Gm-Gg: AZFdTZdLA5vH8rIeBZNby+1G5Y2jLKC8YGbF1LVhC3clIOhiocktEngEFrrZI6jCLeh
	3qry0y0zsFkArWzm7Hj5xQWTJxZ+zjGk8P/8n1gtSQdu5dhm82ADJPSRXem6OlgBMQ7KLoxnRHW
	swmLIfbOqrl4xlwFmdZ3Wl+2l5CCfI3D8N+n19NHJEOELs/kHU4h7wABXGGLfNWVROR8qUzRbh4
	8WwLf3o8rJdxdVFzn7iOAI+yflFqAp6R9kwm2OIlHiKVNMkYFze7RMKrEnDoh6DwwckiQNIZywl
	x39WRUnjT7krTOfAnSk1v8FehjXnBKkRulI2n4tNRQtMtT6W9lfaw86/GCRjhl2gkY3nviGY/lP
	WP/iaMEO9LFCL1b6KO1VX9UzpwrRenxFVk/rftitaj+lrm0QG/tNYN7L6d9lEnYqxD5JeYIIn2g
	dedwIU6SIqyRJqRH5KVr7252XtFxbnunRrDiLYw1k5NpfHrCi4AkWiun3ddRy4RGRB8gbIDEFuW
	F+x74ocqkPWiOdc/ozyqn/+c+t2g0PGKrqzLUsqxN0zjC5L9sr5m5ihdVwNwAm28pXneImoIjiW
	7EBq4BsKecQYb4Wdgx+h31aBDto4wFKm4aKSGO4CT8UyR0fHVGbUmvRsNHI7PtDA97jN3WpqKuK
	Ff9adMv5T4XO8DPpV2NcPY8T92ooH2C364V4dVRopU0LBtTm+JQ==
X-Received: by 2002:a5d:5e07:0:b0:49b:b94c:e8e8 with SMTP id ffacd0b85a97d-49bb94ce98amr26317536f8f.8.1794816853264;
        Mon, 16 Nov 2026 00:14:13 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm22902289f8f.11.2026.11.16.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:14:12 -0800 (PST)
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
Subject: [PATCH v3 0/5] mm: multi-gen LRU: reduce memcg rotation overhead
Date: Mon, 16 Nov 2026 09:13:58 +0100
Message-ID: <20261116081403.216452-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
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

This series is very similar to an earlier patch by Chen Ridong which I
was not aware of at the time of writing:

 https://lore.kernel.org/all/20251119083722.1365680-1-chenridong@huaweicloud.com/
---
v1->v2: rebase after MEMCG_LRU_HEAD was removed by d5d1712c5928
  ("memcg: remove lru_gen_soft_reclaim()")
v2->v3:
  - rebase on mm-new (MEMCG_LRU_OLD removed, too)
  - mention Chen Ridong's earlier patch
  - defer the get_random_u32_below() call until it's really needed
    (suggested by Barry Song)
  - rename hlist_nulls_add_behind_rcu() to
    hlist_nulls_add_behind_last_rcu() to avoid confusion about the
    function semantics

Max Kellermann (5):
  include/linux/rculist_nulls: add hlist_nulls_add_behind_rcu()
  mm/vmscan: move code to lru_gen_{add,del}_memcg()
  mm/mglru: cache the last memcg node, make tail insertion constant time
  mm/mglru: avoid redundant rotations of young memcgs
  mm/mglru: reschedule between memcg reclaim attempts

 include/linux/mmzone.h        |  4 ++
 include/linux/rculist_nulls.h | 36 +++++++++++++++---
 mm/vmscan.c                   | 71 ++++++++++++++++++++++++++++++++---
 3 files changed, 99 insertions(+), 12 deletions(-)

-- 
2.53.0

