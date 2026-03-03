Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B6377EA2;
	Tue,  3 Mar 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581840; cv=none; b=ODCOyFzNcm02vUDqSV0R4ZlvE+9v3L1B//ZidjmWPRYLSznw8niqOwXNrBgYpVLlocTZQXO90wL9MIXu0DnCyLn23ujTazsHoMIONIC/Ykk6u6FVtz0mHGb91BOP0jMAEyCtnOATYGX6P2YYfCHUY1Wvn4WhnqvEA4oNTDB6O34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581840; c=relaxed/simple;
	bh=rcD7aMLeHklXTl+Yf82NJjNoqb+vojvpO5oAEVk22UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knyPaVSW+95rtdGEG+5mnzZTcEj4vcY3KNCc0BQI9qyrkb/UhE082WZHb1eEc+A9hVdR2Vhm3jqG4VuTwEB2lMRP3hZGT06X0D+dcOJmz6GtT0eV+CmurT8owug6mgM3QVn1GD9aVJML06Kqpu5nQUfLNbyDVTdNbDBOs9mycbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1FAnAjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1FAnAjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9679C4AF0D;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=rcD7aMLeHklXTl+Yf82NJjNoqb+vojvpO5oAEVk22UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1FAnAjSZU1FB5Wgie5CLsG9KrBTQ9RtpyFtnGz/Ddllh86xy0uUn41PXwy7xjDUP
	 uS14OUmpNwYW0OGowROToZ40F3D1wrYd9Y193aI61lutBldc8L5cQ/mPgwVq/mrHHj
	 qRxy+SVZ8G4F3aai79bwk1YNf81nEBcnvKvyFZvegMJ1GjndDiX3weGT21SFJMuoMC
	 gcLoXW6nmeTRJ2dNevYHWWw+FvrrCtw8S20bmMi6h5OMpZLAYmlfszqTYAOsqeFXCA
	 kf3T9ffjPXqXlP3FGmliBiVI8CXf1g74Bc1Jd98t+XQr+5nkFKqQnkpxDcUvfBSewe
	 ijWFjOhdPauHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06BFDCE11EF; Tue,  3 Mar 2026 15:50:39 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 11/11] rcu-tasks: Document that RCU Tasks Trace grace periods now imply RCU grace periods
Date: Tue,  3 Mar 2026 15:50:37 -0800
Message-Id: <20260303235037.1967017-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that RCU Tasks Trace is implemented in terms of SRCU-fast, the fact
that each SRCU-fast grace period implies at least two RCU grace periods
in turn means that each RCU Tasks Trace grace period implies at least
two grace periods.  This commit therefore updates the documentation
accordingly.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 7 +++++++
 include/linux/rcupdate.h                               | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index b5cdbba3ec2e7..4d886e7c7a956 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2787,6 +2787,13 @@ which avoids the read-side memory barriers, at least for architectures
 that apply noinstr to kernel entry/exit code (or that build with
 ``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
 
+Now that the implementation is based on SRCU-fast, a call
+to synchronize_rcu_tasks_trace() implies at least one call to
+synchronize_rcu(), that is, every Tasks Trace RCU grace period contains
+at least one plain vanilla RCU grace period.  Should there ever
+be a synchronize_rcu_tasks_trace_expedited(), this guarantee would
+*not* necessarily apply to this hypothetical API member.
+
 The tasks-trace-RCU API is also reasonably compact,
 consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
 rcu_read_lock_trace_held(), call_rcu_tasks_trace(),
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 04f3f86a41450..18a85c30fd4f3 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -208,12 +208,9 @@ static inline void exit_tasks_rcu_finish(void) { }
 /**
  * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
  *
- * As an accident of implementation, an RCU Tasks Trace grace period also
- * acts as an RCU grace period.  However, this could change at any time.
- * Code relying on this accident must call this function to verify that
- * this accident is still happening.
- *
- * You have been warned!
+ * Now that RCU Tasks Trace is implemented in terms of SRCU-fast, a
+ * call to synchronize_rcu_tasks_trace() is guaranteed to imply at least
+ * one call to synchronize_rcu().
  */
 static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
 
-- 
2.40.1

