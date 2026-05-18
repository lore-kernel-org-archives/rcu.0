Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355831F983
	for <rcu@vger.kernel.org>; Mon, 18 May 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110010; cv=none; b=cLeL33X+UWoQcmLotsHhlAmSnb9FX1nKx/glFoo6oYfrqXrTZW3y8pZoRUKeHitoMcP5L4LFo5T4QyW7C1XptHcBlU/G4C7+crgsCbtt+La2pAQfB2Ym2EhCBvlCnYgvrryEAm1aED4BDwP8jTOdK7qPeOHe3jx14TDnCXUqvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110010; c=relaxed/simple;
	bh=GiEkZMkm2x4I0jKruTe/O1TNuhy40/QVV6JTo4QA6sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJJV+CWym/mWNgejI0FV009OY5lkKyAdRzlFIJ7UO/upN7DRtIHMAO3GExFetEwEoDSXajB7xDh8T7EJTN5/J6eM7qdno0kb6KcPAUgBhaqNu5FScePg8lFifjozDTowMfB3407n5WrVb+wUDpYn0qoYfFWa1ZFBSn5B/BrPkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXpAPYlq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXpAPYlq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so1302518a91.1
        for <rcu@vger.kernel.org>; Mon, 18 May 2026 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110008; x=1779714808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16E2PQZmiE6IrGqbWtSpGp/RWymtbpDf21NqZrAM3es=;
        b=sXpAPYlqmJiN6365OrnX6hGX2uOnRqDKZTLMRK2VMYnvwoDEgTCXZZ0IS8xcYZg5Vb
         UufY0ue2JgQqfecAgqekLC3O2QMU1505EOnIDv7Z0TTIM9Eh+EVKyrgntJe5WkD2E7M5
         sal2ekSWDOSHzgcVtNc6f917ti8eENozHD6VgVKHcNdFZ0skKjJ8jrbGjmtDau2kV+tk
         wZ0uwKuDT4kdWrjWevnPQjFtMjJ0FqpCFFzj0ojeSaSVaPONR9m03yYEAe2eoNB5XCJ9
         da5Sx2epN2Fs48KORWWDY0q0QErAdlvGSHKdTNb5jBA8eO09+hpOm/MitjKBfi6mcr5R
         TDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110008; x=1779714808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16E2PQZmiE6IrGqbWtSpGp/RWymtbpDf21NqZrAM3es=;
        b=o8GNAHsExZwwRJrmVDbRRCn8OJjY/dnR1uJS1DK1hcvGK6YOJViQPwFtVQEQ8R/8hu
         6/6sXntSOAuBkAGrwAZX03Yb9A/NSwL7YUsqFROhbeVzzHcz/PLvgo5C9x/ONxVOeKiJ
         4M+Fig30v/JMs3doc0FBz4wp6WaDxFh+dJvdB/71nELHVwQwDM2tHFHYRD1vzOt/X5km
         9Z9TQ09maI1KPUTu7Gf/p5oRlUrkGX48fWcZ9oIobJempdUEb2Tg5jj5EKvo4UaTlqXm
         jprvZj3BQ+/AO81krjuVXrQhhRKUEC/FyU+xzkI/yM2WYZbISuYKdZmHSt8EshypZUeE
         nzYA==
X-Forwarded-Encrypted: i=1; AFNElJ/bzoHDN52YISB2ptGbxGectgtpCqxTCwh+/WDYcchYrRIdm31kfhGhn05CYgpGFPqsKLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQl6Jss7ZPoBRk/o610qY4ziq0x1leRqnY/a98GGLsE/Fg8Yr
	52bEmKjQFx/ivdZdILlAUoSnbcgsbymU1aOPUXiTL/4VWZfk/gy0DjDo
X-Gm-Gg: Acq92OHy+aazB5ZNNmDTWboy7paBaRfR1voW38rCclYcvhC8YcozLD0zjqnb7oi9WYR
	n7AVwz66t5N0jtAta2t0aSDfzxj5WE0KmR/DfaQYJPIIWyIlJwZE/WKGJjxzYAUVi8VdvMYLfQa
	TAuFRPFzncOuzhYhKXGjsN9XvkOH0qizD85L72+JHndQmuYOXl4yBAqDyKyZ9jUfgSvyuTn/BBP
	UtlDLktd+rsk5cksEta0/o9zHB0w/cNFY0qP/72EHVdA4CRQqSpoL1hSrMfg1IFEXWoL8jcjaRq
	Lqlrurv7E2eWddk7XyiOXbgjloixhbRQqBx7xveFCQRfnLFI+pUXPTfx7VWOVTo7bGKLytXDUCh
	B+mnv4Q2ATPhjqmgvuphxPTlGZcl9BBQWBb8yJgEAawEDsHiBwBXX/e6j8tgq41V42M63wo5+KF
	sPbrRbP9TxcOlvN4qJhn74TUKqwdEZngtIl5LRkvLDqvkhcMf3UAp2
X-Received: by 2002:a17:90b:2743:b0:366:4a47:f267 with SMTP id 98e67ed59e1d1-36951b83b77mr15475516a91.16.1779110008155;
        Mon, 18 May 2026 06:13:28 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c31b:5187:c514:ac40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm11241781a91.4.2026.05.18.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:27 -0700 (PDT)
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
Subject: [PATCH v3 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Mon, 18 May 2026 21:11:47 +0800
Message-ID: <20260518131311.1170786-1-yphbchou0911@gmail.com>
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

Patch 1: Fix exit_cpu accuracy for the hard lockup and softlockup paths,
which were recording the detector CPU instead of the stalled one. For the
RCU stall path, use -1 as a placeholder until patch 2 threads the cpumask.

Patch 2: Upgrade panic_on_rcu_stall() and scx_rcu_cpu_stall() to accept
a cpumask of stalled CPUs. Both the non-expedited and expedited RCU stall
paths collect all stalled CPUs and pass the full set to scx_rcu_cpu_stall(),
which uses cpumask_first() for exit_cpu and includes the full CPU list
in the exit message.

Based on sched_ext/for-next (d83f90561532).

Changes in v3:
- Drop patch 1 of v2 ("Normalize exit dump header to 'on CPU N'"),
  already applied to sched_ext/for-7.2.
- Replace single stalled_cpu int with const struct cpumask * in
  panic_on_rcu_stall() and scx_rcu_cpu_stall() (Paul McKenney, Tejun Heo).
- Use cpumask_of(smp_processor_id()) in print_cpu_stall().
- Build cpumask of all stalled CPUs in print_other_cpu_stall().
- Thread cpumask through synchronize_rcu_expedited_stall() and
  synchronize_rcu_expedited_wait() (Tejun Heo).
- Use cpumask_first() for exit_cpu and include the full CPU list in the
  exit message (Tejun Heo).
- Pass %*pbl directly to handle_lockup() to avoid intermediate buffer
  truncation.
- Falls back to cpu_none_mask on allocation failure.
- Link to v2:
  https://lore.kernel.org/r/20260504161543.674488-1-yphbchou0911@gmail.com/

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat (preemption is enabled there after
  nbcon_cpu_emergency_exit()).
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

 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       | 14 +++++++++++---
 kernel/rcu/tree_stall.h     | 15 +++++++++++----
 kernel/sched/ext.c          | 17 +++++++++++------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.48.1

