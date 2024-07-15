Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAA14386C;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087783; cv=none; b=JrXkKDwiqDHRDzDg5khaI6JJu17Qy8wxuG3AWjrjUujVTDONZBLYXEvcVSm+HWOFmhnEdzts7jMbsey0aKG8SKZ0Zmiqig1WQOD77fibhpJEHao5LavIJLbHbquqkVWmf9KSoOnH6qoqaxcdgJYM2O8FC8d4tifzteMnD3Lq9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087783; c=relaxed/simple;
	bh=/FYXu80BB0sUEcSZK8IinsqW7xUpo17gWdLunAU8xkU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dWmY2P5BuOJpl8LQXlwDvjnxJbT7atkfKFtYJoE4A0nk63sv+DEUf+i/BiXvB3/eEWrNoeULlpg40GStSt7stitrpkRHtpi8inOf/w8I+SJRHP63IomP42+2oPurxHjuZval5DUJuwMcPPg1gqNcYM/LEhajb7Ub2a8t9xFB6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiKnQH39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiKnQH39"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B038BC4AF11;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087783;
	bh=/FYXu80BB0sUEcSZK8IinsqW7xUpo17gWdLunAU8xkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PiKnQH398BUyWlo5J2WgjgUG1rSqyrRtt7J4Ex2UehnLUUwnRz2e8pIfH45xQpmNL
	 qhTtoorTUk7TVvI8hxas8CXWCVjPFtikV+Yz0vo5DCmKmXyl+mYKnCwXReQ4cLo+sy
	 XkI3GaPVH+blBDqHDSjmN0fCwinxvFrHf/vmlExE0FkYh7Pped7qLnxdyDDH7YOvU7
	 cGl4OW00lJzZQotlvMJoa1oX5x29NfOv+z9uHCQiBg1Nn+KxeAkm6b/jTxbBVaI8mf
	 IuTBVmWaQjnmnQ3qGWBW9kTmX1OD9zdB4JTYyfq+ZqElFKEGP2KbhnZlXDQx63OijT
	 RD98WvDM/Pihw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A35D9C433E9;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Subject: Re: [GIT PULL] Generic torture-test changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <181de733-a175-41d8-8f83-6c4597723099@paulmck-laptop>
References: <181de733-a175-41d8-8f83-6c4597723099@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <181de733-a175-41d8-8f83-6c4597723099@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/torture.2024.07.12a
X-PR-Tracked-Commit-Id: d4641fa67d3dcc24d108cbfc4e47d0312ef49947
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b176e21d812a0674196996e2f53d481208c5d832
Message-Id: <172108778366.25181.10368481879692023322.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:23 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, kernel-team@meta.com
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 09:37:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/torture.2024.07.12a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b176e21d812a0674196996e2f53d481208c5d832

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
