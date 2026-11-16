Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849407;
	b=JKB/Ek4eAZfTxC2nVZjOUrlCOPhieN17KO3B6beC7WnDGH3CqlN73DqguV378j10IHMd
	 bZlAzdLgufUb52ma5PERzrrZf0iR4y7ret3UfOGnf1BpR+Xa5tCpDGy+nGhmQXotzjYkY
	 h/BE6nv6UqKlBbqSjnGBbtxRxYoB4fOWp7YiaPdH6g/xx16U7uBdj72VI2LA4x7ogzN87
	 XW+SOdznvnu7vzQOfH2iCa5r7D+hDmp+WpjkmTumc0sNks7zQRYS32y5I102l9jfkqOkc
	 9fGAdHqoqsNdFOQskbHIOJgp2XQfUDjjWooiikqGg+MdDsO3ahIIgkZW3etzwP9/LrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849407;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=DOVCQKbC8EVJ29olATow4IqCIcRcEPOW1cgJ8btRlI8=;
	b=tRmCypy9Sqhb+H/tfUslJCAB2Gu1i24Z2+kpeOaYD3rR/1ZDsAXBQZA35/i9v3Vyof/W
	 90lRlKWzKzJDtgzfWu6BpabaAOa7J3/ckZUYFZCSsYMfu4nuiTf6WHeFD5DdSxNNafEl5
	 rRLa2Ps+I9qchXDGsQibPtDdl7qz1S++koV4Ep3mYMToqCtRNx1jiE2VV5EmZbdUfHWFJ
	 6tmNBMCi91QcSl9ZmW0tEZW6/Z3Dw63vLVpvJIstv1IbAhiU4GsISCiaPiayIRsLWndpj
	 R+Lnw6vCNvRdJrvGTBm4pPOFEd89WMeooj6VMxMw2Siz/Eu9BpmMVeDMF06YAM1w2eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyrAceks;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE3606A322;
	Mon, 16 Nov 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyrAceks
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B251F000C4;
	Mon, 16 Nov 2026 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849407;
	bh=DOVCQKbC8EVJ29olATow4IqCIcRcEPOW1cgJ8btRlI8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eyrAceksX7qtKZH+WN4ytGP7ofSMfSXzjPvQimGSrB4AblkuyU9z1Ud8Ftmbgx3Ve
	 dz/OYxQkNYioAQMtc76Unf5Vkksq+afUjXwrmmHhDOD+ZOJnLDyfg/oIO0RKoYCoB+
	 ELuelQvMfi28pGmOl1GUyXICCFI17vK9HvQSw71Uet1pFBKY22zcRPm5qNyYuqKHnI
	 lkp1cHV1WVgVxtrwUMuBPsZFpF0T7pen7o+n6rCztRUzgS1GbS4lkLOZxVDLVZTYX+
	 wPuNvPPb1MqQpQE9PARbCiR8C3ebTodsIUNz8jow+EBnAKM0ZNznVYm/ay21SC/+3S
	 XFDaFwIXJchLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1616391AFAE;
	Mon, 16 Nov 2026 17:16:46 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261116001556.763913-1-jfern@kernel.org>
References: <20261116001556.763913-1-jfern@kernel.org>
X-PR-Tracked-List-Id: <llvm.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261116001556.763913-1-jfern@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.4-20261115a
X-PR-Tracked-Commit-Id: c3f98ff6309a29979e1867bc3c9d4172755ca122
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f6fccf6ee5a345b778706b22159c4e3b547c808
Message-Id: <179484940579.3777341.12017219892480230758.pr-tracker-bot@kernel.org>
Date: Mon, 16 Nov 2026 17:16:45 +0000
To: Joel Fernandes <jfern@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, llvm@lists.linux.dev
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 15 Nov 2026 19:15:56 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.4-20261115a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f6fccf6ee5a345b778706b22159c4e3b547c808

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
