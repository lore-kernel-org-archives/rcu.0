Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530989;
	b=sNgp1rZBoX2PsD1+jV6x/5Ni1Yk3mB35QxEtZDmtQaCidNmVu7L8xPGG6RrAy1LVOx4b
	 aTwKaWxWe5bkNkNjdZidiYSFVHWLACksX0w23qXsUiYZkKI6j7h06LNhE83sRLglDH7QO
	 ejDirS3BlKbIFc/llrK9B7VKVc9cO3YnanR9KI8Vys6tqSaw+0yYL2XpmX1J32yYc9f9T
	 nwlUY35LrSZJzveQuWJO4T8AVqO8S2HQMll3REX6G/iPeeRiHrJsOI3PU21C4gceKMRqs
	 JIatcBZVzEuQXX3BMSH6321sRjlcp4bZhLE/sBWxnythL/hLlzj8TnD+mMCWpfdV+yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d2puXkthG6GtHINRSOYHLBAWxpktS3Z0wpMKqFHsZUk=;
	b=BgB/YnayqlEzelb9j+9bV1opRwvrtl3qwgUfDGq2FVTjtIGyBmaLXrd2ijVDN+UULBiG
	 Kjj43czSc0eLZ4rnbA26sBLwKpZeEiiwDDT7KTpY9z5ko27oYbHYQSIIy75rWc/sVnmjN
	 4LHOc6Nu3R4u/WWpR3NZSe1PLGIyLCGR3Sw4s01pc7unuyYM9OBAbibmwmXxrhh6qoVZr
	 lrRd++eKcuLiZszorPXWIHMf1zrWvU5h/gelIm0CP8moUvcqZzd87jOHhhtjMT44SJBhw
	 47SwADuF3DRXWjqzcX/Vd4IPBCl3096DpUwphRoQJ02W17LVHFRYjTPqSmVNe4Z2wSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIDwlw37;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D711F606A32A;
	Fri, 13 Nov 2026 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIDwlw37
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 298C41F000C4;
	Fri, 13 Nov 2026 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794530989;
	bh=d2puXkthG6GtHINRSOYHLBAWxpktS3Z0wpMKqFHsZUk=;
	h=From:To:Cc:Subject:Date;
	b=OIDwlw372qPQoO8B1UIRX8ERaVhHqNdWD23EluIAtfJE8CCUORGzMZjCnwDMYnHuJ
	 SlGW7sL9pyzhb91vKBvV68IEuMgdjxPsH1FkxCPko3IwaNJdaLikTB6oHVSxoDzU+G
	 0HPzBMybm9Xo4Ao8B43LHqvRu1Xt2tUh6l3q8FOFaAHYeBcGx+3gjbeoAOnaYFkxyG
	 c22RNRa/qn0F8qGYR3CkvFJQqeFZ4wvAPedVldomn/8+Se8i5GeMERJerAIq64YGpN
	 3ZtntDWgItBfIfnOZIqZ8+/VjqpU6vQE+G4iHahjPT0qv461hVdDKFCSyVM5ffV1OC
	 8RMzLVDeAXRGg==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 0/5] RCU core patches for v7.5
Date: Thu, 12 Nov 2026 19:49:39 -0500
Message-ID: <20261113004946.2758197-1-jfern@kernel.org>
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

This series has the RCU core patches for the v7.5 merge window.

Joel Fernandes (1):
  srcu: Select IRQ_WORK for Tiny SRCU

Song Liu (1):
  rcu-tasks: Use pr_debug() for callback contend/collapse messages

Vishal Chourasia (1):
  cpuhp: Expedite RCU when toggling system-wide SMT mode

Yury Norov (1):
  rcu: assert static storage for RCU sync and SRCU definitions

Zqiang (1):
  rcu-tasks: Avoid alloc_percpu() failure in rcu_tasks_rude_wait_gp()

 .../admin-guide/kernel-parameters.txt         |  7 ---
 include/linux/rcu_sync.h                      |  4 +-
 include/linux/rcupdate.h                      |  8 ++++
 include/linux/srcutiny.h                      |  4 +-
 include/linux/srcutree.h                      |  7 ++-
 kernel/cpu.c                                  |  4 ++
 kernel/rcu/Kconfig                            |  1 +
 kernel/rcu/rcu.h                              |  4 --
 kernel/rcu/tasks.h                            | 45 ++++++++++++-------
 9 files changed, 52 insertions(+), 32 deletions(-)

-- 
2.54.0

