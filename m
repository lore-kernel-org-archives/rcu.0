Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9F3C09FF;
	Mon, 15 Jun 2026 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509914; cv=none; b=jVsDIUs1K0aKkkRx5EDBQiI7zoHtV6P84BdNYLMkDqjZ7NWMU6Am2SnhEI01h5fb+UvhDlgWKe2ea1/LvIbjYG3dJZSiEHphEa7ATi+nzQkJDQgKZPR+oYqMyZFiQIEMRlffj7tRNfSB6ZUA82xOTfOvI95K6IB/xfE+uXYrM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509914; c=relaxed/simple;
	bh=w8206dIckT8Os8Fc2i7ansQ475GUfigNcYahGkFcM6g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CIVJWhOYvhzElG0RuX5ht9w8sfq5SarDKdaWQH/iqCdsyqq+mYIUei/wEOYYRXSpxQy8Id4AX7U03kyhq2bpzxgi88eywp6WJAgqGxMkzwWAIifJDspjEi2SsNhpngwHha0T4EeyNnA4qW8ez52tf7pVyq6Vn6Y3L2DY5LXl9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcQD55X9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcQD55X9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A241F000E9;
	Mon, 15 Jun 2026 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509913;
	bh=oQ0nsNel05+guwOcP3ByZG0H635ALkYV40LQi+oU1Sw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DcQD55X9xNAt9MBF1YfgA2SWv2Igr4LcWru4s9UAYqWw6QDe0jjYNkAT/Fy5cOpF9
	 C0TDubK5An3EvbRN2VZNgDUvVDy9io1iYbq/OZPPMGoyLPvq2ExhUfKovmcgsHFhhI
	 yW9jktGF6qEeoo23uTb2nwn+ky/aMXy63cCwQ+ACYgXdRO6BJADv+5vUvg5jGHxGoL
	 Kr5LcDBi8c2O/LLMMsxGRIeynxSBHdjnyWnCrpgCZM3BS/Gm27n2sCIQuu1c7I8ZPt
	 oNlGHYBk5H54QNqZELS/4atPYy6YzjHdJUUCYtQIGWbxrKsWbTniEmIGh5oapwFONt
	 Y1lBZxx55WZbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B763A56756;
	Mon, 15 Jun 2026 07:51:49 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612125701.59340-1-urezki@gmail.com>
References: <20260612125701.59340-1-urezki@gmail.com>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612125701.59340-1-urezki@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v7.2
X-PR-Tracked-Commit-Id: e853c1b28580ea93fda3cd729e440a3fc16fa647
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8b674748fa4b1a384aaa647811109fe9007c0a4
Message-Id: <178150990805.2920647.4099236367379302542.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 07:51:48 +0000
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 14:57:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8b674748fa4b1a384aaa647811109fe9007c0a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
