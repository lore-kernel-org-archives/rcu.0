Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D571CF92;
	Mon, 13 May 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619958; cv=none; b=EKEUV9F3pbQMkGCHY0IV0vRTeyqw45pABwJwwCBx3huB2YSW9bctLQkuOyBPjh2tO8EnJsWTi1aJV0UzQLaB6uZfGen98FnV4lFxduAaOYYU34I0vOvAO+Itxe+9TYa0TnEl52VUULpkOOnsRIKmJAPh0eNy5mgpOttBvWeuJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619958; c=relaxed/simple;
	bh=EziJQJFlPQo1Y7dx/2lm67+p5DWF38vrYwsmvm5DH2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BimkWiFAmBrqQ8gV2oKxb7MIHyoqDMqhDTpbr/hTV8b0GY3cBP7K4CbX6TQRoa5LBKOlmNwRTwBbTeAuhjpgNhG9wg3d/QDtOGtcpBCQ799dG5pVxRgQtpk9wzYALDUxQVFrRfk5G6EG73dLw0judQ41D3pty/6BMTgpMwLt3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa3QHSeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa3QHSeT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1A12C4AF0A;
	Mon, 13 May 2024 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619957;
	bh=EziJQJFlPQo1Y7dx/2lm67+p5DWF38vrYwsmvm5DH2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aa3QHSeTtnX0rcGojniIvDBAhh+GFwgQpxXTZWr1XOckTMSrTa6DrkwFC7YqQN4tw
	 XuwTlrwu5Fx1P93rYvqyyouP03CTE0Bex04paoV8d1KbSV2jSKIBi5UUOF9TAAOtXL
	 eDjKCQc60CZ3S3CpfOgExqXnT1nVtSO/k3h5NZ795GiVk2GQtYnsLJnrx710SapWxT
	 M5XakbFcgitzh+zTT0jdNuqF9zKqxQvTJvDhYsbanLf3VPrH6LHol2jJ5+iK0A5p5P
	 9DFiCASxnoYvAAc7kOBEDccyLjvZbqi14/75yYL2xVQyEmVBgA2bJ/tGRQAFvJcCD6
	 RZCfWslNMtTuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9B7EC433F2;
	Mon, 13 May 2024 17:05:57 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240510183049.312477-1-urezki@gmail.com>
References: <20240510183049.312477-1-urezki@gmail.com>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240510183049.312477-1-urezki@gmail.com>
X-PR-Tracked-Remote: https://github.com/urezki/linux.git tags/rcu.next.v6.10
X-PR-Tracked-Commit-Id: 64619b283bb35b12a96129e82b40304f7e5551b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0b9620bc3f0a0f914996cc6631522d41870a9e0
Message-Id: <171561995775.9638.17597535574035327440.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:05:57 +0000
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes.berg@intel.com>, Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>, Zqiang <qiang.zhang1211@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 20:30:49 +0200:

> https://github.com/urezki/linux.git tags/rcu.next.v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0b9620bc3f0a0f914996cc6631522d41870a9e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
