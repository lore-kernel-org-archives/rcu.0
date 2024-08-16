Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC98489;
	Fri, 16 Aug 2024 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784208; cv=none; b=iar8MOIH6ZVQP9vEFvcNXtrnqzsZegZ0xiYy4A5KHg4ioPNj+yVLlCLPL87W+3ETmnEuPpTwyJfzmAFIbVFlPLEOyFmHNunJea8D2AktE+Y6/gCkbkln+ePg3d3ODHXNXW0oFGjb6dGFlEJgy/zF60IVVRGrdFRdnO/WEOOlf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784208; c=relaxed/simple;
	bh=ZoyRo/tyseF652lJUasxSfc5hrvMgjk/ZV2qAotF3O4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFTrPZCtnM+8u4UXVUA+Afyxc+y+LEJhcq0hA5fsneChsfEhCqU9C7PeVEioLVREULsNxnskG6iGpcpaYUwQJ5qFL62MkdBvl3Tqe36RL+GOV3d7JDS4Q3Ool9ngUE4bTlwePK4oLAysjhXTgbDkH1iN6xoNFGEQko63i2z4V0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0Twf9N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0Twf9N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B6C32782;
	Fri, 16 Aug 2024 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784208;
	bh=ZoyRo/tyseF652lJUasxSfc5hrvMgjk/ZV2qAotF3O4=;
	h=From:To:Cc:Subject:Date:From;
	b=n0Twf9N6SzQifxo75tc4zBmYyZ7lw0zl0HPmf0ypS8pdHoBidwMQs0jE9VcWwym/u
	 ocxVPMZ47A1EKFEHeHt3b19Yw0ZqpPwWP0goDjyeqOgMnt1k/IVKRZdcT09zP8WDXP
	 WNiW2yGR2yC9QNbiUNhFHKadnU2FAD9V9Z9ucoUB0wxt+dt9gGe/s0faYralxHGSCm
	 b8EEQxZfGBbzS1sGiPIso27T8jbv5TSPaeMRNUEEz4MvucNU4OvxLxOv+Itt9BbRxZ
	 tYN7pvR/54M5hWR1pd8ofiw1wslcGCkNMX6eDrhrUXKj23rltereRhAS2DXxDa6Rkn
	 ABcnPFMubzwDA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 00/11] Nocb updates for v6.12
Date: Fri, 16 Aug 2024 10:25:57 +0530
Message-Id: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

This series contains various updates and simplifications to RCU
nocb code to handle (de-)offloading of callbacks only for offline
CPUs, courtesy of Frederic Weisbecker.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=nocb.29.07.24a


- Neeraj

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
 kernel/rcu/tree_nocb.h        | 268 +++++++++++++---------------------
 kernel/rcu/tree_plugin.h      |   5 +-
 8 files changed, 123 insertions(+), 236 deletions(-)

-- 
2.40.1

