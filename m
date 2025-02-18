Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895C1A9B48;
	Tue, 18 Feb 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857558; cv=none; b=eoNKKUOpPQf3WazKrWcSxUFvrVxp/UibZd/QK8IHT/l00kn8K1s66ImF4KYCcogMbkCpMoEebwF7agkO3fnO8QSHuOFWdS1wn4hqFMH+bGqxq05ujXgZRqQ+KQTkLPHiFWfCJw7Qpc7Ovsp1gIzFohQii8FJBHK7r5vlYc5Y4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857558; c=relaxed/simple;
	bh=FNC3ESzhdnefYnWfGSSwUKkIovsievffBMv39YwMHyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LM5juGzzpTihD4L781EESYwbvKLmCJWHzdZHee+rM1SeOOyjMfPUY+3zsH8XLx43B9mW4vwZyMEMOjnxW4GGwHRq8jei/wvDX+C1K8scE6sTG9ytIM0GPvYpp6Iu7pLDYydnJNA7jDlqEUQIIwtyyMj2Oh0IYrv8czUWE/1yPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abBUv83M; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abBUv83M"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471b5372730so65654621cf.1;
        Mon, 17 Feb 2025 21:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857556; x=1740462356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8900xQNk0yNWl72dpFSe4bBu/GJDB2jdwCOQg6tQUXw=;
        b=abBUv83MDooueHrx9Q2eCGL5aSs/VmWW5L+pTF10fI0U6KO2Q9zlBlua2aVXIRS5ig
         OLK7907GCbQLrK2qJ/lLECGAfZk7EphhhX/gOJv/BU2bKMVYQ5A/63TY/+3n3ahlg0Oi
         keks7djY/Ov6E3j5dQUAP20pdQsjnvo1vgsteGaxQiSFzbAGr+oeEtS/lo7Qs43Ry74E
         i3LofXYAn/BiCvktTsSr1Bl2mjLMqfLkQaNErIhkl0fdPARC2bctAt1btk+hELGnhU/+
         WUqdU6CAzV79ejKS3EDYp5PiENlUO+Pg+HR8Xnv50FvepNLIMrMeicHdHCDY8hiiwOqi
         b2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857556; x=1740462356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8900xQNk0yNWl72dpFSe4bBu/GJDB2jdwCOQg6tQUXw=;
        b=CVZX+abpUvb+mAgBIXbOeNBLRnIaWU/+NTHIhrFnx2P5vYtKMD+YfVLEpRoybBx2GZ
         yfTrSNgGAH26Is5QsYSNJYe3XzGRSplI4dJ+WCJ6Tf2s16nXsLa86GgER11Bk+ExAwOi
         3AZgHH4QOaJTM6ZEPFVZ5x8Ey+qjcFqAyE6TfsbzCQ3/kH6S0OcEUqoTmKmgGzEVRHiB
         nPGEzkbtSJaf91iVnSoBx100zsGI2YKjU+L2yTnFMRWaYIKHpNqr3HCt6lkuZ6nBr6z4
         iqTJfyE3ddDq2TCO80AfFlnXZzR6soVp/q2vQBWxvGwy7v+h3VSc2Vh52k2Y4MYujySS
         vbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXemDf79E9JZAGEY6mR6WBNwWkN+PV4fxOxcB0gM8KejAqlJ0+upCBJRZG0eEGANkhsAhY6JF2K05o=@vger.kernel.org, AJvYcCXqwQoJpV3dvFikbVcbyd3SOXxOaAiESfzsrQ5l32Ai+cnCHGvk1Q5mgyipZxtsodQR9c8PX7QqfhE4jCW2@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSha+7tC8HYLDaj5qbNqMZmnIgoJpWNHy6ssaX21KbjmlhaTh
	ONXQEUcZVo3NCtwxlSo1V4z0+wPNbpLZ7RZwC/NjoZlfLF7OwrBy
