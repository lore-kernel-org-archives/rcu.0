Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859512;
	b=SVcYExK7H19JLnHhDQVcxAufXBQwPfxd2HUgohnCX18xgrWSqgmQWot5XL0lhlaixyk4
	 dHEe+CcGs9qLjsMFW625hhrkAu8SrnU9HltEMeQp/i6HL8/9HP5YMlWqh3N4qZQgOq5NG
	 WBQuYGjPDC3MK70S4uIJawm3GFB0+JN7WDeScKHQLTgmnEuftow+13C+jONp2JO46VdDG
	 rJHyvIB7GwVfbmMf09frNYHPpC/pejNVEHXl6mP+hfLogmITvmbEnNC06Lu5jFf99sS4y
	 7dBauQmJg4c5CPI7NSdsTqLk2mrfNvncY4//2xpp53qLF9JCRrdbg+zhZJI4hCtYXMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859512;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=uEWXI+bCr932Kv0ojBZory4V5QpCmPMD+awXAwZTgLA=;
	b=SzsIdhJ4TBQ8QK9pvjPIv9RAdtMSIojjPF4NWBOoS7BLY1bt/Be/Upqvz9tkrBpaUwAp
	 gfFZ7HKGtYwO3CBdmbSzZOCYubuFzKb2osUyiZhEsvCkf5d/ck2f01WK3ElEApSQ0DMZc
	 /XL8LQDO0EqN9K62GLFhxSKDUFVnAm3PzP5e21zZ7s78tqcZMXX3rhndPQ6fqMxQsSKUq
	 2nyR0f2PxwaZrepnrNyJwjomAn6EX1PnmcVSPWhXIuxksluzpdsVcWjOHET0i+VyNM/Il
	 E81NFJuru2USH68D9gvrZdKkeW7mlZ/rzfye/az6hfCQKqMZhZ1yCqGdNMpQx4rDNYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BlO8bU/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7848606A334;
	Mon, 16 Nov 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlO8bU/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693641F000C4;
	Mon, 16 Nov 2026 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859512;
	bh=uEWXI+bCr932Kv0ojBZory4V5QpCmPMD+awXAwZTgLA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=BlO8bU/xPezJkHRRl30zTIGxQgyjZUU2st3CeJrVmeAmUnqRPy5sJjB2mV7+SIu/c
	 GbZPvl2BsXMIOs17EIduu5ixuad8Evq3OKuoeozKI9yT/oG3HYcqHiTDyox6K5FvIF
	 X7pZwriTkr2Z14eSPe6NZSVZW3O5c3IPAPeyTE8fdVmNwtyuFoGCorkDtHO0E6QPfR
	 pzmsWeqhCGMzyRdQkB/EcJ6CGC7MwDhmTKix6t9rQiM1iWncCEjuEW+uwiqC7PyrUy
	 y7Vsp1feayyjQJzAxOArLb/xWnJU/vKbHxAI2cGg9RorJZGx9QGf3iQVxKG5+fykhu
	 ncuvKfT64lBow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2FB5DCE097D; Mon, 16 Nov 2026 12:05:12 -0800 (PST)
Date: Mon, 16 Nov 2026 12:05:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <jfern@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/6] Additional miscellaneous RCU updates for v7.5
Message-ID: <968ab9ef-afe4-45bb-bc5f-3ec8f2b2c1e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
 <20261116190040.GA946893@joelbox>
 <e173f3b7-de3b-4b3d-b0dc-c12a091c9723@paulmck-laptop>
 <CAEXW_YScx57GaYLgUYXVGFm6vq-_eayhJCv4SCKTqhOaspJEmw@mail.gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YScx57GaYLgUYXVGFm6vq-_eayhJCv4SCKTqhOaspJEmw@mail.gmail.com>

On Mon, Nov 16, 2026 at 02:50:10PM -0500, Joel Fernandes wrote:
> On Mon, Nov 16, 2026 at 2:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 16, 2026 at 02:00:40PM -0500, Joel Fernandes wrote:
> > > On 11/16, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > Hello!
> > > >
> > > > This series provides additional miscellaneous updates for v7.5:
> > > >
> > > > 1.  MAINTAINERS: Add Puranjay Mohan and RCU reviewer.
> > > >
> > > > 2.  Make torture.sh test NMIs for atomic SRCU on x86.
> > > >
> > > > 3.  Avoid duplicate identify_qemu_vcpus calls in torture.sh.
> > > >
> > > > 4.  Make torture.sh test NMIs for RCU on x86.
> > > >
> > > > 5.  Make kvm.sh ignore empty-string arguments.
> > > >
> > > > 6.  Use ${:+} to save a few lines in torture.sh's torture_one().
> > >
> > > Thanks, I will apply all except 2. and 4. as they depend on Mathieu's series
> > > which is not going in for 7.4:
> > > https://lore.kernel.org/all/20261112133731.127221-1-mathieu.desnoyers@efficios.com/
> > >
> > > For the others, I have replaced patches which were already there (in 7.4 next
> > > tree) with the new ones you sent, with updated tags.
> >
> > Thank you, and apologies for missing that dependency.  Distractions this
> > morning.  ;-)
> 
> No problem, though you might have been secretly testing if I was awake. :-D

Yeah, that is it.  Of course!!!  ;-)  ;-)  ;-)

							Thanx, Paul
