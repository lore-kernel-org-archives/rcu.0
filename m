Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616655;
	b=ZHmDAbJ0hLHwNXojEP9nyZyh8nfGdIdbCY05oxmL/OSL9gWSKKUfLUreStdzbUnRCEkq
	 rx8WWJjeKUNfI2RAiwoWafJmLmSk9S1748uQfsM8+m5EgO9FsSnowdsMhz5jphAlbndId
	 Y0dQMVMoL/80+GFxr4OyLm1zLc3gZeUeXkGIrnkG7UkyyE2qJG+YCBW87esipIyGWOKLo
	 WfjVZugODeGo+y5oX3NnNiYYsihwhoXBS5kkmAsNH2bg/3TsULLeZ7c3rQLhi7h1bg9Pg
	 eER+vHMegd+0FBOq+EsHv1nmJmhyTR6LUdKufJjV4JTj9enIehCWBiqsPnP8AtDgkVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616655;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=NuV8fWErS0z34Xd5lhASsUjBjU9sOHGmFvV0FLGOcfk=;
	b=N75Sa7h8LiAtZqBIEhJF/C0zMABUxGipfNuT1+rmV/dETwgqcg88tpO6OON9nmn3UYy0
	 WPbz+xU2bS7E+0uehVB8VDR76DyN7t7qlKgEryWtz6Y7pGUT7RcNxCTZW6KahmSh+XWI1
	 9jX3OB0FxKUmuWrLYZccF2eOjvFx06aBpl5gI3WH9gRdptPi71oeTsrc3v7ghj95agAlZ
	 9M1zRZqsRqs1P+X58HDQDRVwN60hMil5g/E0eRNQXdCQkjBrVQqX8W8Ve8+mSTnPjWzDp
	 r54jgtbtdtKGaDq9ZWG9Hhal5egg9hsRPQVHErvckj7BralmUvU93DVugBvkAUXsLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWaaA1nW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FE606A319;
	Wed, 21 Oct 2026 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWaaA1nW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806C31F000C1;
	Wed, 21 Oct 2026 21:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616654;
	bh=NuV8fWErS0z34Xd5lhASsUjBjU9sOHGmFvV0FLGOcfk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aWaaA1nW8RlcFoVhWJ7wc3AVGqdluVh4o29MUdAt3Zx94vw5ShWQtmaSWK1aP0Yqb
	 AtXmAaR3hFArwewhrmkWv0uxttjVVQNvB3aVCIrYegkGFsBteLGE9Y2yWJoefnNptQ
	 Iy5bl24dCBmxVXLQqnJU++M5hadph6DzH9ES7f73oP3oXQPr1BWinNs6Y5Dx2sgGxY
	 l70i5uAl3vSKTf8pu0uZGahZ9tplw0+AfOCJ8ct7bj4kDxHq6ZHqWXYBP7Z+zd7YU7
	 XT5urHRjDj3DpGcEF+hnUXUwTzonor3sAfNN618IRzxssydqf/eD/H/5hJs/jhAMHg
	 /Qa5LTxhzEymQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77513380A962;
	Wed, 21 Oct 2026 21:04:14 +0000 (UTC)
Subject: Re: [GIT PULL] RCU updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <720d335d-17f1-48e7-b5e6-49352712cdca@paulmck-laptop>
References: <720d335d-17f1-48e7-b5e6-49352712cdca@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <720d335d-17f1-48e7-b5e6-49352712cdca@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.2026.10.12b
X-PR-Tracked-Commit-Id: d9011419496a3dc6b455b5308846684c63c18de5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7f2bc878742be60e72616586ef2583a75ec810e
Message-Id: <179261665292.1307528.16343350552519918253.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 21:04:12 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kunwu Chan <kunwu.chan@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Zhouyi Zhou <zhouzhouyi@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 17 Oct 2026 17:25:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.2026.10.12b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7f2bc878742be60e72616586ef2583a75ec810e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
