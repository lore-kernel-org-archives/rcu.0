Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531483;
	b=TrL1lQOgU0F8JL+jdcJotsBQ5dAP1vbRdiH64UOdBmKJYtX72mV2rCZRRZ0ESAss+FSJ
	 dzwba09DlQIzulzsjXwgIj6eRy9RJw56HvxJwk6QYGBCB73171HUnUEhBI91kD+RrZsPf
	 OfiHzIGLlD2auQb5lCz5f/ao43NPBavAkUHaLUWXPq8CyB4djNGS1OiIJavJ1zwbZ4Vxs
	 nWHJAjt6diz19877rMdnhBsld2KKEyU9z9NwOJpFZfJ3o+k+HwpHglnm2rWgB0mOPMqXE
	 d93qOEFD1cSQQ2y8Pz1pMjhPyzlRz8S8EeoII/Mw0RD8UUzT42Z5WJkeZg1S5B0du/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WOyptMnqycF+eH7UUTgEEsSPZ7I0sLzRIjLPCKYpGhc=;
	b=fqzfessF/BUkgylpVNeYR0mc++5gMjAZHYArWIoztj0MznHjdUibjqrL1trdlh2DXQgp
	 ePFFnWTTqMjV8KlGv5T1+IDfWivOiDgFnESjlPxn5SIa2oOT8SCy8XBN06dk6O1vRmVIN
	 SvZjp2LRGvp1marl420jJVUg+kf7EQEkIm0v6pOVzu2cvPBwTDIgf3N/wV3xcRwUis4Vu
	 mswJL9ZS9+ACT/mZcuqMIS5cYTVhUrT4TxAtilzk16CfTqxqw7o7QmX8HzeS4zOo28yXQ
	 BgHhKZrivJeG+FAP9vQ4r53sCP0arQnveZuNDWCE7vuaTwAqMqdTaEByU2OOIoj8UkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cBwALM/r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0ED9260A261C;
	Fri, 13 Nov 2026 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBwALM/r
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8FB1D1F000C7;
	Fri, 13 Nov 2026 00:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531482;
	bh=WOyptMnqycF+eH7UUTgEEsSPZ7I0sLzRIjLPCKYpGhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBwALM/reF7JTLcFjC1iYwRHiDroZ29pNE+UQFlWoKunqwofQkszdLVt+BWshSkIA
	 h0Oa4iOMDdY0mjDHnMJUJlEo7diw/xL8DhE3blB62wnfAeLyClg0nYrEGn89Kyqfnt
	 kCZ+9FwOgg0vLifNsstlCCRCFiMbyJvcD9fzIx7+duvqvZbzpxpeCEnkutEcJ7N+Tz
	 ttZ4xbpPm1mFzQtGV0eDLchv+FnV1HY1D4XJsvqpz8RMMVM1z15MMaQrgH2SnZa8TV
	 TFFHgKxHUoWXYoWfxN13ibDrgGMKKYp/Sm3WDhCy2W8qg/Ox4MW88zickixvGuzcZe
	 qyYRyEecwZn6A==
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
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 06/14] rcutorture: Make tasks-tracing support duplicate call testing
Date: Thu, 12 Nov 2026 19:57:33 -0500
Message-ID: <20261113005747.2977123-7-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
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

Currently, Tasks-tracing has been reimplemented by SRCU-fast, it supports
the detection of duplicate calls with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
This commit therefore set tasks_tracing_ops.debug_objects to 1, enabling
rcutorture's duplicate-call test for the tasks-tracing flavor.

[Joel: On this branch, object_debug=1 already invokes the duplicate-call
test. This records the flavor's duplicate-detection capability rather
than adding a runtime test gate.]

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20261023094039.29696-1-qiang.zhang@linux.dev
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d60d17d14f1c..cbe38aa7ee68 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1313,6 +1313,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.irq_capable	= 1,
 	.slow_gps	= 1,
 	.nmi_capable	= 1,
+	.debug_objects	= 1,
 	.name		= "tasks-tracing"
 };
 
-- 
2.54.0

