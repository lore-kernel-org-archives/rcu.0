Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085000;
	b=bGVbdFxXtLm97MpcNEUHiiwPynYf/BXCfD7/sU1f6iM/Rw4bi1nWTXw2vEclCL0bn5eB
	 rD0Wp8FmAwk5Asisw16gjQnNGKAjKvt58K2xlEAX9zOTmvhG//o/v7sxhOMZ+A1sMfbc0
	 q0LqD4VZzXTV3wXSIwZr8zSxKynjU78bppN43KH8pjokYN8UjnbC4kUPqb65T2LXv6C1O
	 SFecBOWo/MU86UAQHldozmhisAxEsfsWsS1U2Hff38TY1IQz+w+44mwMyWw6sErorcKF0
	 E5HxKsexibZ3YsgXF5kC1TdOnK9VRDK2ntqXrar48B25e0FQzdxVjffaoMba5rREsAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C2zQrivhWq2xS7rGadMgkWdZZAgjXLYRNp3PSXeLbqM=;
	b=dvmK/g63GW/GAu7uyC4ze8p6T99bLeij1rmPtdw2/YXJYr9D4OmpCPgpnc8dIzI+CwKo
	 rktGBJAoaffHlj+M8TpJxzDo/53xsQ10cChfJwZ5vHbJ1jhCRLdpv64ZLTBVV7k/FweVS
	 04O+GH+ffq6W606WbGM8BzKuppE6drq6VQU3kLB+HCiRLAeHkU16pHiYIbqAGKOiNOEWk
	 ej0DXP+B/XF6uxJCUQy8Ac7OWHKXpbfkdBDFeB/UVg2NJGIa0DL0TAsgEsJ0ly+0ozcMh
	 /Houh2WpE39S0hLwntaDOTIYCFcJA2cm8b1yBySbIgD3WWaH3QJUF6opJkhCHC44F/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=egN0oQ5f;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0095606A31A
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0095606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=egN0oQ5f
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a089dfee18so377486b3a.1
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084999; x=1793689799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C2zQrivhWq2xS7rGadMgkWdZZAgjXLYRNp3PSXeLbqM=;
        b=egN0oQ5f3P4k9liFx0lazyZgm7QoUXhnN/1UbwQhc+0aUl7uD79Np68WD90AhuU7Pf
         ikWfRnV7+O/2d+wKRCzBf6BKAWUUTHKGig5HfJ8cPK39I7o6N3XuBe35K4/aJfUNOEZL
         jwxsV5kIZXUR/kiYDRA/jDloF8DEMX58jSyvA6qeOSL7EvqFFhtT9Peen1r6vJ/3UL+Y
         kkV/vPr6bg/s9/7k85fLoUc0xoPQYQNk5gwV2kg6XmonQfeeqkJByXDBRxeCiyJb/+Hj
         VkDzzEW9bisy4ZhVujcu5X/Colswjr1HrQuzEX4ZdoqY8TaCgBhIIgAXeosZFYBDG/aC
         Xhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084999; x=1793689799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C2zQrivhWq2xS7rGadMgkWdZZAgjXLYRNp3PSXeLbqM=;
        b=LznWqn43hkwIQY394edajrHQ4pCnCdvKb8en2VIzf5aFIVb2Ds2Y1cl049wfN8kbmA
         hT7ai0yjWQMAZdjVub/DCKPsxfYcgSNOXxtmMoG/aMCr/BBXkP3/gpbuIwCkMkUrvZs6
         61lxqNHUbGLJXv0UVMiTx1U01aG3StyfWbY2pSZ9rTy04WSeQ50wa2a+Hb17BF5x1TB7
         hQb2PFIcuBpFTQ80XfmsnJhz8c2BAUpIcHLdkslUEigLYsksQFkK1Dg3+5zanj2h08Cb
         shCYJsuyEPMqUc3EesrWzUZoQtuNxD2+LduaBqE8NezUInjH4FfwmVrey/2HrBy9hO0g
         dK8g==
X-Forwarded-Encrypted: i=1; AKwUvBzZEKVXtIqUycBRhYRoc8b6QvdpQiM+NHnd1W9b3Rds7f1H8Hs/Dfe+t3AjxWnyYpMunZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0ucvME4xEfcenPla9u7WLbKEeao+EOXoj8HIIHNfNFpN+MMll
	t0yzIup3kX9aPAq9thZSi45R7iPvI/hyAB+yfX3GJDESdMlm7M5UIFAR
