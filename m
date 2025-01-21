Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01C1714A5;
	Tue, 21 Jan 2025 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500637; cv=none; b=RiNUE6/9RmwyUPVvb6nCuKniOmWLDRF0YpY5dfgvZhzGUlZwcSBFUTQJVGdWBWKo3+l+Dl65nSfPSGUpPVLvZ73mQgWEAGJE3AgruXd5yqfmHeKQ1cPA4SiKKs7cCwylIutpGW7W3QrOTakT7th0TyE/Y+gEMu7iyIdUC+/l5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500637; c=relaxed/simple;
	bh=XrbivC7Kn9qo5JcDOcfP0cTrKbsPAIA8Ib5/BPWqUQk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SCg2TI9k8v4CngD1SdOxqfMjqDZJfDSOxf8pkZL5NwWHSDDdv4MBIIEOJWlsYRIaOput+EEbvkM+hAakGLJ7QeiZ0yLjOwX92cTucn/MwCCOssK75tHCIa4awzYUMiwKnqWVU9RjnSWBQInKVwrORSPiiEWT1E+2ksmQ0Dd9Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a70SbNIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a70SbNIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1141C4CEDF;
	Tue, 21 Jan 2025 23:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737500637;
	bh=XrbivC7Kn9qo5JcDOcfP0cTrKbsPAIA8Ib5/BPWqUQk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a70SbNIqPY8B9Kmq78yM0wM6Z5h0V/cvHegcHrexZuItyUOiixjK5b4XNclfQp5HF
	 W2OkrBQAba4fIvVXkDjVA+iKLxFeatlzNZ51C2DzhUZy3qr9WAT0sRg5mrnxxVCPhU
	 Nq5XD5att0F1LbHNzO1ogkMsm/RQyHzMJ0FdAX8XsRW6GJhH0xDaO07zTzT/0CTg1q
	 LDahLcMzTMxzfbhnT+dOAWQ/wa5xt3EDBVQtPz9wW3hNPSyD659wuq3xSDEZe438Ex
	 SK7xVAg//jzIKtX7YCTM4wsMwV2eV9H6RmjzIIL3daZtg84AqrO0X7fQQEGQhWnOIU
	 I8eouc28s8/nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72140380AA6B;
	Tue, 21 Jan 2025 23:04:22 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>
References: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14
X-PR-Tracked-Commit-Id: e492fac3657b60b8dd78a6e8ca26d1d14706c7b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad37df3bcb1c88f3f73bdd04bad0b9eca8eae7b7
Message-Id: <173750066111.144655.5799290214645213157.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 23:04:21 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jan 2025 15:13:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad37df3bcb1c88f3f73bdd04bad0b9eca8eae7b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
