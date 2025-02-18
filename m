Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF571CEAC3;
	Tue, 18 Feb 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857566; cv=none; b=X67Kza2YQHu//paPyHDja+uMZQ8z0ZLf8Fo9b8JiI7M0OWW56HodoXBX6fqehYcExVitDQ52XEnyyoSfcV1ScWxNPQLU8YWPv/leBpFDXPXS2OZqRvmlD/SI6wYi3wQr6YbkuzCU0L5wSz7BgXuVRk0+BAvyxpTEg4+SToLbCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857566; c=relaxed/simple;
	bh=gGX4FsCiXZJ8ZZ7+WoZlxvaI6QHaQESgtAxBsTbrf4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrxUoOcZTUe4igiyWUb8EWUpGjOp+gwEEI7gz7bOefeU8eeoiaEpg1rptvB2OK1bbkPJ54c6K/L2DjQcryxC5grrlO5RwqCK336B3TvIBoeqv+E4w1uwRwI5ryhhrcHlOb29qHcqcvEfEOhrgQa+/jQliZ1a/J/yr9fkmvK6c1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoWPodqn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoWPodqn"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e6621960eeso41295076d6.0;
        Mon, 17 Feb 2025 21:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857563; x=1740462363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ti+Pk+mBk7PK8fxnF7pRwhz3z0nqohliniWgvUQSKn0=;
        b=VoWPodqnd/TCCxyWymN40byYwKBOJRVJwQCMcH4m29WU3VpuBZgU0pfEkBslO4phaU
         ubkVJqPoU/d7hn/+xPqwEUrGZGQwh1GTEw+zoV1WKK4ZahfTB+p6N775wS01YtgoIghr
         xmItY71ecgtUMD6/pIK+55b7JRa5t5cB7GwJL6FMLWortC1bp4Jk3k9tWBBah4LwvqVx
         JVrIe4tuTf1Gr3kwdCsKObIX+d1Hn34aBK10WN5Upcev5Bzc8fOvhvpiiuHZy2pXNn+l
         lqcMSiKfyIIGpLi8TPcre5ybV6K6LlrEBFjep1GEH3Mb44hRFuG+NdBX44BU1Uk2bAeK
         TIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857563; x=1740462363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti+Pk+mBk7PK8fxnF7pRwhz3z0nqohliniWgvUQSKn0=;
        b=ANvQVPlyI8U6ZgI3YipzJM4p/yBANed6xOtTYRqr3DUxNJgXYjoq0si2RVjFort5Dh
         +iIu8IH9cDM8NdcWTVHA38aaLQ5qMQcwBzHFvSZswOZWuAkH0kxgORoJIYuwrfyCQ690
         pCpY93L496AjLEYM/4LIOsTXPCAI5j3KzLIV/w8U6XV9PJ0FmRnFi1DSJBx2b+E7boCm
         qEvEWT3As0WOOq9mMFJ/8NdHOdqDAEmInI5ZfwncZGEnBFzmot+KiCy0TdKPfa2qOc/6
         /s1F6Tuvnv2bWsjsZQJZOA4LwCJBRmU8KwBN5lNxYijjLvyoRWp0e/Z44NnEo3iJKQhH
         UG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI7MaGViRKD5+djFgf2gMlPnupRRiZv8phWA4awBOWHBxvYLT8ak3Q3SjcltZlts5OvpOJqvamvZA=@vger.kernel.org, AJvYcCVqlvDdvmbwShrV/WPnhZ972K+Pfrjvp91HrPqxhsVM4UznE06CVroldg5UrpOyf5DLbFatyaWiwgspQTCN@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm4a54OsCjtkZCTflEUujJrSaoAZ/nyHQwp/fdoCcAVgeJUXF
	DgguQDi7SIjkUkVjc9gE6KLjkqaDsXu5BrNYstYLfegxXqnIvFjI
X-Gm-Gg: ASbGncscZ5M0zGJ/LFuxewcYdxC14ZYIZWLaB8h0l6Oh4aBT1M2DAFn5gCXS2vKH2Ni
	PoLcQHo3N1uDO/Z/EnHrEJd8kME5Yvv+KvQP8bulaeaUhGoE5lx8BBgz9vIBS5/my1e+6PgCTRN
	ih5HTu5T7iLZ3Ivo7cSdSu302S+xmZ8nAnxLP0WUeA2WFl5Zo+rkwT0reroXmtRwiSh5BxWjpvD
	IBW0+EJ+4CVK3LPTOMadjkEna3766Oz3gwGS+dmiF70aJBdRkxT1shAhu+wUgzpmctoLXtXMcI7
	8yb4pUdGdAX8cleTu0uZJI+NdVUQvKiLdaO3jV1eV494SkcK841KWjWFOuC92Ad5S2uUry4mYWv
	IcvpvLg==
