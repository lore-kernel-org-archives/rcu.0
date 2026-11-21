Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275362;
	b=EVi3IL9sfQD52W+NP2Pm49LUAbnAjhbOhCfB++jDZUXD+TH1afUXNRUYdyHfTmEasJ2I
	 y+mEzMgq9GJ1NA23FBOZZFTvxUBhrIEzLq+gy0EDBoSF6fQeKlmKh0hUF7cnFGd8mhy9F
	 VYg+tVUJyOBTmDtwTEMXxK4YMVino5+57CUYNmdoSK379up8sVuTynb2JANveK6FkEeb2
	 s5fz70bbqvNmRgEYmYAS7ga3mGmy+tgO63v0Po/N8I8YgM4ZN8oEjAp/SYpESnQZvIfyo
	 9xMCf9U4UKcrLrfHPJtFU4Uxg4CoGJvROhNlvwEme63Qp2AtdqSF79rZhPkYjT7U08g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QCzRUsrVJH6ZcRbzmdnsbyjAvqZ9+MEIZ8zwHJoZbiw=;
	b=kwKH6OCkppNI0cGtBirSusonUQfefR2sfbP3cLskCaXfapOvkOzho/NdcPOABSRp5JqM
	 orrwL34uevoWQoaB+UfsUtvJWLENLp2qS7RYltbOjM7YfsP5yeZda1BcnfDw/pvvKI2+F
	 z3rSGU2pKo4HDNR2x/NB6zZcvkJWOaj7aN1EPhZ9Px4hSTqQmeUz+1zW/VwOmnq9qBa/t
	 f+fJNIVhKQ9nvKgZ0ju7c0Rp07LcmXw8pMnAkmF9gtAPXE0BinxNPvBCeNq3mxBjvmm4g
	 Ms8N3OuNkTbxntjh8HU58MvyHAgRhd54IKufJ1unvgb2mVYQntzkn3SvQArWz4/jX5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlbonoSg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7BC0E606A693;
	Sat, 21 Nov 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlbonoSg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E37581F000D2;
	Sat, 21 Nov 2026 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275362;
	bh=QCzRUsrVJH6ZcRbzmdnsbyjAvqZ9+MEIZ8zwHJoZbiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SlbonoSg6AfbgfU+hBULhu7HO1wBXRUGHTh2pYX6d2X+okXGzJNsMHnvTB2zJNo3a
	 JhTN1gLKmgYSYxvn6rRn0tVqqW4W9+h7kQLtTfI3YAk7CGsIL6LVyKvLRUKc2ssTHf
	 nT5TQpTKSR1ViS1QmxEYaco2N6iEOp1sA9gxkKrO18FKEZjNaxZhZ8dluY8k9Zrhn3
	 i/lbL2NPlbwNK9RejpXWVLLrqG7W0DI9pImWogg3Ki7b2awA7AZN86dkbAL25+7C90
	 s/SL+YkEwHWuuzjjS7tRlMFguja0ZpACRsrb0mXXan71FRqxL9T8Or6mPQDHpEol45
	 a50bh1rqgt27g==
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
Subject: [PATCH v3 4/6] doc: Document rcutorture.test_boost_reader_ms
Date: Sat, 21 Nov 2026 10:35:50 -0500
Message-ID: <20261121153552.68941-5-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121153552.68941-1-jfern@kernel.org>
References: <20261121153552.68941-1-jfern@kernel.org>
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

Add the new priority-boost reader CPU-time parameter to
kernel-parameters.txt.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 176648941aec..ac97cbd98b46 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6283,6 +6283,13 @@ Kernel parameters
 	rcutorture.test_boost_interval= [KNL]
 			Interval (s) between each boost test.
 
+	rcutorture.test_boost_reader_ms= [KNL]
+			CPU time (ms) that each boost-test reader must
+			consume within the test_boost_duration interval.
+			The reader runs in an RCU read-side critical section
+			while a real-time CPU hog tries to starve it, so it
+			can finish in time only if it is priority boosted.
+
 	rcutorture.test_no_idle_hz= [KNL]
 			Test RCU's dyntick-idle handling.  See also the
 			rcutorture.shuffle_interval parameter.
-- 
2.54.0