X-Gm-Gg: AYBFou2uHTx3KeRjrgiEeAeonC0JnYOtKfwU7s+zolkZ3yC10Bqh2iv/2OCzC4DrtKk
	v6GepCDwb/j22gxTaf1XiQq5BzP1iVbour5qpbyrhyemCFV1qGknupKmz3jvJsCNADNAJqMh+Wa
	CrXfeIJ23oov8O82Lrw93htUS531bMx7K1Og944PFesxaL6q+jNfAJtJg7rNNiMhiTFFnv/xKN2
	muGXSUr23YgSuudXkoPmL3y8v9LyhZCos3TibcReyiXufG3Iq8C8f0xgzrHGXu7UlSe5FN5tK/2
	0EdBsS/2B29pNS5kON6jj9yzF2aDHUJejtaCSyMr4AHaEj7imSDNdYq3LBGaFNai97ftDrbQv4z
	DuS9SjHnXF6QSiii/3+wivGQ20QB2kTeCBZJHLt7kQvdCblPmVXNeMqrA5Q4IL2c9w48AcGEiKx
	QipAZTjANEXsE7856fsUvw6m8JQVHBifSfA5MUG3q1WlIGHWLYY/P13cgQpu2RsDGWbS2fZezOl
	cnXjHYzqcRtC2EOsPD7sXyf6CsKgVDEDxUWVH7BsuWIViCxbRrVNmYFDui8cuNu4lxLiqFf4Q==
X-Received: by 2002:a05:6a20:e290:b0:3e2:9b9e:7efb with SMTP id adf61e73a8af0-3e8eaea247fmr1321044637.50.1793084998943;
        Tue, 27 Oct 2026 00:09:58 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:09:58 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 00/10] rcu: Improve callback diagnostics and validation
Date: Tue, 27 Oct 2026 15:09:13 +0800
Message-ID: <20261027070923.3054462-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

This series improves callback diagnostics and validation across RCU,
SRCU, and RCU Tasks.

Patches 1-3 record callback registration stacks for KASAN in Tree
SRCU, Tiny SRCU, and Tiny RCU.  KASAN prints the recorded auxiliary
stack when reporting a use-after-free.

Patches 4-6 add rcu_head alignment and NULL callback-function checks.

Patches 7-10 detect duplicate callback enqueue attempts before
queueing, using the RCU head debug-object mechanism.  A duplicate
registration is rejected at entry and __ratelimit() controls the
diagnostic output group (pr_err, mem_dump_obj, dump_stack).
Detection requires CONFIG_DEBUG_OBJECTS_RCU_HEAD.

Changes since v1:
- Patches 7-9: __ratelimit() + dump_stack() instead of hard-coded limit
- Patch 10 (new): same change for Tree RCU's rcu_do_enqueue()
- Patch 9: fixed log format to avoid pseudo-function names
- Tags: Reviewed-by (4-6), Suggested-by (7-10)
- v1: https://lore.kernel.org/all/20261023101841.2910719-1-kunwu.chan@gmail.com/


Testing:
  rcutorture with KASAN (SRCU-N, SRCU-P, SRCU-T, SRCU-U, TINY01,
  TINY02, TREE03, 3min each): all exitcode 0.

  KASAN aux stack (QEMU, CONFIG_KASAN_GENERIC=y):
    Last potentially related work creation:
     kasan_save_stack+0x33/0x60
     kasan_record_aux_stack+0x8c/0xa0
     call_srcu+0xb2/0x390

  Duplicate enqueue (QEMU, CONFIG_DEBUG_OBJECTS_RCU_HEAD=y):
    call_srcu(): Duplicate call_srcu() CB ... ->cb
    dump_stack_lvl+0x47/0x60
    call_rcu_tasks_generic(): Duplicate CB for RCU Tasks, ... ->cb
    dump_stack_lvl+0x47/0x60
    rcu_do_enqueue(): Double-freed CB ... ->cb  slab kmalloc-16 ...


Kunwu Chan (10):
  srcu: Record callback registration stack for KASAN
  srcutiny: Record callback registration stack for KASAN
  rcu: Record callback registration stack for Tiny RCU
  srcu: Validate callback arguments
  rcu: Validate callback arguments in Tiny RCU
  rcu-tasks: Validate callback arguments
  srcu: Detect duplicate callback enqueue at registration
  srcutiny: Detect duplicate callback enqueue
  rcu-tasks: Detect duplicate callback enqueue
  rcu: Improve duplicate callback diagnostics

 kernel/rcu/srcutiny.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c | 36 ++++++++++++++++++++++++++++++------
 kernel/rcu/tasks.h    | 27 +++++++++++++++++++++++++++
 kernel/rcu/tiny.c     | 11 +++++++++++
 kernel/rcu/tree.c     |  9 +++++++--
 5 files changed, 109 insertions(+), 8 deletions(-)


base-commit: 940793b926aa94bf65ec404043050888e3053188
-- 
2.43.0

