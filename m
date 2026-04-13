Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AE1D95A3;
	Mon, 13 Apr 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113823; cv=none; b=VaFw3kpxtIxwVSwZuRqyKY4b6poWlpTBvQ4G67gLQbCDftQF1Bs7iPKb4ZmRwBs5UVCm8UXtDHKAtTL3aIMT3ekUMsvqxOvnsuIfmMdqTba1EOc4QCvc2HqF8tRY2uf7oN/6LQHJOKC+nHoYTbu6fVXoIsDk7q0nlmNheC/uXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113823; c=relaxed/simple;
	bh=/NZQBTrS4aXNzbfYy8WACG21jhIaiCNEjTekbtLr524=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYr/MqHGdinSLNZ0ehzT1PXLaCwF/lcVnLahtne1DoOU1cf3Jh09GH2rF+W3yLF0wqEN7cSE5FSrHcSPiftzTQtsR60J26aCuTmJzIDoTj1PQvHdZlv/aDh/KNhczkeovkWEUm2IcRM73aNmZqaaWoTL2BA6DX/y2F+5EFl9qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjfpndEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjfpndEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535B9C2BCAF;
	Mon, 13 Apr 2026 20:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113823;
	bh=/NZQBTrS4aXNzbfYy8WACG21jhIaiCNEjTekbtLr524=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IjfpndEdmd27Lh6J0oYM4KlhY9ZpbIGzz/JEE2m/EXIFuMEz1wLJI6L990nlYabKa
	 l8CG/xj5GBlFmyF70J0QDB1+DTrOwKnyRrASrrUeziCjQcTBmCrSZa7bWyzbJLMLIv
	 8HjiivO9OHbEJ2sifjiUlth+2bnkx4+e/I4kgh5Ee4i7x34RWfEmQaivkZThUeD0qu
	 p2I+N+C/cy9MPRu11G8n7MPB2QMdDwlv8u+JfnNQ+SL+c7b16zaf2hsstBSBBaqHqJ
	 0IYHsYLFc0PBqZjiRbwRNW0w3RO//i4ZJi9HCt29H6Qq36y9072/qKbSV3/ZXMy3Ql
	 OrS3Hp0LN+SQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6765CE0A6A; Mon, 13 Apr 2026 13:57:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:57:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
	agnel.joel@gmail.com, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v7.1
Message-ID: <0e3dad78-75da-4fd6-ba9a-873b3343c140@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1774978730.3972500.27807@nvidia.com>
 <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
 <cefbf713-0b88-483e-89f2-2589919adb89@paulmck-laptop>
 <CAHk-=wiVy8iHJxmkCrFggEtBrAzqXTm5cgt9xcKvrhFoMzhD+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVy8iHJxmkCrFggEtBrAzqXTm5cgt9xcKvrhFoMzhD+w@mail.gmail.com>

On Mon, Apr 13, 2026 at 12:38:32PM -0700, Linus Torvalds wrote:
> On Mon, 13 Apr 2026 at 11:03, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Apologies!  Would making this instead be a kernel boot parameter be
> > acceptable?
> 
> We already have a sysctl for it, and you should *already* be able to
> use a boot parameter for it with just
> 
>         sysctl.kernel.panic_on_rcu_stall=true

Thank you, and testing is in progress.

> Not that I've tried it, so maybe there's some bug somewhere (or
> something I've overlooked), but I really think the whole kernel config
> option was entirely redundant to begin with.

Given recent improvements to bootconfig, using the sysctl kernel boot
parameter should be just fine.

Before those improvements, associating particular kernel boot parameters
with all kernels was often problematic in large sets of datacenters.
Even worse were cases where kernel boot parameters needed to be set
differently for different kernel versions.  But for most kernel boot
parameters (including this one), things should be fine now.

More work is needed for early boot parameters, and that is in progress.

In this case, I simply failed to get all the pieces in my head at the
same time.  In particular, I forgot that you can specify kernel boot
parameters for sysctls.  :-/

							Thanx, Paul
