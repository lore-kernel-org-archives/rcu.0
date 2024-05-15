Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6381736;
	Wed, 15 May 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777618; cv=none; b=kN4mc+3p+BcpavI4CIrm38tZ7V5rZrFwrhRFezw9BcLkHEPMc7nLMXSkyz4fCQ/b4IVdNCVciuZjY7ZaDjGiFjC3LvrgiLNd986Jy7//w0uxyIcQ2qzMudFIArnz1bV3RvmPDsQmvd+eQrV0lnYN3+mM8veCxGSfhow9kK6LFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777618; c=relaxed/simple;
	bh=o2o8Nk3Mhul8sFHnLwOqUg9mPLkrOh+Fk9GAEIfikwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJRGA5sDajWvJnggnPvAjTcrxPbb9Bk3gL2fbVGBXxMzC6kFPF1OQCU2k65FlQCUCGxhKHTyn0DLmCZyqK0PgN6e4ugk11YTPks1KcHQW4kfb39gba1TQ7jEPtZrfzHAEOYxDL+n588crTLxl3Pg64CK3+dByahettBACAwuR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MywxZ0+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MywxZ0+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E424AC116B1;
	Wed, 15 May 2024 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777617;
	bh=o2o8Nk3Mhul8sFHnLwOqUg9mPLkrOh+Fk9GAEIfikwY=;
	h=From:To:Cc:Subject:Date:From;
	b=MywxZ0+lzR8pSkZXqU7n8np2PduEdofYB/JgM8TG4mASxZTQpM4To6TS2cTIDZdiO
	 m4UNbhCJ7NCr2B+dlkpp1vm1asMNrV9U5mGyoYTqcQAZvRyC/b9zMZORJZRW1WzrcM
	 KEQpNpJ++p07gPE2ZSm4hs0q3254ziz6eV7l/9E2nVVMviYFjUxhYIxRO5HRm6U8Im
	 O42KerhKYtQfwZ4V7hdHP8L+WP9X1bmVUIWAGGAvkC5ARo8/V1rrz6DKvTpggAoG/D
	 FwLJnadRIJqwk+5y5foWxWm0OirCe0OYewc6XOoeGkEb4I0rdKEjDli8tNPHx2WMlY
	 mT8Kf1UnX9evw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/6] rcu: Remove several redundant memory barriers
Date: Wed, 15 May 2024 14:53:26 +0200
Message-ID: <20240515125332.9306-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewing Valentin's patchset made me stare at some memory barriers
on the way. Here is some removal proposal. Some may be beneficial on
runtime (fqs snapshot with potentially as many smp_mb() as the number
of online CPUs for each GP). Some happen on more rare path. In any
case they clarify code reviews so we don't stumble upon mysterious
barriers.

Thanks.

Frederic Weisbecker (6):
  rcu: Remove full ordering on second EQS snapshot
  rcu: Remove superfluous full memory barrier upon first EQS snapshot
  rcu/exp: Remove superfluous full memory barrier upon first EQS
    snapshot
  rcu: Remove full memory barrier on boot time eqs sanity check
  rcu: Remove full memory barrier on RCU stall printout
  rcu/exp: Remove redundant full memory barrier at the end of GP

 .../Tree-RCU-Memory-Ordering.rst              |  6 +++---
 kernel/rcu/tree.c                             | 21 +++++++------------
 kernel/rcu/tree_exp.h                         | 16 +++++++++++---
 kernel/rcu/tree_stall.h                       |  4 ++--
 4 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.44.0

