Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE43139D;
	Wed,  2 Apr 2025 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567807; cv=none; b=Vg5fC6rUU129YrsD+jrODhB0uDxwc/HtBlDI939ljL7lsPplyfMzC1CZNEDTyuur8KUiAgnRge8uYAz/uSxtqnfxWf3+Xslkuj/aWiHgFN4uZwoOrcqpADxoB/gfy1ieb1t+daVzGusrLNl4DCFUzrL1PZVxLwOQIAlEdJG5XCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567807; c=relaxed/simple;
	bh=aXJNaNBKo24tZPmCdTjEucDXK7qzyfwu+SDoJWIsfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZXqfKPOaowiXj+o2SAc3m/uq7rd7XkP6Sj+A3fPt0+rC3mM7qF3KC42Lz7wUMB0TcK3A/12vqWmNjxAS346Z4iFeSNxVpTe8pjR7xkEWi2N/8uhckS4jf59v0i6zlXnaWIlwVOl+wAXa3yQjR/skqs1GkFD88/HOtOWSQMyUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNcaKqGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNcaKqGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3541C4CEDD;
	Wed,  2 Apr 2025 04:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743567806;
	bh=aXJNaNBKo24tZPmCdTjEucDXK7qzyfwu+SDoJWIsfMw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BNcaKqGWTJ/9V0VmabkgaHhTHH04gO6gGO8Gp2bW+Y3upeY74DkK3ZFGJdFiQ5lYK
	 RfcX8ydUsJwwwxNkKyFVeEOoFJGDyOA8xJucbXKyCoAg/5t2oiN4zuUIzTqeoXzny3
	 4LEI4pNtvg+ZHAGahUPqPJq3YRk01zB25zQ6o7ndEfJj+cJvOdmX/PFyMBa91PZ/dM
	 3bz6ruubX9BLsG3LPjw9k5jFsB2Xy0tgm+YNOJG7jnd84yEEvmr2BVeqoEo4ikUmL/
	 TNj2KM4QKOtahLIJ2hkgs/WU7ZMP4wXo3uNtV/wWmauVuoMU/eCemtisFKziZjI0hO
	 rwun++iwrV1Jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 650B8CE160D; Tue,  1 Apr 2025 21:23:26 -0700 (PDT)
Date: Tue, 1 Apr 2025 21:23:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <62ef3d73-1a33-4357-925e-9c2fdf1ac8fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-10-paulmck@kernel.org>
 <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>
 <0cbd404a-856a-4bc3-ab76-eeb839065a2d@paulmck-laptop>
 <d03ed9d9f7d5e9d8fddca4071e044d26c55a10e2.camel@perches.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03ed9d9f7d5e9d8fddca4071e044d26c55a10e2.camel@perches.com>

On Tue, Apr 01, 2025 at 08:48:44PM -0700, Joe Perches wrote:
> On Tue, 2025-04-01 at 07:05 -0700, Paul E. McKenney wrote:
> > On Mon, Mar 31, 2025 at 11:53:25PM -0700, Joe Perches wrote:
> > > On Mon, 2025-03-31 at 14:03 -0700, Paul E. McKenney wrote:
> > > > Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
> > > > served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() APIs.
> > > > As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never have
> > > > happened had I thought a bit harder a few months ago.  Therefore, mark
> > > > them deprecated.
> > > 
> > > Would it be better to convert the 3 existing instances?
> > 
> > Both are needed.  The point of these checkpatch.pl changes is to prevent
> > other instances from being added.
> 
> If those are changed, why not remove the prototypes & functions too?
> That would stop more instances being added no?

Deprecating it for a cycle then removing the prototypes and functions
seems a bit more friendly to me.

							Thanx, Paul
