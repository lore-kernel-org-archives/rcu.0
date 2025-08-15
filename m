Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF85285CBD;
	Fri, 15 Aug 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302398; cv=none; b=CHWbFJL2BStRxGEml59knJz3H7fH6RAvZ+rr/feE95C8NruuBHjmSdGdDbkcXkCSr3r7loK/YFmwVAV7teTIEvxKvN4fOlUtrlQeX4EQG2dKS4gbhCKHoO893IPyPBa7Rc0NsJh4wjLvuAhypRzmKwZw1bU5nkepOrhKgKREK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302398; c=relaxed/simple;
	bh=t3cyA35bgOXkq8NImd3NNO9t9rLob+iqUtnlaLHc3Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jayIVNWr/mlNqpCSP0uEYAvVEG/b+/o+w6cpeYHE2nAP+b7hPRigpsSrZmYe70SH/5tEPiC8jSsblodvXKJRYg4sgq7gIXA1ha7L0CT3AhEP+kqeLq07qL8nhpBiJJBSKnJcIhbVNZS5Nf7586+DI2J1KzxU3A/Ejt6n5A3qb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvcFm7Zx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvcFm7Zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B967EC4CEF5;
	Fri, 15 Aug 2025 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302397;
	bh=t3cyA35bgOXkq8NImd3NNO9t9rLob+iqUtnlaLHc3Rw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=AvcFm7ZxQQov2d8qeftsLV8tznAIlYbxmA/tRwYT1qeXJzZfa9uyQYQGY4UPowefN
	 hS8H/HsF/M6WDEBKiaA3+HcV4Q/XpJXvDtXryNJdco/vRUjqSZTRoF0X/wc0XxFl8Z
	 6sDqpEM/8oQ7dH4rzKNT2rw5MmZHW/VPmFxOigdO04Hm+0/z4iTf5ds8bSBrU8g9AH
	 3gOegF74S25di6gESdKDtMNYi1eUAAyI1RlHlw2XhJFR7K/Xypfx4Xt+2Fwc/VsC5Q
	 2IrErUeLZjt7Dr8Mq5XZzueAp9B9pFuxa2nu7m8IxlInJt307P8c3kh3UxvE3KE7lM
	 Vf70Z3jNV+fsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DBDBCCE0B2D; Fri, 15 Aug 2025 16:59:56 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:59:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/3] rcu: Documentation updates for v6.18
Message-ID: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
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

This series contains RCU documentation updates:

1.	Update whatisRCU.rst for recent RCU API additions.

2.	Add RCU guards to checklist.rst.

3.	Requirements.rst: Abide by conventions of kernel documentation,
	courtesy of Akira Yokosawa.

						Thanx, Paul

------------------------------------------------------------------------

 Design/Requirements/Requirements.rst |   52 +++++-------
 checklist.rst                        |   27 ++++--
 whatisRCU.rst                        |  150 +++++++++++++++++++++++++++--------
 3 files changed, 161 insertions(+), 68 deletions(-)
