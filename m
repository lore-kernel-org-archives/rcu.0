Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C092C1BA
	for <rcu@vger.kernel.org>; Fri,  8 Mar 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937887; cv=none; b=LrRBVfBqb2Vy38DjBgIoQIoISnKfpqb+mfbivqxZ0b/5xmn/lmh3gdhx65j0OME8wqO47xxOOZgBNpNRqK/UEHEIngKzZTu+JhgUUOyiKZ/R0BeXetS/2iTucaX0GhLsLczWqXFjG2tRtaMjrcTK98X7Xkb3iXmw1To02J4JRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937887; c=relaxed/simple;
	bh=Q/dpA4EDL9DKNd657tQSSkB0gcrr3hEqFVGn6lgUnrs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4gtDd2/H/Jj9j/ZX+cqIluNP1+qYpg0hX/R4hO9ZC1MqefBZrEG77dlePT8B+5ZfPep6Tk7Zpf+N6oKNyG5v7mkV2HSLH3wxrD69mw04HR6G6UeWrrXW43MYf4vIEkkVFUltXuoMUdl/AFC2FyW2jYxIjrnWqFLSvrbzMXDPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Vh0eXsio; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Vh0eXsio"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690bd329df2so2764966d6.2
        for <rcu@vger.kernel.org>; Fri, 08 Mar 2024 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709937884; x=1710542684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGozGRObik8kRBqAaXDv14vyB9qXJuUjlDQ4UlEdAqY=;
        b=Vh0eXsio4QZPnTr3kIzy7UeGWLYCc4w26wLtOlwuVa6B8cFSWaaQcl5+MaHl+wHKp8
         q6mEcfyTip67af4fPMimuyjBcmXwsw/JtN1/zeXZp6MCWkxt4XKqIoD3gSHJAYtb0ANg
         /h5Q+XddKt/c88RhFRo1iK3RmLxF0nz6qHVoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937884; x=1710542684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGozGRObik8kRBqAaXDv14vyB9qXJuUjlDQ4UlEdAqY=;
        b=mtiYlcglnTD3iw2eLsfSIeStY1nf95Ko11GuPxrLAeAy3zN7lm0QrN0x/Fj/OWdqN4
         djqAng5zli5jpUtbFRb/1YgBhRtg9vx5w08Pnk7mnx2Gim2QkBXL2ZftTjLYmMNme+jG
         P4iUoIHEoVcNyjk5efqYJzUsc9JCyB8Fi26cKTByFdSj2eURAsotk30A+bYnP46V3M8V
         VQfBZ7L8M4VZs7fddq7gTR50YrKhDKXZbliv6yq4AgMPyOunuAE96msDtW85Uxy0OLAE
         ZAkxwJ0vxE2iohA+qyTR4MV9ngqfeimRrJjm/r5gTIP44r4aKP2rvzffcgPE3VrHUvJR
         xh+A==
X-Forwarded-Encrypted: i=1; AJvYcCVfmAfinWKNU1DOGiAiLdxqJZ7F7ZHTyCxnjZmN2FPwZAl3yWgYIOthF3TcFIJwCF74mXiJF45HrWWYu/YvqeQKuO7K
X-Gm-Message-State: AOJu0YwF/Wr6s5BzTZwdFbr1LJhaKBZBo9uYA817dwN1JyvFLEIQ8Lcw
	//QKwlDC+jPk12citMV6MZp5ihHcegmLVjPhyqgqasw/6L0dWUp5gPa2UkKHVhw=
X-Google-Smtp-Source: AGHT+IEw+M//3zPkORy6vYQ+apdR177VVl0Z+YSd4BJ66C+o526aJdoXX71W9ee7sW7ili48pmMCCw==
X-Received: by 2002:ad4:4d4b:0:b0:690:4ac8:2283 with SMTP id m11-20020ad44d4b000000b006904ac82283mr436827qvm.20.1709937884436;
        Fri, 08 Mar 2024 14:44:44 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id px21-20020a056214051500b00690c0936d70sm36960qvb.127.2024.03.08.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:44:43 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	neeraj.iitr10@gmail.com,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 rcu/dev 2/2] rcu/tree: Add comments explaining now-offline-CPU QS reports
Date: Fri,  8 Mar 2024 17:44:38 -0500
Message-Id: <20240308224439.281349-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308224439.281349-1-joel@joelfernandes.org>
References: <20240308224439.281349-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This a confusing piece of code (rightfully so as the issue it deals with
is complex). Recent discussions brought up a question -- what prevents the
rcu_implicit_dyntick_qs() from warning about QS reports for offline
CPUs.

QS reporting for now-offline CPUs should only happen from:
- gp_init()
- rcutree_cpu_report_dead()

Add some comments to this code explaining how QS reporting is not
missed when these functions are concurrently running.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd29fe3c76bf..f3582f843a05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1917,7 +1917,22 @@ static noinline_for_stack bool rcu_gp_init(void)
 		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		/* Quiescent states for tasks on any now-offline CPUs. */
+		/*
+		 * === Quiescent states for tasks on any now-offline CPUs. ===
+		 *
+		 * QS reporting for now-offline CPUs should only be performed from
+		 * either here, i.e., gp_init() or from rcutree_report_cpu_dead().
+		 *
+		 * Note that, when reporting quiescent states for now-offline CPUs,
+		 * the sequence of code doing those reports while also accessing
+		 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
+		 * that QS reporting is not missed! Otherwise it possible that
+		 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
+		 * the rnp->lock acquired throughout these QS-reporting
+		 * sequences, which is also acquired in
+		 * rcutree_report_cpu_dead(), so, acquiring ofl_lock is not
+		 * necessary here to synchronize with that function.
+		 */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
@@ -5116,6 +5131,25 @@ void rcutree_report_cpu_dead(void)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
+
+	/*
+	 * === Quiescent state reporting for now-offline CPUs ===
+	 *
+	 * QS reporting for now-offline CPUs should only be performed from
+	 * either here, i.e. rcutree_report_cpu_dead(), or gp_init().
+	 *
+	 * Note that, when reporting quiescent states for now-offline CPUs,
+	 * the sequence of code doing those reports while also accessing
+	 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
+	 * that QS reporting is not missed! Otherwise it possible that
+	 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
+	 * the rnp->lock acquired throughout these QS-reporting sequences, which
+	 * is also acquired in gp_init().
+	 * One slight change to this rule is below, where we release and
+	 * reacquire the lock after a QS report, but before we clear the
+	 * ->qsmaskinitnext bit. That is OK to do, because gp_init() report a
+	 * QS again, if it acquired the rnp->lock before we reacquired below.
+	 */
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_disable_urgency_upon_qs(rdp);
-- 
2.34.1

