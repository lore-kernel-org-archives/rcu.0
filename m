Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9251547E3
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499082; cv=none; b=ocWkXL9h+tspyfvqpmA6frJC3YbNKLhmu9ciK5v7SPAAkyOfHb2iWZOkHArD17shynUwy7RM4hY2AZeauwb+/9jC7M4qEWDoW80Qu96MTrE9uRiStQFm6uowr7niVCP1zn/do+ft6atlCcOHwqBoXvTShT/u/bbvuV8g4HrohOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499082; c=relaxed/simple;
	bh=nlXQNhmB+eDUMC3olRT27KFxVPSQ1W0oVfzyRCs9j3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=urbhJ9g+g/t4B+nAK0A4ghOqSQ9JvveDebsykTg1CvzziAiBBuzjLyeHb9RTXryq/W9Br7Y84ha4kz4l14nepDx87dY4ui0Wm8SXlQXQyvBykr4L58jQf9f5sI59wFpVL9hL3akJMSfxC0ZbjribKzn3ATe2ay56IVC4eaexF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEs0wOqf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEs0wOqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AB6C4CEDD;
	Tue, 25 Feb 2025 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499081;
	bh=nlXQNhmB+eDUMC3olRT27KFxVPSQ1W0oVfzyRCs9j3M=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=TEs0wOqf5TwADyYvY041gSh7hmv0pUHf30SoFvtpc1EtX2eRxNqv9JULMfT5cLkHe
	 7H7ooLTvZnSzL33fdGjuLHT0RBJSHC+LcA4o7knbks2DnoWhx/Oas+N6JlsBIIT058
	 pSI9VZegiNMuECKfcjC7d7N0NL5oosn0N7spCxG2vIGTGhp/VxmHWTfgK+uVljDCV5
	 ByFEcSW0/Rdc59OkdhwcWN44MLJz1bWAQxUs7FUKiYN3CdbXfpPhCCqtIQmAW9Nyd0
	 GKQZ7aKjePUujm4RpdFPBMPnlywjE/+wVgyRrIXhEnPJpgqoUNP4MODkJTSA/DqiYc
	 VEJTuGRnjxp1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 175EFCE045A; Tue, 25 Feb 2025 07:58:01 -0800 (PST)
Date: Tue, 25 Feb 2025 07:58:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: boqun.feng@gmail.com
Cc: rcu@vger.kernel.org
Subject: Testing of shared RCU branching
Message-ID: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Boqun,

I have run overnight tests on your earlier branches here:

ccb986e8b69f ("MAINTAINERS: Update Joel's email address")

These passed other than a KCSAN complaint involving
rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
This looks like the plain C-language writes to ->defer_qs_iw_pending.

My guess is that this is low probability, despite having happened twice,
and that it happens when rcu_read_unlock_special() is interrupted,
resulting in rcu_preempt_deferred_qs_handler() being invoked as an
IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
data races between task and handler on the same CPU.

Thoughts?

							Thanx, Paul
