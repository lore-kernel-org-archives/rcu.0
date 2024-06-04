Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878FA5F;
	Tue,  4 Jun 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539708; cv=none; b=KtCp66RjuVAQIeSuCbviHcM1e+x7Rym0k3/ebK83hLilkOnotFQCc6+lQr0EDA4q6ZlgyoIc+almIjVgj+bJnTEPOYOxJ/q35/he2S6Wvk2O+bBOdN5OetBmTPW9XdIXfpTCAbnGAU1j7UzHTJh2SSs5fFFO1ib40lX+MYocxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539708; c=relaxed/simple;
	bh=GruPzUL7hGR9lTs/nVmPAfDyUP1i8SYx0b7jYa5YSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BjsKi7JGgLZzVasNkFmpUdHqrSZM22xE5cO+4oHQXBOYP1lSNNDHWGiKdqRDXefsnWNRFjzuwPIN8j+HBXr1tUH4bUGAvdyAUY/BtOHubcmG8ez/w4pybIeFMhvxTbp2Hd2MMJQbVPa6riUsIQw1KB5tm3u7qVOQjgi1xByEUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3Ssf28W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3Ssf28W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49786C2BBFC;
	Tue,  4 Jun 2024 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539708;
	bh=GruPzUL7hGR9lTs/nVmPAfDyUP1i8SYx0b7jYa5YSS4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=G3Ssf28WVk46KD/WqGaanXGv6HXvJMasxKUV7TTkpGiIHM9nsk7j3cDRcA19VB/Za
	 ihLn4yV6w/L/4VDNs/z1/8G9b6YBcJPZGilpopBk6dZUgUMdWMMCHTW6GoFThx7YU1
	 TVK8ipiN+YIZyLDBOz25GOwNW+j33H3bmpW4jo2bMma0de2Mz0Rw3xo6GiqH0L5FHB
	 CGicfjEVN8B8fFNG+jwtGXAdkr+EL2eC/FLMkgCXYNrAFr7YYgxSBL82NX6Zfp1+d+
	 zN8Y5k85XuKjCK4N/BuwNYbMbN47pxKY3qFj7o8nhIgnbuk+Zaxroipwwsdnk9YUFA
	 /8YesI2htXLcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D836ACE3ED6; Tue,  4 Jun 2024 15:21:47 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:21:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/2] RCU documentation updates for v6.11
Message-ID: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
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

This series provides documentation updates:

1.	Update Tasks RCU and Tasks Rude RCU description in
	Requirements.rst.

2.	Clarify rcu_assign_pointer() and rcu_dereference() ordering.

						Thanx, Paul

------------------------------------------------------------------------

 Design/Requirements/Requirements.rst |   16 ++++++++++++++++
 whatisRCU.rst                        |   30 +++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 11 deletions(-)
