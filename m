Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB2424664
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767925; cv=none; b=R+I0tKJPjVBcZKHVQAa5PBGQGkegHbR9qEzpTDSgQjmjlHwG+xoCLXvjrKQjE3XocUyinjqTviTVfZYAJRCeY3cdihOMFBuYS9uU4UPZcdPHxpO5Wtr2UpM2yEXqgiSj21+17jUW8ee5wZFIC4HuBlHi475gwMUsagK8Vw+s92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767925; c=relaxed/simple;
	bh=1mi1sSG1PVDArQh/a0HO6FvPy3+9LwKcOd0df0B8rHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvIkDfHfbEqJU2g2UwOykSnl1JjBtpu1KSOohz5jATzJilPTf7M4W9p0/arOSOV2PucKWPQRYvlzuqvGZF66rGN4IsYoQbWaGf6GidFQdAngXjgr3brBjlWg3hRDa2+OOOszR9dPZzVGfLW+or3ypifV+cKC9TCw5w3lBZvORjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqf4nY2n; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqf4nY2n"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceab75934dso31005975ad.2
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767922; x=1789372722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qxc8R48qLM7BEgjt6r51DucmEwVVWY83jnrPGmsGhs8=;
        b=Gqf4nY2nXEB1WE3T0bozlmZDtX4q03QOD04JcB9p5Ze7fIt5T9YK6928BC5UKTXmFx
         jqzeIE4QggU9Lawi1oaUxT+++roXJegPmhIS2hdrXszQNkJSZNexPPiHgCU+8Jx109ET
         Q/zGX1BMZEYd8VjDnlhbNCsmkv9pR1yQjRdYCK7Ts2IIt8WfjFC7YOXsmg+X44eM+Lkm
         UVgT5QHgQ6rLRdJPoda4lgmlWcPJKqdKbX1q2LtCs5fgcbl8dCrtqJguFJAh4DLyxjb6
         bP5EeLgs1+mJ16D7OwbX3ELp3Q7XimKcq96FZEyzpVbrXm06FLHGz4YalYJkoo4VwG9d
         q47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767922; x=1789372722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxc8R48qLM7BEgjt6r51DucmEwVVWY83jnrPGmsGhs8=;
        b=FEqPhPd/LGwn18X7iTeVy68KwsdZBRRZ6r9hXw0DnBGgRhRiCg5VIL/cj6Wq9l3uc2
         OrZ4gnpI9ANEanAj7jIMmHRnQtuBNnm5tKzD6BDgfYj3/WAP1ZVwzG184T42hI6A7ADb
         1Xyj5BI+sTwnefLK3hHfyJ7NG2gdn4ubpWbS4V+O6eI8rfcQVKaFaw9GbRW5IlWZkpkR
         sTP7dN/oDeQDoYkvylGv3TSqQR3rPgs/AKWqOjLoAXsgm9SHhBJ9UTDYZsn+19WoSKG2
         5HWzIexanvNufNUGNtBJ78ixweH0dMiV5z0jHfjMYmDC/fGwc/pmT9CNS9nF6hSjx5Zp
         9eUA==
X-Forwarded-Encrypted: i=1; AKwUvBx4rZtl2BeysqNy9N0ihPoJ+ZKqYWzbQYLPl86EUmp+KAgS4uzqTeTAsAwG2fGcQLZhPso=@vger.kernel.org
X-Gm-Message-State: AFuF++muaqSvfi+Y3nUjXxt8ObsHE3FgyF3wjY8MaQ51wgL/BvMDKcbT
	NhLKqWv6NzfWWIEhLkmFcxwrbCC8Bys8DArh61seU/ZX869oNda09guQ
