Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BC1F76A2;
	Tue, 15 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008664; cv=none; b=ZaTell5+6Tz2IGt5Sw9srCzcBGLh9uYXxanvw+t9eCf8U4eu4g6zWkg+VlKzwQboHHQc9qwyRmdngiGqIU8RcU3vESsJUzgXYvoC2ITi5rpnc7gqwTf0kR70QyAVjfKDZyEJ5VMSBZTcPiWKjVBKZhF2Q8N3DWt6Ixzm1AcVeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008664; c=relaxed/simple;
	bh=U9ts/+a4NjkommQNZ2mZfxIet4LTTUDL/9SbZEr3hKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeinecElvcwUkUPqtjgzlRJ3zSLEYyXUQ21u7jQ2FVdJNVuXbQunavnr0LTevqv6+UD3ZFjAGS03oQZ0PLm+Mk9S6xwBps2xzE39Y3ycmIja37+/L1UrtIOdT+/+yJ7bF9S2LkDBJFf0e7APTe3qOt7IA8kUWnfUpgpfKAoUyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aclyjym9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aclyjym9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A197C4CED0;
	Tue, 15 Oct 2024 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008664;
	bh=U9ts/+a4NjkommQNZ2mZfxIet4LTTUDL/9SbZEr3hKY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Aclyjym9FpEAsnryRBe/yIykyF1QMkuC7VisWMuGwcZ0vvG4T4roNUNu+L0MtJcIq
	 pDFdZW+6XLaYygVn067q/aBfT56AMYvqR7pDTzCCu4cB/uZuOMiji5GGqc7FdETOl5
	 OK91LybsaZDqeTM1W9t3lShTniHueH4DJCzbS+iqSvJhzxCjQNoWEqYqvbc8/yCJrF
	 DV1j7dkWm3Ere7Wj02120Ce8JZ6tja2hFSFg/1HK/bXa8VADCXmoVlk4eSpOVvJ69F
	 c5FG35JmWW7m2k0KAj866/dVqvHoLWErzitlLIoi3nXUreZtTDo4to8TnYJBGjwDc7
	 QkmWdv+sRJgxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9D1F5CE0971; Tue, 15 Oct 2024 09:11:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 09:11:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v3 rcu 0/13] SRCU-lite changes for v6.13
Message-ID: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>

Hello!

This v3 series adds support and testing for srcu_read_lock_lite()
and srcu_read_unlock_lite(), which avoid smp_mb(), but add a couple of
synchronize_rcu() calls to the grace-period processing and may only be
used where RCU is watching.

1.	Rename srcu_might_be_idle() to srcu_should_expedite().

2.	Introduce srcu_gp_is_expedited() helper function.

3.	Renaming in preparation for additional reader flavor.

4.	Bit manipulation changes for additional reader flavor.

5.	Standardize srcu_data pointers to "sdp" and similar.

6.	Improve srcu_read_lock{,_nmisafe}() comments.

7.	Create CPP macros for normal and NMI-safe SRCU readers.

8.	Add srcu_read_lock_lite() and srcu_read_unlock_lite().

9.	Allow inlining of __srcu_read_{,un}lock_lite().

10.	Expand RCUTORTURE_RDR_MASK_[12] to eight bits.

11.	Add reader_flavor parameter for SRCU readers.

12.	Add srcu_read_lock_lite() support to rcutorture.reader_flavor.

13.	Add light-weight SRCU scenario.

14.	Add srcu_read_lock_lite() support using "srcu-lite".

15.	Improve srcu_read_lock_lite() kernel-doc comment.

Changes since v2:

o	Apply acked-by tag.

o	Split commit per Neeraj Upadhyay feedback.

Changes since v1:

o	Apply reviewed-by tag.

o	Link to performance data.

o	Add commit improving kernel-doc comment.

o	Pull out into separate branch to avoid dependency on an otherwise
	unrelated refscale commit.

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
 include/linux/srcu.h                                         |   89 +++-
 include/linux/srcutree.h                                     |   44 ++
 kernel/rcu/rcutorture.c                                      |   37 +
 kernel/rcu/srcutree.c                                        |  207 ++++++-----
 16 files changed, 363 insertions(+), 161 deletions(-)
