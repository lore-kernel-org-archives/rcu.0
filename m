Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0412CDAA;
	Fri, 17 May 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959389; cv=none; b=DUGa+GwbIFn5nDa4jcwJbS4JYx5dnDkaSO8RRaQhUOLPskaiAN51EKnYEGFPWktDSqIPEOubDISXgGcAzOvZGqCpexMzqEfKReYNyl9vjlilFDUu2UPZ5h4iBkargegd1F1QRBzfLVETbv0+jkY2eU5Du4CYR9tAp8B6SQOrR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959389; c=relaxed/simple;
	bh=3LP65tfSXoMyUd/3LOucjGN0buuuw/MegJ3O2QRF7nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQwaf9/C7Gg0SRUSPhRLBO2m2Brd21nVP7lpaaevJn7C1gin1a+ZSg5uPo/tj125PNJXyhgzvHHM6393JYnGw8xnXC6UzKt6vjYO+2aYIlI0mIyy+KmUpxCLJjXzmESDiV2X/ka9dc3lww+SaTEYtIfW2UxoM7fgcQB2u/aNvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlwH7tJm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlwH7tJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718B3C2BD10;
	Fri, 17 May 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715959388;
	bh=3LP65tfSXoMyUd/3LOucjGN0buuuw/MegJ3O2QRF7nc=;
	h=From:To:Cc:Subject:Date:From;
	b=DlwH7tJmIMgbOdCT7J2XKc5EPn4qgk9AE/yLrO4HJ+PqM2n7IEt5zhRR5uiyE1FgZ
	 X7FbVb9ZUq7TdePZlyVXFT7wA4lQEyILCAism81vaRsvAX09RoarvFqfRor93FUDLK
	 dHz6SYMKpGt+J+fQ/0TDPim0FJzo1oSY4HyRyElJZA2w3Yvg9z61FVlsHCvtVt69zg
	 ZQYMYhXDcSU+s9nFm7vwRiDHeFCeImNbZncuZZanZ6svBs+lKiwAnpKl8CT2I5+ukb
	 VREu9qYerSxDcXTm136RXT6Gtxj+JtuAExQBBbjc/2SX4jFA+fEgROicfsJG9PGj2o
	 Zeb/kMC8P6OKA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] rcu/tasks: Fix stale task snapshot
Date: Fri, 17 May 2024 17:23:01 +0200
Message-ID: <20240517152303.19689-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue on RCU task trace pre-gp that might collect stale current
tasks on online CPUs, missing the read side of latest context switching
tasks.

Frederic Weisbecker (2):
  rcu/tasks: Fix stale task snaphot from TASK-TRACE
  rcu/tasks: Further comment ordering around current task snapshot on
    TASK-TRACE

 kernel/rcu/tasks.h  | 17 +++++++++++++++++
 kernel/sched/core.c | 14 +++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.44.0

