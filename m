Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00B46529
	for <rcu@vger.kernel.org>; Wed, 27 Dec 2023 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GGlNg/gz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42786514fe6so48642361cf.0
        for <rcu@vger.kernel.org>; Wed, 27 Dec 2023 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1703699259; x=1704304059; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCZ69uSbcTjkg8dgoQT15Hv1NXMMjojf76ZK+8F+h+A=;
        b=GGlNg/gzkY8fU2RQA4hMvY1Y3O09ip2hlt0mXTYyn06FyOTZSbBGmE0wU3pYl6RLS/
         Buaaemp1DqNPBLegGvd9aQDVItfRZJRwiFQwilTzh/HsB+tFCWj27xNCyIHDK7VD2HGE
         ZwrFofNIaehL9H+xTDTYkCLNsFiEZP0gejGGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703699259; x=1704304059;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCZ69uSbcTjkg8dgoQT15Hv1NXMMjojf76ZK+8F+h+A=;
        b=s9XYMQgzqq5Kj7i3detOEKSB9dF65sJzmtIPpTbNkZlTbbIJmEzjLNHjiSg8WSyy63
         XUFOm0FvUJ1fHPjioaic8/LQeAfKImE/K2RzOqCTXU7XqRY647pEus94Zk7YEY8AP4s6
         Aiw9pC2xQyUAE66KmpRK7F9Bh1x1Q2Yrdy+ST3oRtC6T9k1JZVsDLsCVkaIORfxsCcKQ
         NMjgkjDbyTnulFtZxZcAhbAFJ1ImDhHrE97YAd6hV+wo34DoLXAgtyK9gI/O3zO3D29b
         nElMYmwoZRkq6p99jTmSfEqDpBEAZNIf2HSvX0xdiPdQ1jifGiKnBUmeSycgtY34Nwkp
         9AVg==
X-Gm-Message-State: AOJu0YzaLCCmDzLJrIOewbg0TGFA4XZqxNfGkYSu9/GcZeb66rHAB3NT
	slN/5JnOKMur5lhGJpbZRedL0OhM2+3x6g==
X-Google-Smtp-Source: AGHT+IHcoGzBbcSYGqh6UKthu6pqug96DjBDJYTB+W7U5OTX9o2FKVNAx3Rrej3aC7rZ3VDfJksI0Q==
X-Received: by 2002:a05:622a:590:b0:427:8fcf:52c3 with SMTP id c16-20020a05622a059000b004278fcf52c3mr14161093qtb.86.1703699258974;
        Wed, 27 Dec 2023 09:47:38 -0800 (PST)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05622a489100b00427d0be9ca3sm3855689qtb.80.2023.12.27.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:47:38 -0800 (PST)
Message-ID: <658c633a.050a0220.d8198.83e8@mx.google.com>
X-Google-Original-Message-ID: <20231227174738.GA1119@JoelBox.>
Date: Wed, 27 Dec 2023 12:47:38 -0500
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH v3] srcu: Improve comments about acceleration leak
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog

The comments added in commit 1ef990c4b36b ("srcu: No need to
advance/accelerate if no callback enqueued") are a bit confusing.
The comments are describing a scenario for code that was moved and is
no longer the way it was (snapshot after advancing). Improve the code
comments to reflect this and also document why acceleration can never
fail.

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Fix typo in change log.
v2->v3: Improvement to acceleration comment.

 kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0351a4e83529..051e149490d1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	/*
-	 * The snapshot for acceleration must be taken _before_ the read of the
-	 * current gp sequence used for advancing, otherwise advancing may fail
-	 * and acceleration may then fail too.
+	 * It's crucial to capture the snapshot 's' for acceleration before
+	 * reading the current gp_seq that is used for advancing. This is
+	 * essential because if the acceleration snapshot is taken after a
+	 * failed advancement attempt, there's a risk that a grace period may
+	 * conclude and a new one may start in the interim. If the snapshot is
+	 * captured after this sequence of events, the acceleration snapshot 's'
+	 * could be excessively advanced, leading to acceleration failure.
+	 * In such a scenario, an 'acceleration leak' can occur, where new
+	 * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
+	 * Also note that encountering advancing failures is a normal
+	 * occurrence when the grace period for RCU_WAIT_TAIL is in progress.
 	 *
-	 * This could happen if:
+	 * To see this, consider the following events which occur if
+	 * rcu_seq_snap() were to be called after advance:
 	 *
 	 *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
 	 *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
@@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp) {
 		rcu_segcblist_advance(&sdp->srcu_cblist,
 				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		/*
+		 * Acceleration can never fail because the base current gp_seq
+		 * used for acceleration is <= the value of gp_seq used for
+		 * advancing. This means that RCU_NEXT_TAIL segment will
+		 * always be able to be emptied by the acceleration into the
+		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
+		 */
 		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
 	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
-- 
2.43.0.472.g3155946c3a-goog

