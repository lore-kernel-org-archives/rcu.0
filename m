Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876065;
	b=flfE1+Y/NCq2VvRHPbiL9wNezBKO0buZL3sPqynWmvaY7ZGQ8/uixbmsqm3jGe1ADmG7
	 35ssyjOXxOVcW+ABFVPw82fRwee770Zq1qWiwZlSjwwWXD7bF3nOu6eB22oa1diXoWZ3l
	 D16MzmOQss3TikXwOXMZ0uspjwyNxJZKZD2+wSx91kmAKt9pbXdB2NJn40jkeqYjnmoxo
	 R84De6lwRGL7S1lLZ0YAKSfR84IW5Fbm83f8HDWoHz/mosiSakk/JDkuXutFjT4fWRaub
	 PZ0UIC7WRQibQBqeM2ZTFgi8q8BTbTkAa1MfJZvkwCGZ3GoDg0XRiYy/fg5Q8XG3cDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YxaWrVn6n33eWhiL/bZzA2e/NdKxWhMxiAZXgWJylYY=;
	b=V6uqulKYhg9/+ZLFgs1yWITv7hT4JSQDnkH/Zf6wctHTNDZ2e/cdFPIic6e5iZOmrWm1
	 CHgYHVj1z0NYTFcOdho92a3q5YRik7zMvE+ptQrv9pfwG1uj1hm5T1Dwmy/Mj7WcGoglz
	 Lkhpul0JY9kmAbJx7/2Z7EkVWMm+7tXKu7k2qU67HzL7xT9py6IwR7ZocEhgrQQOa6oVT
	 q+i272Z+oksKKi/1khfn3rAbjhpz5u3SRIYAya90uHViQeb8PtJKowlUtpIudasI5GPWg
	 Z8iTB1QTJZnvhGAxr8CBkd8w7cI7XxDi13CGX8Q751/aMFKtInWaGQ66fvwb6ffqBiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqXgLHxZ;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D1606A31C
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqXgLHxZ
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso12912531a12.0
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876064; x=1796480864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxaWrVn6n33eWhiL/bZzA2e/NdKxWhMxiAZXgWJylYY=;
        b=UqXgLHxZd1hm/r4ldhii3WGqA3vrRbdeuEi2fbZBysuaiXrKfeEfD/YJiPdTbvex4B
         a0eU+UFzIb94rHHXFahFNDd/nzk1uIszWKx2/WerqQGdpzPay994jv2YDXWqNhPxsRND
         SqNyT5abmomc06bb7/5MQCAVPvXXP0F/oyXOl0F5sxoBMdyi4+6oakgH32IWjTUiLAR1
         q5uLSKj0Tjnhm0QcB2EqQmxP+lCUZ2QT3a+0wUIXm+r3q1xZryUZLR7skNNa72uMtfJC
         vrCQsOtulrKVgiZvmcQrZIT4ww+WSCz+JwFh1EvMUNgDwImZ1IR6lBYBBoPCo0cABaHl
         5x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876064; x=1796480864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxaWrVn6n33eWhiL/bZzA2e/NdKxWhMxiAZXgWJylYY=;
        b=vSPCj4Z+IGakVOfKdxkEG7qmRwgxFfA4E9u0UMDmZoQbQR+/5MtlLKqUJ/lkVTrBK2
         rXqiKIjkb9gntugj6Te6E6+ct3N1tbEA6h7I9EiUIRm9bTC5A8cuEChuefu6wLOX3m5F
         Wdvu7KRE2XtRBIA4GSyfToWvzN1doiVxJVqVkocapt0ZqTfIStlcZPcSNPs09o3s3sv/
         /0h84JdmsgArLzBdEfYe7Y1Ve3QfgB9MTsvsTLenFZmK7FShQ63VIuWE0GbWUICUtf1b
         +ais3edM/mFzlZUpZwVQMewaH/qcTsC+Ku68ErK55ytuwqOQ8fyzzGCvacmYnvUdNZaW
         VeTw==
X-Forwarded-Encrypted: i=1; AL+hErFgmUuazJQ62pbgTBd7I0w6ehwfhmwmWnt+gvaDnjY+CUXaSg4n6V81ERscyYJ6gCLlkAA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8D7nN78XMoZr1PtoWpt+3wyhutHBit5rXJwHUE8GKI8ASyzrff
	gINQZ+oLQvMDrKb4QK/zWFiKfFUDQB8cs1YHTjalrS676wl2WDNv6ehq
