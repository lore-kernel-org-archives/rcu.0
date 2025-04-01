Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745A2A1BF;
	Tue,  1 Apr 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516313; cv=none; b=c6/ygWjGl1wMzIt2H8rCKKhAMz+SVD1HBe05LJItDk8QMZ6KkRuuIligmztQYNVORhzBI2pqj75pQ0unKGJBr/bDUSIhqGFLlKj5NlKJzKlKjzl72aELX16Y2KtjJufBXey3+LSPsahutAmpdPuKbfN95n/de34npMRUlFBEASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516313; c=relaxed/simple;
	bh=YziPmtCreaxBJzVwx7Ym3Kbx4JMxuBsOjY2qWVUatUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3DlopNJwfCNZPBH3uKsnMG22iQy+70530nbOb+lNduwhZnXpOzS+bEx5gzhGufuwLQFpENVXdsVIfDCDYe36UFSYYlcGZHVlH6QFKDADSrBF2uw5HzNsVGviS0FA5TTITysvpzH/wb6gdLaOgI/iNGxGd/ZN6Fe0PxIjlAMRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OetrQrVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OetrQrVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54500C4CEE5;
	Tue,  1 Apr 2025 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743516312;
	bh=YziPmtCreaxBJzVwx7Ym3Kbx4JMxuBsOjY2qWVUatUE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OetrQrVKoZ4gZPiJMhJ+qQJzd/gkhiswWDugI2/Du/qPLKbeiH/E/44pwJ6TxyFYs
	 cpAQ6DJihrckHqeJB/XnitynGrdR1ViTpqC9td+Hrr7ja04vdM52IqfYESByP4axd2
	 pZ4J913Cn/mncnMhU8AZENZM1MDEgnRTX21yI9D7aK9qGWzpTnMZ2Ov+j1sBg2v0o+
	 StMAmhu6tGiS24Mt++5oNqC7NhmE7XFbXXdTRVXsf7HZiFUaoxymLKbNSH+RJ/s8LJ
	 /LMOKK4az1Ywi7zCJWkgspyfaEunef1J2v0I9NfHtCc0Lx8LlyAm35HWeWkZV8A0KP
	 vnnVM1b9mXxvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC511CE0869; Tue,  1 Apr 2025 07:05:11 -0700 (PDT)
Date: Tue, 1 Apr 2025 07:05:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <0cbd404a-856a-4bc3-ab76-eeb839065a2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-10-paulmck@kernel.org>
 <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>

On Mon, Mar 31, 2025 at 11:53:25PM -0700, Joe Perches wrote:
> On Mon, 2025-03-31 at 14:03 -0700, Paul E. McKenney wrote:
> > Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
> > served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() APIs.
> > As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never have
> > happened had I thought a bit harder a few months ago.  Therefore, mark
> > them deprecated.
> 
> Would it be better to convert the 3 existing instances?

Both are needed.  The point of these checkpatch.pl changes is to prevent
other instances from being added.

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  scripts/checkpatch.pl | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 7b28ad3317427..de8ed5efc5b16 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -838,6 +838,8 @@ our %deprecated_apis = (
> >  	"kunmap"				=> "kunmap_local",
> >  	"kmap_atomic"				=> "kmap_local_page",
> >  	"kunmap_atomic"				=> "kunmap_local",
> > +	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
> > +	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
> >  );
> >  
> >  #Create a search pattern for all these strings to speed up a loop below
> 
> 
