Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04279D0
	for <rcu@vger.kernel.org>; Tue,  3 Jun 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980880; cv=none; b=aMb4GOmw2mt9k3T9KdmwSC2r9lEFO2SCNSj2D9gEOAEY4vLZp9B2UGX9OfVpkmlvHVzsdr7yN9CDXLdtvLyt2txbjKOlG6diSIxRv8p3UckRbp3OV+fisriM4c/9w5yKZt8xk6VgWjd5McvQivZv+dBiMelewTcbHFKHXLog5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980880; c=relaxed/simple;
	bh=xcjXKKhICYCNuARPEH62mgmWCb+8/TQBAyGFoJZnvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Soq7u7kxboCQH/6xG9cKNXYDjCSskr2oV8HCc4HIFCDpbGTsJNCZ8NWg0eNZUt28+aKMIgyihglxJkjCr1+AWVNvihzh/z/b+vMqKWyoMRCBUyM0YAxfGqQtaV96gHiI3cAEL5ygWWDrnuARLsUKFABXHI5+zqPO/2fdmk/A89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFZqObWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFZqObWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AC6C4CEED;
	Tue,  3 Jun 2025 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748980880;
	bh=xcjXKKhICYCNuARPEH62mgmWCb+8/TQBAyGFoJZnvz8=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=tFZqObWWtJSEJbsD+MSDRwnv7qrRj4Ds7TcIZZx6T7H3ZeG7u+0b5KuIfd0lNKDsQ
	 WC8bTfmA8Rzm8W09u8/GloFJhHW3ut3vlRKDcFioonQ2VQg/Hc+QyoJZyQdZ2YI8xI
	 +/i+L2DsRYQWDF1fbLnLi0/i8hXTkLSIKbdTqPdPbgjuNjHe2SpBnBJyl1rb/FaMOY
	 I0EdrTJyDbw0xVLWNORzXuxnv/wT2iyqYrxJ3/08J2wkU84a6VtCfXGVvkZysBH6ug
	 lUcDVqR8p4te6kwRmj4Cb8DjRSaIc3Ev+tw8fo+ktB/dAxnzv31LPE+iFaJW9mkhYO
	 vjNI15e7T0DHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C23D4CE077D; Tue,  3 Jun 2025 13:01:19 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:01:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com
Cc: rcu@vger.kernel.org
Subject: RCU patches in flight
Message-ID: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
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

From what I can see, when I start testing v6.16-rc1, I will need to pull
in the following commits and patches into my pile in my -rcu "dev" branch:

6c59a7c789f0 ("rcutorture: Add tests for SRCU up/down reader primitives")
0a67dd132d1d ("rcutorture: Pull rcu_torture_updown() loop body into new function")
c27d0d38f2ca ("rcutorture: Complain if an ->up_read() is delayed more than 10 seconds")
3b4863a42139 ("rcutorture: Check for ->up_read() without matching ->down_read()")

The above commits must be ordered after this -rcu "dev" commit:

db950fccd45a ("rcutorture: Make rcutorture_one_extend_check() account for hardirq")
	Tested-by: kernel test robot <oliver.sang@intel.com>

There might be a few conflicts to resolve.  ;-)

I need to drop the following commits because they are already in mainline
(thank you, Joel!):

604d70035eaf ("torture: Check for "Call trace:" as well as "Call Trace:")
2e5158390089 ("rcutorture: Reduce TREE01 CPU overcommit")
90c0254a6d48 ("rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01")

Anything else?

							Thanx, Paul
