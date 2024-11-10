Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37712914;
	Sun, 10 Nov 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731250085; cv=none; b=QDm+AbbgmjwOOvYm9vJEf6O1E3hAQ/+xVPpyg/c5wofGy8Xo6dvL4Gl3QYXMwkM0lZIiM/+QqyffjqXXnIZx2txFB7ZfeaN6Tv+3JYjC5P0Hq6mWSc/LWF9CEoP4Rmqlcd64m4SScdgTTuvc7xbli+FEVS4Nik1txNjopIbk+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731250085; c=relaxed/simple;
	bh=W0S6wwtZyVHiWXYRDXodn0d3g+JCwdpafbT9/9GjK1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fA2WrIN8fkXRi0aHz5whbhNsmc5tEcqbgwagXN6MVCKqXaLbIl+fFw82kDlKIh8SLLxxOlBe55+LRi+YGxMsUM8MlLfl3+kI9cit7GcJLEsPgSfHs7ziIOjCgHaAg403r4ckqfl4L+9b70QCRimrCNSd777ggfYt4/6wKydsOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYzTumkP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYzTumkP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so2848514a91.1;
        Sun, 10 Nov 2024 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731250083; x=1731854883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcOz8b4qr56exJz4+nKHKJ/wWB2NsOuN83y1ZKgWdA8=;
        b=VYzTumkPBxA/12CSovo6mCKTiONizbwQYtRhzKeWXmb0k54vCaTz3Wa6seNnM2y7od
         R98D0dKHUkq5elBeQx4BAhBg48EVFX4W+jwnVOcbe6Ttxgi5PePms8npzY9638PZALWG
         e6CcCgPZAtq4VXIZ16q0gQ1zjx9fVClrKg8gQON51EK1hxFd393V9TNhUye91pC0xK64
         VuSkIQ+Jzh3c5TbbpoShzprGTnivFiOy+EqfDZ6HNRs7wLkUJBwhvgI5OnUT6W4D92r0
         CRmEt7NTG5FrYWsxc2H23xF2Ef1wxY0xah0CcHTvjs5eDKzPRBDCVQOUScDlqF7FWE5k
         A5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731250083; x=1731854883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcOz8b4qr56exJz4+nKHKJ/wWB2NsOuN83y1ZKgWdA8=;
        b=enfZTVqQ4EKL/SV+1QFLmn0RgG/VxHrc2UD57f9VTk+R/dG8fbqVFcpH8vLpmzzL9l
         ZotustdOrHKEi12fsT65AjxVYAW5nYJiqZBBlY2J+g32fV8f/XgOKv2CoslWJy3aaF/c
         +2d8AyuFttSCTSdTiHz3LiocKWTeF7zj+4xmHZximGAEdr4e44WtpieNWXlVWb7OtgYt
         gML0RHbbzuydYCvkqFYf6Jxyh3RLQRQbRjs+zmv5VnO+qdyKZZjntPSnxadJP15Y+yLh
         voSuh7OtvCgaxnGFgm3AKREnpxttT77SyerhPG+Qf+JF6o/bBscY0JKXH0CCQOYnDlzV
         FnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXMW7J5WJ0Rxu9EeYlQQ1e1Lijdo4ATIm5MPGpHX5O984IigTiSva1PyUWQwTRuHkL+UjJO@vger.kernel.org, AJvYcCXUBtDFw1pM/OnDkd0nOJm8z+MUp9xhzMuRInTJmM6226a7xRHE5IZ2cp0giWo19DbU3sz7T/jTtst0ppM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KYVh1hqE7B2YrYEIqxsVXvwJU+RcocMDeJx+JVWbX4+CIfPj
	ZN7/6H58JOXICVFQkUSdeJnXW7URvzf74s2nt+c8wE8/ir4ews6x
X-Google-Smtp-Source: AGHT+IEvJVjRjf/FtB5gjRCjlESgTEQrUoU0Laehf5QBDSN/4txS5ZfSVfXOzLLHaq7nDFMqyDqXvQ==
X-Received: by 2002:a17:90b:540b:b0:2e1:682b:361a with SMTP id 98e67ed59e1d1-2e9b177fce7mr13870268a91.28.1731250082930;
        Sun, 10 Nov 2024 06:48:02 -0800 (PST)
Received: from localhost.localdomain ([202.119.23.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc838esm60793285ad.32.2024.11.10.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 06:48:01 -0800 (PST)
From: Zilin Guan <zilinguan811@gmail.com>
To: paulmck@kernel.org
Cc: boqun.feng@gmail.com,
	frederic@kernel.org,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	neeraj.upadhyay@kernel.org,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	urezki@gmail.com,
	zilinguan811@gmail.com,
	xujianhao01@gmail.com
Subject: [PATCH v2] rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
Date: Sun, 10 Nov 2024 14:47:47 +0000
Message-Id: <20241110144747.21379-1-zilinguan811@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is one access to rdp->gpwrap in the __note_gp_changes() function
that does not use READ_ONCE() for protection, while other accesses to
rdp->gpwrap do use READ_ONCE(). When using the 8*TREE03 and
CONFIG_NR_CPUS=8 configuration, KCSAN found no data races at that point.
This is because other functions should hold rnp->lock when calling
__note_gp_changes(), which ensures proper exclusion of writes to the
rdp->gpwrap fields for all CPUs associated with that leaf rcu_node
structure.

Therefore, using READ_ONCE() to protect rdp->gpwrap within the
__note_gp_changes() function is unnecessary.

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
---
v1 -> v2: Remove READ_ONCE() from accesses to rdp->gpwrap.

 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 77b5b39e19a8..68eb0f746575 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1275,7 +1275,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Handle the ends of any preceding grace periods first. */
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
@@ -1289,7 +1289,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
 	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) {
+	    unlikely(rdp->gpwrap)) {
 		/*
 		 * If the current grace period is waiting for this CPU,
 		 * set up to detect a quiescent state, otherwise don't
@@ -1304,7 +1304,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
-	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
+	if (IS_ENABLED(CONFIG_PROVE_RCU) && rdp->gpwrap)
 		WRITE_ONCE(rdp->last_sched_clock, jiffies);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
-- 
2.34.1

