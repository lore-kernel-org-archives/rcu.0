Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B31DF970;
	Sat,  4 Oct 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759606141; cv=none; b=Tvpfxrossy1KanEcPKkg9TwJVOR5Z58Di2Ig9HIzF9+m6p9kmKWGbtfCa6rNyVF95EQgyGcX/QMD0/Qe5rfypO5DBPsdF0UjRAOBJdhRtl+D4WWqprq/Vx7/WOxVE3OZA1wHcnfkAFf9MHg4NCRaXxru2bOHW5Qmzn9w07aI0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759606141; c=relaxed/simple;
	bh=q93svpQ2RTo7MkPDi0d1bAYXST2IPe4uhZu76K3srxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EjO4c+DKCzDsYVod/Cp9bV64Nq6icQWox/90YNz3b/rwS4ydqIDVBSfduI3Uxyfh7K2f82bSn3fuTymICiINbWoQ7z6NhtADBRNAQT9XeBn6HatK7iv6e85hTKvkN+RttmN+QZTlmc1c7/h7qiep3yJDoRNmLAPZDSUskzYRGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB6LpkPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB6LpkPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF91C4CEF1;
	Sat,  4 Oct 2025 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759606141;
	bh=q93svpQ2RTo7MkPDi0d1bAYXST2IPe4uhZu76K3srxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SB6LpkPUvXKFcNR+cxv3mkVYS/aWHbD9hVdLJAeranqfgUr3asbgn8Iwpl66aJKkS
	 QQfr/E5Mr9HNvg8eZ/noYelODI6FqJVgQVNBNT8SYiE1TM1DOX54IrvxIA13Nv4V2z
	 mQ7H+J0CI03hY0loe0aCd3uFx0VynV2mCYVIUoGG6eI05qH78+y6UfTeEoDoML8s3N
	 +AWclov9CABJVEXBACCI9Y19nWPev3216N8B3YjDylgtui90lT1FILHVmIOSGsyNpc
	 HQ9cQY4cE9ZFEDISitJaGtnyhE6F4p7s9/Xp1fHg+HMCH0fVSzKXN77+AUTiu/rdr1
	 ICSIyiMjH+qPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC9B939D0C1A;
	Sat,  4 Oct 2025 19:28:52 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <54b61526-1b94-4dd5-a339-27ba75fb52f3@paulmck-laptop>
References: <54b61526-1b94-4dd5-a339-27ba75fb52f3@paulmck-laptop>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <54b61526-1b94-4dd5-a339-27ba75fb52f3@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux tags/rcu.2025.09.26a
X-PR-Tracked-Commit-Id: 1d289fc5691c7a970a285bc53292bac9e37c89a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67da125e30ab17b5b8874eb32882e81cdec17ec8
Message-Id: <175960613135.420492.15724951855398118521.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 19:28:51 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, -c@paulmck-thinkpad-p17-gen-1, linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 09:15:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux tags/rcu.2025.09.26a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67da125e30ab17b5b8874eb32882e81cdec17ec8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
