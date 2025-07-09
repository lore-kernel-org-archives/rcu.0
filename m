Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD528FA91;
	Wed,  9 Jul 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057698; cv=none; b=M+yQrLrAHPjDeBZL4CENcbB12m0M5KMiApsb8oAixrsFEehaFAnxHvHJtq0NbogqpL/XCsAbiFyoi2sLOJR+WASMIImOtOV0cBSmjdDWqFnqEMzZud2y/ZVzWcf0h/YmIREXPc+5c7eC1ULFgCgocJNDlICJi1HkX6oa6miuF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057698; c=relaxed/simple;
	bh=dTGkQHg9z5fqkIGCmz69Rpg6Oeq4vJsJBkUXplBSvKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSis9OBWRh3Qzxxclh2PCogIXoxIE8CEw6j0/dtx+paqHrrk14ZSDC8fw+q6hO0frLaAhu2Oh/CfZITHtCjwHJL/yiRDwjaiTo1ZtHanWZKc3L+9x2VLjSAf+6oNbI5/Y/8be2zcey9Br7z30zGauVdjqErKYONoZtHg7ofcu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgySBrXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgySBrXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C505FC4CEF4;
	Wed,  9 Jul 2025 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057696;
	bh=dTGkQHg9z5fqkIGCmz69Rpg6Oeq4vJsJBkUXplBSvKs=;
	h=From:To:Cc:Subject:Date:From;
	b=WgySBrXp4MLPIbCWNf1oifA/TqfMksbSx8kxigsTixIWrqTBDHHE1WqlC2VwbJx2Q
	 5H3mUuS+JJYWZ4TePYb1JzCUQWo6SVdI1OVsvDxpktEQ/39N6wdneRavE7shj1Gokv
	 to0Vxsm+/2nk7sPplmleZlakK1TPJS6okMC++M0EzWs3KONUMbEDJ38Uafk7+RV+VI
	 2hxjgI7iwz00usOGqQLWDnBwRMRQy5nMdSgdZx/cyLgYKkxKRQJVVNa0ZAl81BY67+
	 4vsLEwu8RIKUukUA9J7ThOOyj67Eo+N4Io5Qqphs5SdGHHDAzReIfQg5nAxxUujRrA
	 z4mVqetBxtLig==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 0/5] RCU changes for v6.17
Date: Wed,  9 Jul 2025 16:11:13 +0530
Message-Id: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the RCU code (rebased
on v6.16-rc3):

Frederic Weisbecker (1):
  rcu: Robustify rcu_is_cpu_rrupt_from_idle()

Joel Fernandes (1):
  rcu: Fix rcu_read_unlock() deadloop due to IRQ work

Paul E. McKenney (1):
  rcu: Protect ->defer_qs_iw_pending from data race

Uladzislau Rezki (Sony) (2):
  rcu: Enable rcu_normal_wake_from_gp on small systems
  Documentation/kernel-parameters: Update rcu_normal_wake_from_gp doc

 .../admin-guide/kernel-parameters.txt         |  3 +-
 kernel/rcu/tree.c                             | 41 +++++++++++++------
 kernel/rcu/tree.h                             | 11 ++++-
 kernel/rcu/tree_plugin.h                      | 26 ++++++++++--
 4 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.40.1

