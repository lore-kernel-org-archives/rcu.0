Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC91BC40;
	Fri,  2 Aug 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559065; cv=none; b=Xt0H3lheddO3pZagnN+omgDKGaZEE7Pdq9gyonX4z2Odojw8FZMDzy7xD89YeiMsbjoLEd0OturLPCKYq1IEuFXnUr9issdcXtf24zHbc+dEy/LcKcMj782IG1pWUAHAuZuyQtyxw/F4CWpIlLYy1CPaOxNhbc4fFQxqtK3TX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559065; c=relaxed/simple;
	bh=s6i7xFAbcIpBteb2v1GUSCIY/I6BsXA2NQa7QTw4Mvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oIbVJftqlmYsyNExoQeg2E9TfrHTSTB9LB5XQ/N+EYHjUqAE2swdSJakbNFWSIAKcCKvsT8M5/bTemczdi70tzmvGKasASFHKzyIpcp5DQiYz5Yx3U4WaZQ0iHnxcc0skdhea+0q6TchUZ2LIeWMLInUZvutdI8z5IR/vL9cZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foMz4kMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foMz4kMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E0C32786;
	Fri,  2 Aug 2024 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559065;
	bh=s6i7xFAbcIpBteb2v1GUSCIY/I6BsXA2NQa7QTw4Mvw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=foMz4kMUdGo05ETJA0xCqX+QufeZ4kyqzc7Wluu8JrOFvL3DXEq2kNbSX5JO6awqo
	 r4TIt7JrkfUKiKMuFlXkJ0cryqLSML/fKCng2UKufInEM8Q4mDGLFLEv/HKiCSVoTv
	 eSvKGwC0Qkl0hDDK2r+01LSWEad2sNnLFMb9VG4GhgLzlinf2FS92e7U1Km9LsHuhs
	 xJ3EoatjRTpir01jfekSJtzB3ZvncmDge45dY5eYc9+i5maKglgTzM+Mw7PXz6CUpa
	 Yzz81iv2hHmzBhMRioc3Yk+WbG885VGQZCMbDG5FJ/4iPrM/9+VJW2zsd3kI1Mu+IQ
	 wQ+oNZChCsdVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA92FCE09F8; Thu,  1 Aug 2024 17:37:44 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:37:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/3] RCU torture-test updates
Message-ID: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
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

This series contains RCU torture-test updates:

1.	Add rcutree.nohz_full_patience_delay to TREE07.

2.	Add a stall_cpu_repeat module parameter.

3.	Add torture.sh --guest-cpu-limit argument for limited hosts.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt            |    8 +
 kernel/rcu/rcutorture.c                                    |   56 +++++++++----
 tools/testing/selftests/rcutorture/bin/torture.sh          |   38 ++++++--
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot |    1 
 4 files changed, 75 insertions(+), 28 deletions(-)
