Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1D311C10;
	Wed,  3 Dec 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798787; cv=none; b=VrLKE/g00z5KB7Fnx1VdYnjenHzfjCBmvKQ6kG16mgqXm1y5FNgZ7dWPQvn53BZ+fee20xCee+yBT3F5HMSHjgmo0d8EREdUprlEG2szXD6lztUe6Y2tZANEG3zhKXkMhIFFNCd15vPcaAR0wsXc+hK0eubm7G2/p1hd7bmXQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798787; c=relaxed/simple;
	bh=rDtSAgYidPRT20t4p6RCe9dKkpDirN5uYfPKGaB9xJ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RItcH4JXRg4EPRo7HrEJcQF/9SlYRxyuuvM633KXvJxKjt5h5iuIda6qc5J5WXWxinsIYfqrAFR65oWYnTx0NFOAGjLJ8PJ7UVn9FPrf91/CjqrJSvlEeREGQL+YiKDkUwJGof/sjj8rPt8jgqZU1MHdwdRHzdVTysejx2DDuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsExItQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsExItQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA3EC19422;
	Wed,  3 Dec 2025 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764798786;
	bh=rDtSAgYidPRT20t4p6RCe9dKkpDirN5uYfPKGaB9xJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UsExItQEpV+vmjikjY653gyXm0VZ5ApL41gyQlU7YSh6xk5TkBaJCmSOuqAmd397f
	 y9/8QdvKAk0i4pvWF0jyVfFqeVMijepvTctREevcP7NgrqpoyC7+s/GswprIkBqWUw
	 ThXyzYwPtV8xpfl+Y79Hfnkf2ZTsmxJ+CkCOTfIOu9goTmyHsJ0pCFZ/rUesjQXUHi
	 T+1YRJCsPJuhfMzxLrFminP00GddhQsqAio5fVjozUgemA0rpe7H5qpo1tAcWIlzDl
	 se8ZWO1iWVqXWhvCCAT5rmANsiLBz68x9KefoezeRS1JU9Ni2uVveUFRD0++Q6B1QA
	 Zio6q4NyUJQJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B88D93AA9A82;
	Wed,  3 Dec 2025 21:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] RCU updates for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251201120524.15568-1-frederic@kernel.org>
References: <20251201120524.15568-1-frederic@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251201120524.15568-1-frederic@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.19
X-PR-Tracked-Commit-Id: 9a08942f17017b708991c5089843d4a1bfac4420
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98e7dcbb82fa57de8dfad357f9b851c3625797fa
Message-Id: <176479860626.93177.16572429986633463225.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 21:50:06 +0000
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, rcu <rcu@vger.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  1 Dec 2025 13:05:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98e7dcbb82fa57de8dfad357f9b851c3625797fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
