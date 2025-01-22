Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140FA14A91;
	Wed, 22 Jan 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737511514; cv=none; b=GS3iQ6sb2xtg39qt+RfYdG5e8mUTcMw7/GW0F8QkYfd5SxokjLnXl43W9obZC2uLoA1lL2D2IiI4Icnrn6+GVm5aIAU6eQI4nUI3WSy880KIzSuyNPoIphkHNAgXwxGEIAaIFJX4CQq6YdxwlvSdk2iD2w5iR6lmBLzW5tLT0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737511514; c=relaxed/simple;
	bh=vQPiQ8QNaTXXDL8Xs92Hob9VlzqUsWogQhWRHq0xxoA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=opNuJQtFkhULWqsa61sghOx+wQOSfMK250y09lpga1bRWfD7iD7QhpGXXoIVqX46ubLFga9bB7nqC6OQGeKF4Y+epDcB4th4rfcvQ1hVMANIYT0Q/7MKn8iRhI5pG8emdXZRfljAJzTwJy0N/AHIX4kWKZgyFPYFjBF/Do5bpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXN5rVqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXN5rVqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEDBC4CEDF;
	Wed, 22 Jan 2025 02:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737511514;
	bh=vQPiQ8QNaTXXDL8Xs92Hob9VlzqUsWogQhWRHq0xxoA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SXN5rVqVpWfhCfeQjbJIQqv8CYqSSi/lbz3i/jmpuZ1tzW1hNV6wWVHGyEWhMB7OK
	 M0WjMECKkgM4UENgGxt1IHOpncd4sPNICHkuB8njbgl3VKj2plR7pxb8p5GLrZRZzC
	 FRt5QNGdOPaplS1VmbSIiuemqyUwrncmG9X+4emlS1AwK68lwKomjloqwUMnx4JGmr
	 oJ4HDxQGYAmySntlA9OGYy/QBfsAqTwRZW49JG7OjNDESWvZdBdEyqcy8uQekwG2i4
	 IcQcvTjU7SDZRRttBgrDBPDuamsuQQ8Sg8lyZAxJ5KKLy0Ug6cH56C00JdtXXcG4q4
	 jad2xWNj96y5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7108F380AA6B;
	Wed, 22 Jan 2025 02:05:39 +0000 (UTC)
Subject: Re: [GIT PULL] kthread updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z42M-Zqd3kBNCfgz@pavilion.home>
References: <Z42M-Zqd3kBNCfgz@pavilion.home>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z42M-Zqd3kBNCfgz@pavilion.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/kthread-for-6.14-rc1
X-PR-Tracked-Commit-Id: d8b4bf4ea04dd96fe43f6010c614149aba4c9b91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d6d3992235ed08929846f98fecf79682e0b422c
Message-Id: <173751153807.200830.8855582233449245157.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 02:05:38 +0000
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 00:38:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/kthread-for-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d6d3992235ed08929846f98fecf79682e0b422c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
