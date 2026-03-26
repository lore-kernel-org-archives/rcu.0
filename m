Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0128F49;
	Thu, 26 Mar 2026 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489949; cv=none; b=WysvzmvD4J4DS1yLKsHxBDBJetBiRZcoeWI85Ouv/r/3jdqhXrqT2+X29bieVC2WWiUW4x177gi+JRQ5Hv5zEA2K73R6QKIri0be/zDc8VVdRItmAlbWyK64RLEASJ4knXFU7dufxJyzjfdOE6BXAmsxhLoFFMaTLLxemikRMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489949; c=relaxed/simple;
	bh=+UpYb++yXKDVm/k1Cx0Iw+BHYDHQ0Vz+Bkk5fxuk0Ww=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dpfub4Emu50j2t8KDtlw7RgCrv9CZfD1Aaceywxy6ZGYiONWaAjCbu3VwWSMe1dmlv9MGToJrLGOLpXhvV+ltG6DnLe0qU2eq9RjaT+fc7VU/sBBcyXUwRoXJdDEmbQtzoyCb11Z9sZgoc1NacGheIVSsALG9+w7toxdxbnLFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+4/bGtH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+4/bGtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890E0C4CEF7;
	Thu, 26 Mar 2026 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774489949;
	bh=+UpYb++yXKDVm/k1Cx0Iw+BHYDHQ0Vz+Bkk5fxuk0Ww=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l+4/bGtHWwryolokmDvidRmHo3/a/GpunOZORAMT7y31z6WqNjRL9nB9RyBUIxgPv
	 YTHARRWcAjz/MB1a8Q4VT991xS7k2l55sv2V4zNl+TYtfbRpkKKAKXGqNaxFhGvoiT
	 /jJWlGkFIkra7UFobFkYdMXSteKK5qfHZtxxwB2yZ1m/I5+2CQn9UAQ9kASOhDMXkH
	 vKd+7rIedv2fgi9PrxMKy74PJKFIIEwNFp+9RjRfMxHTFNxwd3kKrgittGebYwie6g
	 e+C0g305wpxWxM5A2MX7ioy6Vy3Ap9DvuvRXG6HkzjKm4VlhAT3Sq8CpxZZe6mmZVn
	 BF0dJEQ3eWayQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0EB3809A08;
	Thu, 26 Mar 2026 01:52:17 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v7.0 (part 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <acRho9L4zA2MRuxc@tardis.local>
References: <acRho9L4zA2MRuxc@tardis.local>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <acRho9L4zA2MRuxc@tardis.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.0-20260325a
X-PR-Tracked-Commit-Id: a6fc88b22bc8d12ad52e8412c667ec0f5bf055af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aba9da0905f14106b368e0abf75220e744d27626
Message-Id: <177448993626.2282714.5540685506997622709.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 01:52:16 +0000
To: Boqun Feng <boqun@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, Andrea Righi <arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Mar 2026 15:28:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.0-20260325a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aba9da0905f14106b368e0abf75220e744d27626

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
