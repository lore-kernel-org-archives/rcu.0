Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308167081A;
	Fri, 31 Jul 2026 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459111; cv=none; b=RmYLh0yoiP1WZiIuhm2RaLv3Us0PR40O3V/ggde2PVMqewcePCH4bHQHNkbCXif/8wDhtaeWiB8FDKukUl73hfwSZcwpcSt7fNsh7tfxK+NgyrcDdHiIdYq7exlMu0tHD/0I0atAAtMUAPajb2T4nzup5vsjv+dp4SMiC3ADJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459111; c=relaxed/simple;
	bh=wOa732k0X+Bc8ZoxFKaiU1X+emFbsnRi1EeuudL/2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gATjgHg+Hop3LizbsiYP9TAeMJe9P+fqC/o+a8osuoCDLaR30QkDl9zwyUDwo+o+BpUCNgXRzftm2KDGWiXh72RY3hhExNc1yOhQsoa8Zb+G6d5Mf+7cI/d2EM/xHGML+jqQWE+1uAGtXFPKEKjYVBns5RM1vuZSzL60aXJ5ukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoeKWhzL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoeKWhzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2771F000E9;
	Fri, 31 Jul 2026 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459109;
	bh=fe4qG39bpKoORvVjZ7pc4qbEgnBOBYucZsSLGJXbe8w=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=DoeKWhzLZTmwr9wh2udQafvP99UQFnm57WyBGxCeoFVITFxSUKWLYdVfE79agtl1U
	 PTIsBfq7fuxHpB1ZaMJzOqH32ULMbzFH0TiqcJJFwsZbm0K8Nyg8NxLmrqruLjpBWK
	 X2dlN123MrnlezQqZhIhUD8MujOS3KzVjrLU7AMZruYeVcnBCT0/dVNdohDcTNGJrq
	 nxm+gnTwJSF7nE3Ld1slBR2ViYWIL0xmMYACMrTJvuT676FvKrw4wy7LWPg7s4FYPX
	 8OIdoiW800pASXlPSJtsBd+hUqKs8F0t3+fehMTnhkp2h5zEZ9/eevLs8xIJEorIsa
	 3yW4RrqVAnrFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87F02CE0F69; Thu, 30 Jul 2026 17:51:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:51:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/2] SCF torture-test updates for v7.3
Message-ID: <d470e612-b88a-4916-a1b9-1a6e8e6f968b@paulmck-laptop>
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

The following series provides scftorture updates for v7.2-rc3:

1.	Count single_rpc offline failures in statistics output, courtesy
	of Joel Fernandes.

2.	Make invoker threads actually wait for all threads to start,
	courtesy of Joel Fernandes.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/scftorture.c |    1 +
 kernel/scftorture.c   |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
