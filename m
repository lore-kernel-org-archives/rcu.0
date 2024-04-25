Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346A14A4E9;
	Thu, 25 Apr 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054721; cv=none; b=OR1ukkqrHiVG2VxIWe77b+x58jZAZEByryeWtieoBRgKDXEPjEYweGRbxiR5XASOZPG3ebKfggeTblw0n8Gd33mh8bKg8AfN9rcXfRk3IFiJKftoSw4IrVWuma+zduTevMIvkj6OsLGKgAimhzVbTMZt+HCGtFFI3qnEqo8PZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054721; c=relaxed/simple;
	bh=3+LCJrMTpWDrAfVC9Nynshec8qYyFcNJbRtXFVSsUqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsgrE9QfHdNLcuqvf94BpDcIPq1f52Uo3PG7anWbC7bxbnbmKShK7Stf7p92dFvFqQkAcsXQB2vO2vi1zN2MSUeVqJPvauY+61ETsxof4v4/G8EWOOrTn3Lu7N1aUpoErEli/g8F4jnuKp9kWrD61u1WpIwplPfgosaZ2/7V12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQkaEg9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQkaEg9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E66C113CE;
	Thu, 25 Apr 2024 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714054720;
	bh=3+LCJrMTpWDrAfVC9Nynshec8qYyFcNJbRtXFVSsUqI=;
	h=From:To:Cc:Subject:Date:From;
	b=rQkaEg9wljfOzgf7HMGzIH+D+1/lPYVuBL9OlRBPqhUvmZU1ULHq/3DgMGSP8gFFh
	 F/kwBs+W8wQKfibL4WKRaNKqnLLbN5yAXEiyixVpzCGoZIYZkY+r+laqWixXrANOYw
	 7WGPGGDTosJZ2uRuIv7Nxtz4E0cIZPC7DrxibjOrHxi1IIAiC5pYOG+l3c4QXqbHns
	 zainW7gc+92YWgqaX2QBnRFd4qzFsoiVbJWZexLVAZLqMm1NPguFBJABddMnG7Ymvm
	 nJntYl3MYsRKazALbCGRnHuOJ/DcipLZI9m6B6exjNNdzSQvv6IEpcMNkZcOy/jxPa
	 IP6veMuwUg0/Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/4] rcu/nocb cleanups
Date: Thu, 25 Apr 2024 16:18:31 +0200
Message-ID: <20240425141835.19776-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some cleanups before converting (de-)offloading to only work on offline
CPUs.

Frederic Weisbecker (4):
  rcu/nocb: Fix segcblist state machine comments about bypass
  rcu/nocb: Fix segcblist state machine stale comments about timers
  rcu/nocb: Use kthread parking instead of ad-hoc implementation
  rcu/nocb: Remove buggy bypass lock contention mitigation

 include/linux/rcu_segcblist.h |  88 +++++++++-----------
 kernel/rcu/tree.h             |   1 -
 kernel/rcu/tree_nocb.h        | 149 ++++++++++------------------------
 3 files changed, 79 insertions(+), 159 deletions(-)

-- 
2.44.0

