Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B11F8AFB;
	Tue, 21 Jan 2025 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500644; cv=none; b=EL4tuzCXoFNgdppQBWRCZfHq352VhoHBjQqQee5mGu6r3bD/C4yU2lCMPsl9SqwIT8jcmLAazC4v94/T7FNk6Q97OTTUvUS5XDjPX/5fZ4ldPhs4BSc5jPYb+4MexeNnBPwKcFqA4qrDuGZRj71g6wuvLMIx2FMRpenOxIHd1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500644; c=relaxed/simple;
	bh=HYtsSdNFgC5ePFzBfzUh/XDd7cYnb0JrLcaeNELyUxk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y43XdoqNlGXKb763PSFeR/FYwBtkBjNNh9kU2eYPpy/RnOcVrKm2Tyue7a7td/xXPvdaTECj8Tn9KC9YH0WHkovb3JOr8RDnDXXAdpR1gIQwMsYpHn9JBFDqoVRbVPQvGwyNpKJxBpkPJ9oS22iim+4w6Y1zWT6DjfGH362V8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEYK8NOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEYK8NOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74162C4CEDF;
	Tue, 21 Jan 2025 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737500643;
	bh=HYtsSdNFgC5ePFzBfzUh/XDd7cYnb0JrLcaeNELyUxk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MEYK8NOFd/8vSku8I5xEETfNWkpgDka2JXgGBbbZibQ6HtKAkaVP0SY8GZX6eA72A
	 Av6FPx0XjQRu1nclIP170jfQm4kb739nz4AJXnSN5FcbFOy5KsvO4tIr2cAatMl+OM
	 X2vVW6mRy42V/kjfNNsUeopT7vwtlL4+Eh3znSN72mN62a62tkNDYdyrdN+8K9qZc6
	 SxdLkxQHV/uSTE17DGM9XSYkvvHVNOYOvXEoFFStN+aHAwR3FUQXFOn8f6UOCh2yWD
	 fMFalGiS7T3EN4FYEoGohSfOp1YDR4tCRvc3MjwKEp74iJlM9qzOqPcDnBMjJCZRj6
	 tifr/8qmxox7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC3380AA6B;
	Tue, 21 Jan 2025 23:04:28 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250117172440.49319-1-urezki@gmail.com>
References: <20250117172440.49319-1-urezki@gmail.com>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250117172440.49319-1-urezki@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.14
X-PR-Tracked-Commit-Id: 4b5c2205526cc1579b840893b98eb7545220f7cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f3ee94e705a5b2fe352befb37e499163f98b9b6
Message-Id: <173750066761.144655.3530345511646934703.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 23:04:27 +0000
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Feng Lee <379943137@qq.com>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jan 2025 18:24:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f3ee94e705a5b2fe352befb37e499163f98b9b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
