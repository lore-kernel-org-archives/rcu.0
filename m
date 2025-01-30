Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534191F131F;
	Thu, 30 Jan 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263879; cv=none; b=PD+BlzqFX8EWMrmqkrsIeMYqHv9k6+imDpj1JlNPpcAfPoLMMKnaJcW9fPRD9i8hzP3xZInS3Gsu3NIYHF+ruwtDIw37quD+SIWrCd4YNvvvMNfqhqQlKLQZDwbzkGiuGXW4w0EJ7Xk+8P589VemZMGockRJiIJFnoS6lGy7rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263879; c=relaxed/simple;
	bh=UvstwIrHh4yg71jLnUEWEWjgTy/RtVTNKH20NnE9Z/I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVWB6HMTEL1AoJytUjNW+ilYjNfAr2NAnhG5bxIdRylZjEJyREVkOLRlY+qD05nfvsxKKMq+EDVc4YsVaBp9P1LVEI1TDFmk+agZoEsQzrcONbjMGRDUx6UJIqz8U1TCgUoTuxyEe5hf+aBLJLY9ib1rNdAeiG+nSExYMkdabmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMO2cpVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMO2cpVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C37EC4CED2;
	Thu, 30 Jan 2025 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263879;
	bh=UvstwIrHh4yg71jLnUEWEWjgTy/RtVTNKH20NnE9Z/I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lMO2cpVh8a5wd8bRsrPLXQYbnLCBrHmGMggiIbocLoJ+6h84kurcZSqbHPhAH0Xsu
	 MR0CuI2JZS7em7spANd6rsG1UvZOeoRz9cw4VyZYxTmkiEt1f164lmDzpQ0e2TrN2N
	 FFDKK9zdImTaiGFFGvNq2nVoE53NA25zp9SvTP6pW6eaXc7/R/EELkxZq94qnuvgKS
	 41fDtakeu/nrnP4XkiEngljx2TdqOv3GLhDhbmM0AwGrH9mLUyijSnkfTyMuYFdCG2
	 Dn4Jj0VvTfDEky6RItxZAP2aZDiFJSJdwULCwQH54IQXbbhBGjq9fwq1p4mCkME2Br
	 3ojXWEaRl4dCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D992ACE37D9; Thu, 30 Jan 2025 11:04:38 -0800 (PST)
Date: Thu, 30 Jan 2025 11:04:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/11] Torture-test updates
Message-ID: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>

Hello!

This series contains torture-test updates:

1.	Add get_torture_init_jiffies() for test-start time.

2.	Add a test_boost_holdoff module parameter.

3.	Include grace-period sequence numbers in failure/close-call.

4.	Expand failure/close-call grace-period output.

5.	Trace expedited grace-period numbers in hexadecimal.

6.	Add ftrace-compatible timestamp to GP# failure/close-call output.

7.	Make cur_ops->format_gp_seqs take buffer length.

8.	Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool.

9.	Complain when invalid SRCU reader_flavor is specified.

10.	Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing.

11.	Make SRCU lockdep testing use srcu_read_lock_nmisafe().

Changes since v1:

o	Fix "segement" typo in commit log.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt        |    5 +
 b/include/linux/torture.h                                |    1 
 b/include/trace/events/rcu.h                             |    2 
 b/kernel/rcu/Kconfig                                     |   11 ++
 b/kernel/rcu/Kconfig.debug                               |   14 +++
 b/kernel/rcu/rcu.h                                       |    2 
 b/kernel/rcu/rcutorture.c                                |   19 +++-
 b/kernel/rcu/tiny.c                                      |   14 +++
 b/kernel/rcu/tree.c                                      |   20 ++++
 b/kernel/torture.c                                       |   12 ++
 b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh |    2 
 kernel/rcu/Kconfig.debug                                 |    4 
 kernel/rcu/rcu.h                                         |    6 -
 kernel/rcu/rcutorture.c                                  |   64 ++++++++++++---
 kernel/rcu/tiny.c                                        |   12 +-
 kernel/rcu/tree.c                                        |   22 ++---
 16 files changed, 173 insertions(+), 37 deletions(-)
