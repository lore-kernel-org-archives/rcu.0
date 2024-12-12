Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A416188938;
	Thu, 12 Dec 2024 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029481; cv=none; b=FUaz2xdgn4Jj0YRNx6f0LWqkXSJi6jVHUCBAcXCaXPH/8QYpPcQk0eQROVSrNjfAsdrkXGSX6gK+og4YsUT2CMNNlMdZCs9oL94i8jINp5DHCnpSoElkGFTfx0sP/blRGH9HhFeLMR34mKZSRU+OqkzgdPEzw3KpDyqr0aNNtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029481; c=relaxed/simple;
	bh=uVB9sWODCLv4EDCaAVZ0QQLLVmwGK3gfcpVbu7ue/J0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DxOmct5MksfUt5T10jDT3ZfBg6eWM+OesQQa29rjnnyTCLj8RYY8tJFPSvOwWMFZjbCGlL9mZhn9SNA/TKyJ3T2wF5r2H0Dzb0af5HNyTj5FMYlmx54RExcJHz107BLRJX7RdoKeUTa4u3WcmudgEstIPlQI8zodlIQFILt4HCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5TtcYqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5TtcYqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D223AC4CECE;
	Thu, 12 Dec 2024 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029479;
	bh=uVB9sWODCLv4EDCaAVZ0QQLLVmwGK3gfcpVbu7ue/J0=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=A5TtcYqN2VnNOsyvTD5ECVUg/P+W4LCrsLmt+dtSpRDnbHVu4xj3uAJKRG7lroEJe
	 bYg5zQYqApPDo+VAlqUY6a+jjrSxfCtldGxIAortN4FOAN+QDyC/Vqu5cOmRYaD8vg
	 X+0STOH+r9WR8/Z5duzUcMIX41F+gnWmTObNoTZ7pX6oPwH4cx4LK2J0F+VZ8lD0lW
	 c5zVNzpUFvbQZA6KgXtFT0hgXgxWotwT35LmljSGCbCPFOYVs6AwyFjyqjodVtgEex
	 2Fz/uVSFc/YBzirPiE97X4oKP3HGNa6vEemXWUurTMq41L6UUfYxMsfgYfVydspesM
	 y1b3cF/gSFRrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83249CE0F53; Thu, 12 Dec 2024 10:51:19 -0800 (PST)
Date: Thu, 12 Dec 2024 10:51:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/3] SRCU updates for v6.14
Message-ID: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
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

This series contains SRCU updates:

1.	Guarantee non-negative return value from srcu_read_lock().

2.	Fix typo s/srcu_check_read_flavor()/__srcu_check_read_flavor()/.

3.	Remove redundant GP sequence checks in srcu_funnel_gp_start,
	courtesy of Feng Lee.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h     |   15 ++++++++-------
 b/include/linux/srcutree.h |    2 +-
 b/kernel/rcu/srcutree.c    |    3 ++-
 kernel/rcu/srcutree.c      |    1 -
 4 files changed, 11 insertions(+), 10 deletions(-)
