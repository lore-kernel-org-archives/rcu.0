Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252192DE6F4;
	Thu, 18 Sep 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190459; cv=none; b=Vs4mJfzKuSCdb67JMgGKYlbH0TpYc5ctvDxsAGkm4w883qlWNfAVdyMaAfqN3Rq7Edj7QxeZMVx/7VDu1hafJRWzg/HW2Oj7QObSPaKgAG5MOZ/DW4yUSLb0UWPEd2nFwVuIjVv9IPTyIeu7xBW59n3O7LNNGFcSsFiXCkSW3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190459; c=relaxed/simple;
	bh=PmoUEnx3gZ9tBKlpRUX/hDGj3Yqnge+pVw1wGNerCKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGpQ+GVk4pYXx5w3OtB7LxCP8Wq5KjCM/Mk3KeCAu4u95qnw5VgqK0PMTvvAuqXn01BE/h0aR1b/an4xjwSbz7Ih7qywiP9WuxqU4ONacg83u6/jesCrAHJeVCGDfLXFo6l9tKIVHUXYu0KOghgPTOtvoBE/yvheL8aGHJ4laxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9q7rcwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9q7rcwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B3C4CEE7;
	Thu, 18 Sep 2025 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190459;
	bh=PmoUEnx3gZ9tBKlpRUX/hDGj3Yqnge+pVw1wGNerCKI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=N9q7rcwDDaDovwP1rYoBqfDGLr5NyX9wE1HV8wbwNI4pM+pd3875A6FD7BKsdnN/j
	 7og8+fvmdMjFpERjX+txDwpnpx576q36qO8jgL8kin/JgFI1n6ZGi1pxMwgPWVtt4C
	 6wtZWs4KYqYl92bmT1A6gAKdjg6blycAlLBOXdefUNsD3aYQowmkHDxnqC8q1u5QBB
	 yIk5bMe8wN4njc95OjhNQp58uE0ce1ZNyAF3aRIqtPdcLwbriSru1wp1uP38HkSxkH
	 KJHjFLAke0YHwwvb4CW3a6I+tQj1hexgu+MOesk7faWoUQSgnSUggl4fX3f13qITBN
	 bSuztSmq7lmcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 82654CE0B32; Thu, 18 Sep 2025 03:14:18 -0700 (PDT)
Date: Thu, 18 Sep 2025 03:14:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH 0/3] rcu: Documentation updates for v6.18
Message-ID: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>

Hello!

This v2 series contains RCU documentation updates for v6.18:

1.	Update whatisRCU.rst for recent RCU API additions.

2.	Add RCU guards to checklist.rst.

3.	docs: Requirements.rst: Abide by conventions of kernel
	documentation, courtesy of Akira Yokosawa.

4.	Documentation: RCU: Wrap kvm-remote.sh rerun snippet in literal
	code block, courtesy of Bagas Sanjaya.

5.	Documentation: RCU: Reduce toctree depth, courtesy of Bagas
	Sanjaya.

6.	Documentation: RCU: Retitle toctree index, courtesy of Bagas
	Sanjaya.

7.	Fix typo in RCU's torture.rst documentation.

8.	rcu: Replace multiple dead OLS links in RTFP.txt, courtesy of
	Nikil Paul S.

Changes from v1:

o	Applied Bagas Sanjaya feedback.

o	Applied tags.

o	Added commits 4-8.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/index.rst                              |    4 
 Documentation/RCU/torture.rst                            |    2 
 b/Documentation/RCU/Design/Requirements/Requirements.rst |   52 ++---
 b/Documentation/RCU/RTFP.txt                             |    6 
 b/Documentation/RCU/checklist.rst                        |   27 +-
 b/Documentation/RCU/index.rst                            |    2 
 b/Documentation/RCU/torture.rst                          |    2 
 b/Documentation/RCU/whatisRCU.rst                        |  150 +++++++++++----
 8 files changed, 169 insertions(+), 76 deletions(-)
