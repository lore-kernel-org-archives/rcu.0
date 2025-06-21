Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843DDDC1;
	Sat, 21 Jun 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520813; cv=none; b=kejvJxYZqRyMPmhFYmEEgp4N1tMHtL5TOnogZsP2Miz68t0vgApeVQCocx+P9HlkWoGTl/4PdgRaoPKJplZoKsQDpSGLWYAn29AghhOMzMuE6DxX4W3O8LIESe9Z+Up/YdrzJD5K+qkGWHe86uJUnSaHNxuVyBn5nMpcct0iIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520813; c=relaxed/simple;
	bh=LdBGgPrkf5Iy1nVeGl1Mb4eJjm0U2BHjhS8/4YVauyA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b8GitQoMxSb4YXvKoPFqtJzJ9xqv2fVQ+BQlA1VKF44MRtbzlto4n8lYhaVCWvaZskvh65aJ2owR2D1cg5ofDDOIFkfDEu/88gqSU4PrXzuVLphsaW15Em82PTUZitmNQmJRsYBMzJihRguZArX6jSnAHi3Ym1c8PT3jkbQ/oEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ/6H+U+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ/6H+U+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D536DC4CEE7;
	Sat, 21 Jun 2025 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750520812;
	bh=LdBGgPrkf5Iy1nVeGl1Mb4eJjm0U2BHjhS8/4YVauyA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lZ/6H+U+v6wW0BqH6n4+FJDW20spTuLDl1LlFwmEV8hfIF/T+bta6Y5ZZ6F+w0bnU
	 BCR5s/MFFWDO2jwVcME6bu+XzEblApbzYBGu1FClanqiCnLhbslDV5qkZeSDBlxuXh
	 QeOY7X0XkVZN6ftvIzS89z5ccsVgDYMEv9Ceyj/5ywtAkjaI6Og4QD3hxyGXhyO9Xb
	 mRPhlJqmiflmBWGQ/BRNsVpnRAHUqnRIiaVKdneleGbTBf592NY7469whrucgUDaqQ
	 6TEu7CMTlkJifdMFV6JNNtnU4usV9Jok4gJN4T+b4CbhbEde6ykA0eI17xh0+NCFkQ
	 3J0j0hg1wFAkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5438111DD;
	Sat, 21 Jun 2025 15:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v6.16 -rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250620195234.GA3336282@joelnvbox>
References: <20250620195234.GA3336282@joelnvbox>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250620195234.GA3336282@joelnvbox>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu/fixes-for-6.16-rc3
X-PR-Tracked-Commit-Id: 33b6a1f155d627f5bd80c7485c598ce45428f74f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afa3d8b6e01b4637d494bf1b1b8b531fddd1e452
Message-Id: <175052084035.1887408.15628494856931395536.pr-tracker-bot@kernel.org>
Date: Sat, 21 Jun 2025 15:47:20 +0000
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, qiang.zhang1211@gmail.com
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Jun 2025 15:52:34 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu/fixes-for-6.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afa3d8b6e01b4637d494bf1b1b8b531fddd1e452

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
