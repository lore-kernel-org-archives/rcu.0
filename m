Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CD1BF37
	for <rcu@vger.kernel.org>; Thu,  1 May 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114459; cv=none; b=mjBouB1Rub3JttBgVUsVz4cTYXtnHcaaEOQKUTNMFYn3vD/VcuTK7tWrUEow9VmCSwTMAwfn288Y5oWvq4ayGpfjfP+jhn/PmnNPoSBnbhQ6KEZrBwbpvkVA/js/+DpUOtpfYNxvqS5HPCetRSjt+xopd+6mvcy8wDgvVhFE+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114459; c=relaxed/simple;
	bh=6+QK256qzDrkJzLh1qTPoA5Aybl/kL8wWZbdARkYNew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW/iLyBGPh0dp2NzDMBUqKvocn1xgPfVLJFySVGabsScGrV6mExkB6/bzLLUpnZ1tKjHplq8Cs0VByaeE0Omm3VPuZLvM4MPnkd1qnAFI2hJS6zzsHAl5SD0K0Ro1EfFFci1MoIA1kFpFvH6kXQz4xRDLLxXLYZef+AyAEYCxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD7RWXzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD7RWXzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4755C4CEED;
	Thu,  1 May 2025 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746114458;
	bh=6+QK256qzDrkJzLh1qTPoA5Aybl/kL8wWZbdARkYNew=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nD7RWXzCkWwPBlfBJ8aNn1Mw6BSaaTfhdJBeUgvMY5v3p0pzQF+uC4+5M3lk0bGjc
	 zuO/zi2VE4nfi9dcaBCVu+9lN9yRGU45TCrpYuzQi1OwWPz/CvVZmrB6c5uBVM9ZSX
	 yWK1GQFMZbNWu8lr3jlYBh9ntOeYftmeJODtsRoy61c63V7tIGR/Fo5RwlAP7rNb+d
	 ra6OXTWqeKBKa+IZy8Oi6VqS5kR+5kngDi3hXvSTGZ9qHWWJ+F+gDwOpW65UrWf4mP
	 MpkQCOm1sxxGByXGPdxH5PJSJjLOHkLu8O/ctZ++VlUBzaWPWOE5115c5gWus52ua2
	 Xhpr4K3vGkdhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1638DCE0875; Thu,  1 May 2025 08:47:38 -0700 (PDT)
Date: Thu, 1 May 2025 08:47:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>
Subject: Re: Overnight rcutorture tests pass on ARM64
Message-ID: <81416100-45bc-4dc9-be17-21e2973410c4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ce1f98cb-265d-4415-b9a2-39c9d4116af1@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1f98cb-265d-4415-b9a2-39c9d4116af1@nvidia.com>

On Thu, May 01, 2025 at 08:25:30AM -0400, Joel Fernandes wrote:
> Hello,
> Just want to report that my overnight tests on [1] with rcutorture on all
> scenarios are passing.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
>     tag: next.2025.04.29a
> 
>  sudo ./tools/testing/selftests/rcutorture/bin/kvm.sh --duration 720 --cpus 288
> 
> As such, I am planning to freeze new patches for 6.16 (except for maybe Z's
> patch fixing the nocb warning) at this.

Very good, great news!!!

Could you please from time to time test merges with linus/master?  If some
merge conflict or bug appears, it is good to catch it early.

							Thanx, Paul
