Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C04EF152;
	Fri, 16 Oct 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167147; cv=none; b=se+V4DwZN3wuv/8/FwkL0yfSZvjlBbnTvrTcU4b1CLD5AR+ADjd/4A9K3YzkV9fYg5KYGaLntXT4gGIxHFyah84eDWapHI+MsaWzMynvmwnng9wvknz7MjJFi/xy3AcGq8RsUjZ7vzEmtKk0PiSntgF0HOO/0NfGiySbtOK6NbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167147; c=relaxed/simple;
	bh=6p6k1tESHb6KLOyroOCrQTVD9xoFJZXMURVK4JcZqRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFla6t65GH7Z6Q/DYg74S0YypXuHCpq6miEUovTKQ2kJrOelzExuUsk1K7NucC2X+Cga2MRDlSokXbksn027dIHVdVrZPK5WmlHd8hsz5ySbfpB4apnR5NQ+Ij21nUOoCKpD73biY5K663n7og2C/IUFYvcv6ugof8fZEAvTjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu84eWNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu84eWNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EA41F000C4;
	Fri, 16 Oct 2026 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792167144;
	bh=BkRKNTsVNbs/xZi9aRNbP/sFK8QUWl/Yq+okInPou/o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Nu84eWNGsZIlwjZlO/A878R3/4HqGFugQF4mH6MMaM73/tYkY8fCiA10Wv2wN5G5y
	 6Dqw3iaZVRtThsKTq01RYaziz9dRanAvn/5iKGpkiXBRnTNfziRlyf9pucZWCMY4BO
	 Zg0rijBwnka1MY3PHyJfWyOXZg9N/qN/eaNoFFYbMMIHlwf/MJeMinEoiyZ3k7Vtwe
	 5G/RRSlpf52I6qVcJJA1lgBaROQ1f7vHqiFYT3WC4GuSqz5oEXIFMQukC+lks4s99A
	 dmwcRKBDGYPMWfk5nXWgPvkE2toeu266QvbiYo6RrZ7x1haQXpy5UsrVpJxQxO6rAM
	 C6E6rbUjdp8uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42C4DCE0854; Fri, 16 Oct 2026 09:12:24 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:12:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: KunWu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>
Subject: Re: [PATCH hazptr v3 1/4] hazptr: Fix two-phase hazptr_synchronize
 race with detach
Message-ID: <9fe81762-af07-4161-bc87-82b369540a66@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
 <20261011194902.97364-2-mathieu.desnoyers@efficios.com>
 <CAN_Opa-zH=+By+Qrsrg3W0prQPNv17xCCh_n0CzfimUB9__obA@mail.gmail.com>
 <c38a5c3d-ad8b-4cb4-8ef3-a9602a1f3c38@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38a5c3d-ad8b-4cb4-8ef3-a9602a1f3c38@efficios.com>

On Fri, Oct 16, 2026 at 09:41:12AM -0400, Mathieu Desnoyers wrote:
> On 2026-10-16 04:24, KunWu Chan wrote:
> > Hi Mathieu,
> > 
> > Scanning all per-CPU slots before the overflow lists
> > addresses the race where a backup slot can be moved to
> > a list that has already been scanned.
> > 
> > Using a separate overflow-list phase also decouples list
> > selection from the wildcard phase.
> > 
> > 
> > Reviewed-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Thanks for the reviews ! I've picked them up in my own local
> branches, but it would be best if Paul can add those 3 review
> tags into the commits he recently picked up.

I will apply them (1/4, 2/4, and 4/4) on my next rebase, thank you both!

							Thanx, Paul
