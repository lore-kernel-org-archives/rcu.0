Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D63DDDB8
	for <rcu@vger.kernel.org>; Wed, 10 Jun 2026 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105259; cv=none; b=Au+IiJtQuMFaCfDzlj0op/WfktO/3+vUwYLT40WQX1x8A+4OVv4E8OvJcZWvyvAkJLDXMKZp3iVJeJpHvwlGHG/qVWHIsG7I7s19eT3ftJzlrLgG3y7okKzjbePYnlcZ1ZfU9m6zJrs1TdQItL7HcolFiHvdV8hWDgRJcYp46hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105259; c=relaxed/simple;
	bh=6Bg0X6mwTP2+ImN1J2i6ndUpUub1QcdoDe2lQpBKbjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCQkDnbULJHgTY8V+y03EH5KQOF1oK9LXVw58SFeck/+lz8NS4kx1+wEfn1AEnptdWJD2o6DYiGaZZLRSC8EN3s1oh4LCSPtwFCul9R9OZp7WuQDgo/Ka+d2ArZmi4Cx2FWop9NrqOHBqo4cTyARRISlCukaRJbK0c0Im3Colo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW+eTkoO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW+eTkoO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so4167383a91.1
        for <rcu@vger.kernel.org>; Wed, 10 Jun 2026 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105256; x=1781710056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1UmrkVoqnDgoi2g7SQ5UlHE2AMC3tgS3t1nYgbC9co=;
        b=cW+eTkoO5fhFcSXE9XR+0WVEueD5VXD9vQD9bdOyDt55QORnq1AzBtCfpE6Xqzo3F8
         Oc0QggGsvBOK3ZUa4QiqypNMzM4sC/u4VqLIWBFF5b+O+Dlg1ijnsHlvjsbALPaRaOUO
         N2NJp5S879Bn7TrEhloYwTbZUxzi9M9SKTbfvrG0z4xoVEnn84mFd/kuPQTVwiK0ada+
         u591pQLClGZADfyLdgvXS0QBngDkvVK02+/G8oPjWKUXq+4o6rsjry8cRLHgow1FLied
         EfPGHcn4gCaDir9ve1dAy1zNchtKTQ0fxNuwk8rfR6fU5RELWLOGgL3DwCKLJVxEhc5t
         mung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105256; x=1781710056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1UmrkVoqnDgoi2g7SQ5UlHE2AMC3tgS3t1nYgbC9co=;
        b=WG3S27FCYNQ/eS/qM+kRHgHYwigHQo76KWWZ9X62lrOQj1eX7qGcmJzJ6c8b8NYX54
         IYQG+6dsSoanilZw4CbTjW0bZm0hq3lk7+MkxxupGFoyadPETjmR4A47wZMO+mYIlnWe
         teeMjKXY/LMDyIqX507FgrzWeekyJ16hdtqNDUIK6RbNmlXORuMKjbGQ0NNlJe+7jUNM
         BxXObCW4BaiqkV8ORQzVTAE57Fu/ELkkSn3nehFTRnUik1GN6+to91D8Luv15gFTKhid
         lbz0ePsa5ddDNiJBj9bhmROgON+TdHdQNskI5/AeLoXH5R4XqsMMCvkewaaGY6SWFSs/
         dNJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bcW6Ar8mQnKko6GwInHH+ERmCAYFEMrWY35Xb6yYhIP1VQuW90nd6N91Q86j1KSHuSsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkW7rZwnfwlfclrV8o1YriCJ6daExLEaFcMyVxnmTcRsCCbS6
	1c0LVClrU4zvHH8V58TCzhx8L1XZKj70wg7vpFB6lGslscJdTHUaI2s7
X-Gm-Gg: Acq92OHu+Wqj06E14lizmvwcynyYDqG8ESUq9Jytl6s2EdDmMAV1Tn07cMDr9S9Gu5A
	aI2rTVxPWnISdYBvxdXWa6LMElSC7eAkGlTq5N+wORWg+dMCVGY3G+4snRNv0MbnyYqmEo1Yeps
	hBrGM4aBnIBBHYUiw1VSgfpYulr4yHbd+uDFRPqbX0S8ZZ+3aj5z8+LuRAQt+X761rCBJ+vRu28
	cY8GcgeYsAkqrFxdegsuSW1MYgbEOrWyeOQK8jQlbz5x/VCXmH8bLO1LoC/q9sqmzJVd/7ixTqt
	tYOgMNwcujpKQ+L595yAtwor7ldJi+xp+/pqcQxIa0asEG/PLRHEyA/vXDIv55WhxdErFTvV7MY
	QGkOhjr4Es+dtHHprkZc6cHccxFwunhI7PHXEDVyqK2tjaNCgilKV2bNwuwNEFxSTeX+XAtgAL1
	GxHip2SjQAMuWd6PyzwunumgygCN0p6YdGywbhdgpA5mq4vXCxrIGCV42bHbjsEXOn56pAPiH02
	UT7JXG44H1DU2Vb+qmzRFon1PU=
X-Received: by 2002:a17:90b:48ce:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-370f076d7e4mr31059928a91.13.1781105256103;
        Wed, 10 Jun 2026 08:27:36 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-226-225-196.dynamic-ip.hinet.net. [36.226.225.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm253335795ad.47.2026.06.10.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:27:35 -0700 (PDT)
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
	chengyang.chou@mediatek.com,
	yphbchou0911 <yphbchou0911@gmail.com>
Subject: [PATCH v7 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Wed, 10 Jun 2026 23:26:54 +0800
Message-ID: <20260610152717.15905-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yphbchou0911 <yphbchou0911@gmail.com>

Follow-up of Tejun's suggestion [1], discussed in v2 and the subsequent
review thread [2].

Patch 1 fixes exit_cpu accuracy for the hard lockup and softlockup
paths. For the RCU stall path, -1 is used as a placeholder until
patch 2 threads the cpumask.

Patch 2 upgrades panic_on_rcu_stall() and scx_rcu_cpu_stall() to
accept a cpumask of stalled CPUs, stored in scx_sched and piped
directly to scx_dump_state().

Based on sched_ext/for-next (180c5cefd174).

Changes in v7:
- Read smp_processor_id() once into a local variable (Andrea Righi).
- Link to v6:
  https://lore.kernel.org/all/20260531152646.1206799-1-yphbchou0911@gmail.com/

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
 kernel/sched/ext.c          | 86 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 6 files changed, 91 insertions(+), 23 deletions(-)

-- 
2.43.0