X-Gm-Gg: AYBFou1tEJCmla21FzGiIIQ6sVAS7g0IejDfb6ANdzWnnt9XfoYXPOjMU17aQsVk6GV
	KiWqRj5BgOKMWNmH+EDAmEP6Ccxln0Rxk9mspwmEy5vVMXR6Qc04u/iAntxn7R/+7aDh0H74WQn
	Zlm3C2wkUYuxxH37NBHc8xrvqiGM6d5hN8Uj874TsxTO6/bXPTBzgT6y0+LlV3eE+jmkzJLGt9p
	a+yTFdXM3UOzw2y3CzxCpTxXpbsb+SbLs54vZs3ioDKwJjtffgmjltrLFLjVgvUyb0a9suIVqgG
	QbGb9KGBElY+oADsf/ESBEBAuAaud+F/NHSkZCBqrNSqHS4E0gjdXWT0iPeFPKyZ27tvTC0zHdq
	pgWfyZ6kC7E67D3t3S47a8gvQ+UcFZoO02Qs6LrW8nNX+7aB6e2Kq4helt9Zz+k6y9OH9RcOs+m
	Mi/3aN3gnCWnkAiHCRqZog1uf7EuOhwnFuyergcRVwpgVYAwJlbYseE+tJIU/BUNn6L9M6+dlnZ
	zkehQGA
X-Received: by 2002:a17:902:d587:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2db1265add0mr316562505ad.7.1788767921900;
        Mon, 07 Sep 2026 00:58:41 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:58:40 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 00/13] srcu: Round out atomic SRCU support
Date: Mon,  7 Sep 2026 15:58:16 +0800
Message-ID: <20260907075829.2073224-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

This series rounds out atomic SRCU support with a reader-free fastpath,
some atomic-context fixes, and additional test coverage.

The core change is a reader-free fastpath for synchronize_srcu_atomic().
Atomic SRCU's read-side critical sections disable preemption, so when
the summed lock and unlock counts match for both ranks,
synchronize_srcu_atomic() can end the grace period immediately, without
the index flip or the srcu_advance_state() scans.  Correctness depends
on the grace-period anchor written by srcu_gp_start() preceding the
lock-count scan; two LKMM litmus tests (patches 1-2) verify that
ordering.

The series is:

 1-2  LKMM litmus tests for the reader-free fastpath ordering.
   3  srcutree: add the reader-free fastpath.
   4  rcutorture: add --do-atomic-srcu to torture.sh.
 5-7  srcutree: honor and propagate is_atomic so atomic SRCU never
      transitions to big.
   8  srcutree: forbid srcu_expedite_current() on atomic SRCU.
   9  rcutorture: disable srcu_expedite_current() for atomic SRCU.
  10  srcutree: skip callback scheduling for atomic SRCU grace periods.
  11  srcutree: drop the srcu_barrier() sleep for atomic SRCU.
  12  srcutree: remove leftover debug pr_alert()s.
  13  srcu: restrict the non_block annotation to task context, fixing a
      KCSAN data race.

The KCSAN race in patch 13 is a data race on the interrupted task's
->non_block_count when a timer callback runs atomic-SRCU readers in
inline softirq context.

Tested with herd7 7.58 (litmus tests), torture.sh --do-atomic-srcu, and
torture.sh --do-atomic-srcu --do-kcsan (KCSAN+PROVE_LOCKING).

Kunwu Chan (13):
  litmus: Add SRCU fastpath anchor-before-scan test
  litmus: Add SRCU fastpath scan-before-anchor test
  srcutree: Add reader-free fastpath to synchronize_srcu_atomic()
  rcutorture: Add atomic-SRCU support to torture.sh
  srcutree: Honor is_atomic in check_init_srcu_struct()
  srcutree: Make init_srcu_struct_atomic() prevent transition to big
  srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
  srcutree: Forbid srcu_expedite_current() on atomic SRCU
  rcutorture: Disable srcu_expedite_current() for atomic SRCU
  srcutree: Skip callback scheduling for atomic SRCU grace periods
  srcutree: Remove srcu_barrier() sleep for atomic SRCU
  srcutree: Remove debug pr_alert()s
  srcu: Restrict atomic-SRCU non_block annotation to task context

 include/linux/srcu.h                          | 10 +-
 kernel/rcu/rcutorture.c                       |  1 +
 kernel/rcu/srcutree.c                         | 95 ++++++++++++++-----
 tools/memory-model/litmus-tests/README        | 16 ++++
 .../SRCU-fastpath-anchor-before-scan.litmus   | 56 +++++++++++
 .../SRCU-fastpath-scan-before-anchor.litmus   | 53 +++++++++++
 .../selftests/rcutorture/bin/torture.sh       | 24 +++++
 7 files changed, 229 insertions(+), 26 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
 create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-scan-before-anchor.litmus


base-commit: ef15070f96c5f07de3a9b593c36f6e83bc9e3d58
-- 
2.43.0

