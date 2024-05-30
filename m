Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DB3D68;
	Thu, 30 May 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076761; cv=none; b=NKNk3Kyr3ukkeqI2HqzS2p+YY+QKsJ20HSAD4fWtxd1W9iMf9hVIziBC6AL9Gc/diLVac3dS8DYl8ZpArsNhf9UtKbTRrRC0EaloZw36zrO1QE+fuolGmx1eJYG7VuKmyHPQZSFP9bC4RD9vXpN/lflaQbzP5+/MQMcPoYWvF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076761; c=relaxed/simple;
	bh=lN0Jd+emoQsfNHfUuQGeGM64FiQzitT5VmVytjiJLqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLMWFLISz8pVObz8y1aLWArbwJbsMT2VDkoASvMkfbwuKHXNN8gZ50P7sM+utgfgN0ihBjvwugf83CM6q7jd4sNRyHSAwWpnLRKlzPGkkFoA+UxSP6HJt+6L4McfFzpCYHlM8OcEV3hMTRIpf0F8ISk0iRNSfSQbEYupG8fRK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKcPZu6x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKcPZu6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14805C2BBFC;
	Thu, 30 May 2024 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076760;
	bh=lN0Jd+emoQsfNHfUuQGeGM64FiQzitT5VmVytjiJLqM=;
	h=From:To:Cc:Subject:Date:From;
	b=DKcPZu6x6ZDOQSnwjf1knRBhFe8sUJl66+u1mp5Oi/6G0sInEE+S59NuJjMXhl1pl
	 Jbn2VqYYKzQre+POsFszMw0VJv3iyf3s5fmrOK6T6BUqpK7R8S4KNzm371U+qf6D3n
	 2ZkC35fPG8OUOmnggYUODhwONny7WFCD8svC4rh2BX7tBrT7HUxrHUMw4VqfUwKRDh
	 CmLQR47st6nr6kfj3eFDPLBhzAYQQazw//q4WWi4kRzjTUNVHpB5Ucfv6GQykHbMzQ
	 /XLRpfXN3r1vd9hJCBI1Oick34uZ9bbdWF61B/II4tOY/g4Xv9POfHXQkLdzVP/uQc
	 GRHNsXw+93HYQ==
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
Subject: [PATCH 00/11] rcu/nocb: (De-)offloading on offline CPUs
Date: Thu, 30 May 2024 15:45:41 +0200
Message-ID: <20240530134552.5467-1-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last LPC's debates seem to have raised general agreement that nohz_full
cpusets interface should operate on offline CPUs to simplify the picture.
And since the only known future user of NOCB (de-)offloading is going
to be nohz_full cpusets, its transitions need to operate on offline
CPUs as well.

The good news is that it simplifies a bit the (de-)offloading code, as
the diffstat testifies.

Thanks.

Frederic Weisbecker (11):
  rcu/nocb: Introduce RCU_NOCB_LOCKDEP_WARN()
  rcu/nocb: Move nocb field at the end of state struct
  rcu/nocb: Assert no callbacks while nocb kthread allocation fails
  rcu/nocb: Introduce nocb mutex
  rcu/nocb: (De-)offload callbacks on offline CPUs only
  rcu/nocb: Remove halfway (de-)offloading handling from bypass
  rcu/nocb: Remove halfway (de-)offloading handling from rcu_core()'s QS
    reporting
  rcu/nocb: Remove halfway (de-)offloading handling from rcu_core
  rcu/nocb: Remove SEGCBLIST_RCU_CORE
  rcu/nocb: Remove SEGCBLIST_KTHREAD_CB
  rcu/nocb: Simplify (de-)offloading state machine

 include/linux/rcu_segcblist.h |   6 +-
 include/linux/rcupdate.h      |   7 +
 kernel/rcu/rcu_segcblist.c    |  11 --
 kernel/rcu/rcu_segcblist.h    |  11 +-
 kernel/rcu/tree.c             |  45 +-----
 kernel/rcu/tree.h             |   6 +-
 kernel/rcu/tree_nocb.h        | 266 +++++++++++++---------------------
 kernel/rcu/tree_plugin.h      |   5 +-
 8 files changed, 122 insertions(+), 235 deletions(-)

-- 
2.45.1

