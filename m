Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084039FCCD;
	Thu, 26 Mar 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552384; cv=none; b=SAMsnDQwMDr5GINpbO60JNKjjXhTzNJzopoFjhrpYMnyRKKZng4A5t7vAnRxwQRqjOpR21FRhkcwa7dghWexAwPgTUfvgwh1MXogBpYc7RfZY8Vcx0kse85rZ4puDcp1eREk6X7tztmWJjOZS3aeA82gjCBWvELgBlXyXIsSPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552384; c=relaxed/simple;
	bh=3ZQf9WuP8cl8bJKSC1pSwwfILb9OWtBr6zRFVCQ/uKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=glFgXhu6WXTEzFJZ6cTtJy90j5OVO1qsKouXZuniLOUuYqeTnfQzBgho4PoyQvt6qCbtl6YwSIrpzjeLZbhIqzJi5rJ29AoeGrKF33vMoCwWqJEW/MTC6ceALeNM9TM6hXAqndTrH5f4qLXLJA2aOZ6p+qbdpHM4hv5VSPQ3+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHYy8Lr7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHYy8Lr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F76C116C6;
	Thu, 26 Mar 2026 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774552384;
	bh=3ZQf9WuP8cl8bJKSC1pSwwfILb9OWtBr6zRFVCQ/uKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JHYy8Lr7dKRIzjuL4FQAqSvhh17aT8CLNkePixCpFFFbjLqueu257tACUuynlz16Q
	 2rvyf+69mQgXYNR/oqQeoAnevnKlYR4cmS/CD7zRu/hHTGIaORhcQ45LXRz9Mg1Xv0
	 7cttJAIcFvfDFFQqitHeB1ffX+JnwDLJ5K3fl6oqIIJjQSsxGQ/mMxhStafoCO4+gU
	 9UbvQ0Wt6II9RGgD8aI7sNd9eWNWh/8mWhCqaelwx1NI64OgpEYkcHXP5jwIrTPMe5
	 RKy/0NijaMwmpXRnzwM65qqNevpqbLvFrQ/Cgi80T1BaKky1ir8w+Dm+yby2tDxzEj
	 H/vbZGsz+aBOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E7D39F2038;
	Thu, 26 Mar 2026 19:12:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177455237053.3138649.16201619133847668451.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 19:12:50 +0000
References: <20260320222916.19987-1-boqun@kernel.org>
In-Reply-To: <20260320222916.19987-1-boqun@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: joelagnelf@nvidia.com, paulmck@kernel.org, memxor@gmail.com,
 bigeasy@linutronix.de, frederic@kernel.org, neeraj.iitr10@gmail.com,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, tj@kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, arighi@nvidia.com, qiang.zhang@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Boqun Feng <boqun@kernel.org>:

On Fri, 20 Mar 2026 15:29:16 -0700 you wrote:
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
> 
> [...]

Here is the summary with links:
  - [v2] rcu: Use an intermediate irq_work to start process_srcu()
    https://git.kernel.org/netdev/net/c/7c405fb3279b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


