Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC26481B1;
	Wed, 16 Jul 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626734; cv=none; b=HtekfBOuWp1KfEInx+7+icMu8Pj4SRWPR+5z0AuahpZKMKtDKjh3I9M6C3O3FavjyTD0bYBDIH7Fz2KrHO/Jmbt6+72InvWdiwr+qxlYx4YpATgpb1iNAvGkzHPtYgDcUG8hfn56SuHp1lMTFw6eammy6A75uB/zuftNJGE+PBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626734; c=relaxed/simple;
	bh=6A8i2095NxDn0VLyNRp8X+k1UdttbEbiIcumbwRl8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nv17Wa0cT8p6gCZT8bHJAOrh7pDTIePHDAboi9DwgtyhbwtDFsVCJVM+dQmxQcY48wJ89lE7aImMvCbEy1Fa5fMv190Nde04hYxRn5Z5w43xyaAzQuR7M5rExhSAEzFaIPk8dIneCnFbNu5rAvLgqzH5hyyhu/Omx200EhSg9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQDFujzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQDFujzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED14C4CEE3;
	Wed, 16 Jul 2025 00:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626733;
	bh=6A8i2095NxDn0VLyNRp8X+k1UdttbEbiIcumbwRl8P4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=mQDFujzg/aJFZmpqhd1+9BXzuMFu6Z1O6BTHu3C4RB9V1L+fXyXjGkNtrE2eOqVl/
	 MFc8Q4ueETsrk0JIKdxMvJxuEEfVPYn/ImqWVpN6e4r3OEvcwxL4/5Bdc8uhy30hUo
	 2mlrS6/l1Fs1R0Rn5trR9ea6HGkhyuKKzT/FvWc+J5G0PipbsWiYgcncj/5PK2u6iV
	 pkDOw99FkrNlJGHGt/p5su+a7AQtEfTtcfMlIFKqr6h0Qsf+1dlrMA2/D6Etfx5+ck
	 Vzktn2HxAB0LEvPJ0PVGwjSePVN0R++awN793uhWA7MDluH5at3OP1zrfhq6FrqGif
	 SHY+L/r4Ggycw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D046DCE0990; Tue, 15 Jul 2025 17:45:32 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:45:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/2] RCU API documentation updates
Message-ID: <70015517-57ab-4d07-9792-3ab1beced9e4@paulmck-laptop>
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

This series updates RCU documentation to reflect RCU API additions:

1.	Update whatisRCU.rst for recent RCU API additions.

2.	Add RCU guards to checklist.rst.

						Thanx, Paul

------------------------------------------------------------------------

 checklist.rst |   27 +++++++---
 whatisRCU.rst |  150 +++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 137 insertions(+), 40 deletions(-)
