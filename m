Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6A1D5AD3;
	Tue, 18 Feb 2025 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857567; cv=none; b=tomc0Tgby0AECMPqXarPNSZP5DB4UIu48Qu1CPKxO4Vc8q/XvcvciqgbJQvrMJBigpyOrCCM6I/U8jFxeLoz7uLi58H04c1yrni2bJuXH6r1qJdHUaxiMv/RKSySObK8YBxLdA5e4ftzjuBIAGx0fL5zWzIDgbxAYbzNNL+5u4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857567; c=relaxed/simple;
	bh=OfWXye8Of8O9FMlyzbA9MTX1oxKIhmqiEz/OMs6hb7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXoxJwBMGfW6Z/Z6Grb3dtQaxp88TE0cteyoFiOeRAQ7W/V9xFQKAxoxis4ZceVqJX6VwIcvBmtUQG/IXOjNX59NRl6JcQTHJ9IRNFs2Tw0/D+zj6ETeiu8Mgxlb3yTCFTRIfx5sQeVD91a1Mu1oDJYrb+CyCub8j9aeZJNE21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0IXA1wk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0IXA1wk"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e660740061so47300456d6.3;
        Mon, 17 Feb 2025 21:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857565; x=1740462365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGqcu9I3LwOV/o63af69yARDQi685oRGnRYvxczUj+8=;
        b=W0IXA1wkxoT6Wflqq3i8fVZmA2ULXfl1K9zUGbilO+n5zaEOk0rMEFda29tTPESNYC
         h+pOcmKAXIfp/rjjQdIyDH1SLKhKFPqd2tF5c18/1GuvwjTCMWXrUjGzNTebm89CFUKx
         qyHB1ujhbwBhQ0hPv5/WWZmjcRM8/dPYbyuZkIIaeOb4m0grIlg7mLfod73132V6Pku1
         TzoFGFg04LmbCrNH9ni2dPPI5EXKkVpdQfxkflpBQ7OONCZw0vba8VVeF6HQtZ19HEH1
         7mF70k7pOj9CQnomlgMfVqh6EQG29qLBv/rrIcPhrqVtp2RBnd5+WEtOUAqTEDnzzy5q
         GqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857565; x=1740462365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGqcu9I3LwOV/o63af69yARDQi685oRGnRYvxczUj+8=;
        b=Ob6hGWPrQAWqz/AQFjLNVGFkH2o4d29wEd5msr5IgqnyfHzetHZ3wTYBShC4NnmxaT
         wOOSxIp9QFTCV+BaJHIYE1lWqcwqExHgOukJPGNl/xDUfAw365WlAq3bH7wi8ZTXgT0/
         V79hWUYJ+1/jGikWWJ7oqUMBLaWfSCHhgA65/rKweAQ1fYylEczSsMud4TiMIzd1+YxD
         h+/4OzjWX/fcKie4x6F8WiVfrepxQ8TCnsZMvQ/GzHCoWm8aI4x+Y7ySUAkPK06TF3X0
         jLCXkD/vOIQcGEcRIQ3vF4+HV1hyGc6bdvRpfwxSwhVQ7Arpn6yZlC8kAdtgygWLOpzX
         bLWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6SMuKMN3rf84lBNEm9PCxIC2fPO5ysblNiYAAuuXWlRYZX9OAIDCfzMVT3N5XdECaMTRe7mmurwofmfWj@vger.kernel.org, AJvYcCUHgFcdG1gWpfYECypp8jYduhgt3rsq1W7uo+xqWNTDG55jplDTVW/SiQkRQ5iGGQCvfKtL6P+mYkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzmOg4wMg+65iPJNT46X3tBA6FbFgLg9rOZaxOJlA8MDR0+Mx
	5le0UK2kds+DTfBNh7iqBGwMxwsk9qp7tIlMlVaLeCQrdxFqioXK
X-Gm-Gg: ASbGncum4NQ29ABAKfVKAl4Cujl+JVBijOhB8XxERoODrxPfoUcklAFfMrjPwWItcnf
	86ZM42L/IDHN+D9scowFwb9BfGffHB7VFa/V/Du1vjvBgFFfqur7eU7eySLuittB/EwM+GKfWcm
	JbKmxRJxcldcbMru60P5k86o+dFMMTAKk3nFM2hUPh0NVccGDaZV1MtgZOOPtcrGQDosvNgY1Ph
	2aNWtLA3VRYIdS9gr6JpgFa4igKscNm80819YUiFr6MD9OHlNnaSqjnPX7JG4ftVjVYznCTyIAW
	1yPG6QOEHtKkI1q5gA6f7HTmgocGKEKgc8AV1BflIVSEVUVzo928RL/XXAL9yQ+SZ4BvYQ1PE0N
	8lOh+4Q==
