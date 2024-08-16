Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35F3C24;
	Fri, 16 Aug 2024 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787567; cv=none; b=ulb2/ViVOZQuVEzxTZbpj9k7Sp8NgrSWmQIYL3DZgecEFdRCkVFpLpeS9USHlAtlbfzkI8DXA4w/4tIdaxtXvy1abDPg7qXs6Whkid/3CHOKtalCrWyEITRZM6N+AQuPs6ONuROlIKDoYFxXwuac13yoa32xq+Mczn32iyByY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787567; c=relaxed/simple;
	bh=DBiOcfhqnE8MuQdVLwD3ByxMbNcD38rTZ9pi2scYThs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ug/Xed5whInB92UJTHaG6VVXeHgrLXXywHafDqxNb/Hb2lWcSl4lYajc/O4ccJ7oht2W3m99X7RtE7H+nrG3L746TYpKJL7BJ3f0GAjvFGsdOzciM1HhOroz/WH9i+ftNCnPOOiInUm3M1CUrgM7cJJ82DvGxHNZLLh6Zn1N3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3+zpS/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3+zpS/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86900C32782;
	Fri, 16 Aug 2024 05:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787567;
	bh=DBiOcfhqnE8MuQdVLwD3ByxMbNcD38rTZ9pi2scYThs=;
	h=From:To:Cc:Subject:Date:From;
	b=m3+zpS/hbYwn99dWnTjnjz64eVEAR0AaVCi9jT2TArEdUIJ0QaWmxTTy4SOLBUC/a
	 EGHPhGrbo3PvzcxXXsr2mZiX7zBw9e+T9lB9eMAnNCARE0c+qHGPkU96zSTyXsCAfM
	 0xs+o5+HyKqi/LVKeP78yZ1yvI/0QxlSR971AyykwCm1DSgkYLWBrBo4KlmS2OPONc
	 ogr73wiWFE7favxLhWNHyTBcCO8k5WFpYA6SX6Ly5LvT2ju0ZxkLoe7X0a+OO18t61
	 1Kaifdtcu+ookzYktBrET5JiDewte+aTaQuwobx8zl3rfMj37DC2eJX6TQ/NGlNy1j
	 wZ8KIc9wzoWFg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 0/8] RCU torture test updates for v6.12
Date: Fri, 16 Aug 2024 11:21:55 +0530
Message-Id: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

This series contains RCU torture test updates targeted for v6.12. Following
are the updates:

1.      Remove redundant rcu_torture_ops get_gp_completed fields,
        courtesy of Paul E. McKenney.

2.      Add SRCU ->same_gp_state and ->get_comp_state functions,
        courtesy of Paul E. McKenney.

3.      Generic test for NUM_ACTIVE_*RCU_POLL*, courtesy of Paul E. McKenney.

4.      Add CFcommon.arch for arch-specific Kconfig options, courtesy
        of Zhouyi Zhou.

5.      Make rcu_torture_write_types() print number of update types,
        courtesy of Paul E. McKenney.

6.      Add rcutree.nohz_full_patience_delay to TREE07, courtesy of
        Paul E. McKenney.

7.      Add a stall_cpu_repeat module parameter, courtesy of Paul E. McKenney.

8.      Add torture.sh --guest-cpu-limit argument for limited hosts,
        courtesy of Paul E. McKenney.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=rcutorture.14.08.24a


- Neeraj

 .../admin-guide/kernel-parameters.txt         |   8 +-
 kernel/rcu/rcutorture.c                       | 109 +++++++++++++-----
 .../rcutorture/bin/kvm-test-1-run.sh          |   2 +
 .../selftests/rcutorture/bin/torture.sh       |  38 ++++--
 .../selftests/rcutorture/configs/rcu/CFcommon |   2 -
 .../rcutorture/configs/rcu/CFcommon.i686      |   2 +
 .../rcutorture/configs/rcu/CFcommon.ppc64le   |   1 +
 .../rcutorture/configs/rcu/CFcommon.x86_64    |   2 +
 .../rcutorture/configs/rcu/TREE07.boot        |   1 +
 9 files changed, 119 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64

-- 
2.40.1

