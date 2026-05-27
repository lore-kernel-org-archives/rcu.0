Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4012D1F1;
	Wed, 27 May 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924159; cv=none; b=qfv3GyX1nXSBzSbasrU1UhVMAh0x3pI+q+usaOS8lyERSbrX57I3tjz++s3Z5zhs8uOo04LpzemtB4oqyCrdDyFD0/tL1b0SwrxgoM1nqFrmpQCmIwmqSBKzTj55Ns+UPWr6bdEJ+Fg6urwmgg1u3imNZrOCxZEw6KX+r8crFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924159; c=relaxed/simple;
	bh=fqVXRwFv1VvmgpE1kXVkKHPzDD/7qNHrTERs/lFKw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks55tEOkQow+XbzOr5sTTJC8Z4X4nAKbFq8xYGBdwFUacm/84TRCRscCORwfaIn45WbvDdVKD64Lq8muEgPUbDa/cUMekgsyeDVdjuLVoONezh5N4APwaYhHD7hE/XVHVRgwyF7MQAiBbCj6eMpRhsvjlyIzaZUIQ37SXqEwJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haOQRro+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haOQRro+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39CA1F00A3E;
	Wed, 27 May 2026 23:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779924158;
	bh=j1xyI7P+WTp/P9Rk6Kt/53SKQtT68HojHWUUChNsPVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haOQRro+gmdn35n8YxSKV0Qmf5UJslNLNPs8O/Q0XDOLR2bb8juNxnnV6GYvF3ex4
	 UVNzR9cB4U0FQH9CW7IhjXxAu4ZYRdghrNXDyoXNvCxlQao4dzrjdn954ovIAi9V7b
	 Rl143WgtYAViUws+94lmS+3FX8CwyZyv4tKxaZzw8gBzzd1ZmqxdWp18lKd1NNgweY
	 VJ4N16BvjCItmsQesVK6MpoGYyq89ABGNwWhw7A8FWC9ETt+LAMa9C97QnElDPIUaU
	 iytyOYP7Y/BEd2yzQYsOGzxXw3cW1lldhQL31/4X5UphQRgpV1mbZ06dE30rYAbKq9
	 Sm3x9mOgs4okA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 06CC0F40068;
	Wed, 27 May 2026 19:22:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 27 May 2026 19:22:37 -0400
X-ME-Sender: <xms:vHwXavHN_52GM-JTAghd37gjRGAQtCOzJvgotPz_O7YL0yXzIgzUHw>
    <xme:vHwXajbMeLEoBzoTC1psxBHejdc_JDNnfPt7a_1sF2PyYE6IKZ_S0LK3hkyrjiTnJ
    R0QW27ZgPFpJEdKn-dt7poUNaiCDfWu5FtcIfBRqjIB4RIXEm649Rk>
X-ME-Received: <xmr:vHwXao2YeTf7qNTvHTrqgnP3ZVccC0lubw67slLr03zZNrEHfYMgldzw9ivjHGHUzWNbjaaFIbyCTH6-QMF4rwSx65exiT0b>
X-ME-Proxy-Cause: dmFkZTGJId6qr8MHe7lb4Vx+MRl0oW9QQLk5HNc0vGM63bzHRLNKLK45wHmEIDfbJtwmOd
    IdFXFQ1ZQL1kMub0tzqCFZ9mVLiQKDJsypUttJAsoVYDDf6yRs91BsXGya+CY7TK4rZx5d
    tTkxZGUCuV/YdWlTDyjBfopFYBOKsHcalX9iPH+Za7DMqFdkeFpCDJYcGn1r49cPJZzcmP
    u3JgLC4G+j097ahr4EbDPw8BWx/m4ynSjuBhQysab2FZno5qgWkITelhJuXnrvR54hkmYQ
    5eohNKNzRG+vFKwbr8gIE3lrsHAW+J53soPa1IODuTOcmi39lCeQ6PrU8RyaXpUbyMo0cK
    1FZ0FYJGcWByqW2CNIySRQtEFSmQPR7nERvnJTUQoXY0gfkzM1AJOYGJlZR67DI9SjaHwC
    g8H7XYF+TxtC+BSnYUh62x5hpnqCd72liu6123U/wbkRbRmuGvlpItNPNo7ePvC2oFbaoa
    NgrdrnbZMZf6J15WPm45F4dVSM85QwuoxNeh+kmgEGByURMmb+VNR/2LKav7Lq1k/Y4reY
    5lpQdrSROgBA85UL98LRtaI6hJs96DMiepWWLmQyMLsOqxcXqN7grZRV/N3kHQIY7dla76
    LbrUWulHdRLlhUzrqpgbl3s/wvX+77v1OtNl1OfqzyCQldKtIoo3MN+05NjQ
