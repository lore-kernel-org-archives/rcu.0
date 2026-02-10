Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26128A3F8;
	Tue, 10 Feb 2026 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684620; cv=none; b=kNOBfLp9orT5ytg1QPlBWsDYHDFFbX/njOaLo96DFXyH+trDJzd3GFyFCbhSPSiUVBKBwmpw1sMwNoHBZRMFK9NE1a6g1bPDhUMFKa1oAzlP1RTjEe0FWmdsyNipldsYGCgx55FMhjiTAeJ3OGdDGL0CoKHlSUl/zDl+m6gemY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684620; c=relaxed/simple;
	bh=rJj57/3AQz4t5mc81tMaEFJ/Pr2ZbJrqqy5O4dT6EuM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GR3AeBf2ErLQMZi1EnFwAjYcIeENORRXVjbA5nA2VxrMFGpfrSdTwaF2A3FcA5M4DYwe5Z4Fe2DEgD9v8oqAGWMbKrGEk+oAkopZ+lFXGEkJ94fG+WKPpopYocSskmf3cZ3fInis5U/BCUliBMx8Oi2PMzz56//suG4K0NKGOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZKPpeiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZKPpeiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDACC2BCAF;
	Tue, 10 Feb 2026 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684620;
	bh=rJj57/3AQz4t5mc81tMaEFJ/Pr2ZbJrqqy5O4dT6EuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OZKPpeiWorMnIJ+vNZy/FRDNOI6cugw9YesGPu3bwnzgRw4mv0WiN3dCotvnQAonU
	 D8pjWajmkTIkIi7qS30xQuJmMklp6zd1k41yNih3rUM+WVomGH/SjptjFPnnyvCelL
	 Yr489tzD5HKLswiJGu2EH03UUy1JIbg2/eB7qw7eQAvFnDKybjvMXUyDXXyn6IUSo3
	 CPjKiCzgnqlHX7MsYzjXIJD/87K6kKQKuFaLCT9THj7MfopDVTdwL+k3Kuf+BqQF+X
	 i8UQRdggFsP/teNGMUFQNX/M69n2Cdaj0tQaV3q89geyEicu81CSiqpovpCQVPHeGU
	 0WNiHckGVyZog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D83DE380AA4B;
	Tue, 10 Feb 2026 00:50:16 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYG0q5P0_GYhrFws@tardis.local>
References: <aYG0q5P0_GYhrFws@tardis.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYG0q5P0_GYhrFws@tardis.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v7.0
X-PR-Tracked-Commit-Id: ed062c41dfda2de8d1712c91e089303dae013bb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef852baaf6a73551cfaa0d082477b50d842b79b8
Message-Id: <177068461576.3270491.15008244738821794270.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:15 +0000
To: Boqun Feng <boqun@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 3 Feb 2026 00:41:15 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef852baaf6a73551cfaa0d082477b50d842b79b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
