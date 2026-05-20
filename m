Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D393F86F4;
	Wed, 20 May 2026 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290662; cv=none; b=kBBFoGf8fB8RpxNSTNOXL7HGfbov7+KJsGufqcqq5VxDjreuhJ8mE6tcLtL4W4OMk7xzNYI0OCp4/r1PYtPwxO8QB649uMZdilfQLXmdlgW6Y7jpEuPd3Nx6bxNoE/NgGjkoyHWMu0WJHfF3qxC46Rky6o62/h7Nw42ekGr8T9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290662; c=relaxed/simple;
	bh=lN9CHNxLk99JCYbsgaIVUEqtqTIhLi/g10RSSRRAzB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IyJ6f7UOF5fNMp9Y95NJL4QAdKMJaEDQLZEKJ0UYZgfF5JCBHMn4v7rZn8RW6mGC+9CIwpZx5susyCvrz4YbmU8gXBF7Rqt6E2wsFw7jzp+C1iaawosvZJ6tymsdmHkFUp4J2tnPCJkEOkUz6zE+KWao4lucqmLYFnivzwtV61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F46LCJ5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F46LCJ5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B91F000E9;
	Wed, 20 May 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290661;
	bh=bt67/hPVoorLMvLof7Z4Kw8vbGNVbQRlXGSHjSqikQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=F46LCJ5OD9IoYUYP7eTi7q5dMs0VEnVYrrnEvodSyAM3Q8Q2YUsa3tunaTBqn42aj
	 esuNyslwzIDM5d26WBbw6w7VGdCf/C0DGoDasIL1t3Kr0TQ1ig9tln0T4/Zs7f/WLC
	 ZU0hPtshZm0E7z3RX54RdkjF/ivLl+ZScDeJYZbmw1CIrx+tSdOczKon9QE4AH4UNy
	 0kTasUOuVv2iW4J8gTULPgjywrzqpbYqYEbjASblS8EBStyVwD7dkIXYatOZaWHCNI
	 nQCaTUrUNyUb+ICvkv2qcJsSOzEgdy6eP6jEw4fyr65dGq8UoJtO41//a8srrdvODv
	 CfPQoil3eZPCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F13930B36;
	Wed, 20 May 2026 15:24:33 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <agzUPJ24ENDu37bS@tardis.local>
References: <agzUPJ24ENDu37bS@tardis.local>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <agzUPJ24ENDu37bS@tardis.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.1-20260519a
X-PR-Tracked-Commit-Id: 593889c401426004bd0ea0f6d4fcece728b03420
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df685633c3dbc67441cc86f1c3fee58de4652ba2
Message-Id: <177929067202.3632670.9574555510792609929.pr-tracker-bot@kernel.org>
Date: Wed, 20 May 2026 15:24:32 +0000
To: Boqun Feng <boqun@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Samir <samir@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 May 2026 14:21:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.1-20260519a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df685633c3dbc67441cc86f1c3fee58de4652ba2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
