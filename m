Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B81B7910
	for <rcu@vger.kernel.org>; Sat, 28 Mar 2026 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774737471; cv=none; b=lK9MhLJg73tQRjTtQPjGQlrF8dRCNXLGaSfYjivcPVfRT8rYi7J486UEPt7gBqHdn/pphHiVt+Z2Stknnd85/cNWD8R5QbHgLA3xgf2FnOxYU1KntA2nqu3perh7JD++9/Xj8tC9/yxy5YFU4nkowF3MHgekvT5ZPPQd7ElPNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774737471; c=relaxed/simple;
	bh=GTChoeDH5EoCx8wAZh1LgGhH7N9O4cG0Td6PvmnbpIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ln1RVpnXnwIxFcDEg0nG1BZHMyCkiwFOvlPrYpAVECsBOHNWkLUKmq3fu9P4UGZ7lCO+64q6wXtzgfxhzF8dbnYkV0T9LtR0hKc6msirVNuzlWmMCDYtXZQiY2VMZaQb+a6r+GCvVBkp7DX6mntg9byOpZI+sPZ+DzEn2dapOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D764npn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D764npn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F9C4CEF7;
	Sat, 28 Mar 2026 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774737470;
	bh=GTChoeDH5EoCx8wAZh1LgGhH7N9O4cG0Td6PvmnbpIA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=D764npn5hBpQlkFKd7bopubprabS+Ukq6dZ+zBHy9U2oMOBALhyD+kGB/9ufUfPq9
	 LyYBeSfY+Wv7kmHYeGQx0eIkzmVClxfqD7mWw/EuFWtyNwkLzCJExLGfkHdBAQGs90
	 5G3yzhzYI1dfkYlPqwypFkUhl1CWvefX2MwQY/WeZDQZL83IuIbh8obbEjjwNDfHf4
	 ZA7mzC4+zBDrR9A5XXmeiNaLZo7L898ZxVANY8XRf/50XV7cFAm0QFMCtn9HhtzqsS
	 JzpZ/qSrkHKE95RkEVstw2vtTZDLlI3WFewMAyF5VwA6qJd06yayhqr59H6fcwBhq1
	 ZMNtLKc4Dmotg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 339B1CE0AB0; Sat, 28 Mar 2026 15:37:48 -0700 (PDT)
Date: Sat, 28 Mar 2026 15:37:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Semantics for hazptr_acquire()?
Message-ID: <0787677c-809e-47f7-b8a9-75f65f3b0a33@paulmck-laptop>
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

I have been (perhaps redundantly) putting together a torture-test module
for hazard pointers, and need confirmation of the usage rules.  Here
are my current guesses:

o	A given hazptr_ctx structure that is passed to hazptr_acquire()
	cannot be passed to another hazptr_acquire() until after it is
	passed to the matching hazptr_release().

o	A thread that has done hazptr_acquire() can be preempted and can
	be migrated to some other CPU before it does its hazptr_release().

o	Except that a given CPU can have at most four outstanding calls
	to hazptr_acquire() that have not yet found matching calls to
	hazptr_release().

Any corrections?  Anything else?

I know that there are restrictions not respected by my current test,
and I have the splats to prove it.  ;-)

							Thanx, Paul
