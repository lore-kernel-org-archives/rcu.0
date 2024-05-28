Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4939FFB
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922485; cv=none; b=txyeu7SDsg+r0jyUtIfmcf1x+RnmlGsdKQhMwuZvHvQNadUpEGx8indKgFoXq+Z8464GCjhF/NcOFVAK81bwDmdDOX4qSzwSDCtK1PTqus8up/vXueqI7tNzILIrC3akEfRcdJzOKieBNaG2wVlrvyUd8/RjfxZlpba2jM54BSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922485; c=relaxed/simple;
	bh=YUyh2qma1MRu57iPqV1TyD51IsY1jFqaoH+CTQFc+4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Er17AQHLWguhNntnXvkTDXBWcLc110vVElaE3ruINiTH/DKg9fM04k2YN5H91QlwRdEErrD+v9ZVUtsBhScTbtikWQfF4Oa3Ogeaqn4+CgOo8JuH1LrpMzB8CwnYhNEar0XMRUzeUOJaAoe5V2loSQQvS+ZvvPpkFZb3UDUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG/CM6EZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG/CM6EZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1660C3277B;
	Tue, 28 May 2024 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716922485;
	bh=YUyh2qma1MRu57iPqV1TyD51IsY1jFqaoH+CTQFc+4o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jG/CM6EZqnOT21PataO/CtKVFG0UhrtF0Q76kkIMmjoB3bFi7hSvB1HaP01n6fvjx
	 XXZHVdebzWnSSvRKyNpguwSoEc/Li4ye/InarSe5p5bez5Wh6iWHM4AOp3loayhDdL
	 brWnNZAgH1HTrxkyByWWb1Jn3UVxORZ3R5H1imIGhw5s/eZ/fk0WdGno/3C2VuIQaV
	 DFbCnvd1Qurc5gJ6edwI2qJf+RW4sFyCHWgv6Z3G74PCtYRrhzaBN1DJUR2EFPycsE
	 OdHYTrRpV4fopOrGEevaLJtMHPwHPDKljNN+CUE5ZlC/xcATMjzLo9BcRd0mQDzLih
	 d9aiWA6D3PCnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96D51CE0F8F; Tue, 28 May 2024 11:54:44 -0700 (PDT)
Date: Tue, 28 May 2024 11:54:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: sfr@canb.auug.org.au
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com
Subject: Updated -next branch and repo for RCU commits
Message-ID: <732c43ae-6d7a-4a98-995e-e96086a94678@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>

Hello, Stephen,

From here on, could you please pull from branch "next" in our shiny new
shared RCU tree?

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux

Please let me know of any questions or concerns.  Or, for that matter, if
there is some automated way to do this that I have long since forgotten.

I will still have non-RCU commits from my own tree for -next, and I must
confess that the name "rcu/next" seems entirely inappropriate (to say
nothing of confusing) for that purpose.  Would you be OK changing to a
branch named "non-rcu/next" or something similar?

							Thanx, Paul
