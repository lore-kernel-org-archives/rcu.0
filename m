Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A51BDA91;
	Tue, 18 Feb 2025 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857564; cv=none; b=BV7WuC/h5qecR2gutjNrBWC+Mjilv7ij4v7EOucbpeekmVI/GQ5Ru5Mh4N9edruhYwImK41nRF1f8blKV2gZYoDE7FJeRInUnjKhjva7GUYClNu1rSnQ4zrLWTlinYen1KjP1cUjqhblKwSoKzknvKdyPMNUs0+hSbB4mZvv1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857564; c=relaxed/simple;
	bh=SVKo/5gLmbKnQEp50nZawVJcERWFrqzurgjroht0oMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVEUlxCcpbmbBPXEOlZzA6ktdBtFRIq7ojpv494NogWmRKECjc0bMYhiD/j1Iu0+QnW4iqkEHmviAL931p6T/YKtviS54bmXlNH4GgGqQ93hBWs16icydWd00C3i7bO/0HzOFIlkfodwdkNOhTuMChGQu7uEIoShf1emhsrWuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNaCDHEX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNaCDHEX"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0970e2e79so315252585a.3;
        Mon, 17 Feb 2025 21:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857562; x=1740462362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Ek/R8Hi0E15SqkOu9AVo8oTZDPYXJVZ85ePqaSyeVw=;
        b=HNaCDHEXkXOSuD+zqugJWx6d21OMnnztD284nQiXc+pb6Uj6a57iB08yBc7Ht2zCkA
         Fc55zohduObaY0LNAfIjLniHYd9V33vAm29J9odmWUFaDc1M6ahQo6qBJbF/ZBz3sc4G
         YapZkT8XixqdSvsW/Dx5+NOxR/f4kYWoIrpYhQHnfd9CsiTvlJ3FpCUWkTXYXScM1R0h
         Lo4veY9QbOX0g8zB7wQJP4Y9yh+P+GLYRfSiet2DtHlVJ1FIhb7lVxpnEtTXeLKMZ5Gr
         4WrtPFYvFIA+6yGTkYaW8fDO1sIPviWSy0Q3Rn2FL9Po8hCrTurpQy764MZF6IOKXMMm
         vWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857562; x=1740462362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ek/R8Hi0E15SqkOu9AVo8oTZDPYXJVZ85ePqaSyeVw=;
        b=drrDFprLYPKt7fIcXtBE/IvJFhx2W6FSbpeH5TwX+/XVcHxK+Xo1ikPLV2I4m3s67x
         SyyT1hF0ZUXF5AfiF0aIhmpsHPUZztRzX7aRVpcURf8gLoKIiXVpE+ZMq0+wSBOWW9qx
         K4nZoeYZ5P/d/Lz72DalKqQ6xctgonqiLONBGMch7FC2iWu3PdTyWpHOGnCkmNp0/MYV
         QBbIDzTemyj4k9NhBGV/TMLSvT99y8Q/WoEGhueD2+1V5rtpPVuxORpigz/D7MzcNZ9p
         5/DhjhgbndcVAA5sib94mqSFc9k5F39yl/XnGilk/yQVOtFZUOgVBRfOxbhGw7xyWiFH
         1wjA==
X-Forwarded-Encrypted: i=1; AJvYcCU0hjGXPAWrhdEtpAlUfHntClip152CgFoZMmxiPkcNlKVY5ZiaJxjTOe5wBbQO1kX6Z2wLJP8LFqzc2xPk@vger.kernel.org, AJvYcCUicnKmeonR29fituoXcqt+ibtVG9Gs6A1EUrZzijNvezKJzZp8QkS8amzArfRIWQMHo3gpQm2jiuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdCrfHaN0PX1W7bE7eCO+6t7RsKng8kMtYoZtAnvBtWPVBbsc
	ulz8AekaCpai8bJyWXNKGYTHxF4bLPk6bg0GHQek1eqozJyqnZo8
