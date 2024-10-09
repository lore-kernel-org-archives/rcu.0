Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84491E049A;
	Wed,  9 Oct 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497237; cv=none; b=AfBDKq+HnzJFIXcjEDt/yVnXNBUQpwr+1Phe22E+GQzZQC3Dw3xtaUx/GVQnP1ETVB1+37470xHiy2OXeWG6QyoXO60ZWm95yxh52fNrmvzQ6nEwAdNM2veQHqywBLdCqmxJDk6YOnNuyY3OxZYC5+7feVHsUEB+6ICqfjelDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497237; c=relaxed/simple;
	bh=6R3+ZzJ3wC8hJaVq4t8tQzf+S+GvwCzlc3djTWezkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KzmoaHMjun/F144DSZH2jBTQoGmqmG6HDe7F1bP9oDlTuyMxGvVSvpsL5Ioop1yT/uuIXiCJU/Ak4FqMX9MgRpmOrAfFNsDMoPyw8ko+GUoAX7/3t1bdzpZS7vGFADbi4zYV2q7Z/icQ21LkpUrdKiJgJpGAZXtRKwZy1tifP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR3/7DyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR3/7DyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ACFC4CEC3;
	Wed,  9 Oct 2024 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497237;
	bh=6R3+ZzJ3wC8hJaVq4t8tQzf+S+GvwCzlc3djTWezkYU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=DR3/7DyKiCiiR6fp8+tBqxUmKZnNxgvkpRny+Cx4UWuWufYvrmaeRROR54eUMnooQ
	 InLEMlg2tO9N59eYLbzv3Z8wqpL6rJUVnAVG98eAFH7zOnnmXo0laFhYkbQXBR/VHw
	 ivCHC+EFjrkcLmipZrz4sfV7+nNIU6q1CYNF4UZM5ojgyZEpyXo99d17y93aGEMt5A
	 RmtDGKqinMLcLkD2WKXhbNKyoJyg3iK0a1oXki9HLsHmWpBu9p3tUDwIu/Z8EPIBQ4
	 W8+TQF1iJrnoju9NoW2EPai1vKULRVFk0hlNLa9yUiMG1DSlMQrYAl0RKtnYO7dZup
	 ABsxETRinQREg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F10D9CE08E5; Wed,  9 Oct 2024 11:07:16 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:07:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/12] SRCU-lite changes for v6.13
Message-ID: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series adds support and testing for srcu_read_lock_lite()
and srcu_read_unlock_lite(), which avoid smp_mb(), but add a
couple of synchronize_rcu() calls to the grace-period processing
and may only be used where RCU is watching.

1.	Rename srcu_might_be_idle() to srcu_should_expedite().

2.	Introduce srcu_gp_is_expedited() helper function.

3.	Renaming in preparation for additional reader flavor.

4.	Bit manipulation changes for additional reader flavor.

5.	Standardize srcu_data pointers to "sdp" and similar.

6.	Add srcu_read_lock_lite() and srcu_read_unlock_lite().

7.	Allow inlining of __srcu_read_{,un}lock_lite().

8.	Expand RCUTORTURE_RDR_MASK_[12] to eight bits.

9.	Add reader_flavor parameter for SRCU readers.

10.	Add srcu_read_lock_lite() support to rcutorture.reader_flavor.

11.	Add light-weight SRCU scenario.

12.	Add srcu_read_lock_lite() support using "srcu-lite".

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt              |    4 
 b/Documentation/admin-guide/kernel-parameters.txt            |    8 
 b/include/linux/srcu.h                                       |   21 -
 b/include/linux/srcutree.h                                   |    2 
 b/kernel/rcu/rcutorture.c                                    |   28 -
 b/kernel/rcu/refscale.c                                      |   51 ++
 b/kernel/rcu/srcutree.c                                      |   16 
 b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST      |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L      |   10 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot |    3 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10      |    2 
 include/linux/srcu.h                                         |   86 +++-
 include/linux/srcutree.h                                     |   44 ++
 kernel/rcu/rcutorture.c                                      |   37 +
 kernel/rcu/srcutree.c                                        |  207 ++++++-----
 16 files changed, 361 insertions(+), 160 deletions(-)
