Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531065;
	b=mnpA71BG/8t/xRbRGGX27fiuhKR7HT3tiKXU0H1xp/URugI4lwyJzLlp4w07qDM+IpDi
	 42N4zfepMl/pQf3w5aJ1jW8Bm75U/N4Rurx6zr4jTc3fcyAt24RyVOjnCd6n0F01kRr51
	 nCbUrwvunRHNKJ2bVeFwX857j/YgIncRlTuLZlpiCZeAtyoBEXqgdhwm0cT2GrklsCkFv
	 5DuoYhpjdFuWTF4ncvJGp97v1GEVQX2h5WfB0SRR4t1XCXetBUlULV8wnnWbQkW1MZD6w
	 ALEEfMqsws5q/1rMQDCdaJwhaAQaGCws2x0Qwa36HphUziB0nkz6xSSq4dYoe8eQNSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y4EPc7LQ9L+uSnT4Nwfj3eeUKO46+ppEOHVsBuNwJr0=;
	b=GQzC/e4IQP1Aq3mnB1CxO+nAuX/is53mFwSDZJP7zQVYf1S+9FpbrK2Dg6n2vWzYHBU5
	 VwvaDVEjkkXKL1nJ7MZE2r82MimN7AZ5ZzR0/vNFES5AH3DtHcuudBKkhMqyFEOM7bUZM
	 vVLOdFZ3z3L42JhuIjvqsq2DsUhCAcoo9dIknJDiuQUT0SSIJeoR+DfaUYsx+Nu9BPxSv
	 7uXTK/DNvoKyb3EBuZifIQi7XT19LV6GnQ9nfx67nOekRuidx3I9bZc05ylu//DL1va92
	 A6Pq4HVAoIY+7/2QcK9FRfrNFb1DBI6lVWu7KyLvuBUNrCu+TBFWzyQ87cK7ltptN9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Vw5JXR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 53850606A881;
	Fri, 13 Nov 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Vw5JXR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D49941F000C4;
	Fri, 13 Nov 2026 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531065;
	bh=Y4EPc7LQ9L+uSnT4Nwfj3eeUKO46+ppEOHVsBuNwJr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1Vw5JXRPoeZVWKb6J1dBfBZ0f7gQamkbS9lvhMCD4y8FcZPYtNSn0A19mN19ChgK
	 sXLMgh7iB9ehY4NOxhyEpTL/d/krac6fuZ/WkXNF3PGppfuQ/KAiZUNOmIT3hFJtf4
	 GQu7j9HU4DNfXk/2A1O+cXhtanbmKkVeSD8FpsGRUQq206jErXOvSP2Hoti/JKhDJk
	 1YyfY0zLBewbaD8oq9+hwCITP+bWXbD93Q9w0NCxwmhZ8VJsnuBijM8+5xvu+f+Y8n
	 DNztTbMch72X4+RKjxv9Webx6w6WmdNJM2Pr59E7mXaO9xKyXcNqX02y4fhwco+kpy
	 5a65Q7Mbh/WXQ==
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
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH for-v7.5 1/5] doc: Update recent SRCU API additions to whatisRCU.rst
Date: Thu, 12 Nov 2026 19:50:50 -0500
Message-ID: <20261113005056.2793983-2-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005056.2793983-1-jfern@kernel.org>
References: <20261113005056.2793983-1-jfern@kernel.org>
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

From: Zqiang <qiang.zhang@linux.dev>

The commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
introduces some new APIs:

srcu_read_lock_atomic
srcu_read_unlock_atomic
synchronize_srcu_atomic
DEFINE_SRCU_ATOMIC
DEFINE_STATIC_SRCU_ATOMIC
init_srcu_struct_atomic

This commit therefore update thems to whatisRCU.rst.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index e6767baff2d3..75c50f2f6d79 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1209,11 +1209,13 @@ SRCU::
 	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
 	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
 	srcu_read_lock_notrace		poll_state_synchronize_srcu
-	srcu_read_unlock_notrace
+	srcu_read_unlock_notrace	synchronize_srcu_atomic
 	srcu_down_read
 	srcu_up_read
 	srcu_down_read_fast
 	srcu_up_read_fast
+	srcu_read_lock_atomic
+	srcu_read_unlock_atomic
 	guard(srcu)()
 	scoped_guard(srcu)
 	srcu_read_lock_held
@@ -1229,8 +1231,11 @@ SRCU: Initialization/cleanup/ordering::
 	DEFINE_STATIC_SRCU
 	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
 	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
+	DEFINE_SRCU_ATOMIC
+	DEFINE_STATIC_SRCU_ATOMIC
 	init_srcu_struct
 	init_srcu_struct_fast
+	init_srcu_struct_atomic
 	cleanup_srcu_struct
 	smp_mb__after_srcu_read_unlock
 
-- 
2.54.0

