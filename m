Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5823390C84
	for <rcu@vger.kernel.org>; Sun, 31 May 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241276; cv=none; b=OYJgJUWfxJNX+3G7mG6mdwuPM43UPYJ2+MLS5XSYAV+SU2uySUcWk5PmVKjWvngTafNF+0pKD4ujauxV/RqAaTfDGaKtyRKkLA1VOZ47y0SPsrC0TL30Ro6yGSLvvxssRCi8hau5gywitypCw/Aov+hjkv2JSX7myJoI8L2LUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241276; c=relaxed/simple;
	bh=VjCJylqdfAQWj9+KnBFgVKqM4UADrEfypRh5XSComKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHM4LAdERWrCV3vs9yVKWh8OOWliwcF90LsiZ5HsLXHwO5OhO43pTkDsjLk1gB7ce9xqw8sTSOQz3VM3Jbkg7XBmzQmnJIgWVisNQp06vTW/AS7wgjuhfK+eWVqUc+wu1/Esf6Ft0HBoHj2EMltIigbUzMCH0DBgtoGb+/WsIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmWQdsX3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmWQdsX3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso3425485ad.0
        for <rcu@vger.kernel.org>; Sun, 31 May 2026 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780241274; x=1780846074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8U6hfJxoj/rPCBmp3s7bgS+TKfume2zkXAj7Af2fpo=;
        b=GmWQdsX342DnIk/zgPdjM2rGAfqPUiryO7o5E36Kt4F5ToPq0nX3wIv22hj6OGvk3Y
         Y1yriq81cSO+iKW4HezUk29GtZ0nUVznx53ErG5pCx7+4YEzKfY/2jWQQfUn367fuHkq
         nnaJziZJf9sccZSWdtfK3lzd+6t3UzuoiOs8NWTeeIG1sugEyY4HNruzmvMaaOxeKvLg
         gY0L2UI4toWOfPHQQcAL/23E9h7Wfz7sHrFCYovAsoCsNLGiZciGtYd6QECeRjVyyi9O
         KNf10CR0WzVsLcM+m3o+DXlFvhpHKHMNIX/IBvNqyj2qrdoNclPwmpBX5t3kwGsaYapz
         c4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241274; x=1780846074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8U6hfJxoj/rPCBmp3s7bgS+TKfume2zkXAj7Af2fpo=;
        b=ShZ/jpgm+Ly1419y3eEdemfufs0JfGHl00gPxuipMrMYSXBvWbASDkMLI1cD0MJ6sY
         07IYsIW+aYSchs9bwi2b51iYxAV6xn/0N99Djbs6vNOhmQL7HatGpZ6i6JUSbFMnRPI1
         9MXgTsUY1siIKD1U//FDMcrH153c8iylWhQP8RAFXmh5ZmZmcEW5yBkZ0/Tzg8C8yFfd
         0q2FvEvFzcdVIi8AVlorqawblfJEwUOEsxzMqdX8RCyG1c3suiuFChCpG1a4+yq9KgCl
         PlHvq215zOdTSfEyuOzUhsEMVJNvH74IeSNbM5EWa8/fh1jX1PkqK/gFijN20W3bP2ky
         HbBg==
X-Forwarded-Encrypted: i=1; AFNElJ9/zMUe7BJqi6URvku3YdMWyoJpzlU11SEfqwtTUQEGXjEUUEN/SFEKEcUJ+oi1ayIJQwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvA8H28rZvBcQk1mt20JTOcFzFxP3zNwK+AEwpQZWwdaLI9Zp
	swpftNECnqtHan3nV9oWUbEeznQOOL+jLb6+fxdGtLTc8U8owr8fMSf1
X-Gm-Gg: Acq92OE9R82z7Vt0wVOj5HOuOhTh/XrK/U7fag64jgGLEXhauolL5gxCP5/LvueQaVB
	cWhRsKE3n1ZPAvSC30LbYeYurqkGfbzmpOgBJSLvjUEznWezoKH2CjCdF1miBNkpftck6d4il8A
	Zs9wxilSiW+NikVsDFLse8nnSRhL7RUHp1GuCyDPMcMdN3te32VAUz+Z3Tad4hs0wXH1nE4VPEc
	ksNY3MNk6AqJ5zYHKHPPxSIdFrwFqlpyQHsqDAgXj8Wk8Qk4xth1nvQXB/+AS+GPbB0z7JhJIBY
	up7QUIq2jykFJYIu3nX8QMSG9ox0GTT7nCM1Pbp4/0EXSJA+87bw55uZUNZPUolvYS6+FHsZNw0
	Oqnlm18WjQjGHnCH/9REMAw39GZXEOzSa6Iqq/wqFjycR0IzO3LPvg55V7wPtX3lVMaCCo+A7R1
	VXyu7aH3pOzyxrcRhR8hOAl+dE/ahP4U4hAoSgFfyhAzXzpbYhPdBE3Jm0cejTQF4=
X-Received: by 2002:a17:903:8c8:b0:2bf:2256:7334 with SMTP id d9443c01a7336-2bf36828b0amr76246415ad.24.1780241273958;
        Sun, 31 May 2026 08:27:53 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1fc8:a0da:7205:7281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00c13sm83921845ad.28.2026.05.31.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:27:53 -0700 (PDT)
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
Subject: [PATCH v6 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Sun, 31 May 2026 23:25:25 +0800
Message-ID: <20260531152646.1206799-1-yphbchou0911@gmail.com>
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

Based on sched_ext/for-next (b565a73baec2).

Changes in v6:
- Drop stalled_mask parameter from synchronize_rcu_expedited_stall()
  (Paul McKenney).
- Link to v5:
  https://lore.kernel.org/r/20260521161636.1893894-1-yphbchou0911@gmail.com/

Changes in v5:
- Replace dynamic cpumask allocation in both RCU stall paths with static
  rcu_stall_cpumask and rcu_exp_stall_cpumask (Paul McKenney).
- Link to v4:
  https://lore.kernel.org/r/20260519171745.1551340-1-yphbchou0911@gmail.com/

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
 kernel/rcu/tree.c           |  3 ++
 kernel/rcu/tree_exp.h       |  5 ++-
 kernel/rcu/tree_stall.h     | 13 ++++--
 kernel/sched/ext.c          | 85 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 6 files changed, 91 insertions(+), 22 deletions(-)

-- 
2.48.1