X-Google-Smtp-Source: AGHT+IGXjA0SVcPAeRrYT9L9owbyGfR21mZr9aSl8Vj9CbXvXgYISkJyHB0OXrwPypzsCAZvWUQB/Q==
X-Received: by 2002:ad4:5e8f:0:b0:6e4:5f2b:9f15 with SMTP id 6a1803df08f44-6e65c8fed77mr273991976d6.14.1739857563558;
        Mon, 17 Feb 2025 21:46:03 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a1f089b2sm165544485a.53.2025.02.17.21.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:46:03 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E12F1200043;
	Tue, 18 Feb 2025 00:46:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 00:46:02 -0500
X-ME-Sender: <xms:mh60Z3bJCwy4TvanRA-86uWDw6K0vDc5tuHDr99EE1_RWE4tR_nt9w>
    <xme:mh60Z2bnwgwL4aowgFnfYvUJUFGMFb4YssRvvxHjIdW4sw6k0LhWOxZR15itrXQET
    5i7ijayH-C8liYhPA>
X-ME-Received: <xmr:mh60Z5-CSkjku0MdYAHTBHCaqPF3JQLPHxZhM-Hs1XKLkURKbE50pkkUTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:mh60Z9rji0oLaPSTQjSJuBZ1PVKkiOOcAGa8NQhQQagCJSzY3UPoFg>
    <xmx:mh60ZyqkgcH5Lt5PZvZ9GxCj0MYKgA_oYS-cKy_lCXDOxiCZV9gqnw>
    <xmx:mh60ZzQ-TyH2fqMzpSmkxNLi4cf1jb8Mnl6U-WNKiXeWN48T7miWxw>
    <xmx:mh60Z6rFLUPAsCy4XU12prTJtlAmCLZhXhHapXMUOvxw9PPhWWEnNg>
    <xmx:mh60Zz6yfGe9STtcJiA4cxRI6rTj-mW6qG9lUaVn4mgH-i7SMY1uEXnl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:46:02 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rcu 6/7] rcu: Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text
Date: Mon, 17 Feb 2025 21:45:46 -0800
Message-Id: <20250218054547.7364-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250218054547.7364-1-boqun.feng@gmail.com>
References: <20250218054547.7364-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit wordsmiths the RCU_LAZY and RCU_LAZY_DEFAULT_OFF Kconfig
options' help text.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/Kconfig | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b9b6bc55185d..2bb22dac3b5a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -323,21 +323,27 @@ config RCU_LAZY
 	depends on RCU_NOCB_CPU
 	default n
 	help
-	  To save power, batch RCU callbacks and flush after delay, memory
-	  pressure, or callback list growing too big.
+	  To save power, batch RCU callbacks and delay starting the
+	  corresponding grace  period for multiple seconds.  The grace
+	  period will be started after this delay, in case of memory
+	  pressure, or if the corresponding CPU's callback list grows
+	  too large.
 
-	  Requires rcu_nocbs=all to be set.
+	  These delays happen only on rcu_nocbs CPUs, that is, CPUs
+	  whose callbacks have been offloaded.
 
-	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
+	  Use the rcutree.enable_rcu_lazy=0 kernel-boot parameter to
+	  globally disable these delays.
 
 config RCU_LAZY_DEFAULT_OFF
 	bool "Turn RCU lazy invocation off by default"
 	depends on RCU_LAZY
 	default n
 	help
-	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
-	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
-	  it back on.
+	  Build the kernel with CONFIG_RCU_LAZY=y, but cause the kernel
+	  to boot with these energy-efficiency delays disabled.  Use the
+	  rcutree.enable_rcu_lazy=0 kernel-boot parameter to override
+	  the this option at boot time, thus re-enabling these delays.
 
 config RCU_DOUBLE_CHECK_CB_TIME
 	bool "RCU callback-batch backup time check"
-- 
2.39.5 (Apple Git-154)

