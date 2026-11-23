Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441926;
	b=pC9/nbQfjZKIJ3o9QfPuyKJsk4FdmVT5LS2Sk0if2ah8DqTcVE6whwmfadn8PFiQHKax
	 qLTJYRtLfc0lBMqRHh7DZW4LBg8c+LKZPIiMu+9E5e1xB7XVHwQiUHNft6KgSIyr0dea7
	 wUj0/i2/ZzksvCvgjTTCTD71FTVHonm7nTYVpMEOxFLv7nP91iximy24W/K9jLUqgqTAb
	 hsnKxqp2/Y+XuYPvPl8zjbnAZzPCOc0CPB1+umgpxSVRqpDLe6LGCLSYEr/yMSaJWn3zZ
	 AxMo8GvApQfj9/Xf6zNnosvygZU5wW7MGea9qovkDl5ST1MbaVkNHpjJa+sJ0+PBtRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fPiZCMrGxeemf1W8hSc1ZOEaUK9xMjW2agUNdF2P2N4=;
	b=Ieimjsev+F/ctitXOD1o25qD7IXh0uQn0G1X2ij7YrKFWxf4FsFvoNwPRcbHsa2VX4X6
	 VEN/Uj5f+gt77J8Qfd6GW3TxAj+7fYIIyxu4WNIbV9BV4Vy7pZCb3lTyjA1jwMU5cNBiu
	 mNr9TDE4vblBmEEbbuMZZ0OVtpTvJDNncMJBnClTZ2yu79P58sIH7umMsJzDDFyuFoAOv
	 SkwfyEshPHJSMZte5SB7hdFyf/iLq8RYOhUfBnUwWSAgaaHYHXZZX/WrJLqHXZayMo+Mn
	 G97EtDj1mFHgW0yDgkPtl4Zk8KUD7o2hokcar3f4xcPs4QUQlTY5iuRZzK+lM9gVgSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YlA3RwS4;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CA606A31E
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 676CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YlA3RwS4
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so32342275e9.2
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795441924; x=1796046724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPiZCMrGxeemf1W8hSc1ZOEaUK9xMjW2agUNdF2P2N4=;
        b=YlA3RwS485TQgeCI7mlHFLTVnZ9jSnnBB49zGGY0zBRocCfRvNHSSQ4w1LqiJGTQds
         /RDaM/mdGLzRNNtqc28bwP7p0/gLKKC3KhiAv7TG3ReTPTU/oqheXREH4DgoZrP46tq5
         8YRgw18ETO8+1mg1P8kmLYNsQayFLh0U5QZlEY1z5W0BKj4rhCbL+6TL7PTveXafMifx
         Rwg3hJS08BKDN8p3De+EE4f4wR60VuHSlGdivOzP41pUObkah7P3OGFOK6xO9lym55rR
         gMvE3UefUWgHRB7lNHng+PCgUCq4ADqyGm3Z/O22mCKeIz7uDMIFWvNvkWrJI1baOuLR
         hW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441924; x=1796046724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPiZCMrGxeemf1W8hSc1ZOEaUK9xMjW2agUNdF2P2N4=;
        b=Hm1o7xdcEvAJBqqGFiL+FsBZheG+ThYSNRRLbDM4bxNN1FF07LWkOYS2nhTLI70SoN
         JQHFLM0qd1dNwHLntnbay1m2KPSoxvj65MDgmOfrq3qReaD5DDk7kfoOgb0mUBsO/dNo
         rU+/GkXgTE2DHPGUJRichnchZgH0tFowE862yzXtgWkfvtu0IRWVuD87n+7tnPx7OCP/
         tSmR480KLaAow6cT0v2VeZVmG2M67tzRqbSP6x6pFwNKadl5Wgfc17XfOihiN8bUxrEi
         nnS6Hdf9sFLw6IytoDyGZbH1dY2InOcdHBd0BWjkKCzLkHYPlGWnDzKKKK31WDcnnq7H
         e/dg==
X-Forwarded-Encrypted: i=1; AL+hErE8TpQLWp8nrYxbOE2lI7k/HzouQg3cA51Wpm3eK7m9qyT73lxhtzJU7h67dJKVzc/Nwt0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CM3CJUn6Fx1VG0GsPQ8ZuVsR6w3i1yF5pq6mk+U1iiXFHIh1l
	UueO8QYCicYrEX67gZljKaFJY62LWstFbBrMbAVY399pVj92jEEaNa6SrSAuxg9IIUw=
X-Gm-Gg: AZFdTZcaK5o3Fs4oVT5tv/z7+rxprJq1+WvrLNR9zelurnEWkm0vJWN349D0Ee9vCT8
	ToYOeU7dtWW4tYE7YseUplpo6bb4eURcroM3IDgqOirK/NP98lWqoKvPqPXx9FxKjaeYxRB7I5v
	KCsIKZAH0ecaekZAERVIQqrrvHiDWVZGMa0jnUU8c8guZdvetG5O7m4vS+4B6GMoIkUDf+B3loH
	54X+yHD+NhLq1bK8AUQepCX33cFBe67FssVzLJB00OiLdWD0cuqidJTWPaPvjlGITvcU584kIO7
	0Qzix1+NhiGhlWr0D93O3sLyCM3Q9zI4ca9JexYqCui7SIcjjCb0YmMbkTZg92Snk0FFktpS492
	xglAdIRbZJwLQYXRN4k4cxtLwsg0kURyItI8jvSFeNwVD7BszeFpTyuwJpxODEp0WOqfrLwEptK
	cMJPoNF8+LuBK/QbhbIPAJmvCWhi9bFBWsUyvcq80Y/GNf+bGIYpTMd2LZOJk/BgjES32zSgsxo
	Is31SpwHVnD6mvUhsUdN45YHb61TjJtg24SubDM3dHGG5gVREXPLLTNsx9Iur7Lh7ePwIE1tP7a
	Po7CDni21P650X3+zymju93grV9aWjCep1FQprUHEO1GX08IcK7PX8vIIFCmBdwrsLLKFIRoiF7
	LLFBCT+SAI5qQO0c8gBR1iIntDVCJwQ==
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4bb887c2c98mr222234725e9.4.1795441923736;
        Mon, 23 Nov 2026 05:52:03 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f1b7800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:7800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm169279215e9.5.2026.11.23.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:03 -0800 (PST)
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
Subject: [PATCH v4 0/5] mm: multi-gen LRU: reduce memcg rotation overhead
Date: Mon, 23 Nov 2026 14:51:55 +0100
Message-ID: <20261123135200.4086519-1-max.kellermann@ionos.com>
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
v3->v4:
  - fix hlist_nulls_add_behind_last_rcu() function name in [1/5] patch
    description
  - move get_random_u32_below() back to before the spinlock is
    acquired (performance regression)
  - added VM_WARN_ON_ONCE() to [3/5] (suggested by Barry Song)

Max Kellermann (5):
  include/linux/rculist_nulls: add hlist_nulls_add_behind_last_rcu()
  mm/vmscan: move code to lru_gen_{add,del}_memcg()
  mm/mglru: cache the last memcg node, make tail insertion constant time
  mm/mglru: avoid redundant rotations of young memcgs
  mm/mglru: reschedule between memcg reclaim attempts

 include/linux/mmzone.h        |  4 ++
 include/linux/rculist_nulls.h | 36 +++++++++++++++---
 mm/vmscan.c                   | 72 ++++++++++++++++++++++++++++++++---
 3 files changed, 101 insertions(+), 11 deletions(-)

-- 
2.53.0

