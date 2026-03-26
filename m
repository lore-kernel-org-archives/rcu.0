Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478A0370D79;
	Thu, 26 Mar 2026 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552383; cv=none; b=YCIgXysAYda72oHw7C4j2aSy1vPxL56Ec+YIu/h2xaNVFqkcPwMojpxoiL//RMrXpcorckRyhowxl769AzhwYA2UBLk7KtP4LYfRiMLLgmPU31GzU8M6q+1BkNATNhD2KznT2XuSNzry+XoWBIgpAigjUiAIjRc9Nc6rUnR9xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552383; c=relaxed/simple;
	bh=Aa3rHcccrln4g/Gw3W0aDpp0xXlQ+cW/hRKBhMrldHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HwJhrvLm8rQ6EIpG6p0IMD8do8DiakZh/PIwCZ3Dle3Zevw+OIBkYSw5kUQx50Byiy6lkurXjvYvAvm7JnCf//XN14jzKHFAAS9POTvxG7aFJKVCqPESI4mstsoUu+GgWL9sJlkPCQFHf2NVwpp5m7In8ymmx0FFRcV5b0WcrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2SB6ybR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2SB6ybR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64BEC116C6;
	Thu, 26 Mar 2026 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774552382;
	bh=Aa3rHcccrln4g/Gw3W0aDpp0xXlQ+cW/hRKBhMrldHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H2SB6ybRbwia1wMFb8TbE4NMDsBFAYANLF0gC74rURn79FnrQU0PPYyyTWsMmmd/+
	 KVC/O8x4qK4IPJ/qAFq6/G1yPAKCTOwvzQfYWP1XRqxrDgFby8sPY12nG0Zp1ERQL4
	 O3lB2MvBG1FqlLmxtt11ggpN/cyHpZbQnY7aO2HhBI9Z0KGULeSDvegUbppxKbBEYS
	 KS5sNkfJOtk+QImW796OyaiZYskm89qWRpynq6sh4UIQUzYsMPtDoofP1cZaLy2KQB
	 gYLz+rE8jUdbgOOR7CBvxEX3JXV6EZMrKO0ph92o7IqRWkgGqQFxVrkLWelA6M6VpI
	 n9Jz2gXDyinMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFFE39F2038;
	Thu, 26 Mar 2026 19:12:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RCU fixes for v7.0 (part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177455236929.3138649.14628219359281836881.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 19:12:49 +0000
References: <acRho9L4zA2MRuxc@tardis.local>
In-Reply-To: <acRho9L4zA2MRuxc@tardis.local>
To: Boqun Feng <boqun@kernel.org>
Cc: torvalds@linux-foundation.org, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, urezki@gmail.com,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org,
 memxor@gmail.com, bpf@vger.kernel.org, arighi@nvidia.com

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 25 Mar 2026 15:28:51 -0700 you wrote:
> Hi Linus,
> 
> This is another set fixes for RCU in v7.0-rc, please pull these into
> v7.0. The issue is since we replace the Tasks Trace RCU in tracing
> (e.g. BPF) with SRCU, SRCU has to work in preemption disabled or
> scheduler lock held contexts, which was missing in v7.0 RCU pull
> request.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RCU fixes for v7.0 (part 2)
    https://git.kernel.org/netdev/net/c/aba9da0905f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


