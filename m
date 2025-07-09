Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D128DF33;
	Wed,  9 Jul 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058016; cv=none; b=tJjX9+3V981OV2Wo0CTuw1iLZT8QTmRp4V6ud51ts2Op2YZP3jTHQkEa9RYdpdz3h2mk1NIbqUqXWyjIdeULlMoU5n0IW7u4eIg6Rc5KWr0kDgM9HFFJuos7g8CqRnI/kDLRvmaQ73tDBIeAvU/zucOU/8tr7c00d4Ouax5SHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058016; c=relaxed/simple;
	bh=z3oEOuVmMZau4TOqlJCsEtRonxNstKpn9ysIqzbERG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z16K9ycjG2U/z46PGAdXqtiM+e6zaj2RxNyxZUCWtGc8PN6PBkDFt/SSbW31WoZkOJai+TzCwyBAbYGyPmIny7DVHXu5kkc5rhf6kez4adYw44mrwi9zqjmd71ttHz6NkgFR/0JEC2psImw2vwSY2PCHYl50EPRbGulaWgMNMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skqAcGlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skqAcGlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC644C4CEEF;
	Wed,  9 Jul 2025 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058015;
	bh=z3oEOuVmMZau4TOqlJCsEtRonxNstKpn9ysIqzbERG4=;
	h=From:To:Cc:Subject:Date:From;
	b=skqAcGlLlCFVDbsWUGZl3dZM4kP/f1mlmVd5SZvwW6PLu2sOhVGdlf6PSEgCDLUUV
	 fTb15YhtVKON5AC+punbWySXLhexnD/WiesJiV5GhWeT9GXZiko5w9tzLzbuSU0kjU
	 NCJl/69zlgi8t6wYTG1An83npsGafqNwZFVpSWa2Qt80zhKdEea1sKAOPKu6j8BoMC
	 nYfqYXKwD5tn2agcB8w5/j8jzSuqn21JJ0WyurgRzhqNk33gi+D0jeStLwqOFHbM2x
	 en42pGhTRirCLFor0dagbYAExkL2Xo61CuUWeNaRcALSPbkN1827jaAl6/oxxScOIc
	 IQVAMF5BN4ZBw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 0/2] RCU nocb changes for v6.17
Date: Wed,  9 Jul 2025 16:16:39 +0530
Message-Id: <20250709104641.15699-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the RCU nocb code (rebased
on v6.16-rc3):

Frederic Weisbecker (1):
  rcu/nocb: Dump gp state even if rdp gp itself is not offloaded

Zqiang (1):
  rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access

 kernel/rcu/tree_nocb.h  | 8 +++++---
 kernel/rcu/tree_stall.h | 3 +--
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.40.1

