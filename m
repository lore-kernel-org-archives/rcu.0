Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232519E970;
	Fri, 11 Oct 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670831; cv=none; b=g+0rwFqrlSRud6zOT2E+wz+iArps48+laJ7WzdZtIxmF4q22lMckXVcaZRgWAxW2yQTjNTQ06qWANPIkpr53DQraORoG2uQgr6xohRL8O7SphbJtw+k81n+GoiWuZToRAcu2dFMvVcTk8fxCGfgmWy8Q0CDCgOX3D1CfFWOKhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670831; c=relaxed/simple;
	bh=ROPfuj3UJOTQI3v065YFVp0KZddNySLy23l3t7G5axM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4H4s3CSD6+BwmqGhjKa7+mWRFXgfO/eqJ9UIf1C/kfvHZDw2cEIGZtz55l4MeSyc/FpghwnJ2Wjm6MmJMkYKawNHnOZCMzoJ1Gs9oTYYtJTN+2x1qaqYLL51IGCFZ+oiqDVivtLyMVEylRJIh308fZJX8F2wtMHzA+is4aMBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDIMa/Ws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDIMa/Ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763B0C4CEC7;
	Fri, 11 Oct 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728670830;
	bh=ROPfuj3UJOTQI3v065YFVp0KZddNySLy23l3t7G5axM=;
	h=Date:From:To:Cc:Subject:From;
	b=iDIMa/Wsx6CthCQLOsvDG4SGnMhz5K/tcCTU4LRrZxBnrrqXND7V22mtepdV+60z3
	 QDjSEyRMQYDYZ4tZcbX7JzrjDoBbkmf6hZBSU2HZUESscMXZVesABQHGw2fcIUYt4y
	 mCyezg123lelx5+gawSdya+P1KFPeI+swphbj8nVaUPnVnEgzNhYI2EgyDeSkUtM+d
	 7Ktqz73Vb+5yxbd2oARkSxRqaTX8znNJvhVPOc5cnPecprJ1g62sMr4SsuqbIyHHYL
	 ad+fEOUX9q3JSpgIf4hBMPdXsS9kIYWuXTHMv/W316qoDUhgmTnV9Tzs9wm+xw8TO9
	 iXnc9FB34d1hA==
Date: Fri, 11 Oct 2024 23:50:23 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: torvalds@linux-foundation.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com
Subject: [GIT PULL] RCU fix for v6.12
Message-ID: <20241011182023.GA2363@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.fixes.6.12-rc3

for you to fetch changes up to f7345ccc62a4b880cf76458db5f320725f28e400:

  rcu/nocb: Fix rcuog wake-up from offline softirq (2024-10-10 22:18:19 +0530)

----------------------------------------------------------------
RCU fix for v6.12

Fix rcuog kthread wakeup invocation from softirq context on a CPU
which has been marked offline. This can happen when new callbacks
are enqueued from a softirq on an offline CPU before it calls
rcutree_report_cpu_dead(). When this happens on NOCB configuration,
the rcuog wake-up is deferred through an IPI to an online CPU.
This is done to avoid call into the scheduler which can risk
arming the RT-bandwidth after hrtimers have been migrated out
and disabled. However, doing IPI call from softirq is not allowed
Fix this by forcing deferred rcuog wakeup through the NOCB timer
when the CPU is offline.

----------------------------------------------------------------
Frederic Weisbecker (1):
      rcu/nocb: Fix rcuog wake-up from offline softirq

 kernel/rcu/tree_nocb.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
