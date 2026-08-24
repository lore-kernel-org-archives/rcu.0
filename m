Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6991219E8;
	Mon, 24 Aug 2026 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538711; cv=none; b=RKJ97GvTnllH4gmz2ecp+401UzuqHXC2yGSNbtNKOX8YbnXPE8qym1fvODF6mjqw2egWPCetIDIp3ghqlrpynV/Kct+TMRlBaNN1rq/ODIwAfTdj3cKx7k+obqDpmDw723FaVjWAjaTtuD2r7hJGDJ4z1XS1gLziM6lfWpjjz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538711; c=relaxed/simple;
	bh=dmhGH35IPKYsMghBdgaAkG4cwTspEqYJX0xxCk+JhnM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=puCvJV9Psj7ZTmJ0G0U7EZd45nUhy6m4lU8LXeGT1Pqs6U0AVWBCj/MvH/FK7wSMDX+Ck67GcS06Leiqv4nRlycr1yskVuZmxDA2OwxvJqNM7AvxdXn3n5Twm4/I+JsZvIGukG5/JJH0Lcz2185YMMa3ifETyR++qvVha4zgFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKEcrFTG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKEcrFTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E77A1F000E9;
	Mon, 24 Aug 2026 02:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787538705;
	bh=k3XKkBFkBXVzLDYe1mc3c9Z3G+7IAoGEweylGVLmZcE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=hKEcrFTGzYjZeFX1p+1ZecPR/8xWjM4+bDB7/SkkT4fX/kpAiaZ+wGMOCRcAEyska
	 xCGHsHQCAadKJfy5j1JZ7KxAuW2Smda3v+EDjM0LH7dBEUitg/1OU88RvGxONnBVgj
	 RRDqaZm+Wo3htUtVdcW23jk6RFpJljJCEj1H4hZr2/r9rNY6rYXkig2zo9EeroAoXu
	 0/97fzgULOIRP19biupYllKS0N7s31Ck+he3Iomi+8O2wBg24FTUfNZ6EJ/P2IMkxM
	 SFczbkrlz/hQtYcgEbx714b8G75Fsn7d/s96/KjFUImalip1Fy81VFVwVa0eWCpN0E
	 lm+ylJIajJThg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 59280380CFE9;
	Mon, 24 Aug 2026 02:30:54 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <930b6c91-c426-46f0-b193-22c1e984f5e2@paulmck-laptop>
References: <930b6c91-c426-46f0-b193-22c1e984f5e2@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <930b6c91-c426-46f0-b193-22c1e984f5e2@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux tags/rcu.2026.08.18a
X-PR-Tracked-Commit-Id: 9cc63f8bcd560c760d0b12e15bba8f81c86237cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83684c4e4d62cb02b2e4d0d18963d1035439278e
Message-Id: <178753865353.2221708.309134272321974998.pr-tracker-bot@kernel.org>
Date: Mon, 24 Aug 2026 02:30:53 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, puranjay@kernel.org, kunwu.chan@gmail.com, manuelebner@mailbox.org, joelagnelf@nvidia.com, qiang.zhang@linux.dev, itai.handler@gmail.com, work@onurozkan.dev
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Aug 2026 16:41:52 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux tags/rcu.2026.08.18a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83684c4e4d62cb02b2e4d0d18963d1035439278e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
