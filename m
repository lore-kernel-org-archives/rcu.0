Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87244377EA2
	for <rcu@vger.kernel.org>; Thu, 21 May 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380210; cv=none; b=bxY1wxtijZ36cX+AHwOa0diGXAECPPvAfG4dRV3iWqFQhJCVlZRYlYU5U2QqcV38O9CGsHOXaQPGsfoy/ga18pEbjJwA8UKV5nyh744zM34O2guHj4Ja0irw3MSwtdCvOVmnLZ2nJAJVjviwgE+D+l5cJZg1C9V+tjugwuaXYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380210; c=relaxed/simple;
	bh=P62Cyp5plWaUgw9n2uFlaZ514koIx+Z2Xn5bP2ce7WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8Rl1c/NFHJPBbsCJqq4ncNjng07t+8NMNTvobWa3/5DnQ/sdk487TNNMAgMpnD5YAP4OkYJDBDgEdcfwHOSo2KU+FgOIpZxAmxZ6BcS6wggIH+BovJjYzjG2qwimhZ8FtQPvbeojxUR7U1ABCUu8yqP62NBcRY3bbelBv9QTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egZM490W; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egZM490W"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-835399c11e0so2936959b3a.0
        for <rcu@vger.kernel.org>; Thu, 21 May 2026 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779380209; x=1779985009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQd6/fi2In6zkfYaJSiVJvX9BwZpPa+F+dRko1X3xlI=;
        b=egZM490WC9cO7XAYJ87KKGSSuQ7GDxXQANBpvioLyjegPjAwFnVN2PlRQV6OFJOzR6
         gm6UyZ//JgUiCO2ob7ZHPXcT+QkUGPx6v0jGawpAC2wsyLGPlOEpmnTA1pRmG4gUFN2y
         W7Nfg8L/pm35EuZ8m0yjavPqc0w7VUNmbjLhfsuJecXaL5IBmh/xMEv0RV+NkyxHcLfY
         ERSCGNAoX18KzuIqFQ8UPC+9UC0XGCcSl6GAzJlSOGqYCgZi9WO5Oyxr1ogGvUKFrJbu
         TC3MqzqP+64Yll+82aqKAp+0yP69PBia9PUwP+YqtK2HPnhzhEdFJp6d5hff3qZ1qj5w
         Ax9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380209; x=1779985009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQd6/fi2In6zkfYaJSiVJvX9BwZpPa+F+dRko1X3xlI=;
        b=hyLhUeHP8duRXAgB6JbiiUIP9VfNxgadAQmia7ks5nVOc46Lkw5kHGaq3WoXydx3Fa
         mWDIFzVZhwSH/NE9yxpoixEb9tu8nt+8ZynyLyKaZ5BydRpSWld+6VrDtShCdEaBBDQL
         dd8E25/fPVUbonWfsv2F+MdFMiYP5YJHPCUJPAWlOgFcM9ai1FYIpVr4tWuP0BVJHj0N
         AVHo/7DMYKnX6PS6pWpYZQc0+MpVCdaPlwQf/B/9TgZxvemE2w8nHoMfCCXGZnEQSgYe
         IEWJ7r5Z3D8C9PAq653L0yra42455bhUYjcFQEswCSyicM6BCBZxwoO+93lG830DvATx
         7LbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YI39YQuucpoxYjlkDNsdcKCAFuSR9As7Stf1vP9yJoMawoQE+C7dOEtevcIOwbaamE3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9ekAcaxxAH9PDeNzfqrWSeVeJ6iM8NYnqTna1z1uLIZUwbOy
	DMBOq2x+PCjy9hAxtI5SDJXtRYktMJ3ZO3L9ufW3APuCTNfBtLVIamVBhIEPLw==
X-Gm-Gg: Acq92OGYS72NBW6EC56CYK5Hf5Sg8kcmYAFj5p8MMHQMykzmYXwfC9xdi7s1XkNBwpW
	CbcTMEanQwbd+oXJtIUdjanVMBu36Xz3oxwgGvDzOxjGWtCAoZ9mzQu5tc9pasHoZfeQnQDlcxp
	0bu9X1eUg1fyArE++001jgaEtGx4jZMgWaD+1wt3DCgT2lE2zQkqHFiPS5ObpHBaKed6OGz2wgh
	O98WpsW+C6USiT7fkGnyfKXAcKJ1ZDoJAzTricI6K6o9RVS+cjKNpG1oULunloJyNsmrfG/D+tp
	QveQh6nts0JuvVPCdIkorTtdS2CI5bbPccUOBqLKsV2wsTm9C5nlaJJ7JpnBFqhGGyOn2XaNl9a
	qUAa69vhMjJiOXB0PP7yD6h71ZAuHel/5lPM6SxzEgikFF14p2H1VNjpoddwBXM1Gk5OgdKCW9S
	CJPOdQyJQadwMpwWN3YnoodQXXRShbiM/2Bi+teSbYEd0Nj+7ZX4+t9pWPYeID+qhIAU0o/W6PU
	A==
X-Received: by 2002:a05:6a00:4c8c:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-8414acc6e8emr3752411b3a.21.1779380208635;
        Thu, 21 May 2026 09:16:48 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:431c:aecf:2272:9090])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549c4806sm1729493b3a.6.2026.05.21.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:16:48 -0700 (PDT)
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
Subject: [PATCH v5 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Fri, 22 May 2026 00:16:08 +0800
Message-ID: <20260521161636.1893894-1-yphbchou0911@gmail.com>
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

Based on sched_ext/for-next (515e3996a4c2).

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
 kernel/rcu/tree_exp.h       | 10 +++--
 kernel/rcu/tree_stall.h     | 13 ++++--
 kernel/sched/ext.c          | 83 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 6 files changed, 92 insertions(+), 24 deletions(-)

--
2.48.1

