Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531471;
	b=IIa2WsVSyTvY4cSzRHWTw71VXjvkOE1LVPAVVATHqXMjNgAOfyjir75S+GO1qGKbcH3B
	 HqF3wWWyfgfARc9lnRBQEhk69yzDj+4oJaj0TWxUufvlKvGpuZgaRzVw2i+2FEmt73RVa
	 hKnZ3USVSYJwbRorc3+TSOvQk/PyX2nH4aaBbHUX/ED+FIIzJPuRm1SjLNh143U5p4Qej
	 uxjOwC6gsjQZvgvzmXlnkeQV9SMP4vbhoUivwcYcKNbY00smr7oVH5+eQV7yNU+CcFMwk
	 b8hMFK4K7W6aGQVJU7w711BtQD2UfrWcVhscVt/9Xo2olHk5OaL+JfAdeRcWi3x4uXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l3z13c8KdCozrGJ3h33Sac6EIBn2Z2Lilns6l3wa2I8=;
	b=RYaKZbjpXxTA4H2KHJMntrFikFeQQUBh5TYaKsk5p5XzCNqVQdu6RZESP0D+D9rQiv+g
	 5Z8XXVeNq3Ea/VcodC75rn8Ojmd3pUqbc8SYSXm+LZ/endDYRuN0jBK8VaUxn8GbYv8JG
	 ErSNEczN9Xeg+s30HCMMB420Yz9uNlzMUrV9J0LxQzXDR2Uv+/WdeLP7CzE533VGe+IjR
	 ay1StGPfZL9lT60GeYc8OH789I7dgEOaUCZdFYV5buUZdSL9CwdOpgwBAIBNDov/fNMIV
	 JwUr5cKr/pg8zRQ6IGlQsKKq9cXHqT73yENd7nuCZfadgZc6mBGF8oQ8tAPTNL5hO8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eS/c8Cms";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E3AA6606A323;
	Fri, 13 Nov 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS/c8Cms
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2BE3F1F000C4;
	Fri, 13 Nov 2026 00:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531470;
	bh=l3z13c8KdCozrGJ3h33Sac6EIBn2Z2Lilns6l3wa2I8=;
	h=From:To:Cc:Subject:Date;
	b=eS/c8Cms3oS+oE02RIOaXDm6uWI2KNLjbTgpE7JJFBxQycdCglvbqIO0LvlqWf/RD
	 AcCkpB5Qeljd6tSGclzTI7ayummgg2k2WlJdg9qqCQQNpOEM4ILAdgqJS8Ba0/jjL2
	 MYmope84tFC+tcoOxblF4YS2dY9G7UoZoKcEvl8d1XS4yXV7HDtYR3A0tZbuG2bnvB
	 vslCEgqmYeCME6IRUE3xa5S38VweUGCNEy6p4BlfAWVgQdltL7yPC6zQoX5QYEhXs9
	 AO0SHiYn42P6pFet2kbcoOaOna9S4TJf3wChqglpN61Z9gYtaiNqJJsSZJ/+vnIfPg
	 mNP7Ust3M1M1g==
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
Subject: [PATCH for-v7.5 00/14] RCU tests patches for v7.5
Date: Thu, 12 Nov 2026 19:57:27 -0500
Message-ID: <20261113005747.2977123-1-jfern@kernel.org>
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

This series has the RCU tests patches for the v7.5 merge window.

Fu Wenxin (1):
  rcutorture: Fix busted_srcud crash on module unload

Joel Fernandes (5):
  kasan: Avoid an unrelated RCU warning in the callback test
  rcuscale: Consolidate per-writer arrays into struct writer_state
  scftorture: Reject empty workloads before starting helpers
  scftorture: Protect the initial affinity check from hotplug
  torture: Forgive SMT-control failures in CPU-hotplug testing

Kunwu Chan (3):
  Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
  Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test
  rcuscale: Add srcua scale type

Paul E. McKenney (2):
  rcutorture: Enable RCU_BOOST where supported
  rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios

Zqiang (3):
  rcutorture: Fix suspicious rcu_dereference_check() usage for
    trivial-preempt
  rcutorture: Make tasks-tracing support duplicate call testing
  rcutorture: Avoid create fwd_prog_tasks for tasks-rude and srcu-atomic

-- 
2.54.0

