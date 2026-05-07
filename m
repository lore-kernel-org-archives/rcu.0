Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7E3E7151;
	Thu,  7 May 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173782; cv=none; b=kes4PPYxLkLh1+97NceuNoLVAIHeC+D4q5O2/Kz9SLzt6yOaD57IFN6uvy9HjORrua3Fgz/keuAP6jg5Am2Kz9Db2p8irXpRv591bIh6wrXWRN3NBtbgotVkkdjIeKMHxEVOWxnSeRcFtRkpg1yLTeBminGXS7xWoNyB13VbLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173782; c=relaxed/simple;
	bh=uXm6hxtP4mdAXAz4HxFH5Z3mJEEYGrLoc84p5U9NvxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QW5I+GE6l8pvF1uJVZoJou06nNHNlix9RTCDI27G9RKQ5aUDsmLd8lTu0k1gJ+v60adi/Kf1ulO3P46i9nxUYwagZf6nlrZaFDF6lsVRCrLShhBv9lu91eyk5/0Vo81o3IegvmlvyMVDxPsGndpcSpKqUM2ZePOIlW3/xskTvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GStauAOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GStauAOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0834C2BCB2;
	Thu,  7 May 2026 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173782;
	bh=uXm6hxtP4mdAXAz4HxFH5Z3mJEEYGrLoc84p5U9NvxE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=GStauAOgIdOquOLPgrwgk/bHcG6JXFz/UisNYkddtJwa4pGv4VxlfczDLfrNYa9VQ
	 1Zqfvnqj1lnPu8IVYmyLTXgbdkZRzZx/K1mRNbtEQDtxwc7IMnPWsWQBYMkd4UIVIG
	 IuezCFie1ETvVCibaNFkyUn01n2fzCWbpfdutfDOD2tH7kkGdq6Avagt5ohyDDtDAF
	 V0DgA2N25EEqZxakWahSZBJyvF8pNpKtTnbHmD/cC9hSWJf2Ilz1JCsztStk8CyXp/
	 jUFeKW+cC5R8c8M8Oy0k/r4FhIHgcPeFQwkE3RYW9xz32aPVGCEo0XUM009iOrbmZV
	 j/oXj3ZyUFfUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50DDBCE0863; Thu,  7 May 2026 10:09:42 -0700 (PDT)
Date: Thu, 7 May 2026 10:09:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/7] Miscellaneous RCU changes for v7.2
Message-ID: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains miscellaneous RCU updates for v7.2:

1.	Don't queue workqueue handlers to never-online CPUs.

2.	Fix kerneldoc header comment typo in srcu_down_read_fast().

3.	Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace().

4.	Mark rcu_read_lock_tasks_trace() and friend BPF-only.

5.	Simplify rcu_do_batch() by applying clamp().

6.	Simplify param_set_next_fqs_jiffies() by applying clamp_val().

7.	Document rcu_access_pointer() feeding into cmpxchg().

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |   12 +++++++-----
 b/include/linux/srcu.h     |    2 +-
 b/kernel/rcu/srcutree.c    |   12 ++++++------
 b/kernel/rcu/tree.c        |    2 +-
 b/scripts/checkpatch.pl    |    2 --
 kernel/rcu/tree.c          |    2 +-
 scripts/checkpatch.pl      |    3 +++
 7 files changed, 19 insertions(+), 16 deletions(-)