X-Gm-Gg: ASbGncsNd9HChD556IYDTp6KZ+gy0AJANdEaZrOSXMifL1x09YvGbZM1r0ktXOnaBhF
	xrmqIkGwsnziv6rC5Jm0l9dBv/RENAIb0U2dxX3Vbr0mZjpOHK5ymaeKOokw+GK5rvhjYHFp3k6
	VId+HdmIGyEHcvImLHNv1l/ehXsB9XuMKrHaxGXwr0XZs5eYU+AXKbV4q/cBLB4tPq6Bfh3Ox2i
	RC2l4cg3l0JiWtJDcJjBcrK1dPS82eL5qSLjHxL2jE8wbMWDHsQqnYUuJgp9cRdVXVNXNFXmu+i
	txhN4LOJSyLvQvAp2vdEGQ3cCK/DPoNyFdEAZ9MBsLOMusrcGMkK1FdRJfmpj5EWBcT7VXOVACJ
	EX5Inlg==
X-Google-Smtp-Source: AGHT+IE+jZADXT1WftgC47lrepiElxgQ0jGHyauZ55yN3mAwZXV4I60zoEAVM2f6IITuz/AD0ZdAcw==
X-Received: by 2002:a05:620a:290a:b0:7c0:69a0:d9ee with SMTP id af79cd13be357-7c08a9f54b2mr1672320685a.33.1739857562058;
        Mon, 17 Feb 2025 21:46:02 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ac2bc478sm63711185a.21.2025.02.17.21.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:46:01 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2EB9C1200043;
	Tue, 18 Feb 2025 00:46:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 00:46:01 -0500
X-ME-Sender: <xms:mR60Z_bVPbisQVgKQW4WKGFWmJXnNaoADQhrwsCz0WM0GIs6QxIE4g>
    <xme:mR60Z-Y5Tduj42FkXlh0qDKSKPQGxc773sxO-0Qo-UUOlAv0S4SJQ3dr2P7sjPqGL
    fUd9iXQjOh0lkrBjg>
X-ME-Received: <xmr:mR60Zx-jTo3xOuP_Go-NidhZfZZqf98Q1G2UiyHt0sWiHmAuYbVWEx7m5w>
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
X-ME-Proxy: <xmx:mR60Z1q6gFi1P-ctqpd0udx8lQAsnCGoWhBuLMrQVxNqz8wPncblTw>
    <xmx:mR60Z6r4d2meLlzfjMg4XpImz_ayMklsZRXwbJUisS5Ixdi1GoW1kQ>
    <xmx:mR60Z7Q4HNt7mBShx7V6xkY59v-bER21zpqOI8oBP4b0vtLBotklLQ>
    <xmx:mR60Zypug3bLoolHwnSZxL1vwZajtfe_hMvqZ7eSvuq9jFQ5HyEYdw>
    <xmx:mR60Z75wWI7Lrl2yUewH-ugNKn8fjGpxyiU6ehZq2fGrxgeRidyc17CU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:46:00 -0500 (EST)
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
Subject: [PATCH rcu 5/7] rcu: Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header
Date: Mon, 17 Feb 2025 21:45:45 -0800
Message-Id: <20250218054547.7364-6-boqun.feng@gmail.com>
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

This commit adds a description of the energy-efficiency delays that
call_rcu() can impose, along with a pointer to call_rcu_hurry() for
latency-sensitive kernel code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2cd193ed854c..780e4b30febb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3172,6 +3172,13 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  *
  * Implementation of these memory-ordering guarantees is described here:
  * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
+ *
+ * Specific to call_rcu() (as opposed to the other call_rcu*() functions),
+ * in kernels built with CONFIG_RCU_LAZY=y, call_rcu() might delay for many
+ * seconds before starting the grace period needed by the corresponding
+ * callback.  This delay can significantly improve energy-efficiency
+ * on low-utilization battery-powered devices.  To avoid this delay,
+ * in latency-sensitive kernel code, use call_rcu_hurry().
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-- 
2.39.5 (Apple Git-154)

