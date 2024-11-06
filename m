Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A920127C;
	Wed,  6 Nov 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907140; cv=none; b=RscP5yRdDj0l+ib3cSHE3tgKTGzWBysOZBboqW38UtsiTh8GcAIJHFBkQBDiZ56wqT3kWVtXgYKvc7XaSX943L0wvyEoo0s6cZEYtdfFw8mkXlUQ3PJxbazVLLgVy+cf7wOMQYBJne3QVMRZK6kxWr3tEpPJ/uRuL2bfnW460xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907140; c=relaxed/simple;
	bh=OGwhap4Hdi7ntRats7Gbbk+jNfVESuzRedMOi2TQDLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uq1j2nkZm/BkqrDkZSHTtUex0GC77KrJnRSa7FtsSGVA1Tj0I3g/lSLfF3CVT+M2M2fcUNiquE5etzPCfWn42ckMtnEPS6Z14msqkdWTZqVk8uOFO0eEPwEfQbeCQuEIYBnIs3ZaSJ8y8oksCk3IjwYlkyQzJIlP7l7oU6sQqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABWT85Qq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABWT85Qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DE5C4CEC6;
	Wed,  6 Nov 2024 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730907140;
	bh=OGwhap4Hdi7ntRats7Gbbk+jNfVESuzRedMOi2TQDLI=;
	h=From:To:Cc:Subject:Date:From;
	b=ABWT85Qq1/Vt2H7IuL50hUoTZLrFNTyyquThcZtr5D5faIrvmu53ayHvjowhtRGK1
	 tWYvzc3SIS6PpvzTdT2Kzig+5D45ZsWj8ek5wZXFWdCnlBrF/KlAF7PNlXGkyYf14K
	 slYXVzj8z25VkhXhBdAzyIikOjJWNhNQvF0NvsHfC039TW2PU7kHujzAJjZ1D5OH8o
	 iA1cZ7zSK0LVOdZr3+OFXyD7Vo/cd7NeYw65HCzFMoVdVasSJmoVfNuISKsphz3Jdh
	 QGnFhLtJM2YLIcw6sUKR70+drhcxVTF6OuTwMKOfrtBUsxwuI/yf/1rRGHUF8CBPR3
	 0bOwxPvCrugLw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/2] RCU NOCB for v6.13
Date: Wed,  6 Nov 2024 16:32:11 +0100
Message-ID: <20241106153213.38896-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please find below the RCU NOCB patches targeted for the upcoming
merge window.

Yue Haibing (1):
  rcu: Remove unused declaration rcu_segcblist_offload()

Zqiang (1):
  rcu/nocb: Fix missed RCU barrier on deoffloading

 kernel/rcu/rcu_segcblist.h |  1 -
 kernel/rcu/tree_nocb.h     | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

Thanks.

-- 
2.46.0

