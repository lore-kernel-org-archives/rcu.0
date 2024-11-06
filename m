Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BA1DCB06;
	Wed,  6 Nov 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908950; cv=none; b=qpHY7eI3RaMqOUa4S/uvdqdkoyTfLJaTuBOgJb7JFUpR+9zKB17V2yRny3HF9Nq4jKaLTDp87OESDolxfY6hmja7lXhThke5A55ggaYxXnUiuROD/wLjUeOn+sY6NqcDVphzMkpgqZCJD6sJModLVyJc92eXG622+9gf3iP66tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908950; c=relaxed/simple;
	bh=NNlKLYkSvUiuHvvfUCv7F3lPdwNDwIvAhpGqiuvtzTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtxVw9Uib8Rf+jeAltlO7hT8QUw2D4kgV+vARflJFyPeU9VQ99sSIAEpxb2x3oMeVswx4CS5SKhoFChsgc4BFKv7N4rfkKOLXp33oO4H9Cd5x28LfZvmPPIYSWTCOkh9kPAG7dKQXwXTzsqkOt4M+/mg52GIMoOBH5loVkU9iCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uby49Txd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uby49Txd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F567C4CEC6;
	Wed,  6 Nov 2024 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908949;
	bh=NNlKLYkSvUiuHvvfUCv7F3lPdwNDwIvAhpGqiuvtzTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Uby49TxdXxNKcrSta1xCEZXFpQ3eOyeKMuFpgXw3QTasAO0rhoGcU3f+2ZuHkuVYN
	 KgXWkc0ZRoJIRp8/UjXpIYnlssbhzQkWL3wtq88wybDijdW7/lWhFkzy4pWngWtF57
	 nJsJTXl+cYfyLLsEzem1ErurgmXNIE71If8fPKCCnVQ6i75H6cApxD78bVY9FD5T3t
	 LcyyfL3fkfdzEROZ5dG/i/2XNi3gFckbql9Ch9ZNsYzuXEd5autlolguwGm1pA/DzA
	 W5nCi6EED9w6vnF27uMxzRTRKxO6Fa0/Ty+CWZfv4jCJWUZ1WZpL9991kUr2UoyS8a
	 gxz9CIZRGJN3g==
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
Subject: [PATCH 0/6] RCU torture for v6.13
Date: Wed,  6 Nov 2024 17:02:17 +0100
Message-ID: <20241106160223.42119-1-frederic@kernel.org>
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

Paul E. McKenney (4):
  torture: Add --no-affinity parameter to kvm.sh
  refscale: Correct affinity check
  rcuscale: Add guest_os_delay module parameter
  rcutorture: Avoid printing cpu=-1 for no-fault RCU boost failure

Uladzislau Rezki (Sony) (2):
  rcuscale: Do a proper cleanup if kfree_scale_init() fails
  rcuscale: Remove redundant WARN_ON_ONCE() splat

 kernel/rcu/rcuscale.c                         |  6 +--
 kernel/rcu/rcutorture.c                       |  9 +++-
 kernel/rcu/refscale.c                         | 19 +++++++-
 .../rcutorture/bin/kvm-test-1-run-batch.sh    | 43 ++++++++++---------
 tools/testing/selftests/rcutorture/bin/kvm.sh |  6 +++
 5 files changed, 56 insertions(+), 27 deletions(-)

Thanks.
-- 
2.46.0

