Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F218CBFB;
	Tue, 25 Mar 2025 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863506; cv=none; b=cRaUeRmEiocNG7lHnzqJUEFsFZEaQPQUj0KM80z2w4fV1BcQxQdOFKw2M0Td5qkNXfKyDkuftttnZZqpsdClihjJhSXk2mTqYNdKx0PlxbnnnaPBRtb/iop/tl3yeUC1xT7ozLecKiUW8JFqfkUNXG5O8dYMcuzKiiXh7eBsY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863506; c=relaxed/simple;
	bh=qOoc2us5AFRLCf1ziDpSdiIZ7QoeVcfsTaS1YLpSnuU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K1TEsqliXg6TCUc3BLjMiu4Z4HlgC7RM04toj9zkFuO2STCw4QfDKboCKd0WFAjwD1Nztvv0rSK1pyxQxVSb+2lv2EftzTW4HLIlih/vjlTzEeDKV+9sihH3WQIdJdBwfSHazucFZBmF7PlSR4RlgEMnF6VDmVWPL0+dHzjpEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgTbA5gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgTbA5gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C56C4CEF0;
	Tue, 25 Mar 2025 00:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863506;
	bh=qOoc2us5AFRLCf1ziDpSdiIZ7QoeVcfsTaS1YLpSnuU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MgTbA5gqxsnF8epOEckVlnEdR1f377ucJiTywtOszJM1+Itp3Fkw/tf/bsL4Yc6iF
	 sFXtLsYPWSeUmCbcIt2oNfeu6FMYXn31SJO3/L5IKVfS+9y5ivoV/0l5DLlcIsQY5T
	 iVkw/qHyF32kmUfcQY/AFhnK3Ug61cA/dRUz3k8/N6TsrB5XKEGkVQl8uqV1/Z9yi1
	 6bpZDEuBWdGGSo5Shd6TNduT/InGSGPsKEH2IRRfPhuS8brntKPTKWRr0afUkkW6vU
	 bMfnKlolAFNYJ3dMeyKyUM4ucDSFgWb/xokHZKy/nxTwwKbtSgYyNVdDVJXCzFUrV6
	 NGUyR+h9oh8Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C60380664F;
	Tue, 25 Mar 2025 00:45:44 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <2f7985a8-0460-42de-9af0-4f966b937695@suse.cz>
References: <2f7985a8-0460-42de-9af0-4f966b937695@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2f7985a8-0460-42de-9af0-4f966b937695@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.15
X-PR-Tracked-Commit-Id: dea2d9221e83ea02b45a60ab88284cd3bb4bb2a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05b00ffd7a0bf31f45b63242f30b3a8a0008fa78
Message-Id: <174286354269.36585.4983079050671394587.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:42 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 14:06:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05b00ffd7a0bf31f45b63242f30b3a8a0008fa78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
