Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C335200CB;
	Fri,  2 Aug 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558977; cv=none; b=J02K0xmvN6ZD1HfoQgK0Ca8gRpE+ysxneoZEcSgBobuqc4ZR7g5vCa9VcJznrZ6D7nS3EvR7/u6+q0MOqRZgLXRjtG+lt8MjeaQVyZAZgTNKlwNYlyfj+/BGrEaEH5tABolXIOvwo6OBInv23KehRf/hADjRwwh/45GbyckUs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558977; c=relaxed/simple;
	bh=La7QZZGHpgNDXujrceRleDZAWQsIZlJdOLY1oV/s1UY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QL9REY40biUH7LTUHoR9/+0UVnYEh95OqLgYquJxiwippkJv2liA36y/09MIH8beHRzfhguP0D4ScOr1/cfJWyR5ci3b7L74WxMlqxssrmiPvHOb1UZzWCwtvfqzL8z+ntZ8SKe8A79EQzqTxB3L7fEoYOgol2S4Z8WqtaGwamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAjfDNl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAjfDNl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2337C4AF0E;
	Fri,  2 Aug 2024 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558976;
	bh=La7QZZGHpgNDXujrceRleDZAWQsIZlJdOLY1oV/s1UY=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=FAjfDNl67OWzJ2QJB/9q6tfijPRr/FNSjzMUuuRAZwn01eTnHQndset1I1ni1S0p7
	 Tbq6XcZ4+mSP1UaBZeuYTBrqS5P59HI2aEWby9uTNa920qJ3gy4LUOJ5GbMHDnSb5Z
	 YaPTLSB+MScwHYV8qb4MoJLtEMS2E/gBiGHzSSmTGfU7kwHAxxWY7Z5o2Q7kegM+QI
	 2azti1BnreeJkYsZb2+vL9nYStO2ItFVziBODSH5Au/rhl1AidJDVrlMTEz0IIM3dn
	 rJCDYKRIF1WKWEan7/m1tGf8l/6JvTS8Qa7Y7DJvFy6tFJX7FHGgWMEd1eOPI6/H/k
	 0+IemtKCG4mxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 75A20CE09F8; Thu,  1 Aug 2024 17:36:16 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:36:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/2] SRCU updates
Message-ID: <7f2dd4bf-525d-4348-bf1d-c5c1c6c582b0@paulmck-laptop>
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

This series contains a couple of SRCU updates:

1.	Check for concurrent updates of heuristics.

2.	Mark callbacks not currently participating in barrier operation.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/srcutree.c |    2 ++
 kernel/rcu/srcutree.c   |    2 ++
 2 files changed, 4 insertions(+)
