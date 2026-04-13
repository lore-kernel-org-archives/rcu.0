Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8894345CDC;
	Mon, 13 Apr 2026 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099680; cv=none; b=LqmswsPM0W42gY1XfnBiCylBHW4WL9GHcI22+amQd3Gz7RBMCn8JtUKCQqnHYBXAC8lXxVQqHaetts7r3cL6b6zbkGIgGapxLX2TXQL0tIJnH3rvY5Rs5dcUY8rQNmSOvuHjxwqDO11r1CIMSmH8u3j2F2GAoLJkDu9PAhIcctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099680; c=relaxed/simple;
	bh=Be9BdUtBFgci48ZylLLFqQIEOxZ4xJE01rg4a9czsBU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HcLo50CmGq/uOI4bt+FFOJWMn+E2hdM7Y9BNvnYYRCtIxaKC0N8Tn43ThO/ejKGI2b3N6KWNyukYwOHNMjr8C8sLSO9M9iTTItmqr7AREVnLXdfbJQ1C3L0TWbLKCG6UZMOD0BPqjhzLqW5QCzVb7UfCZKDejrfVcZEc9z5Tj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsoeocFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsoeocFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B168C2BCAF;
	Mon, 13 Apr 2026 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776099680;
	bh=Be9BdUtBFgci48ZylLLFqQIEOxZ4xJE01rg4a9czsBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AsoeocFMENJGi2/86rZJvHHCVg1gktuFvgCnc+Pp1a5JJ75oXEMgwBJWCId7BVCV2
	 Px5Xx39dISl8VDKRL0lRDJlpxSO2cC+ozizkyCbWg3S7TDZj/s8thina9u1cSIYBWR
	 oujZ7t4cdt7c5K3V21XmYSLI6oUaj+h4TWdeA4e7MvnOYWAxhE1X/eJuvVam8qeYQW
	 kpcWUvhAHGyoP8aPnqohP8kebNQWkoBv4T2kVIhBZ1cV730yj8ZIiEJ2MguMFh6gIv
	 ATAe1VuqDquBHdC0+1Wq2G+Adj/3O84VHqe0ePY9FLSdwSjW7r8nl9UPBfZC2d/PtM
	 PBXSacmgPGL/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE453809A8A;
	Mon, 13 Apr 2026 17:00:53 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1774978730.3972500.27807@nvidia.com>
References: <1774978730.3972500.27807@nvidia.com>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <1774978730.3972500.27807@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.2026.03.31a
X-PR-Tracked-Commit-Id: 95c7d025cc8c3c6c41206e2a18332eb04878b7ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28483203f7d7fe4f123ed08266c381fac96b0701
Message-Id: <177609965186.442142.11981535262792757574.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 17:00:51 +0000
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, joel@joelfernandes.org, agnel.joel@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 31 Mar 2026 13:42:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.2026.03.31a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28483203f7d7fe4f123ed08266c381fac96b0701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
