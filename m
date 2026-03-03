Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6D372EEF;
	Tue,  3 Mar 2026 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581832; cv=none; b=trDFtAUPpe5CgEdA8q5VqevJyn6ouXs2AWANzZriCjgWnmLAie7F8rgb0lZ2R0i6PlRHdzV9g5zssD+bXFr7TEDbSymj4HRnBnS9Xw7vgQaR0j/lrvh6p8A7Wex4adT0P7q2dDCXqRbIQcMH5CexOs60ZkBJHmfj5qovZ3JNa+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581832; c=relaxed/simple;
	bh=FONqaufaRI1HJ8xIDDC9O94yvsfCAy9WQkGRLeZY55Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=drhqZcbW4jdmW1WUktmSpSckY33q1vGNkrDDewRRLzkvb0dutrV0fvbPnCT535QEqZVKqsdphOb6TNc7QOIUcoh3ciJcNmQm+OpbaDWoDy4Gj+XMAHH3VjQvnDqtJkK373+om+I1/kNLkHw0xfVPI1I1d7GzFMOpCvYTi4+XJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo2fh2O6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo2fh2O6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F75DC116C6;
	Tue,  3 Mar 2026 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581831;
	bh=FONqaufaRI1HJ8xIDDC9O94yvsfCAy9WQkGRLeZY55Y=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=eo2fh2O6IkwRRc5AH1FAExx1XU6WbTWd0WppCptgouBZLMi2Iu0+wF0P+jCOUdoYP
	 CRErjEDrSzMrKYjmzvTNhzoiJ4D3rwBV4bL2pzN7jTowNiUrLXxLE28k926bqrV2pG
	 IR1spf3Umgwm/5RCM2SOICJ8ffR3IBwGp0VlYqX3Ii7DrJ8nbi+vAeDB0MhXPmp4zz
	 J6za6Qb46WwbKik5vniyLZPnnAO1AMb3drjJcFyi5JuzvM5ier2if16TFKzqcwf3wa
	 BTImYRVsdp6a5Ujpuntnf6C3SaUxvxb3qd4pbQkcjvDq7jPqqIVcGCqHQjfSA4OIxz
	 Rq+D2hJAbkDwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D534CE0D66; Tue,  3 Mar 2026 15:50:31 -0800 (PST)
Date: Tue, 3 Mar 2026 15:50:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/11] rcu: Miscellaneous patches for v7.1
Message-ID: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
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

This is a series of miscellaneous patches for v7.1.  7/11 and 8/11
were generated with the assistance of an LLM named Claude.  The prompt
directed Claude at existing Linux-kernel code, and I inspected the output
to verify that the expected changes were made.  I also undertook the
usual testing.

The patches themselves are as follows:

1.	Add a textbook-style trivial preemptible RCU.

2.	kvm-check-branches.sh: Remove in favor of kvm-series.sh.

3.	Make hangs more visible in torture.sh output.

4.	Adjust scenarios for default lazy preemption.

5.	Print informative message for test without recheck file.

6.	Fix numeric "test" comparison in srcu_lockdep.sh.

7.	Ditch ref_scale_shutdown in favor of torture_shutdown_init().

8.	Ditch rcu_scale_shutdown in favor of torture_shutdown_init().

9.	Fix SRCU read flavor macro comments.

10.	Fix s/they disables/they disable/ typo in srcu_read_unlock_fast().

11.	Document that RCU Tasks Trace grace periods now imply RCU grace
	periods.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Requirements/Requirements.rst               |    7 
 b/include/linux/rcupdate.h                                             |    9 
 b/include/linux/sched.h                                                |    4 
 b/include/linux/srcu.h                                                 |    4 
 b/include/linux/srcutree.h                                             |    2 
 b/kernel/rcu/Kconfig.debug                                             |   11 +
 b/kernel/rcu/rcu.h                                                     |    4 
 b/kernel/rcu/rcuscale.c                                                |   78 ++-----
 b/kernel/rcu/rcutorture.c                                              |   57 +++++
 b/kernel/rcu/refscale.c                                                |   51 +----
 b/kernel/rcu/update.c                                                  |   22 ++
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh                |    2 
 b/tools/testing/selftests/rcutorture/bin/parse-console.sh              |    1 
 b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh               |    6 
 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01                |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04                |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05                |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06                |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10                |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT       |   12 +
 b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot  |    3 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh |    2 
 b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh |    2 
 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh           |  102 ----------
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh                  |    7 
 25 files changed, 179 insertions(+), 214 deletions(-)
