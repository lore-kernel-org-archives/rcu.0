Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D54A6881;
	Wed, 14 Oct 2026 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015359; cv=none; b=s2ChSqPs4PgSNNo3CDpE+ycTySXgtFtFC8b2U8fy4MgW4w/23FhqNa0gXcXusLKVylfs6pFiQ4K1bVOvOgrpJq6q/qi60t7gwM3/cFAADrmRD3AlAVyZJnO3wsx6sY7z8VNszu7yGTtaTtxql1psRDo/kwcrI5l8yXkAfg2gFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015359; c=relaxed/simple;
	bh=QRKnAZ1eF9j61rXjzFQQL5XQHM4eObtX8gVBQrn8IP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqIDmSnfXmf4IBLw+yB2EKrD7zOXLoJZauVw8Y/B3oLB9Rw276EsqhuA/dl+hLh1+G+jEweo3Lz9YK4quCZZ1fewwW5quIaJWFRcRJdXOTX2jTNRauv6yQbPKOKNBXwU7f+3CFFeOT2S1H1JasBjKDGsdbPt/SyDBRCbRW0EFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVKukfnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVKukfnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B5B1F000C4;
	Wed, 14 Oct 2026 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792015358;
	bh=HGCa1vj+reAt1H3nCbAhK2Vvxjze0Nlqyn1XaSBSqFw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=fVKukfnB3gjy/M+0qTM+rUn6dOla58Rl3Bx+u5asl/8CfJukz5gZ8zC4G4omPQ2tX
	 Cy46C4v7KLpZ2hDxsdns0+z+FsT4NEKp4sSNHcSA0Eu0xv5z4Uf7nRno7cpPZequbp
	 IItRyUoymBXkVMYMZ8WqJZ6JuPxhkiilYizo+Atz/EfjoUEyFr0d2wU7NU/HOhuEOz
	 hqNI+IZn7Wdm+nYkZ0O61Sn2/uHM0434l7SQB+GIoEFDF+3uzTep2Iek+ou/ggzn9u
	 VE/aNok7ePG+VDs8MVyRqva+EIGyE1uFWNIQl9PViN9DNDYIxwr1g+0iM/KiwDJ06v
	 /RiaT1jopOMyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 39F07CE0C55; Wed, 14 Oct 2026 15:02:38 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:02:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 04/21] srcutree: Add an atomic Tree SRCU
Message-ID: <eaef6b8f-1c50-410e-87a7-a0598b8963c3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
 <20261007205924.1983367-4-paulmck@kernel.org>
 <729dfdb236e4daaf2438b74d4d921993a156ec34.camel@infradead.org>
 <d1539cc5-0ff3-400e-a487-eedd942cf6f5@paulmck-laptop>
 <3aba8068a1424c91c81ec35b2ea6dfaa28161fb1.camel@infradead.org>
 <0514b2ce-217e-4e0e-9b2e-3f145a3e8afd@paulmck-laptop>
 <ecd351a5d56edd89e7d0ff5f57c585f00de60717.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd351a5d56edd89e7d0ff5f57c585f00de60717.camel@infradead.org>

On Wed, Oct 14, 2026 at 10:31:16PM +0100, David Woodhouse wrote:
> On Wed, 2026-10-14 at 14:14 -0700, Paul E. McKenney wrote:
> > > 
> > > Looks good, thanks!
> > 
> > And these are now applied in my -rcu tree:
> > 
> > 60df507b6091 ("srcutree: Add an atomic Tree SRCU")
> > a48669f0c49c ("srcutiny: Add an atomic Tiny SRCU")
> > 
> > I intend to send the pull request before the merge window opens, so if
> > further adjustment is needed, please let me know right away.
> 
> Great, thank you!
> 
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-srcu-v2
> is now based on your dev.2026.10.12a and the tests will rerun overnight.

Very good, and looking forward to the results.

							Thanx, Paul
