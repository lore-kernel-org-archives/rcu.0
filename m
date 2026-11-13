Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531063;
	b=hHR8SNavhOxJLfw3n4Qb93EriZvkaYDfiHqzOB9heBlCoDrLjvXzXhM4j3fLBt0n7WDk
	 z22qRNJPf+m3+nxAluVi0k71b6dIW4s7TBzrZeX6rzt1NyA9GzVqiFE+5ZdHwNF5HA391
	 rPHTdA3WeRenfTwbXYbBaoFo5UifT2iz5l0ZBZU8shc6kCYbtK1rXyqM+wsHcFIRsTkDD
	 z8+CIs3YnwPo1/T00mlrA8GSFRKMO6YiK8nSLIO/mTMqtju2nu30tPL/4Ww7FOlmH6AS3
	 K5h4vuiJ2vv7lq0NMxayudylf/m2X7MPzYNMjREoFzN2lXmVG0zXxhpA5uTyLNTfp0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531063;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=03EXbnRkMo+YA7pX6ZIL45pVSzt6P3Ln3Yqjh2bhzWg=;
	b=y3BD1NTX3jKmiZxULkXPHQ2nj4wFXmpdSsTuKzjvQK+LJB5mk3xoFrsW0pkVZPJEu+v6
	 t0lOfHMd2JK9e21G3OYLCZ4d5BoU4Sxn/t/SXAnwMSDZc2d6w+fcpORrciQo5ZUotgEIa
	 PGOvTwLsmOgabRDAFJLYP4nlwAat+edIg4bSHdkS4azBdJZYQTsxROQDhiScaN2uDZraq
	 67THVo7H75f3tYeqxoZQd83myi45f6djJ/JVyglaIk7pLqBjQdLa3aGfeAk09ZGPUMZSQ
	 g6WATeui3TTMY/6LR7XKYuR7o0na5nzu1yEor/BU9sMrrcUXIj6aWM6nPVyrSM/7wCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BujtTeGe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5BB02606A323;
	Fri, 13 Nov 2026 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BujtTeGe
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DAF621F000C4;
	Fri, 13 Nov 2026 00:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531063;
	bh=03EXbnRkMo+YA7pX6ZIL45pVSzt6P3Ln3Yqjh2bhzWg=;
	h=From:To:Cc:Subject:Date;
	b=BujtTeGe6OkRVIz+iIfRWu0AKRxf8u3bzVL1Br3Pg8VI+4LpPTQFOWc2blGdcKnzt
	 Ls13AmKajrTbm52gB7/SUYHWQXEUDagCMJCcw6z0kAy6ild1snpSPikEEZyi6dgNWh
	 M/8VGE5effvYV9PCnh1Ts9OWZHRpyyf89fipxAUvhZ55HgWdUCM+NSf38580d/ba13
	 nLTcD5wLBWqCXZyCrIMl+nXpubIJoNpddoIUXL/eI89oazkjnCzYFRO/+pDugvXOwv
	 t13oAiWb8IrokUd4BGTLFxnbWum2323Ouig8dGglvZUMnMpu/ei7V5z8aBdz1Z7UKg
	 RTj9OxmEj9V6Q==
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
Subject: [PATCH for-v7.5 0/5] RCU docs patches for v7.5
Date: Thu, 12 Nov 2026 19:50:49 -0500
Message-ID: <20261113005056.2793983-1-jfern@kernel.org>
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

This series has the RCU docs patches for the v7.5 merge window.

Joel Fernandes (1):
  doc: Document atomic SRCU in Design/Requirements/Requirements.rst

Paul E. McKenney (1):
  doc: Document additional RCU task-stall dump information

Yonghao Zhang (1):
  doc: Fix stale RCU_GP_WAIT_FQS value in stallwarn.rst

Zqiang (2):
  doc: Update recent SRCU API additions to whatisRCU.rst
  tools/rcu: Add new APIs to rcu-updaters.sh

 .../RCU/Design/Requirements/Requirements.rst  | 28 +++++--
 Documentation/RCU/stallwarn.rst               | 73 ++++++++++++++++++-
 Documentation/RCU/whatisRCU.rst               |  7 +-
 tools/rcu/rcu-updaters.sh                     |  3 +
 4 files changed, 101 insertions(+), 10 deletions(-)

-- 
2.54.0

