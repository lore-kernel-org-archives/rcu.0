Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858290;
	b=Vv22FR6KR6UwQ4J4DZaxbizh/s2MgxOYwkluJAYM86Thp2Hl0a0w6fqHD36xOhG1vhY8
	 LdzFEUlq88lkjJ0gxj1boiuLhMTreUzCrJ28/YWHVjiKm/baUj9D7S13OHmG34bGQP85g
	 yieMLeGYXC1WV2aKJUd/SN7XrCHMbaiu8l8Tb9iwO1F7ddAQmDVmWg7Hq2T14PzK2t9Ph
	 627Dhn9nXqWtjNBr/LMLUK0R11XnCjRbIj9dHmUf8LZZWZS3w8mnIZyKl8w2Ap8x+sNpq
	 XgJkYICLjzLd6bWiYPJPupi2vKx+AEseXrVW+JRfw53waXEh/2XAAh96U2enpe8MVQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UpTG+yOXKDQ6ZkneekhZV8SvZTiW3tKfLXSDQpqWFrI=;
	b=a26dnP2bGj3Ks1mIAjEIHQ7If2TM2mxSGa/YGqxbhxtiftQimprEFvnw3j0SQw6MifW1
	 q8jNV/lmJo9oAbdhP5saxxsIDbz2pf4ZxuC35obBliMyaODY2jHPB+SA9wPhmJ+s97uOd
	 0T5XWCd7nO5cFZSXwieYDaLvT2s9/82Det6mYQEeuV4BxevZL6gwzyAarEdiIMZx+czBn
	 kE6MlY/BDazRYWtotri8oJN+Sxb7ukj3YvWY92xSLi4p0zWdPPRd8h+bnjAxPnDFSgpLe
	 CzDWbsOA1PN55EIej8U4m0WcHTCltQ3UK5l/CbgUmdJwfnNWABWjJj8Yfs+tx7DyjKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGQM25QT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C41AB606A89C;
	Mon, 16 Nov 2026 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGQM25QT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1C8BB1F000D0;
	Mon, 16 Nov 2026 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858290;
	bh=UpTG+yOXKDQ6ZkneekhZV8SvZTiW3tKfLXSDQpqWFrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oGQM25QTi8xfCx1iLpJijXnkLMvq86RmLzqM6LQDJeSiHXztpIK8gH5yDLaXjqGBW
	 wJiHGdE6RmDmzJ1eBoufeU9xLLJrUDoMTjH1YM+M8kmaiGhI/PkROvbwjN4SmdS3rA
	 RfyLXacly02WmpqbtLHpKETKimRJMdej3/6OL+rG2YIuQZa2oJsOoPqLa7kpgeUx/c
	 urDHz1eWfiRgSDyFMP+Av8bdcHS2/spmtAngGa2WKU4x9WZ1gPpfKwiSvnN9PeSsF0
	 EwynWNY651JJs6ZjLn47dyiFEdrXLlkxXDCRUYFK/TCvg1KDh+ff8eIvMth+VeOPq5
	 tXXIiJkWqUmyw==
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
Subject: [PATCH v2 6/7] doc: Document rcutree.boost_disable
Date: Mon, 16 Nov 2026 14:44:37 -0500
Message-ID: <20261116194438.306618-7-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116194438.306618-1-jfern@kernel.org>
References: <20261116194438.306618-1-jfern@kernel.org>
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

Add the new rcutree.boost_disable parameter to kernel-parameters.txt.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac97cbd98b46..8f91499b3488 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5651,6 +5651,13 @@ Kernel parameters
 			Set maximum number of finished RCU callbacks to
 			process in one batch.
 
+	rcutree.boost_disable=	[KNL]
+			Disable RCU priority boosting at runtime, even in
+			kernels built with CONFIG_RCU_BOOST=y.  This is
+			for testing the boost tests, for example by the
+			rcutorture BUSTED-BOOST scenario, and should not
+			be used otherwise.
+
 	rcutree.csd_lock_suppress_rcu_stall=	[KNL]
 			Do only a one-line RCU CPU stall warning when
 			there is an ongoing too-long CSD-lock wait.
-- 
2.54.0

