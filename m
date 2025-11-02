Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC95B663;
	Sun,  2 Nov 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117539; cv=none; b=jqYZ3BMqAdAV/z2GY/GAjQqHfd3m/85fKBuvnTCQbrCTfq3jn9wB41m1odZkY/H/oJuJk8yl+azRBuv0aFM3/PF1fa1dY9lMONm9c9ShJU1sLaZUx+ayKnZFKXl+2IN1DtmU1PbuQEyUz9QvDlImZ4MGSFsDqFIc8LD4N7np6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117539; c=relaxed/simple;
	bh=XOWgPjZl8OpTIlB3PQabtMF0yGYfr9xcimARbAiruWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WT+bC1MSTzQdhgW7BWbAWY0eLPhjWTaa3nXr6VNvfh8I3IFB/qx8BdzvsyrsHHgoxlzdmFJCr5uAifQhBrs6gx8oLLOWLqDGXTqQSHa3RXebU6TxW5LXwH6kKY6Rcx49lvKnty3oJ9y4hm5fxeZMe3G4KxKdUyuxJnAvuzTzttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bknimoo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bknimoo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D31C4CEF7;
	Sun,  2 Nov 2025 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762117539;
	bh=XOWgPjZl8OpTIlB3PQabtMF0yGYfr9xcimARbAiruWw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=bknimoo8FbvV8LzDBStYcYVi43byS0mlU0N+P6l5AwJ8VGo/s9RAqGxfWtuleJQ7d
	 44IGp4zodDyPNyqyYaRkRlTzsZLTgViVsxyr0KA5lpNmv5u5mDvYYlKzlKfGQjLjyy
	 5aPxf3wdNUBh6O6xuulOSSsn7i5897U7VxkdLHkTSrcc/mgK05UkBahUVUPvrG8HlR
	 5f3c9BttvN6rg+wuNSmSBZYKwTymyUs4kwAZE6DC2qZT7ucAzSLsaEH/zhb209Bj2I
	 QEgvs7w4dphBgoUNJsZZusxgM6EgULyQozlc2yTtNFktiNdUAG1983G0FPuXnS2q0J
	 /VFc9zGVKPp0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7CD8CE0F4C; Sun,  2 Nov 2025 13:05:37 -0800 (PST)
Date: Sun, 2 Nov 2025 13:05:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/3] Miscellaneous RCU updates for v6.19
Message-ID: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
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

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rculist_nulls.h                        |    6 
 kernel/locking/locktorture.c                         |    8 -
 tools/testing/selftests/rcutorture/bin/kvm-series.sh |  115 +++++++++++++++++++
 3 files changed, 124 insertions(+), 5 deletions(-)
