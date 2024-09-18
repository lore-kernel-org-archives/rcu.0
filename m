Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF432176FA0;
	Wed, 18 Sep 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647012; cv=none; b=Ox7RfUcHF0Xfy/NG71jrIcnhRkFWvGpEiODVpX8T0BftUsZe3S3tlXu9YT19aA4yyQeOclIy8OMDH4cuTyYCNYevVvRMRfhvcqE0HKQLU79ef9ShC23rwLcRiyxM5+fFcfzx16rpagGT1PTl+7KFlTi57BhQzixscmp372tok1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647012; c=relaxed/simple;
	bh=NUie15iA1ECIUc7zgRAua9MnBTbYbm3GIixWKMegGJY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l5QsAYhbnhGAV9khKqG9xePr4+CUw4VueqDMhwUhZ5yqq4a2YBLAgBwIw+K9Waxh16LKQpLI6DPACfRIn25LuC/qTWjyhaEJ2ybn3czUftdbP+wR1ha84DI6XCe0c3+JbxtFVDf8gnsaujf0GAoHBhc9va0YOped6N5qRYL5bfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoThfqD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoThfqD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940F4C4CECD;
	Wed, 18 Sep 2024 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647012;
	bh=NUie15iA1ECIUc7zgRAua9MnBTbYbm3GIixWKMegGJY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VoThfqD2yTO9vm3hipzQJ1kXJN+MuedIw/iF7SmNbL4ifQ+sDj0MwyRjxk8+Bjh5v
	 9facxixc8SHOIHheFLUDFyHO2zo55urgR5a1pMz9QFL6jiuwOPi5UYm4OL04FK7PG6
	 0vDImPqdOxeDcP/ZoRpHYfrn0PDbomYhsu0+xDXzvtWe39A348PRVjxmBhYiwt23Ag
	 QSFKaBJY9pwPV+VcWd+HqXgiihUl9FQ+AsGSK7qrlSCq+MQ23A+CSvR632PdyNzzk1
	 Pip4cMcOdcCQd4PbY/hGCdK+Xc+F7ykh8TmwxrZOFAZzm4pVvuB51kBjrH934qgTqC
	 s2dAc+V2GAopA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 99E023806657;
	Wed, 18 Sep 2024 08:10:15 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
References: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12
X-PR-Tracked-Commit-Id: ecc4d6af979b3bd4d239ff80bbba455c90d3f4f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdf56c7580d267a123cc71ca0f2459c797b76fde
Message-Id: <172664701428.684502.2936994868129456564.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:14 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christian Brauner <brauner@kernel.org>, RCU <rcu@vger.kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 11:45:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdf56c7580d267a123cc71ca0f2459c797b76fde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