X-Gm-Gg: ASbGnct1vdsv7u3f7uVQNNg/lrIQsJvjEEZ855uPh3EIlZysU7KD1usX3lttYbqXWO0
	DUB3cCZ31V9pNy+fDgvZOiqh3l3P5WVk2cg1qymVuhPD+/+P1YsDdDikORw03phLPC/APWlKwgX
	lRI+0XcHJnhff23AyxRXpgcCtlFcOEC3PAm5lLKpfRb8smhOSi5i3bUSfl/CBagNvYNgxjoKqtX
	0ztnE4Nxg2z5KfTxpdhYuoTJX2EHs8TvfgBiDt9R0IymqbL9/dU7FNOtnhUtUcxkAbARW/JDSd/
	dzsTYvDN6NgaMwhlHqK6cefKOHVfiefzefMzHn4wQEKeM3q5M4oQu5hUmAEC2WjjBNcBgrHbdkP
	+nnqCow==
X-Google-Smtp-Source: AGHT+IEClAWnk4HlCe5BsrZlJ1ndipvs0umm1ENZRk5e7iXAcUlLyX0HZTrIkd52R3H0ji/u6pIScQ==
X-Received: by 2002:ac8:5990:0:b0:471:9bbd:83e7 with SMTP id d75a77b69052e-471dbe9e46emr180601471cf.44.1739857556115;
        Mon, 17 Feb 2025 21:45:56 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f194f857sm18398031cf.5.2025.02.17.21.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:45:55 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41E4D1200043;
	Tue, 18 Feb 2025 00:45:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 00:45:55 -0500
X-ME-Sender: <xms:kx60Z2bz3nvLb68xP1nsSR6QpbsfWb-977xTZ_XGthDWX6kZoNSeOg>
    <xme:kx60Z5ZimSp_Lf2l8nTx_8v9Z8EnVqLXZCO09L_dIG58YFvfpC0wfRAHCveYccFm-
    8gD2sAR-zsP9b15ig>
X-ME-Received: <xmr:kx60Zw8Wit_OLY0twW_5PMh5RVjsSPth2UDp5KzSnAwR-RaIE_6bymkEyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
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
X-ME-Proxy: <xmx:kx60Z4pKVNoRI6vFWpCKbGO4Tzsjw46H_boQEgVFtyKT6mzv762vKw>
    <xmx:kx60Zxp9V1CdA76NIL01TIVSOqmHmtPrgQ0eza8jdsaLkhD0Tq4wOw>
    <xmx:kx60Z2Q8hDBb2nhXVXL7glzL_PXghn7sDQHbOYMssosWtbawwywWbA>
    <xmx:kx60ZxogXU1FPGobyKFGGtrftLX9QppVRfHB-DGiTeoCgfn3Q6Xjog>
    <xmx:kx60Z-7TJsgglVpCsgGcYj8kWxan2mVBzPIp9oxEgQeYtlYFs_LA3eYj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:45:54 -0500 (EST)
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
Subject: [PATCH rcu 1/7] doc: Add broken-timing possibility to stallwarn.rst
Date: Mon, 17 Feb 2025 21:45:41 -0800
Message-Id: <20250218054547.7364-2-boqun.feng@gmail.com>
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

Currently, stallwarn.rst does not mention the fact that timer bugs can
result in false-positive RCU CPU stall warnings.  This commit therefore
adds this to the list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/RCU/stallwarn.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 30080ff6f406..d1ccd6039a8c 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -96,6 +96,13 @@ warnings:
 	the ``rcu_.*timer wakeup didn't happen for`` console-log message,
 	which will include additional debugging information.
 
+-	A timer issue causes time to appear to jump forward, so that RCU
+	believes that the RCU CPU stall-warning timeout has been exceeded
+	when in fact much less time has passed.  This could be due to
+	timer hardware bugs, timer driver bugs, or even corruption of
+	the "jiffies" global variable.	These sorts of timer hardware
+	and driver bugs are not uncommon when testing new hardware.
+
 -	A low-level kernel issue that either fails to invoke one of the
 	variants of rcu_eqs_enter(true), rcu_eqs_exit(true), ct_idle_enter(),
 	ct_idle_exit(), ct_irq_enter(), or ct_irq_exit() on the one
-- 
2.39.5 (Apple Git-154)

