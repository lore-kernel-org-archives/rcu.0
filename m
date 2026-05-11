Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5633128B2
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522094; cv=none; b=hpk7WEHuJhjmKxHiPEU6ugPjX/mlS2bCvnv2mu9fIeLZwV01RROUAHDLttIjxM21P5PYWfnyJXC5JChGxpunyIMw6Iv/lKbQbNZpd/b9SUw1yf9hFaXNyc4GHsWao2h4iV5c6n4+kgl5SIe7UQxKEHgGcKZoJTuPhltRY7lh4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522094; c=relaxed/simple;
	bh=z+gyvwNGzm/z1Obs8ib5XDuIVqgfnLpXZ9O3DRQ2gEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKxBCPPxx00Qfru2qkmPAY7jlNiiCmFT9Y5a8EKlONxZ1kSRZIX9Rzb/m7yZ1jKFk2gxcXc+N9YkJlPTlfqiat6U35jI9H59GzSgNf0ommBhMrBopa6+Rgz06W++rrLar0yNSA354dFY4HLsnHrbpOxU2Z61Li6USE5u1N+ojOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnS3lzQ7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnS3lzQ7"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so41292831fa.0
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522091; x=1779126891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxRZfcj3lZvo6x+hY3dzghP4yMszIa/AY5T/Ujh/ZOM=;
        b=SnS3lzQ7XEgFaAgLu1iO3qdm49i6NfUK53hhrvm6pVcJrXR1aM5KgPNsO4mB7LBCW/
         EJw39pBoPBintxKkgNbsxAWJPVU4IOKyqdQHzQPmpqb1M5DPgTkrQdIWmEE0YClT9NkQ
         LAW0qJ5CnYeHXELGvX9Zn3w4IckAdyUBZMW+IreqbgSz6+1k1BZh2BH0N/SFpOoRbyxv
         kO1skG5Tw1okXS1n264696ArosxgWFZ4c7liv9hPTzeFQscRAfkHsUruSJeClmdKDm8P
         l44RbqTSVo2HSdb3qEcxz+OcedTF/6O2pWv4EcoTF05u/RmfZnXFo4rgXRm/mN0NJXO7
         9EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522091; x=1779126891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxRZfcj3lZvo6x+hY3dzghP4yMszIa/AY5T/Ujh/ZOM=;
        b=KvFXqfrNH/ecQmldF4rBH4Wl0llGlDT9GayI/UX49DtNf3bgN6HvVMZf0wL7QINBKz
         +COidPTjjPwYvfIIEOTwC+hzRcXMNgPbbQULKg42phBEa/oce4SjgcPYKatkv+uQfwox
         LScaNByDDpb4Hn5cJEyCaZbckIB8TRFpBvnyY1B4IAiWBxgIjhVTaA3wCUTgdUAdhLge
         7fsD5anf0nbGcvv5rrkCrkZ9Gv2B/0lkVzEIxF50FUlr9fCGKeinRsFHx/hRxpFHsF+i
         kMni7zkgyOhMF0gG+rDsrxmFcHHZrBDckgH8NW4Rzde3UBT0kIgK7u6LfR2pMvrYiRtJ
         Lleg==
X-Gm-Message-State: AOJu0YzQ/v21AVCtpUAKXYtqN83R6T8pNvlUg0Qgdpk1RztYqDFNyv0J
	KeK5iDRJROM5JLGJbEZWMyciuYlWAtuBmvcYOSPmqW9e7RhRs7Rc6ZkQ
X-Gm-Gg: Acq92OHM3oJRDN2BunINLcMZN9mqdX9Lr0vk8yr3d+gkHQsDd/Cre6kOE9jlyQhM20F
	KGP7oNKaYgokF/jHDQzM2a85M/Lkra7MGQfluBzfOQMrhp1uvkyKBE9JZ3A64zZAAuG1UzoXwWX
	rHNJtXsbqSuSe6BT19wCtimFUZVOfzHNbSqV/MYld8dd0T+s0zShCG1AoSxU19JrwXGpvMVbbUJ
	9ilNgj9pWoN6UQjLAUAserc//A89LegHe+SggO+EoYixw7CGyRgMCHDmABoeomCi/A3deUS86OV
	45jfGrkPEZMX4AE/jE0verv1uSBhJszosVN7Jqa8wFtiXZUeFVY5Nv3XKmb7SkkFCc0zquB+D16
	hvmMoYfQbGSTjhxTH/DEAqJIOLX1tXJW6Rbr01QGhFG8JFevaMoOJ4BuBRPYqaIOzfki46KZw4N
	yk4bAl+F6mcdFcGbM=
X-Received: by 2002:a2e:9c8f:0:b0:38e:d18:4d0 with SMTP id 38308e7fff4ca-393c41501cfmr84719161fa.13.1778522090495;
        Mon, 11 May 2026 10:54:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 00/12] Candidate patches for the v7.2 merge window
Date: Mon, 11 May 2026 19:54:36 +0200
Message-ID: <20260511175448.153326-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

The git tree with candidate patches for Linux-7.2 can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git
(tag: rcu-7.2-v1-20260511)

Please note, there is one patch which should be checked, it is
from Zqiang.

Paul E. McKenney (10):
  rcutorture: Fully test lazy RCU
  torture: Add torture_sched_set_normal() for user-specified nice values
  torture: Improve kvm-series.sh header comment
  torture: Allow "norm" abbreviation for "normal"
  srcu: Don't queue workqueue handlers to never-online CPUs
  srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
  checkpatch: Undeprecate rcu_read_lock_trace() and
    rcu_read_unlock_trace()
  rcu: Simplify rcu_do_batch() by applying clamp()
  rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
  rcu: Document rcu_access_pointer() feeding into cmpxchg()

Uladzislau Rezki (Sony) (1):
  rcu: Latch normal synchronize_rcu() path on flood

Zqiang (1):
  rcu-tasks: Fix possible boot-time tests failed for the
    call_rcu_tasks()

 .../admin-guide/kernel-parameters.txt         | 10 ++--
 include/linux/rcupdate.h                      | 12 ++--
 include/linux/srcu.h                          |  2 +-
 include/linux/torture.h                       |  1 +
 kernel/rcu/rcutorture.c                       | 21 ++++++-
 kernel/rcu/srcutree.c                         | 12 ++--
 kernel/rcu/tasks.h                            |  3 +-
 kernel/rcu/tree.c                             | 56 ++++++++++++++-----
 kernel/torture.c                              | 16 ++++++
 scripts/checkpatch.pl                         |  5 +-
 .../selftests/rcutorture/bin/kvm-series.sh    | 11 ++--
 .../selftests/rcutorture/bin/torture.sh       |  2 +-
 12 files changed, 107 insertions(+), 44 deletions(-)

-- 
2.47.3

