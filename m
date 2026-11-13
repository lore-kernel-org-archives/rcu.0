Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531029;
	b=MqAaDPXWyctNJAhdypnL9zmE7a2E5E557kY8eYXjg3pe9oJIpSu3vtpdPu7Bn4pl0pcZ
	 J2vykffk42umQlWjmKKDUJ7LnW2+GhqzAijPRy/Lt7zLYWMyEKsSWXwSvC8A5zTLA6Olc
	 99vOXVtT6J9nJjbOMU+JqucWVwbyeNoQ3aHAZFNBf7TGqfMrp3q42ke78NAbiNhgU3EyF
	 j+jMd7Ep/+7wXc5fmzeO8N640ZSbINtwFtP7gLFzeaduxEUKUlud+knZiJIKQb8t6mD/O
	 tu8sRSGNrkqAWl1LAHsKOwqLXvV3MkSW+48Lqs/6pytP0T2F2yfz0jk35uRKan5ihJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jVfyoLnDGmmilsJ+3jf3unO3KLgq7TUTUHr9b1lHMBQ=;
	b=J2uTbVThh5731SRCuPeWcOE+xfBxsX2tVozlBoKThEvGHO4QzhwR75dK4cV9bu/UCyvZ
	 nVGP9rfJxwRDdU3/2qxiNoEh8gfTvp4d/Cv7OkMpa9NVEpOCbOE5Mi5ICz0K0xTntxoPw
	 ZboUqSN3j0JSVI6JJCYKzWY132PlNiC74C7OQugjclGMsYVnYMJlFLFIbENYZTneLjrHi
	 5W+4JwKyTikgnH9WdrKHZuo03wOlr2UnPe89yQUuPkaEt+znbo9hx1Mre72ioQId21wBL
	 2yDwQ7Ij2GAHCvjVYv5uASXBtYLFCoiaw7CQ4wgr/hlZXOVRbGTIbj6ZdmQFMUO4VFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itNgnD5m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1D53F60A380A;
	Fri, 13 Nov 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itNgnD5m
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9385F1F000C4;
	Fri, 13 Nov 2026 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531028;
	bh=jVfyoLnDGmmilsJ+3jf3unO3KLgq7TUTUHr9b1lHMBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itNgnD5mAfcKhA7/eQf+6jnWrA95phtIHIUM3hzGFtlE3HGg7BKbZp+6DO8Q+8Nws
	 slOhhC7rISGBx5/VmCTHD7M51XQ+K3ztvvImJKCrKXdzKjNd847v4Glbh2vW59kRel
	 +duFTiF3n8Q4R3LfNWFfhdy65wvUpEH6UOncDPjx9KZQ3V+QH1jrzbOzn+XRR+gjAO
	 Zsm6nUTXeT1vEZtlbnuxpjXQRfu3p/bMO7aVVNrVW1yGXbBwp4oKrf8YUfs20b8hXv
	 iBPIZtlSgU9ogeTOSY3u2Y0aNgkY1H7+vco3nbUY2sWQJue0eC4KRy9MpUrNmB7t0u
	 vf5S9E4jXiHNA==
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
	Zqiang <qiang.zhang@linux.dev>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 05/11] srcu: Validate callback arguments
Date: Thu, 12 Nov 2026 19:50:07 -0500
Message-ID: <20261113005017.2772440-6-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005017.2772440-1-jfern@kernel.org>
References: <20261113005017.2772440-1-jfern@kernel.org>
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

From: Kunwu Chan <kunwu.chan@gmail.com>

Check callback-head alignment and reject NULL callback
functions in the SRCU callback registration paths.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/srcutiny.c | 7 +++++++
 kernel/rcu/srcutree.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 3ee28885b96f..98864977bed2 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -291,6 +291,13 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 46fe2f0cef85..76f074f67299 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1532,6 +1532,13 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
 
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
-- 
2.54.0

