Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89833291C;
	Wed,  5 Nov 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373993; cv=none; b=jUEsg6yN2S8sEzmQClck1OMCfss6DHQskO0fAogTNCiDcFGFm1TRWPx03Eo62fo7J+srBaeTwmTqCxPhnynvtAa8HJGBwQ69m8Si+8OPyJY5Q8u9qJPXus7U6O3tAtS6L4wGi3ROYP4gf+pC0sCvfePryBwa1EJWR0Srt9gHX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373993; c=relaxed/simple;
	bh=5i2wOEfRBZMVtbDNLlGIv1oLd0QbaUK8gc54zHHbOnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tasm2aEyZC9ZSKQEsWCtpPFGjminQT7qXr0ms6i+4qZ/rUg7yGh3Oyk+ksAhhu9F0vJ3OyYpkoSbveF/TgsX+4nXg6QYqmhC2HOKvOiOlFjsvH3OrU9K8wfYFkvgUU9e8/DMEoa5oV0gkQpv9THV/NRg/d9a5PZm6vQ6e4mfXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMn9XVIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMn9XVIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7791AC19424;
	Wed,  5 Nov 2025 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762373992;
	bh=5i2wOEfRBZMVtbDNLlGIv1oLd0QbaUK8gc54zHHbOnE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=iMn9XVIwffuSpnQMM/6aZKEQz2bQRr7NjYxWyYHBgK2z0+hubPzzexTc2jxvNYZue
	 kMJR0bSPh5OlgXJPY+K1nZy5t09Q2vUvExs3T+QJT8+b8IXzmPJmYuWjE+C1rcISVM
	 cyfzBg8Ob7x6duajVhVLKLomlhPGiTsvTIDXlxwmvTS+U4NgbrfZ48vTWjKw0JHYxY
	 yIjfVQzdReaR36/hXsfqpjGAMDQyoEZB10681XOyS0+SE3kgyw9UfcMkJi4hDU9qtb
	 hznBjerMbc7DZ/bzM1E3d9fF6mVPjGosxQpxtqmAmAw5yHg9RuRsLSOCdSLiOLRE+2
	 Ybv0XwlvVSSIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7FA62CE0B94; Wed,  5 Nov 2025 12:19:51 -0800 (PST)
Date: Wed, 5 Nov 2025 12:19:51 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/5] Miscellaneous RCU updates for v6.19
Message-ID: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
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

This series provides miscellaneous RCU updates:

1.	Fix memory leak in param_set_cpumask(), courtesy of Wang Liang.

2.	use WRITE_ONCE() for ->next and ->pprev of hlist_nulls, courtesy
	of Xuanqiang Luo.

3.	Add kvm-series.sh to test commit/scenario combination.

4.	Permit kvm-again.sh to re-use the build directory.

5.	Remove redundant rcutorture_one_extend() from
	rcu_torture_one_read().

Changes since v1:

o	Make kvm-again.sh able to reuse the rcutorture res directory
	in support of upcoming parallel execution of kvm-series.sh
	guest OSes.  This is #3 above.

o	Remove a redundant call to rcutorture_one_extend().  This is
	#4 above.

o	Add the SPDX line to kvm-again.sh and remove a trailing space
	character from the comment header.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rculist_nulls.h                        |    6 
 kernel/locking/locktorture.c                         |    8 -
 kernel/rcu/rcutorture.c                              |    4 
 tools/testing/selftests/rcutorture/bin/kvm-again.sh  |   56 ++++++---
 tools/testing/selftests/rcutorture/bin/kvm-series.sh |  116 +++++++++++++++++++
 5 files changed, 166 insertions(+), 24 deletions(-)
