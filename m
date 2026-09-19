Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B829B77E;
	Sat, 19 Sep 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778228; cv=none; b=uSlbeRK22X2AIQO9UXfEWrADne42OGbMB36D3T2s7Q1XBYjhUw/9u/swNbMBAht2edKscxaU+KqWWH691BChZUbSIZD6GvV78WYf246/wqSP4+Y0273Zruccwl3GjibLzVrb3Pl5J/Gldj5E0g1JMLW9NEV5ogQjpw9pujk1zAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778228; c=relaxed/simple;
	bh=oCwKRsaMLXQSs9CTWsuuIEHYyuzkdq19o71TcY9Bb6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tawAvYz6Ix0e84OyMo9s3BkBToieg/8WKNVoDQ/xE4tJs6D22V7cKFUf6c3TGwH2MXlFXWY9wzkeURm/w3BJ2yCsOInKA2YmEe6m1BOungjIOKtEsKxBHS8+t2OJy5EfUYEkGOC/sSsbcJ2F+iFGIlJJB6U6OvGwTsSQ4gh9NPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVTgq9c8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVTgq9c8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4083B1F000FF;
	Sat, 19 Sep 2026 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778227;
	bh=WJf+Ua4nz/jFYgxoIlzs9JiY1QEvmBEBYjvK0NKga1o=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=nVTgq9c8ayVU48cIRFuHgK16sVVeua16MQTYI007Q+nw9iM4WQMk3wAu457rEtVIW
	 43CYr+IONf9g0b2TN9ci1d3J8llsDMSDfDgSkiDlyCPlRhL8KhJhinmd4c3sN08rM7
	 UDKvUh+FfB+4JSPdH4i0LLHma/ELlXErfWWHqWs+Dkea/wy1fGDY3LywCA8HZSejm1
	 5gsDd0TDqvr4yZhxE6WK4vAYZlZid+4nM0RBfAtBkoP/41k6U4nivBIFY9/CWPtpCG
	 35vmBskpYvfKQaNKz7WFr+PUKfDSjBV/U3N/Nk4Y5tkDaZdS24OZ7ZEymCjP5OtNFt
	 RmLNosJZvalLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00F6CCE1775; Fri, 18 Sep 2026 17:37:06 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:37:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/3] Torture-test updates for v7.4
Message-ID: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
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

This series adds some torture-test updates:

1.	Fix divide-by-zero with fwd_progress_div=1, courtesy of Kunwu
	Chan.

2.	Synchronously wait for all rcu_torture_irq() callbacks to
	complete, courtesy of Zqiang.

3.	Allow specifying alternative ssh command to kvm-remote.sh.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                              |    2 -
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh |   22 ++++++++++++-----
 kernel/rcu/rcutorture.c                                |    2 +
 3 files changed, 19 insertions(+), 7 deletions(-)
