Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858281;
	b=gXXYuHdgAHlmZ8rSLK0aNjBS+vSLMrQWXDmJRgZl76LK/WTXQeXoQvoCSaUQSqBpV8z6
	 PSKb28czcWJXmaO7aJqqJ1U49NV0hoMiILhEx9YMXS4w71PuS0/tsc6Ui3rcXryfq7UdP
	 pF8Y9zSE1HuLDksPmoOOl+YstCJZ2e4PZJOgAWdbVE2L6NtJGQlPD5JVZAj+qGKyxkQZZ
	 z/guwSpQnQPBAYXNyom3/5FRDCbY4/3m1ll5Rzib1al0iEnrbXENXcKIJiARhhz2vXuw9
	 1ZGHkG2QHmkioDoWSPGdT+zI18QbQ/MfGw8VwuOTbaDMYWmHWohLH/7bNBOsSN1nx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i1vlZC4rlK1lJETL7MgudvHOPWJ9hjZNLkiNbIOMUN4=;
	b=0xz2QUCLS9GpcTULOXGMLYO+ZCogLY9NFZe4xQNSGdefxVkGLHV2ld9y5v20xe3x/4cZ
	 AfIIokxzzgXYFdjYMif8EoUZjdh1bOQQW0A3es3MdwNl6cbs7vmP9RGHzhyuqYX3ZIxwS
	 3Lu8/yu59raVKipU63pDMggvitOmTMBD7PdjJySosDTEOA+CD8uxnIhvwxsogofeiIAYn
	 GAXctIMd/lbxOOZH6byGzlce33V/Q+tOj1778qKWa5DOfpE3URwkQ3Zsrly4V+TA4w6LF
	 x37r0JbqddSyDjrMnM2IAMsF0tae+l7aTW1q/fxcnh/1ZQklusGLm1uHWEkGOVhEgAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmzJEpHI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E7A59606A322;
	Mon, 16 Nov 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmzJEpHI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4E3281F000C4;
	Mon, 16 Nov 2026 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858280;
	bh=i1vlZC4rlK1lJETL7MgudvHOPWJ9hjZNLkiNbIOMUN4=;
	h=From:To:Cc:Subject:Date;
	b=RmzJEpHIrcpenSyFIRTDgQ6kDmJbN/Ocq5054bBjuTDmywfw6Nh1a3pxtQB+kXzhc
	 t59q4KCWlmSsMhOCNDbHe8pWw2E540XAUyRnybRpbuVfKMzyW+slOopJh0zHAV7mOF
	 ElHof3SyIAISCYSdhYRApTVsRBcmGTVwNdTKKSjoBqjeIZqQ1pvkXb9Pp1Cykq317J
	 Hk+S3XD+uoakWMbcFRqsZv065fizosVu/hB+9cGvyos8m15RJ8MlGhAEgP/erWKdVK
	 NnFWjB6Uzx00m2MpSnLeCv/XObU5ivyOwksXcUQp0jfHw+E4Utbl1vbz9UNaFz/vIq
	 UeOTjKf2BQjGA==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/7] rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
Date: Mon, 16 Nov 2026 14:44:31 -0500
Message-ID: <20261116194438.306618-1-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
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

This is v2 of the series that rewrites rcutorture's RCU priority-boost test
around a CPU-hungry reader, so that it neither depends on disabling RT
throttling nor infers boost failure from a grace period merely taking too
long.  The approach is unchanged, see the v1 cover letter for the full
description:

  v1: https://lore.kernel.org/all/20261111213826.2035045-1-joelagnelf@nvidia.com/

Changes since v1 (all from Sebastian's review, thanks!):

 - 1/7: Use kthread_run_on_cpu() for the reader thread.  Range-check
   test_boost_reader_ms in rcu_torture_init(), clamping it to between
   1 ms and test_boost_duration.  Use div64_ul() when printing the
   reader's CPU time.
 - 2/7: Replaced by Sebastian's patch [1], which also removes the
   sysctl_sched_rt_runtime declaration from rcu.h. 
 - 3/7: Drop the sched/sysctl.h include that crept in through a bad fold,
   and also remove rcu_check_boost_fail(), which has no callers left.
 - 4/7-7/7: Unchanged, other than the rebase.
 - Rebased onto the current rcu/next.

Testing: kvm.sh with --duration 30 and --cpus set to all CPUs, on x86 (32
CPUs) and arm64 (80 Neoverse-N1 cores).  Boost failures / boost intervals:

  Scenario      x86           arm64
  TREE03        0 / 220       0 / 217
  BUSTED-BOOST  247 / 252     250 / 251    (expected, boosting disabled)

[1] https://lore.kernel.org/all/20261113-sched_dl-v3-3-a76ffa1cdeee@linutronix.de/

Joel Fernandes (6):
  rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
  rcutorture: Remove unused check_boost_failed hook
  doc: Document rcutorture.test_boost_reader_ms
  rcu: Add rcutree.boost_disable to disable priority boosting at runtime
  doc: Document rcutree.boost_disable
  rcutorture: Make BUSTED-BOOST disable RCU priority boosting

Sebastian Andrzej Siewior (1):
  rcutorture: Don't try to disable to RT throttling.

 .../admin-guide/kernel-parameters.txt         |  14 ++
 kernel/rcu/rcu.h                              |   4 -
 kernel/rcu/rcutorture.c                       | 197 +++++++++---------
 kernel/rcu/tree_plugin.h                      |   5 +-
 kernel/rcu/tree_stall.h                       |  57 -----
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot  |   1 +
 6 files changed, 120 insertions(+), 158 deletions(-)


base-commit: e97b821f72876c4760bddc79f0858155e012da8b
-- 
2.54.0

