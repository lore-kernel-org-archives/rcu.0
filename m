Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98A5172CB
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169434; cv=none; b=JCeroGGEyd0+709rIW+5035tD3COMn6YNorWC0IDMi3ObuqeNxc9tcJcLPRknh/LFITwAss3LX8RGnD/2v009iTF/0JBe01EoQXkLyjM527GztP7/ZxyDfa4Pt5J6q8UI64KlIfEyZJ4WUukbilz9L2AnyDeQ4FXxr2CwPGnloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169434; c=relaxed/simple;
	bh=KVMSLGPRO2+7PVAHB/n0RyjWbbJzhjMW/9+O3nUaQl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZDXKGokjmT53cUNcRDKd9Ey8rZ8HtzTwzYYUmMXX5YwSvA65DW5B8tQY0oOstHGeRyUN+CMvxjyzRi1xzDQBE/+3MTQVzWM6r8+byxI6EPM4kxWMOq00aYZ9j2/CfhinwoWmtDJbjqP2Wz+MsqK90dVZ/1VivDSc9jI/tbwk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSgrZu34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSgrZu34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C4B1F000C7;
	Fri, 16 Oct 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169432;
	bh=/cI+PMB6gO5WFUYroeEAdKvBdqsQC/M7jhQ4SzXUUbM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XSgrZu34hkvMSDqO2dND1QkBU47EmwTD8xW7UxpQnzpEexCF0jfQ97anCxaKqYiiu
	 YfGhsC52u4pCwKwki0t9ItLNNQlFhY/CHVrQtcGJ+7IKuukffxm+XaCmbss+5rwuvc
	 QtPU03Opq1rkp0HG9xUTndgixU7s/LcxIktnEWrl9eDO2qijSpeX6BSdUke+x24kEm
	 0pdD5FYx5tvtFAF9+a/229VAd6zuveLdo+f2qdxL2Rz9KeFtzRYsMYgwMI+lzNiJqN
	 6uE6GsCB5oMImnpR2axXUaz/MvN2sUmvP+yFILEUrpitwoOrMLh9e8QHmD0dj4DyUB
	 K6nAlwDz5hegQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F017CE08CF; Fri, 16 Oct 2026 09:50:32 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:50:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcutorture: Ignore KBUILD_OUTPUT in kvm.sh
Message-ID: <d3d15a05-149c-4027-9e97-6adfb4659be0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016102657.2347381-1-puranjay@kernel.org>
 <b18525e9-0508-42f3-8640-3177c5581926@paulmck-laptop>
 <CANk7y0i3CELP=xfu8vr4O4_-8ui9v4Odc3VimaSsw1nT16ub6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0i3CELP=xfu8vr4O4_-8ui9v4Odc3VimaSsw1nT16ub6A@mail.gmail.com>

On Fri, Oct 16, 2026 at 04:22:03PM +0100, Puranjay Mohan wrote:
> On Fri, Oct 16, 2026 at 4:12 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Oct 16, 2026 at 03:26:56AM -0700, Puranjay Mohan wrote:
> > > kvm.sh builds the kernel in the source tree, and kvm-build.sh and
> > > configinit.sh expect .config and the build products to land there.
> > > With KBUILD_OUTPUT set in the environment, make instead writes them to
> > > that directory and fails with "The source tree is not clean" or, worse,
> > > clobbers an unrelated build.  Unset it so kvm.sh works from such shells.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >
> > Good point!
> >
> > Should it (non-fatally) complain if KBUILD_OUTPUT is set in order to avoid
> > silently surprising any users expecting build products to go elsewhere?
> 
> I guess I am the only one!! :p

Well, the only one who has complained thus far.  ;-)

> If you think we should do it I will send v2.

Please!

The other alternative would be to make these scripts correctly handle
KBUILD_OUTPUT.  Which is probably the "right" thing to do, but might
or might not be a reasonable thing to do.

Thoughts?

							Thanx, Paul
