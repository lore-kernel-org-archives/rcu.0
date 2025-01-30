Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3A84D34;
	Thu, 30 Jan 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263192; cv=none; b=YQTl/uHoGGaj0TDYbAJOXFGmYaW5SDTwpoPfEVzS5roxzZ1J/oQLdN/fTcZNXZ/BqTSfK9C+lku6mnjMC0KcBc7jjLqwsn99WEXaNpX2MCFodGRdfqWMmKrM+az0waFga4JqL/GO4Oh+awcXuf+5D/6BUsZfwybzbuFmBSuX5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263192; c=relaxed/simple;
	bh=N+DRiklgJDiEFjoPBj4apU9cKXMAWotvOm4Vt9yltJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU1e+Hw+/Z3rbsQpV4aAGYAu9GJx2+sDwDVk1OC79/yovCuLSSfCSFp20N5cVJYUBpBAXNjKa5oqlCnOHi0ILSK7w9u0BDadzGSQmKLRBlsvdW6BhL4M0YLvNfWJmYvFHlRXguSFoWWUHY4lew9YRZcjGAXmriGL5dAiOepmbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjc7lnhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjc7lnhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC9EC4CED2;
	Thu, 30 Jan 2025 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263191;
	bh=N+DRiklgJDiEFjoPBj4apU9cKXMAWotvOm4Vt9yltJk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mjc7lnhDy0x2nDl8h618lGNmR+XdnFqLYKWYN3JxkEB0fGlD7Y6BEes+FxEn9JXqM
	 o0+/7U5utIpBbNBXuPBkXamRsbqGSGlkeL9Jdza/VmHrVJTZMdQWbjaowp8bTlntAZ
	 2SYKtIAS4A+Dsi1XDqaQ+fphTp7bvhhbsjO84L2IFScLppxPk9MGGuE0YAm9T+eMGE
	 RoAJMhHnpy0AAI6dtxL+lib88JL756XrO53fYmXD3qi8QGmJs7g+FCJmt1w4D1FSHK
	 O96RUibEl2tMKJ94cPaNnU/Qd5mIQ8CEfag+d5Y9+YZPRvJLMeBNRZyHglNGlvtuh5
	 U7RBjbEX3igYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A092CE37D9; Thu, 30 Jan 2025 10:53:11 -0800 (PST)
Date: Thu, 30 Jan 2025 10:53:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/5] Miscellaneous fixes
Message-ID: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>

Hello!

This series contains miscellaneous fixes:

1.	Split rcu_report_exp_cpu_mult() mask parameter and use for
	tracing.

2.	Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes(),
	courtesy of Zilin Guan.

3.	Fix get_state_synchronize_rcu_full() GP-start detection.

4.	Move RCU Tasks self-tests to core_initcall().

5.	Print segment lengths in show_rcu_nocb_gp_state().

Changes since v1:

o	Fix "the the" in commit log.

o	Add Reviewed-by and Tested-by tags.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    6 ------
 b/init/main.c              |    1 -
 b/kernel/rcu/rcu.h         |    2 +-
 b/kernel/rcu/tasks.h       |    5 ++++-
 b/kernel/rcu/tree.c        |    6 +++---
 b/kernel/rcu/tree_exp.h    |    6 ++++--
 b/kernel/rcu/tree_nocb.h   |   20 +++++++++++++++-----
 kernel/rcu/tree.c          |    9 ++++++---
 8 files changed, 33 insertions(+), 22 deletions(-)
