Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16527EC7C
	for <rcu@vger.kernel.org>; Tue,  1 Jul 2025 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395465; cv=none; b=mb0bwVB3uTkSVbtm3ooBzEw1ysfTYpoyVmgiTDWcfcrH4jNU/r9D+fkL1L5IGyRb610sIT9DhcYf+24RjglhAS/Sh0L9sog/QHEjQtOPiTmNOAFntytgclqUJufo5IFQeZ8bYiDMajnKzB4E5DmhKtRBFOAb4zSDaPq0t/Upokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395465; c=relaxed/simple;
	bh=t9birvpLJlDyWpLgV3aEwz66oVgJL2jhscOtH1+1sxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ1xxLQyhl5YGcAxuEhGGjcgnY32V/GcW4aoYBRI6ZDSD2wUSFtPgsUBj05DMrnhZ69u8MGez0ee1Bp5DuI/QFQ1WwPC7fAVaOXDzw0tlx2N/KgaTBFHGU/KH3Et+WtoYhH5OtM9RfjCAW4XjsZfbBtn9tCIMS3ch/x2HWlC0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuLC6EQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuLC6EQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56309C4CEEB;
	Tue,  1 Jul 2025 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751395465;
	bh=t9birvpLJlDyWpLgV3aEwz66oVgJL2jhscOtH1+1sxo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VuLC6EQWF0fpVxFM5aKH73+kt5CZNZ9m2oxBhkzHwa0F53msQaOG2/Sr2FSpSkc8l
	 YtI3XzcXB83bmeKszCNtj3CJlYf5lZZMfG6rZjQzY8LevgA/piW6fgMsDUW0Rt99u4
	 pqTO0K8p4kWsSyWZ0F/gFPywQDxVg+16llopdy3BPBTgdRwwZzwk1V+HctptQsyFKC
	 kZ+ekE3IzceMUDmcT78JPRmnGHvDQVZJr3ta2lJNJ3o7alM69A8EwRsOOMTd9UUdHv
	 l2deQ1IZzKOjKv8+pIcaYOQ4bKVKHB+FpAjON6awYferEb+p01IjY5N+ew+ifMJMDr
	 jGA1YgCsWqCog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EED0ECE0E63; Tue,  1 Jul 2025 11:44:19 -0700 (PDT)
Date: Tue, 1 Jul 2025 11:44:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: Fw: Statement
Message-ID: <7381a6d0-ccbe-4ed8-95ac-fb228409f408@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7dab50cf-ec63-476a-85fa-6aa18995ad7c@paulmck-laptop>
 <11caba19-aeb8-4106-a097-89f6113dde08@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11caba19-aeb8-4106-a097-89f6113dde08@nvidia.com>

And I do appreciate their abilities as well, just in a different way.  ;-)

							Thanx, Paul

On Tue, Jul 01, 2025 at 02:17:59PM -0400, Joel Fernandes wrote:
> They did say they appreciate your faith in their abilities ;-) ;-)
> 
>  - Joel
> 
> On 7/1/2025 2:11 PM, Paul E. McKenney wrote:
> > They do seem to be getting better at getting through spam filters,
> > don't they?  :-(
> > 
> > 							Thanx, Paul
> > 
> > ----- Forwarded message from Carline Hood <zaqergrd@gmail.com> -----
> > 
> > Date: Tue, 1 Jul 2025 13:55:54 -0400
> > From: Carline Hood <zaqergrd@gmail.com>
> > To: rcu@vger.kernel.org
> > Subject: Statement
> > 
> > Hey there!
> > 
> > We have received and are now processing the latest order you placed.
> > We take delight in making sure you're satisfied and appreciate your
> > faith in our abilities.  Please contact us at any stage if you have
> > any questions or concerns.
> > 
> > 
> > Carline Hood
> > 
> > 
> > 
> > ----- End forwarded message -----
> > 
> 
