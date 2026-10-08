Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0726158B;
	Thu,  8 Oct 2026 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434829; cv=none; b=PwToVYleSo4ZYTdmz4V2DzQbSwjsi6lKJ849d6MQpIq0hS5eS0S2KGLnCC4V+wSV7p8hgfcdB3/uplyi8ZKOPU9b5TRnTGDPNlU14170toe1EQlM2BSikqTHwsyhvwhOTi+RsJ3a31+aIrdmInDXYNobylOmdfu8NkUnJZ9QRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434829; c=relaxed/simple;
	bh=fsjsecC7jmQ19OX9K7iFS7+Kt1eWakDJtyAtLEpNcro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O2MKIb7lHXC1ZEpuHQBuA05K+RMlg3Y+sEdozutvpp2UfqYSE+7o+dty8IzUSUAFeXnJ/yXglzhguWv/gFsxnPiAUvaZUkGu8oEO0z5ht1zmuOkqsfiUUo5Cac9C6p/LON8ywVDPErSdkFLRHr0VdQeFLzp/Gk/KD/DtU1BJo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG997vUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG997vUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811111F00893;
	Thu,  8 Oct 2026 04:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791434828;
	bh=mZh6ATN7pYd/biAqRPZPvUi1TVgxtO6VDMH0qJLu6yw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=hG997vUW5QXanwjREWCfjUL7+L5Y9epv+L3qlmb3OrJMotHMqZMt81gE5sgKumTev
	 dt/QY0H7Jlg9YE/BGxKp5TR7wBSQQE9MEDJhM8FYMfiCwnNLQOw78Z+rU1tw812Jf0
	 PZxI1qGm3X+RCt1b0unkz3Pq201kRnUXhCTsD12nrNxilxilD9urEWBoZ9F4X7iTT9
	 SgLOrPo8co5t2ICeF033nEk6MD+QqzCohP6lewkg8alR4wnwd1zAG4R9H64zlkIKdH
	 Sq5Xu/bLeM4s0Ryv4cGoj/UcpkmEyKifJlfNiRpE5TsqMSNHPe6k6aKDaCF51dXyJp
	 Fs+j6fjVkvHxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774F73809A13;
	Thu,  8 Oct 2026 04:47:08 +0000 (UTC)
Subject: Re: [GIT PULL] Urgent RCU regression fix for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <3aca04a9-dd13-4990-a715-5778871ead57@paulmck-laptop>
References: <3aca04a9-dd13-4990-a715-5778871ead57@paulmck-laptop>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <3aca04a9-dd13-4990-a715-5778871ead57@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/urgent.2026.10.01a
X-PR-Tracked-Commit-Id: 26f90559a77cac4b8fdfa3491732b7c7e08210ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cc6bbaeb3afe9166380eccd8d166d2dd75c0278
Message-Id: <179143482710.3815904.5365962844535111103.pr-tracker-bot@kernel.org>
Date: Thu, 08 Oct 2026 04:47:07 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, Sunho Park <shpark061104@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 7 Oct 2026 13:10:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/urgent.2026.10.01a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cc6bbaeb3afe9166380eccd8d166d2dd75c0278

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
