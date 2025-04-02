Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585281DDA32;
	Wed,  2 Apr 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616060; cv=none; b=kKgUN/TOgA+YMnoxVXzIZQpZTcLDxJdRc/rsUDw0iLb+xeja37uOWGiCCHfy068Aj+2ncJy7fzKu+sN1VZBGG0n1KKNEncUq/BnfdDmPicD2ntHZ9dV/XRb04XWuKkhRxDj8tjsT3OTbAsfLB0IJbGjWZqM04zaiy3YN2zmxPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616060; c=relaxed/simple;
	bh=r+bIMNU16rm/aHZcFKK/UubMhI9ff0TZAd3Lb1i6ILY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g372y4CYwmeaI4gPC9FMnFqkYM6hYBytGqRh/nE0PL5X6p4w2k/IDc78vVTeWOu5VWjgI8eQ60RH3zEXeqMnAU7M2c1mqBvbz/ML9CskelEO0j5q5HiTR6dobJQug4ghINZgw5jCNGdICPiqkpmKZM+/HY2wO7XK16HPkaOid3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWEBdPD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWEBdPD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2118FC4CEDD;
	Wed,  2 Apr 2025 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743616060;
	bh=r+bIMNU16rm/aHZcFKK/UubMhI9ff0TZAd3Lb1i6ILY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AWEBdPD2deC2gG75t06sB3AX4FtwVO1TIlx2ZG+vpiNCLiHpWVx5Z9b5/SDmgPBab
	 PMJfQs8NT8CG996QOGCfOyJChziUQgHHcIWRdRlhkeeaMa/1RgKEKiLZ+dje89F7xm
	 2OUChBecWC3Rr27Ksr5suTO97MnrqWZobGckLu3JyBaRsbJ5gsIWrT6ECW4leK5vtP
	 e1tm0kNphjN7lfpQa8O1FaWB5Gm6TGZqJ+8m9lX2+BzmRv9aO7SXBFg2qx0syBDVv1
	 jv9XGdI/KzffT++IqnPPrHN4rlXr35bpsshHTNqOi2qfAkCwXDJYebwTsTV9U3Mc2N
	 yEeHv5sYuhaDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB7380DBDE;
	Wed,  2 Apr 2025 17:48:18 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-zWJj-pYdvuUYPE@Mac.home>
References: <Z-zWJj-pYdvuUYPE@Mac.home>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-zWJj-pYdvuUYPE@Mac.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes-v6.15
X-PR-Tracked-Commit-Id: 1dc1e0b9d694eb9016d3105ca4ba8bd90eba888a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da0512b2a3b4124b1483751f090d7ac13a713f0e
Message-Id: <174361609686.1617726.14301012725477903008.pr-tracker-bot@kernel.org>
Date: Wed, 02 Apr 2025 17:48:16 +0000
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 1 Apr 2025 23:16:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da0512b2a3b4124b1483751f090d7ac13a713f0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