X-Google-Smtp-Source: AGHT+IEAkSg/F5FygsWRs9N3+5vWlJflzbDzp53QeMTt6VL9QsT/DkGXNgp+CdGkt1Y7eFgLZjdrfg==
X-Received: by 2002:ad4:5ae6:0:b0:6e6:659d:296 with SMTP id 6a1803df08f44-6e66cc86b35mr222749096d6.5.1739857564934;
        Mon, 17 Feb 2025 21:46:04 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a4430sm60540986d6.65.2025.02.17.21.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:46:04 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05CBC1200043;
	Tue, 18 Feb 2025 00:46:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 00:46:04 -0500
X-ME-Sender: <xms:mx60Z47Srz2WsHqCXY_6CvD54hI_CUG42919RMuElhhw5hPuQsiJrw>
    <xme:mx60Z55W5sFmtAMZxVROE9UlyhR3hUyfYspnjzsTgSyePrFKQU2d5fmpNep2aLiji
    zE-wbIS77vHHBcRDg>
X-ME-Received: <xmr:mx60Z3ct7VWBiOcy2SSiGhazUberXzI9WETrvEbxTUk4QfPFldMDwgv8dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:mx60Z9KxbA3oL6FLO-3py3AqmntsiFUSdlOD40N5OM5-E8AgaeOwkw>
    <xmx:mx60Z8Im5qQ4YFAmIVY2uxXc3EJpUL7bh5MlDfAO0jMA9CADtK1BDw>
    <xmx:mx60Z-xoj3SBZuLxNTNSkLyZFBQs1n2ZMs-atXbCLcl1gAb6AN3wCg>
    <xmx:mx60ZwJGgU3o97eIl-Hq7-ZIGGV1V_BuwJtN5tcy8nBOt40h8mefTA>
    <xmx:nB60Z7ZneXMZcilSr34l2IGt_06bZo4CP2eYsDKi_ZK-hVNoMVOiwnUR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:46:03 -0500 (EST)
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
	linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>
Subject: [PATCH rcu 7/7] rcu: Remove references to old grace-period-wait primitives
Date: Mon, 17 Feb 2025 21:45:47 -0800
Message-Id: <20250218054547.7364-8-boqun.feng@gmail.com>
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

The rcu_barrier_sched(), synchronize_sched(), and synchronize_rcu_bh()
RCU API members have been gone for many years.  This commit therefore
removes non-historical instances of them.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/RCU/rcubarrier.rst |  5 +----
 include/linux/rcupdate.h         | 17 +++++++----------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 6da7f66da2a8..12a7b059654f 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -329,10 +329,7 @@ Answer:
 	was first added back in 2005.  This is because on_each_cpu()
 	disables preemption, which acted as an RCU read-side critical
 	section, thus preventing CPU 0's grace period from completing
-	until on_each_cpu() had dealt with all of the CPUs.  However,
-	with the advent of preemptible RCU, rcu_barrier() no longer
-	waited on nonpreemptible regions of code in preemptible kernels,
-	that being the job of the new rcu_barrier_sched() function.
+	until on_each_cpu() had dealt with all of the CPUs.
 
 	However, with the RCU flavor consolidation around v4.20, this
 	possibility was once again ruled out, because the consolidated
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..3bb554723074 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -806,11 +806,9 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
- * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
- * wait for regions of code with preemption disabled, including regions of
- * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
- * define synchronize_sched(), only code enclosed within rcu_read_lock()
- * and rcu_read_unlock() are guaranteed to be waited for.
+ * Both synchronize_rcu() and call_rcu() also wait for regions of code
+ * with preemption disabled, including regions of code with interrupts or
+ * softirqs disabled.
  *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
@@ -865,11 +863,10 @@ static __always_inline void rcu_read_lock(void)
  * rcu_read_unlock() - marks the end of an RCU read-side critical section.
  *
  * In almost all situations, rcu_read_unlock() is immune from deadlock.
- * In recent kernels that have consolidated synchronize_sched() and
- * synchronize_rcu_bh() into synchronize_rcu(), this deadlock immunity
- * also extends to the scheduler's runqueue and priority-inheritance
- * spinlocks, courtesy of the quiescent-state deferral that is carried
- * out when rcu_read_unlock() is invoked with interrupts disabled.
+ * This deadlock immunity also extends to the scheduler's runqueue
+ * and priority-inheritance spinlocks, courtesy of the quiescent-state
+ * deferral that is carried out when rcu_read_unlock() is invoked with
+ * interrupts disabled.
  *
  * See rcu_read_lock() for more information.
  */
-- 
2.39.5 (Apple Git-154)

