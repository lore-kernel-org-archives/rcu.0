Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF1288CA2;
	Wed, 13 Aug 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101100; cv=none; b=tPadt51Lj7Q4Nw8It+r+lJ6JAmhciZLAFV7s1hlwwtCT8Wi1ywo8/WFlW5l56wl3FBM1HXIcSlpaTEfh+zGQb2loOS4bi+7AvaM4qEzBUR0T2xpWGDLPQr+3WbIId4xXNkTZfDj0vrPHbru3yL7JnHgjEQbGNTbtxeSBh6QX27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101100; c=relaxed/simple;
	bh=yiXLb8bycpvpUQxupXfp+O9anVMwvIgHsJkuMlujP3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rIdM8B1J2hAsCUDXK+Yj3GXQTYM/A42+o2l6Fdy+E6e6LgnvSmKAu+9jHpEKtGvPa+A3kxjsFkfSj/xvtmsmnEdaExJ8MQFVWgCWiTSV8AWV9V2pLbD+trOghd+g2knIoho8w1epdNFwg6RtsBi2/VbcFdVw+Y0UANOfxtZWYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqQib74R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqQib74R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFACCC4CEEF;
	Wed, 13 Aug 2025 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755101100;
	bh=yiXLb8bycpvpUQxupXfp+O9anVMwvIgHsJkuMlujP3Y=;
	h=Date:From:To:Cc:Subject:From;
	b=mqQib74RQ67gn0JQi7jQf8jin8mJ4NEx0UcPdAvOGtm547NhgLrRklBwslGTaDpRa
	 K12OfvTvh21kRzfZ/Xh1PDrUBNzrWlIFlg7surEsLpApqfV8LdKG2vfobzzjwxH0HS
	 ePXHYfGCeMkl/CtGNqtAzMq2+2ia0ADqWIZLDS/dVrNuJd9nX5/uLZJod0PQb0xu5a
	 +PE4sWLYgjerPqxVBgtMSnijyyabreLSFct3x32JeffyZzk8MzVONXfUNF0uUPAr9P
	 J2PAv/q1YYH7VWTKnn+ru71G6Owvm2U1wAlnMNYIhGwvRESoaTngTLGfepF9loF//8
	 qssETdQbNKleQ==
Date: Wed, 13 Aug 2025 21:33:40 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: torvalds@linux-foundation.org
Cc: paulmck@kernel.org, joelagnelf@nvidia.com, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rcu@vger.kernel.org
Subject: [GIT PULL] RCU fix for v6.17
Message-ID: <20250813160340.GA3357@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.fixes.6.17

for you to fetch changes up to 61399e0c5410567ef60cb1cda34cca42903842e3:

  rcu: Fix racy re-initialization of irq_work causing hangs (2025-08-11 08:43:49 +0530)

----------------------------------------------------------------
RCU fix for v6.17

Fix a regression introduced by commit b41642c87716 ("rcu: Fix
rcu_read_unlock() deadloop due to IRQ work") which results in boot hang
as reported by kernel test bot at [1]. This issue happens because RCU
re-initializes the deferred QS IRQ work everytime it is queued. With
commit b41642c87716, the IRQ work re-initialization can happen while it
is already queued. This results in IRQ work being requeued to itself.
When IRQ work finally fires, as it is requeued to itself, it is
repeatedly executed and results in hang. Fix this with initializing the
IRQ work only once before the CPU boots.

[1] https://lore.kernel.org/rcu/202508071303.c1134cce-lkp@intel.com/

----------------------------------------------------------------
Frederic Weisbecker (1):
      rcu: Fix racy re-initialization of irq_work causing hangs

 kernel/rcu/tree.c        | 2 ++
 kernel/rcu/tree.h        | 1 +
 kernel/rcu/tree_plugin.h | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)
