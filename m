Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AF2E172D;
	Wed, 30 Jul 2025 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901271; cv=none; b=d7cMIcC7aDAOSnNfw9Gg0G5dODgKNW4BxAGMiK1EV2NjjuTWFwporaGrYPrVFeltCkOiDRv7zlODPpKOzkaT6NXkvgAsqHwBz4dbWr/vO/n3yRc5MVjWk7bwTnCZsIiAgRW3NVqULJ/077OlXRI+foAHKtjkQtKZ/fNTO1mGf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901271; c=relaxed/simple;
	bh=IdiLQQ+QfRvE7e12xyGZtZUPFNqgDITGXGAz31ONsaA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MfF4yPiOqY0mHwBPhXgiEn0SYp15Y43fM6EvLJ0q4jJrBV2c3roleVUZ5fvDSgbGmta5VuWa6flzgVkFHJmi/wGXZV4QSRKVTGG9853HiZ+/TJQlGyq6LV77XCj8s+TqTaE82TYDBApVXSAcfu712Z6b0YUdF3i/55e2h2cP7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX0EiKGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX0EiKGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC06C4CEE3;
	Wed, 30 Jul 2025 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753901271;
	bh=IdiLQQ+QfRvE7e12xyGZtZUPFNqgDITGXGAz31ONsaA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tX0EiKGj4KGN6XFbj5AlkdotSR7oqIrfRekFGHx/We+N3SgDUFmIi4oRWWjFM4Lxy
	 2L9G33ptjqJrcPgQbzKeeH5w6Xq6MgYeYD+tuAB8vzTofmZz3WAjOwjq5CVv3owGWW
	 ns6nzvqDSBywtw9Oik9DuR4dI6vSmiKFZ+WAwiqTJ1Qo8BDJIQ82+WdgL1j4+QMIRQ
	 MAZYV9eygeEawl89gC1uQ6kesZMGZ6HNQBy2pFk0DoYgDENbghRM2mwSlPKoiufCTQ
	 bdbQPS8x+7A6eHmTdDg49qACb+DkOu2pJukABgFrg13lveNULtIddKV6TVXao6Y8Ij
	 urF+q8vxFvklQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4E383BF5F;
	Wed, 30 Jul 2025 18:48:08 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726024605.GA17131@neeraj.linux>
References: <20250726024605.GA17131@neeraj.linux>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726024605.GA17131@neeraj.linux>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.17
X-PR-Tracked-Commit-Id: cc1d1365f0f414f6522378867baa997642a7e6b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2db4df0c09eeb209726261f43fc556360b38ec99
Message-Id: <175390128712.2433575.9447733185035659832.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 18:48:07 +0000
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: torvalds@linux-foundation.org, paulmck@kernel.org, joelagnelf@nvidia.com, frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, Tze-nan.Wu@mediatek.com, a.sadovnikov@ispras.ru
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 08:16:05 +0530:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2db4df0c09eeb209726261f43fc556360b38ec99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
