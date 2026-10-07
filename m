Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB72D2381;
	Wed,  7 Oct 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403829; cv=none; b=WZKlNaho+2N3d2vBMSFupNvPF1IfefCLOI/LOgs7WzeSLe9AQap02ljcdt3ZefVymKoRGsI8uAyEySxWIy+v5UIK1yJz/Sp8jDsxSHS4c5nB0zgbmXCKLJ7TvNs/7S2Q0H2Q9hF3lwdRX+lOkDrvwxGCY/D3fqJLfHULAL3qBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403829; c=relaxed/simple;
	bh=PMlWtu18HG+gNIkrPu0KptYgwh5u/6Re/HYEmnLWOkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=axOQnwa4bD8yrriguz7oUc+M4Ph/aiBDTISkChZNFbF9OSCalgzbhuIZUv+hhI/kE/cOGLMMU/ObOIbjbQn3flaGucGeZrhWzybpuRz6RW/H6uf2MdSL20QN5NW/Gmp1kEFe7JBnBqZFubDPcpTxw3IVHkNZCIFtTchcSJKFBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2cyTpxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2cyTpxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F921F000FF;
	Wed,  7 Oct 2026 20:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791403828;
	bh=06VxM155N/x0DjcLR6yENvx2V+wSHTOR+6PJW9u8auo=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=I2cyTpxzrNo5Y64q9I1kL511V/dNmyCChBmAGGtSaE3QCPqVrQuxMOZwDffgVtT90
	 LiFkBOUZtNq+2uhtxTDQxV31/RkJMLqFF9cnmB0ICrhzZOSUdLgefXEhaRILlDRDgx
	 Hik6A83oW5a5UoJ2ocw3jzHmAZ7V0vKbywPajc5qL34ag1R+qBASxzJXt1jSgm2XiH
	 7K3lTWqNugL2RGmIxsjr0OBvq34J2w3NUgXBZl9DI75TZG/9pvM0RSrmGM5EvUERL+
	 7XI9qY8PK/4LB3TH/NuVLJoVVCnkmyZhZhrzJMmO44d+1uC9WBnY37s0+CxIFU/tJe
	 Ms4aPi2MOISFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C198CCE0D79; Wed,  7 Oct 2026 13:10:27 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:10:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rcu@vger.kernel.org,
	Sunho Park <shpark061104@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: [GIT PULL] Urgent RCU regression fix for v7.3
Message-ID: <3aca04a9-dd13-4990-a715-5778871ead57@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Please pull this single-commit urgent RCU regression fix into the current
release (v7.3):

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/urgent.2026.10.01a
  # HEAD: 26f90559a77cac4b8fdfa3491732b7c7e08210ac: srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct() (2026-10-01 17:17:48 -0700)

This regression was introduced by this commit:

78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")

----------------------------------------------------------------
srcu: Fix spurious WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct()

This issue was introduced during the recent merge window:

78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")

Enough people are hitting this that I am sending it now rather than
waiting for the next merge window.  Especially given that it is a
simple one-liner.

----------------------------------------------------------------
Sunho Park (1):
      srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct()

 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