X-Gm-Gg: AZFdTZc8gSv1VjsDWtXQcAmLBWmszOUpR8OGbLsxN0HvG14yQGWfhnZfRcevKKPz6+r
	HbjZJX7qvFyCSNCD4xMU8furQlh+G6+YXxfBVWlnjPX7IOFHLHsQ8W1hun/BNOYZU4RxZrUcV+2
	LWr7BQNa1j2D6Vg9DEmYCUPGgv/koYJ10eIBMcoJ3uHhQ1SLqGJ2BTb5J4NYpR24bmtglTvMPBu
	v2uQUtnkEJ+zh5+vtcBvUnLgRRqztuZ4oypcVYu729F6GxBGe7e6dfhMilKnVfja9ozfZFsMjO6
	tht9CIU9Id6iWhRXr0gi6aDvGpOqXUd7zRqIE5NMHd6Lf41q7e3JAP1kt3RslyScWcN4aSIMEpL
	LbtLlFFZHIGTuZXqZgysFmB0pZIexWuPrhJCWA89DntqU5url9v7Br8u7vZyAmBPrsWUnGluaOZ
	IdIJGq1+Heub3zOg/LU2Z6PidPq0i+MI/XmjaCrpa3b2u+WdJPPRqyYVvEEi37N8N25hUll6aF9
	nk6whzBVTNrfZgLe50d/o+XkKW2PabHk3QusS291y6sEWB+MfuvcFwtrwLump/cg5QahXLbjvML
	KiKJZDDwx+iV85ZsFHB8NSWaMi1CBNu/QxfL/175z2OVNKF2XaigkzzXkKV8cDtMB+sDG/BZjGd
	8CmdxWtFSma+7DVu8
X-Received: by 2002:a05:6402:1941:b0:6ba:7b46:78c3 with SMTP id 4fb4d7f45d1cf-6ba7b46833cmr16806864a12.22.1795876063386;
        Sat, 28 Nov 2026 06:27:43 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:27:43 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v3 0/7] rcu: Record callback enqueue stacks and add torture tests
Date: Sat, 28 Nov 2026 22:27:22 +0800
Message-ID: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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

This series records the enqueue stack for RCU Tasks callbacks and adds
rcutorture coverage for duplicate callbacks and KASAN auxiliary-stack
recording.

kasan-aux.sh runs the auxiliary-stack self-test on existing scenarios
and checks for the enqueue caller in the intentional KASAN report.
Patch 6 runs it from torture.sh when both RCU torture and KASAN testing
are enabled. The extra builds follow --configs-rcutorture. --no-kasan
disables both ordinary KASAN torture and the auxiliary-stack checks.

Changes since v2 [1]

- Rebased onto Paul's dev branch at 68dcfb0e34ee. The previous callback
  stack and duplicate-enqueue series is already in dev. Joel's Tasks
  RCU barrier debugobjects fix is included in f9857faffbb2
  ("rcu-tasks: Detect duplicate callback enqueue").
- Dropped v2 patch 4/7. Zqiang's 6abf78ac6a2c ("rcutorture: Make
  tasks-tracing support duplicate call testing") already sets
  debug_objects for Tasks Trace.
- Adjusted the torture.sh patch to keep dev's NMI boot parameters and
  QEMU arguments for ordinary RCU torture. The dedicated aux-stack run
  uses its own boot parameters.
- Added patch 7/7 to accept the expected KASAN aux-stack skip in the
  TRIVIAL-PREEMPT scenario. Codex found and helped fix the checker
  omission while comparing the rebased series with v2.

On the rebased x86-64 tree, I built the RCU objects with Generic KASAN
enabled and checked torture.sh argument handling. A 30-second QEMU
run of TRIVIAL-PREEMPT skipped the KASAN self-test and reached
SUCCESS.

[1] https://lore.kernel.org/all/20261118085147.1668598-1-kunwu.chan@gmail.com/

Kunwu Chan (7):
  rcu-tasks: Record callback enqueue stack
  rcutorture: Require debug_objects flag for debug-objects test
  rcutorture: Test duplicate call_rcu_tasks() callback enqueue
  rcutorture: Add KASAN aux-stack self-test
  rcutorture: Add kasan-aux.sh aux-stack checker
  rcutorture: Run KASAN aux-stack checks from torture.sh
  rcutorture: Accept TRIVIAL-PREEMPT skips in kasan-aux.sh

 Documentation/RCU/torture.rst                 |  46 ++++
 .../admin-guide/kernel-parameters.txt         |  11 +
 kernel/rcu/rcutorture.c                       |  54 ++++-
 kernel/rcu/tasks.h                            |   4 +
 .../rcutorture/bin/kasan-aux-check.sh         | 158 ++++++++++++
 .../selftests/rcutorture/bin/kasan-aux.sh     | 229 ++++++++++++++++++
 .../selftests/rcutorture/bin/torture.sh       |   9 +
 7 files changed, 509 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kasan-aux.sh


base-commit: 68dcfb0e34ee3a9628f6b5ce7e06931b5248bb9e
-- 
2.43.0

