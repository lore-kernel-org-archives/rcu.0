Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BE502B1;
	Tue, 25 Mar 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742874759; cv=none; b=jqC2YQu2g51TPjLDuJWGMa2c3hnTp7Sw8wajAqIaIsDTnTNe01ek5DIpY21VPmxs0+H2szTtucDVJuVlwU107T5MnYux2QHXd4GMejShlKNsMywJTEfMZb1guIF5atM4eQ/Wj3Ro0etEZi46//5d4Hqb1+lHaFTiV6RusZdK9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742874759; c=relaxed/simple;
	bh=AygCpEaW/xU7cbEzWuEy7eBXSG5U9w4tnIRjlFNTy8Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XmOyfbL0YoAaYsclneL1sAahrIBlKO8i61jehv83r9/2aQLb3P8FOQKzYsiJ1vU5vZME98dRYmrjQ4OBupY7b7YFziW7MXaifSHZfe1IasaWssj4dF0gFPTFgtRtdxHF0GmuIOZJQvpEtzWTyWXQVIsUTOy4UHU65ZHWh2PCX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCFsz3IH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCFsz3IH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC050C4CEE8;
	Tue, 25 Mar 2025 03:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742874758;
	bh=AygCpEaW/xU7cbEzWuEy7eBXSG5U9w4tnIRjlFNTy8Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qCFsz3IHw3kc+3IlEg3W2Dy4KEtGTkgun9IYN9gQphenYQ2iZChNd71CB/ofyS2aV
	 QggfZPZJDMESHQoRSIYjwH7lgb+qH5nNBHHKywX3L9L12yOcr6E+SjjV5OL9BurwTm
	 2roYLArl8g+JLoBp4ZnJMWemHLIYHed2TsPVCTlaGZUaC+6EJfVpgghfjNdI40eyGf
	 zCqtrf+Yl1Hc9/Od8gmycwf6aHsDZ2Te6Vpd2/X0fCiz/SCG4MidMSyxqkVcPnRpur
	 lYGkCnF6FBjSxwcyLI+ljHtOo62Ro7GRQLdkypEvxPp15NxcQe+DDBoVkJxsEbKDMj
	 +AvGqX1zz5MkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3430A380DBCD;
	Tue, 25 Mar 2025 03:53:16 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z99wJFZC1XlvA4vC@Mac.home>
References: <Z99wJFZC1XlvA4vC@Mac.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z99wJFZC1XlvA4vC@Mac.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-next-v6.15
X-PR-Tracked-Commit-Id: 467c890f2d1ad6de9fd1dbd196fdc8f3ee63190a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ba7dfb8da62c43ea02bc278863367c2b0427cc1
Message-Id: <174287479472.80196.12052300501583742810.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 03:53:14 +0000
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 19:21:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-next-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ba7dfb8da62c43ea02bc278863367c2b0427cc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
