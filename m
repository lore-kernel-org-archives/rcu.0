Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6B37FF4E;
	Sat,  7 Mar 2026 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913646; cv=none; b=gXoYUD2Os146N+mLTtmkcKMZ5zKC+3IjiM3V3Oi05zROAT3ap7e+GNGPFYOhOTazUAMJzrd+ARA5rhC3NLBwQkbnaN2KRUjRt8P42zIKLPm0UNDEUwzRqS+rzdUM1HFLXZ1ccoBL4VPK00Ameu63ORxlA7KO+bjHrsnkdevWs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913646; c=relaxed/simple;
	bh=uc+HQxdx7S6mqbvdxxVC3VppSOmYSDY36704l/cWMY8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bm8sDAeby+2y4eaZSa0voMT4ty40Q5L9d3E3fwMUFzKgb1giKTptVcULHaLac1tIZxTkVZy2dqVIMb3NztOLATwX4rhfeRo7NkszV5+I2ejfqwmusGQJtXy6xMQ46AY9g+EnNMrW1rm7f04sej4lsh8Be7IJINSjW2PxGe/hkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJp8az5M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJp8az5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589ECC4AF09;
	Sat,  7 Mar 2026 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913646;
	bh=uc+HQxdx7S6mqbvdxxVC3VppSOmYSDY36704l/cWMY8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lJp8az5MWh0yW3T960c1SAETbDL+UYch5x+zGQmM2ACxqsufUhNzbifuAJYiqS2ar
	 beiFq2rFzS21pvdgOGrAg523MSXwIjMJMJZposcptq93yB4r2W2E1t7gVC2xYB9c3M
	 8PuiyHAuoc4cj5tvNzvnY1ckrEDRIEP4Ax88NBjeFrD3UmyCXjeVFCWTu942wiFZ5a
	 IA5NpwICW1WFnkLbixbLCXi9+FJEusnmAjoRcXiEY58GfoOPpWtliXplDG9+3dAdJG
	 4FX7JMeqgI/owMHJJNCy0odkv/WSQLFPuA20eW0GniB7KqtBnC4x/uINALEfq3BLd0
	 h6GnEJiNtQxOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 335923808203;
	Sat,  7 Mar 2026 20:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aaxo3f8V-IM8WGpf@tardis.local>
References: <aaxo3f8V-IM8WGpf@tardis.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aaxo3f8V-IM8WGpf@tardis.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.0-20260307a
X-PR-Tracked-Commit-Id: 78c2ce0fd6ddb6c87aaa56b0d49c70e17df21e6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03dcad79eec3b2056c31031217cda9be70eabe11
Message-Id: <177291364506.308260.17964083727900660483.pr-tracker-bot@kernel.org>
Date: Sat, 07 Mar 2026 20:00:45 +0000
To: Boqun Feng <boqun@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Mar 2026 10:05:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.0-20260307a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03dcad79eec3b2056c31031217cda9be70eabe11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
