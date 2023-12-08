Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558D47A5E
	for <rcu@vger.kernel.org>; Fri,  8 Dec 2023 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw+MKktq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A29DC433C7;
	Fri,  8 Dec 2023 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702073152;
	bh=CgYvOu578AFfLRbBC6EHcv8SUptcV6n5XjcrCPA7nDI=;
	h=From:To:Cc:Subject:Date:From;
	b=Pw+MKktqBiWhUgo6VfuY7O/2yoxIeItlKxQdYL8fX1bz1s/zy7Ihk79bC/wo1Bxzi
	 uRBhcWs2U2UYM8pajpvAJQqhLS1aJEJRK3lZWjiB/Kbo2QkALyO58X3A+D0NApzlhs
	 Bn8MOA1bGIAehpbs4DsmTNLqnsEvc+owbWRKAMWST3L6qc9VgdnxnPkdwwF1GDQ9ft
	 Gv8/IyjFjDnOlait/gfqbobtCiex+zCxlqD/+1oAvQaJ8mGK9w38VwSjdMgdTa4A87
	 lZqYCSKGDMU3PDjsZgd5PKusJFY5k5lUn0Nhnu4KjvGW4OcWko9ekeeaqzdFsFBZ7v
	 jnjrxXCI3aBvA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some nocb stuff)
Date: Fri,  8 Dec 2023 23:05:37 +0100
Message-ID: <20231208220545.7452-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TREE04 can trigger a writer stall if run with memory pressure. This
is due to a circular dependency between waiting for expedited grace
period and polling on expedited grace period when workqueues go back
to mayday serialization.

Here is a proposal fix.

Frederic Weisbecker (8):
  rcu/nocb: Make IRQs disablement symetric
  rcu/nocb: Re-arrange call_rcu() NOCB specific code
  rcu/exp: Fix RCU expedited parallel grace period kworker allocation
    failure recovery
  rcu/exp: Handle RCU expedited grace period kworker allocation failure
  rcu: s/boost_kthread_mutex/kthread_mutex
  rcu/exp: Make parallel exp gp kworker per rcu node
  rcu/exp: Handle parallel exp gp kworkers affinity
  rcu/exp: Remove rcu_par_gp_wq

 kernel/rcu/rcu.h         |   5 -
 kernel/rcu/tree.c        | 222 +++++++++++++++++++++++++--------------
 kernel/rcu/tree.h        |  12 +--
 kernel/rcu/tree_exp.h    |  81 +++-----------
 kernel/rcu/tree_nocb.h   |  38 ++++---
 kernel/rcu/tree_plugin.h |  52 ++-------
 6 files changed, 191 insertions(+), 219 deletions(-)

-- 
2.42.1

