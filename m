Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5245008;
	Wed, 16 Oct 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095532; cv=none; b=r0zixpxFQxFlR9sdxaC4mpQUA76mVzaBzobM6QSzXx9ojEMzFBpDO0YqHKstaf9W/Gryzgtzv7XdoSAC3nbN9fdMYhEFeuZHwMip6Zi9qASAWUh5LzTEfaZnZMzokWdZRiO4AWtwSweoAtJ4NxyjSD47eLRqwmV6LO+QxU9PzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095532; c=relaxed/simple;
	bh=aBIvETqKl94KeNJUMmTeq/D8trRXd8B8NutvTcC+c/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGM1v2teCBQysC35elDfCizW1YuHIyT3t6uDX7zxnR0JlnK/prGQub2cAy6KtuEXinoFhKLsBdo3MyKh/EIGDgReHKGBrfeqD+ud4pWg606EMIL/S9EZfsbXNfa32v0btDr5OVhFT9YbEDmbuTus/HUxLD+97Bf9ycgTMduukrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnhezzg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnhezzg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704E7C4CEC5;
	Wed, 16 Oct 2024 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729095532;
	bh=aBIvETqKl94KeNJUMmTeq/D8trRXd8B8NutvTcC+c/Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rnhezzg/yDnFSvVcTi+mFsfp1uwazV66KxR/QLGKzwcTO8+Xl5UuUhHXPf/k7TZdW
	 XOX02FDLzoNE2EvOsg/4Cryw/qqPUHQjnO9fOQqE7digDrjthNmGL8JeUcy7N1suJC
	 HyHH8QFfVvXUiyt1vzKa1PKO0R4AEBpLdo/jCgr6vOmzk73kl8gSOZH6QyPytHlgku
	 160W5K09id2DNFCz8FA6e4PcI3SuDD709b5EVFWpJOzWl3JpvK48F4ouSF5kudvbD7
	 iD1k1iZBwpXDsieBWKxs4nB3xYgfb5aPJ6ClzrA1jva+T9DnUFlZl9FA+gSKpaKt9T
	 DRa5jQKdZGIOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A6AACE0DCA; Wed, 16 Oct 2024 09:18:52 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:18:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 rcu 0/3] RCU CPU stall-warning changes for v6.13
Message-ID: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>

Hello!

This series contains RCU CPU stall-warning changes for v6.13:

1.	Delete unused rcu_gp_might_be_stalled() function.

2.	Stop stall warning from dumping stacks if grace period ends.

3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().

Changes since v1:

o	Add data_race() to grace-period sequence-number access per
	feedback from Joel Fernandes.

o	Add Reviewed-by tags.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcutiny.h |    1 -
 b/include/linux/rcutree.h |    1 -
 b/kernel/rcu/tree_stall.h |   30 ------------------------------
 kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
 4 files changed, 22 insertions(+), 45 deletions(-)
