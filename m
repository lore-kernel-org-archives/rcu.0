Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9018D65C;
	Fri, 18 Oct 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288144; cv=none; b=gyTBeLApedJ1V88adSqTmFC4qqfuFotF0D/SwWzc4kTWZVFVI4WYBjUlMGtlrbsWu6tVll/BBGvVzqNokNn0gnFDQDrnt+3gLZrjqHjauNgTmwkpb5wpZD+YFflEE8I3VI/xFLVp2sDynl1BuYZ9i1RHAyhbbRVe2MAKdByXX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288144; c=relaxed/simple;
	bh=f3K+7NqUjDXNy0lO4qYq2vhomW9AqXHiAR3DfjcaQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHGYvXtSjUKWSerLESYiUcJqhljaz/NpEKu2p70qYmCPh1B6j2J2x7RYUAtA+hK4FzoD/a1FcKRHLy6glJicKsgGsSaE7ljL3PQYhwUNpyZqzt27mGnrIfApkeH+ozF12J+nZptphii/Oel2sqjuZn9nVTejtzg6/CYShy4w3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow+FaBcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow+FaBcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AA6C4CEC3;
	Fri, 18 Oct 2024 21:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729288143;
	bh=f3K+7NqUjDXNy0lO4qYq2vhomW9AqXHiAR3DfjcaQWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ow+FaBcOeGP/rIPVF/PedkcrTFEStuDALunMpNpm84cbC/scHnEzed+rs7oFY5/Nx
	 wFAiSD59AEL1Ses51JifBxLTT6PJdgGr/piBP3bNG8KXF3dm2nMBJkaCkpfz2DvtUz
	 slFMDuFSoXNw3l5fdoE714VIzfmmcxB5IwZP1itybeX8XLfAhgcXgafiB3vZhg7eC5
	 /P2UwYwFPRaKhKqlnFEK+DcIaYKKuDE7Mx/UAKXrTA1bnSIlXOwcXIjeWScPFDaYQ4
	 08z0WPHan62FNn9fvlZWArjPczv0Z/J0oDHw+cEOJndaHoSSAUDb1A4mZgED3whs98
	 27nLTku+t9L1A==
Date: Fri, 18 Oct 2024 23:49:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 rcu 0/3] RCU CPU stall-warning changes for v6.13
Message-ID: <ZxLXzKoiCnIlmd3k@pavilion.home>
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
 <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>

Le Wed, Oct 16, 2024 at 09:18:52AM -0700, Paul E. McKenney a écrit :
> Hello!
> 
> This series contains RCU CPU stall-warning changes for v6.13:
> 
> 1.	Delete unused rcu_gp_might_be_stalled() function.
> 
> 2.	Stop stall warning from dumping stacks if grace period ends.
> 
> 3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().
> 
> Changes since v1:
> 
> o	Add data_race() to grace-period sequence-number access per
> 	feedback from Joel Fernandes.
> 
> o	Add Reviewed-by tags.

Applied and pushed to rcu/stall

Thanks!

> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/include/linux/rcutiny.h |    1 -
>  b/include/linux/rcutree.h |    1 -
>  b/kernel/rcu/tree_stall.h |   30 ------------------------------
>  kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
>  4 files changed, 22 insertions(+), 45 deletions(-)
