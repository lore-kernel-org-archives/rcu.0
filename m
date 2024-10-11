Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C781D1756;
	Fri, 11 Oct 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683089; cv=none; b=kYgtRSLaA++j2r38VF7CtlBd6FjWIml+gLVNfCdUTopVsz5fjSKWEzpNsJkVya4tt78zOWdrlpsakTOtjdxW3F0EQ6igprxZwgfpWIMD1MV+1ApSqx/9AdO+feDZY5k1QZiMNilLiVWbrkWa/FvNohs6RaN78h5q+F65j0M1F+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683089; c=relaxed/simple;
	bh=HBIoQTwPJaS7w23jKyM89yEFSQ9mjOTVub5UYgP8X2U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pQpv94xAOibmMUEe/X7KeclBrz+X9Eqv1DD/SwIr8t9ENz6K8II1ApFw622q3ESxZMtYtI0coN1uVuLA8IWjAlgJBXUAjR0PIR11mtLVO6Z6yzE6fgUXlXNPDEXQEpx4lxbuJ8Y9TGO4fhfy9G9bkmiUQo+LUARFqjR10lNV8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjmCSzzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjmCSzzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80CDC4CEC3;
	Fri, 11 Oct 2024 21:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683088;
	bh=HBIoQTwPJaS7w23jKyM89yEFSQ9mjOTVub5UYgP8X2U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kjmCSzzXsnf7DwiK1+6tgMWKw9k+VbYGiwAwjCW7RuRX7esfEKvbT9T60KNUIc/p4
	 Jfeg25ERb304gKwi7mznmSBJ4roo17DzUv4vm5tYZ/EB2zhd3q6saDkklkhubSS+eo
	 MMZ0hDJftyNcEBbRfIwHHH6pVXrAQli3rZqYXpnUT8bAIOIO+FSBBAT4hoUHREdLsQ
	 WAHs57oUljW3RsKZ96TdJ+pJ94o1G80QftGXwyTKfjR5haHhVoOWLwbNIIXuFHYGeO
	 JvFon+ZKNf6F3oSRMriCGLz2rn8Q6vfpiRk9y6BQ0vv8sWNYMqkFfakdKhk2U69ENZ
	 o7jGfSNwTKS7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC838363CB;
	Fri, 11 Oct 2024 21:44:54 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fix for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011182023.GA2363@neeraj.linux>
References: <20241011182023.GA2363@neeraj.linux>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241011182023.GA2363@neeraj.linux>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.fixes.6.12-rc3
X-PR-Tracked-Commit-Id: f7345ccc62a4b880cf76458db5f320725f28e400
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1029768f3931b31aa52790f1dde0c7d6a6552eb
Message-Id: <172868309308.3005321.15268049738184752691.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 21:44:53 +0000
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: torvalds@linux-foundation.org, paulmck@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 23:50:23 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.fixes.6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1029768f3931b31aa52790f1dde0c7d6a6552eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
