Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015383DB31C
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211089; cv=none; b=PfvbLYXnZLbF8FWaMZDujJ1iadG8MGwU3CI/C6iJeBrnwX6M6Vm02uEqZi5aPXOwM0iuADZoOHnq04g9uz4N6MLr9+lgvnyW3AC6/PyPwGADJ1+YUzGfoYdweFq4+F8yFWEyTacrtcJZrDSp3HeVM1RmcjpogNqSZTLngnwtqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211089; c=relaxed/simple;
	bh=jVJJDUj8+PjwISGS1w27b5BIwI/zVSAmcpFxz8EZ3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUQEJGp7MV/1Eoh+49UtRqUlbUBVYLHIbN1MrARNpx0ra0AJu7EzpiJifFGfh+Lu9JumDs7IcmHCWgD3TdQVtyuyIWc44HlwJV4LiDiQeORu8d1dggCbxLPmcnHQ8GtkNn91qS3uzZESQhPePk88f/QRerzaFN3wULmcSddOnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOvA3aIC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOvA3aIC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso1949788a91.1
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211087; x=1779815887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TwRvLveuMRBQLS2zF3jBM94tcspTaYSUuwSyp0/s0g=;
        b=eOvA3aICBNEnZTBcAZbak+PRJBfdgD2D3XNMOiJhG4Gl3W4rk+N9oPzB73AJ/XAEuf
         KhUtF2BFywojsGExcccs4wMP1XNANiMz/p6RlhLxjiAKJMvd3BYBCyvUKsaMv12Yw7/B
         0C0gozrc3j8YJpcox9Bq0Rreq6Oq8OUJu+Q2JUxoweiiDsacIqkDE5TeF1AgJ7mRYaOM
         z/H/lVccc+g0PNSIde3zqz1yBoPuu0KwKTXVL3zZP16xSQdku9m1obY4nWHpRUIzz1aS
         Eb5o9lzdIz4qP65jneAAlKUPExojIN1Hf0Fs6iJscTWpIz1VTer2djP4po4vYfmh2y4B
         V5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211087; x=1779815887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TwRvLveuMRBQLS2zF3jBM94tcspTaYSUuwSyp0/s0g=;
        b=NxFLgLOkqAoQF3RJz9FIw9iIF5xD/o+NbMG4syHLb86cxA+Iq67Z0mTFJDTh10H50K
         t5DHQgZ8wNQ2JgRGRBA47BzqaNFCDIiNX3zdDWwSNwHn4eUBnFbENc5SWaPDMydRDwxc
         PJmxzNKvdy/3IdwLriWIgmB4IKYUePfSaDb8GDrhD/WxJDMMbGUPvCMCV5IEZpLRwcvh
         9UpE0mG5mlx9fD/JN9DhKAP3wb0wT1kqLwzQa3hDinGghCuZOmTCtikBxBiDoiIEWdyP
         pOfe0+izE0+9kh+xoNtkryZK+A2YG0I2+AFJDhXObh/Y3AH87aTeo18bLW3qcBT7vF+c
         wCVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fPihl+ZULj8Qqo5XzrzjeRcU7j66WTWh8hKBPCrqZ05bVD7Q0nyx+okWUTeuSXNXlhMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydisaxyMbudgWNex31HOGXA3dVQk9bDQg0o2vrsZ68Qu3t4Tjy
	bmVB3YXTb6sYihRi7Tf/jMxUTzax8laztDoSpgsReS0n4CitdLYNwBi6
X-Gm-Gg: Acq92OF7j9epgkVIvPrRD1TklgPRsmm5Fmhv/9gSR6y/c1MQc5llOQbwjOXm6TzYWFx
	Ml2y09HPetczgnVmnw+qnLwnKcTYUm7agKUJneA0uJiztTB9bNSW6mtpquoeTxr2z2jaCyMSAHc
	bLpPiopBUgg6YbGZErwXffSVPbSBCs4q8Rn5/VnoiKIYPKt2ZLbTGhDxNs+8+rKIJ/8m86NKb3R
	mqWSm1Bk8/wEHvHbqZHtcWXVifk7wV2TdO1iXd39TzIQhxUYUoKGEZTKBmB/3//0E/7actutlNH
	iL3qsowjEAeNcOX/FRHO/4W9o8fiyK+y1LmRuYqmsqqMyNlYEtKuOY08k7s+9akj/MW8w/kubmu
	IN4QXtmtVxI2Eox0MON9SmaPPdy4daJ3UPM4Hw2pb4Sw2PGS5oH+T1dhi6nw/8ZZy8bPxb7qPez
	teeD7vXMWAB1c1mNLa5iL6PUOdvMjS13cbTwvgqryvaTl1zwo8wQ==
X-Received: by 2002:a17:90b:4c06:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-36951ca601fmr19693758a91.23.1779211087202;
        Tue, 19 May 2026 10:18:07 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:46ec:2327:9655:89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm14370012a91.0.2026.05.19.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:18:06 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v4 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Wed, 20 May 2026 01:17:29 +0800
Message-ID: <20260519171745.1551340-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up of Tejun's suggestion [1], discussed in v2 and the subsequent
review thread [2].

Patch 1 fixes exit_cpu accuracy for the hard lockup and softlockup
paths. For the RCU stall path, -1 is used as a placeholder until
patch 2 threads the cpumask.

Patch 2 upgrades panic_on_rcu_stall() and scx_rcu_cpu_stall() to
accept a cpumask of stalled CPUs, stored in scx_sched and piped
directly to scx_dump_state().

Based on sched_ext/for-next (d83f90561532).

Changes in v4:
- Store stall mask in scx_sched rather than scx_exit_info (Tejun Heo).
- Use __GFP_NOWARN for cpumask allocations in both RCU stall paths.
- Link to v3:
  https://lore.kernel.org/r/20260518131311.1170786-1-yphbchou0911@gmail.com/

Changes in v3:
- Drop patch 1 of v2 ("Normalize exit dump header to 'on CPU N'"),
  already applied to sched_ext/for-7.2.
- Replace single stalled_cpu int with const struct cpumask * in
  panic_on_rcu_stall() and scx_rcu_cpu_stall() (Paul McKenney, Tejun Heo).
- Thread cpumask through the expedited stall path (Tejun Heo).
- Falls back to cpu_none_mask on allocation failure.
- Link to v2:
  https://lore.kernel.org/r/20260504161543.674488-1-yphbchou0911@gmail.com/

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat.
- Link to v1:
  https://lore.kernel.org/r/20260501131521.161852-1-yphbchou0911@gmail.com/

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/
[2]: https://lore.kernel.org/r/af0Gn47y1Lj2BAqd@slm.duckdns.org/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Fix exit_cpu accuracy for lockup paths
  sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled
    CPUs

 include/linux/sched/ext.h   |  4 +-
 kernel/rcu/tree_exp.h       | 14 +++++--
 kernel/rcu/tree_stall.h     | 15 +++++--
 kernel/sched/ext.c          | 84 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 5 files changed, 96 insertions(+), 24 deletions(-)

-- 
2.48.1

