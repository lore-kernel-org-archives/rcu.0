Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA753A397;
	Tue, 22 Sep 2026 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121090; cv=none; b=VFFkZZFIsLQDIi0Zpiiu9CLCcvkSSx9ER5WuFtGrFM1sAQy36jB9FpDjLr1jHUMQMowdrAU9QdNW8yaIAnotciJO3K2uo5i2QnXIKrpxGWxX5LViQezMKecUu4XjmJOAPCaXy+KrvMG6i3fbmSJtt8Jzhqfp3g0omGXAd+WFY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121090; c=relaxed/simple;
	bh=pzIXoUkXZUuRItdPlxMI/vriWSqOHOkFrEivzHnld8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CdI4aYUIOjTdUNXYTqAMnq6Q+QqT5nEUAkkrWcuiRQcvWw8clHH9nuILoSHownUGIc9ubL+oFPAbOLpAV/ZKnA9kH8ONV5KiVexzosAn0QxOS8sWbxIkPtBluyF/SZlsuQarJ1o4HQYrC5+9eXRKqtHl4/8kSLm+WvhMZ/OytOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZy+RkYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZy+RkYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6F51F000FF;
	Tue, 22 Sep 2026 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790121089;
	bh=hIHS9ZT0yvp0KzPQBwpWWHTyda6SsL/n6IC6kywKrdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fZy+RkYrF6BjJhQbmfgGeV+kq66kxjyJr/Mpd3QAIo0pCrpM1c6Ozt0r+bAnMBBCj
	 d5x5B/TKy0bV4BmFn9Kz05Dc1MGlkE2tSFAHZ1jqMGmoFJRqM13fObqH1S3Y4mjWBK
	 lEKGE076GRKAjUuZVNG76b7yeqvI/5jKozyySSN/WCNWHw20Q5Ole/MFzqPzALx+g4
	 joS9yv3sXt3rj92okICEJr4gOVCSju9kmRGH/rLyGtHJBAALYotSle6mBE8rcqE3aw
	 u/uRXmX/VWEjnq2Jl9JdRB1XkRUiAboOq7JRpLsW6WM0ll1m1lQXVpasxifJPSg6ww
	 xabl8jl8iX/yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C843822D65;
	Tue, 22 Sep 2026 23:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and
 bpf_call_rcu_tasks_trace()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012101963.134796.5104936283975615071.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 23:50:19 +0000
References: <20260922200208.3203834-1-puranjay@kernel.org>
In-Reply-To: <20260922200208.3203834-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, harry@kernel.org, paulmck@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Sep 2026 13:00:49 -0700 you wrote:
> Changelog:
> v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay@kernel.org/
> Changes in v6:
> - Size struct bpf_rcu_head at 48 bytes rather than 64, matching what the
>   inline state uses (Alexei)
> - Trim patch 1's changelog: drop the reasoning about possible future
>   layouts and about what the other async kfuncs return
> - Rebase on bpf-next/master
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/4] bpf: Add bpf_call_rcu() kfunc
    https://git.kernel.org/bpf/bpf-next/c/1832696b2207
  - [bpf-next,v6,2/4] selftests/bpf: Add tests for bpf_call_rcu()
    https://git.kernel.org/bpf/bpf-next/c/908a60853b8d
  - [bpf-next,v6,3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
    https://git.kernel.org/bpf/bpf-next/c/db1b20ed6b09
  - [bpf-next,v6,4/4] selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
    https://git.kernel.org/bpf/bpf-next/c/b22f65a009ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


