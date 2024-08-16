Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7683CDA;
	Fri, 16 Aug 2024 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790862; cv=none; b=EMaqINW1uKqbj0vH7VPMm1CDVnRjOT/xtuOpRPJoiImERz52yaVY17q2NJAezJOiS9+5R+WqRQ+wXynnKeiqrFdVYY5tkB+zHXtXuMhRIDXEzJht3F9KYGI5vs6BML2JuPUBdokWW/ZFc3qCSECk35XbmMD3FlRchvkYmNGLegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790862; c=relaxed/simple;
	bh=bknvr7IDkDIglLnjUd8I48/sh3vZ3Fw6ZwBwLol2Qg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JEd7WqcZC2DeqEtiMQrGYdOlsvYqv8MmbrqDtHlZh3zdi6JNXvsSWbMi5xPfQz1Hz/z1GHRmKTRVc5xPIjeiK5lqLRD5H9xI3a9WYi+Syx3qV6HbnyREZdmn4xj3yRGoAD8oz+QlH+I/K922ihQ9JNh+4fYK4ge5YXbJi49GXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPlcbiWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPlcbiWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EEAC32782;
	Fri, 16 Aug 2024 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723790862;
	bh=bknvr7IDkDIglLnjUd8I48/sh3vZ3Fw6ZwBwLol2Qg4=;
	h=Date:From:To:Cc:Subject:From;
	b=aPlcbiWZbKYDoADdVdZjo4/xf4jgIA5COc1G0NWTl6SarPHw3iHzsfMp22i7rc/kD
	 hPj6lTKkyBsb8j4VvTyph5w2W0qh9tuX1mJtIjOssWw5cHe9z7bttm/3TUpwE7HqBd
	 kPbRa187PeWlpbBozftet7pm4mlS/b/9BK3hnl4yniooGwEdeeX+LNpW821qrGz6Rh
	 oASiIOTWV8tchuj7484TzpEwkoesHUNpcmi2P670l+fgg+JYfIf/zaEZavotFTaYFf
	 UpfpAjmNCL/yOqXWatP/ixVTinOq5MgNf8m+o4DGGFUHNYKAdQO8yZy8g9x2CFupsB
	 NkSl/salVXf7g==
Date: Fri, 16 Aug 2024 12:17:30 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, qiang.zhang1211@gmail.com
Subject: [PATCH rcu 00/12] RCU tasks updates for v6.12
Message-ID: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

1.      Remove RCU Tasks Rude asynchronous APIs from rcu-updaters.sh,
        courtesy of Paul E. McKenney.

2.      Remove RCU Tasks Rude asynchronous APIs, courtesy of
        Paul E. McKenney.

3.      Stop testing RCU Tasks Rude asynchronous APIs, courtesy of
        Paul E. McKenney.

4.      Stop testing RCU Tasks Rude asynchronous APIs, courtesy of
        Paul E. McKenney.

5.      Remove RCU Tasks Rude asynchronous APIs, courtesy of
        Paul E. McKenney.

6.      Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb(),
        courtesy of Zqiang.

7.      Check processor-ID assumptions, courtesy of Paul E. McKenney.

8.      Update rtp->tasks_gp_seq comment, courtesy of Paul E. McKenney.

9.      Provide rcu_barrier_cb_is_done() to check rcu_barrier() CBs,
        courtesy of Paul E. McKenney.

10.     Mark callbacks not currently participating in barrier
        operation, courtesy of Paul E. McKenney.

11.     Add detailed grace-period and barrier diagnostics, courtesy of
        Paul E. McKenney.

12.     Add rcu_barrier_tasks*() start time to diagnostics, courtesy of
        Paul E. McKenney.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=rcu.tasks.14.08.24a


- Neeraj

------------------------------------------------------------------------

 .../RCU/Design/Requirements/Requirements.rst  |   3 +-
 Documentation/RCU/checklist.rst               |  61 +++--
 Documentation/RCU/whatisRCU.rst               |   2 +-
 .../admin-guide/kernel-parameters.txt         |   8 -
 include/linux/rcupdate.h                      |   5 +-
 kernel/rcu/rcu.h                              |   5 +
 kernel/rcu/rcuscale.c                         |   2 -
 kernel/rcu/rcutorture.c                       |   8 -
 kernel/rcu/tasks.h                            | 212 ++++++++++++------
 tools/rcu/rcu-updaters.sh                     |   2 -
 10 files changed, 180 insertions(+), 128 deletions(-)
