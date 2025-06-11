Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A081FE45A;
	Wed, 11 Jun 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660049; cv=none; b=OsX6pkPAJST9dNQoe5osJt741nuupsdqcncnu1iD9aEwqIG0J2wxumq0Ly7QDW28qzulM2Jeb4cmVUP84RD4aNKPvks9PecEyWHt+RGxSMcoK+1z1DVfzBjg6LxZtFpamGRhjc06Nxc19zw/XWoT7YL104anzFeyHTq7cxNafbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660049; c=relaxed/simple;
	bh=yV4JktqvQTygx7IwJSqnpH4MNC8ygUGuE0X8CQrDdzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u4NUH9qX9ffaPuNeUZivGlMnlRSBlkv3Sk0P1v4+eFmWYT/iNf0RpfQoPcrBNqWwScShupMQJzFWttAmHPCa6H3z9hzEeLNMQx18gyANbgCvZOOPrIt8nWhTw9PnmJhcGUhOG8bk2tw7PeJioGcV1ac10yY8ibgpgmONGLh+9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evOT4nSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evOT4nSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D70C4CEEA;
	Wed, 11 Jun 2025 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660049;
	bh=yV4JktqvQTygx7IwJSqnpH4MNC8ygUGuE0X8CQrDdzs=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=evOT4nSFqkN4qnNCy8xWFPWtDqeNgGqM8IvKq5q2SooA3CnsT+LqKG9uH2RQapxrV
	 NnIR3W/5gdeiOHKe1DwyJe4juGFa+XWpPUkemkU/kv/NkNzYEFMTU/Hs9TdcO2SRP0
	 Kx8oyGWcb+TVpSYLdix3adDg4fRPgiwlr/chE5zDw/9eQhi7XgMZBr04FAU7V6whXu
	 /SS4bJpXY5O6pi28iMTEwht9W4jSdtSqjFrhOLosD/9dMlcW+0XzSlDkgXJcfFBXFR
	 BhmSyvzNFTLjUEG6nBzNcMgY27llGr6ZFbcweiKuEAlQQgwIyRmJBAoxaUGfvfjX35
	 hltmV7WH+o3ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C186ACE077D; Wed, 11 Jun 2025 09:40:48 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:40:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Warnings in allmodconfig builds in
 samples/vfs/test-list-all-mounts.c?
Message-ID: <927f7547-ae55-474c-b211-24854bd988c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Christian!

Imagine my surprise to learn that "make allmodconfig" builds
of the kernel also build userspace components, including
samples/vfs/test-list-all-mounts.c.  ;-)

On CentOS, "make allmodconfig" gives a zero exit code, but gets the
following warnings:

In file included from samples/vfs/../../tools/testing/selftests/pidfd/../clone3/clone3_selftests.h:8,
                 from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:20,
                 from samples/vfs/test-list-all-mounts.c:11:
usr/include/linux/sched.h:114: warning: "SCHED_NORMAL" redefined
  114 | #define SCHED_NORMAL            0
      |
In file included from /usr/include/sched.h:43,
                 from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:9,
                 from samples/vfs/test-list-all-mounts.c:11:
/usr/include/bits/sched.h:32: note: this is the location of the previous definition
   32 | # define SCHED_NORMAL           SCHED_OTHER
      |
In file included from samples/vfs/../../tools/testing/selftests/pidfd/../clone3/clone3_selftests.h:8,
                 from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:20,
                 from samples/vfs/test-list-all-mounts.c:11:
usr/include/linux/sched.h:137: warning: "SCHED_FLAG_KEEP_ALL" redefined
  137 | #define SCHED_FLAG_KEEP_ALL     (SCHED_FLAG_KEEP_POLICY | \
      |
In file included from /usr/include/sched.h:43,
                 from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:9,
                 from samples/vfs/test-list-all-mounts.c:11:
/usr/include/bits/sched.h:51: note: this is the location of the previous definition
   51 | #define SCHED_FLAG_KEEP_ALL             0x18
      |
In file included from samples/vfs/../../tools/testing/selftests/pidfd/../clone3/clone3_selftests.h:8,
                 from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:20,
                 from samples/vfs/test-list-all-mounts.c:11:
usr/include/linux/sched.h:140: warning: "SCHED_FLAG_UTIL_CLAMP" redefined
  140 | #define SCHED_FLAG_UTIL_CLAMP   (SCHED_FLAG_UTIL_CLAMP_MIN | \
      |
In file included from /usr/include/sched.h:43,
                 from samples/vfs/../../tools/testing/selftests/pidfd/pidfd.h:9,
                 from samples/vfs/test-list-all-mounts.c:11:
/usr/include/bits/sched.h:52: note: this is the location of the previous definition

But on older Ubuntu, it builds without any warnings.

Is this the sort of problem you would like reported, or should we go
back to looking only at the build's exit code for allmodconfig builds?

							Thanx, Paul
