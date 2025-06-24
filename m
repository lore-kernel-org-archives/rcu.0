Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FB28A703;
	Tue, 24 Jun 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781634; cv=none; b=U10da+MjJ/bVLBHjIKRSshwcJF+f64StW6R71rzp0LsnFy84fJcZ/pVnuPWpVdpe5oH3KHD4hseRCd+WCgYuJ8i3A1LKPs1OTI0fBejjQTTuTW29q+WZa6YngQOXHfUzREG7FN/iYUBISk4Vrno8pMR4oCHvtEKt9cBmsK/uxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781634; c=relaxed/simple;
	bh=hZCVB2AyXPrDSc6UP3805nf29pF3+Y8CbnsLL41zF+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ptYRiQuL8WsM9ga7YwNskpGWieD7crr0G9JJhd75eYWeRLmf7K3oFwSTkEeQ3HJMN4qHR1iYnSSxwVVYxvdlom3Jfa9m+xaAgqok82LzPEBpKmPgI30MQCf7d+/CYrzTne5IBED0E8PuoDBdW8rjNjQUy7aZ/UHGsJ/iqNKgdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuaZVeql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuaZVeql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1CAC4CEE3;
	Tue, 24 Jun 2025 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781633;
	bh=hZCVB2AyXPrDSc6UP3805nf29pF3+Y8CbnsLL41zF+s=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=WuaZVeqlHxWNx+ojMovpVXBoAFKJBQnuvrJ9zww92sSmO5aNgBJkCAClJAy6f1bO9
	 gpxuFvuwL8EWw182j8SZLx9r5QRZJHg1zlP8/8NNMTxTqT6Gntaud1gdJV9A3FtuhZ
	 mhW77JBD5Oh3fDm6T+t480WhK1pJXMyo0W1/djphBe/EGOT1W6QMbMDO3TTHbMVeRd
	 HO08dtjTTC6yAKs1B/tFL07IYS3EQ2dz92ro++1KN3AVpUIbIP8u7oW3LVCsjrKd+K
	 Cdr1M9sfCgsNePsLDi/tJN1C3+tZcmxyEkFGyaEYIcsRKQyW/km1xH9yNr8cIh38xo
	 VoX7NevsffekA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20E21CE0B27; Tue, 24 Jun 2025 09:13:51 -0700 (PDT)
Date: Tue, 24 Jun 2025 09:13:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/5] Remove SRCU-lite in favor of SRCU-fast
Message-ID: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
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

This series removes the deprecated SRCU-lite flavor:

1.	Remove support for SRCU-lite.

2.	Remove SRCU-lite scenarios.

3.	Remove support for SRCU-lite.

4.	Remove SRCU-lite implementation.

5.	Remove SRCU-lite deprecation.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h                                     |    2 
 b/include/linux/srcutiny.h                                 |    3 
 b/include/linux/srcutree.h                                 |   38 ----------
 b/kernel/rcu/rcutorture.c                                  |    7 -
 b/kernel/rcu/refscale.c                                    |   32 --------
 b/scripts/checkpatch.pl                                    |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST    |    1 
 include/linux/srcu.h                                       |   47 -------------
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L      |   10 --
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot |    3 
 10 files changed, 4 insertions(+), 141 deletions(-)
