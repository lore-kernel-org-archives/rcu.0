Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EB20E3;
	Fri, 16 Aug 2024 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792943; cv=none; b=d1XWlQPKYK/fqIzgFeJOwMZnx54u28Um2HYkpsC4zaXw5bMVFwCIVhlx8vNiOmGTS2Jzwg22jwNovxgUnJODKYymjMhZNLm2VQqlzC5YnMNC4XzYFrLNXC2s8+czQlw2OKh/G8+MDJuHdY5lDWaqUpcFjYKKEfrd6VFe+y11KJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792943; c=relaxed/simple;
	bh=9oYSuoGOQ/ko0ZiuVhlSpU0pG0SY5OUXiFRX/l/YhJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DUt/bTcC27kN881r11tjSzsdz7IfbW6Xb2DRhUUjZmu1IzxCjVc1AP0Z9a3UyVgN8WajQrU+CX4Je/WDy2aRgKBZe+u3FZlG9lLckYf1r5wANwz22z/t7MCMQ5ohmT3Y1HQNbFXQHDGSl8Wyj7+6/OGnCBZrHuXjxC5gfzLamOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejhhR7v+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejhhR7v+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100F3C32782;
	Fri, 16 Aug 2024 07:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723792942;
	bh=9oYSuoGOQ/ko0ZiuVhlSpU0pG0SY5OUXiFRX/l/YhJc=;
	h=Date:From:To:Cc:Subject:From;
	b=ejhhR7v+VNEYRqEqG4cYAUFx3vP3E+yp9gQDs/O1LsQoArspzF8wX645jomlOs+eD
	 tqThmIUooSIRvAB7UaLP17LhLi+RUT2Awk0bdFaqsUa8VMjrBl3smi8ic1I1E5LpA/
	 2ZPyhLR0WSyFyXUIhyOVPGsZX4TQTNh1kJjGHiiUoAbDznZWxJf9B8eZ7lNKMCAta9
	 3gkCX6H9UM1NehOvP6ELFCrXlEOEbM1YZu/1bRLwA2V+K95NIs4UnLcZ1DP1Bv7xHi
	 ElYum9AlAlJiCbcMaTKGrE+5lC8NRwO+Q+j0vln860FA9qxvFX/kcZPtFl7xBK6HBE
	 u4Fq44sSRNxWA==
Date: Fri, 16 Aug 2024 12:52:10 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, thorsten.blum@toblux.com
Subject: [PATCH rcu 0/3] RCU misc updates for v6.12
Message-ID: <20240816072210.GA65644@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Below are the RCU misc updates for v6.12:

1.      Warn on unexpected rcu_synchronize llist's done tail state,
        courtesy of Paul E. McKenney.

2.      Better define "atomic" for list_replace_rcu() and hlist_replace_rcu()
        list replacement functions, courtesy of Paul E. McKenney.

3.      Annotate struct kvfree_rcu_bulk_data with __counted_by(),
        courtesy of Thorsten Blum.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=misc.11.08.24a


- Neeraj

------------------------------------------------------------------------

 include/linux/rculist.h | 9 +++++++--
 kernel/rcu/tree.c       | 7 ++++---
 2 files changed, 11 insertions(+), 5 deletions(-)