X-ME-Proxy: <xmx:vHwXajdW349LM0D-lMo7TabU-DLvQoRAt079Y6rKKQWM-pzduS8MEQ>
    <xmx:vHwXaiAt-5QPGL7KGCqWiSNwBTgWsUZrdeDtsgXaeUrUVR2TMBwWjQ>
    <xmx:vHwXat2nzhDkLGz2iMgaNjtLONbKeKSbpaYbCfLpyT3hF2Nd2FXgNg>
    <xmx:vHwXaqMLudM5ENtrANeIjZbzwpNZqFfBYDEI1wV_4Qbpt7bcGoXV5Q>
    <xmx:vXwXajcOPiUl5dVro4UiKxg6k9FR3DZBLxenfjCq5fHyh8h8QTfj8CaS>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 19:22:36 -0400 (EDT)
Date: Wed, 27 May 2026 16:22:35 -0700
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v6 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Message-ID: <ahd8u-GGfpT03qsj@tardis.local>
References: <20260527203615.163688-1-work@onurozkan.dev>
 <20260527203615.163688-5-work@onurozkan.dev>
 <ahdw348VjaX70b2x@tardis.local>
 <7bf56f66-a964-4d83-b3cd-ab1504f306d0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bf56f66-a964-4d83-b3cd-ab1504f306d0@paulmck-laptop>

On Wed, May 27, 2026 at 04:06:11PM -0700, Paul E. McKenney wrote:
> On Wed, May 27, 2026 at 03:31:59PM -0700, Boqun Feng wrote:
> > On Wed, May 27, 2026 at 11:35:35PM +0300, Onur Özkan wrote:
> > > Include Rust side implementation files to the SRCU maintainer
> > > entry.
> > > 
> > > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> > 
> > @Paul, could you help review this? Also the patch #2 since it changes
> > the C side.
> > 
> > Of course, your feedbacks will be much appreciated for the whole series
> > as well.
> 
> Done, though I am leaving srcu.rs to you guys, unless you have a specific
> question for me.  ;-)
> 

Thank you! I saw you left reviews on v5 and I just want to let you know
that in v6 (the latest version), my comment on patch #2 had been
resolved.

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > > ---
> > >  MAINTAINERS | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e0b307b2108c..7739a435f258 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
> > >  M:	Lai Jiangshan <jiangshanlai@gmail.com>
> > >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> > >  M:	Josh Triplett <josh@joshtriplett.org>
> > > +M:	Onur Özkan <work@onurozkan.dev> (RUST)
> > >  R:	Steven Rostedt <rostedt@goodmis.org>
> > >  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >  L:	rcu@vger.kernel.org
> > > @@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
> > >  F:	include/linux/srcu*.h
> > >  F:	kernel/rcu/srcu*.c
> > > +F:	rust/helpers/srcu.c
> > > +F:	rust/kernel/sync/srcu.rs
> > >  
> > >  SMACK SECURITY MODULE
> > >  M:	Casey Schaufler <casey@schaufler-ca.com>
> > > -- 
> > > 2.51.2
> > > 
