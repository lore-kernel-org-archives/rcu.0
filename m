Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244320E6FE;
	Thu, 12 Dec 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028930; cv=none; b=Kx/5P+nat6YlMzRTv0z5SKf0oQFl1NzUBIZN4zAuVj6j3svkgCObQaYgAX7mmziAjAyiR1BKpRpf6A7sO/xwESN6IE9JSvldF5HV8+TNoLLnF1BaTmcJbk2bQ0y4pFDOlQNq6y2on9oohIuS25IV7OM65bdUkomxYnJQfrNT7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028930; c=relaxed/simple;
	bh=pA3hzbi+UIvVcfwZZt/1zIEJpC4EwSq+soMiFM0DzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sSQpoW3jGmCHAa/UqN+N17Sa0eiLSnohBPyb0OW05anQXOcpGs9yjWnUPgsaC5gQmo8CW8Vm6ze+XxZaH6jhAA3ntpVA8KCzAG27gnT6LuE34byEZiCuT0JAlR0D5a2Dqo9kEfHvU8ZdmRBDZum5Z6OuJebkmNQfYmiOIHORcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdRz0dDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdRz0dDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849DBC4CECE;
	Thu, 12 Dec 2024 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028929;
	bh=pA3hzbi+UIvVcfwZZt/1zIEJpC4EwSq+soMiFM0DzTw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=WdRz0dDv1834pdACamYIFN+6U4Ey6Lv5rm9IGtupFo/EYgQ9mTAkm5/i/Xfa8yEMN
	 vij8/1smbtfboB4OBZcOVBmLUzyp/DceRfA9fpSRKzWlhuo9GcC1bOJi/M8vLgux9F
	 DnnIURcx+t3UWmIZvVmGW5evlRVDuK+vWuxBG8Wa9tyIXOFya7miygFACCq78+xXF2
	 f+3DTefSCporO5kWU5nq1QzJikjss8UM68k5gKd3Q2DhKkw3o6OyKEzbADF6zquHwf
	 h5Lo52qdHtExl+pbXBx7iKjouz1Q+9ajcmnB2wlEgdABfPo4sg1T1RPVXcBDFJlTeY
	 5J5+JNiBPHAvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20F9BCE0EE3; Thu, 12 Dec 2024 10:42:09 -0800 (PST)
Date: Thu, 12 Dec 2024 10:42:09 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/2] No-CB changes for v6.14
Message-ID: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
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

This series contains NOCB updates:

1.	Use switch/case on NOCB timer state machine, courtesy of Frederic
	Weisbecker.

2.	Fix rcuog wake-up from offline softirq, courtesy of Frederic
	Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.h      |    1 +
 b/kernel/rcu/tree_nocb.h |   33 +++++++++++++++++++++++----------
 kernel/rcu/tree_nocb.h   |   14 ++++++++++++--
 3 files changed, 36 insertions(+), 12 deletions(-)
