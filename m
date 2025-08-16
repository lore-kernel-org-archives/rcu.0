Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73DF510;
	Sat, 16 Aug 2025 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309763; cv=none; b=Ab7M2SoqM3LBVJCoO16ta/Ey5sYbzfbAJwu+4wPNdnw+SmTbwcbXlplsjJceh+XOVurJRLuu40uYOTgsqMcua9ya9Rwb/dJ0hT/a+wRsRDrXv/gwmcSb7mpnD4v7PKSHcIZIZkR+2EgJ6CAkKyjwmitSbNYvpjNcEwCyTljrOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309763; c=relaxed/simple;
	bh=sGUNgCY385m7isyqgtZnYnEdpgyJMVjKbw8JEVSVPFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij4rEde9lqorba578nmne97SF8jIuUdniti6aOoMVyFtZ7d9ZooIoWLzhZeeu+QFII+1pzi1zy1QtpdRAGc6q+Qt0urepayd0Lxtoc9uecQshe1EXtoaHVekUhoZZ5e/wvQ99GtwHOC0o7OhLF6pr791XDjk35GboweqDiSYoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwG48gnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwG48gnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE19AC4CEEB;
	Sat, 16 Aug 2025 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755309762;
	bh=sGUNgCY385m7isyqgtZnYnEdpgyJMVjKbw8JEVSVPFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KwG48gnxoeSXrMw3AxUJzMXT2S4l2yi8KXVPznqjaR5ZQxa756gxX1Xi0HH75ItSB
	 meRovvhc2tjM6UJzfzfT66tNum0lY1Aa7cBWxwuDy2VgnaoK/b1rio3O2JIsL98U+p
	 Z4Xs1JYzHWii2mcX8aN93LJhzYYT3O5dG3+j8sWsRKb85Q9OG29isH2X7AAwGqaFOg
	 IGkUlceX1iP0/0coh2K7afmzDq1Gu7gY+AQsOrALmBzvFap4OJeM5VV29qSE1UxVPg
	 OEaBMY/lasM82y/YpU0M8vDKGKV78WlI3jLSgheORwbWM2za3jagJyZoY/Cz7dQTKh
	 HKZeiYVhbT3IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C459ECE0ADB; Fri, 15 Aug 2025 19:02:41 -0700 (PDT)
Date: Fri, 15 Aug 2025 19:02:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [PATCH 3/3] rcu: docs: Requirements.rst: Abide by conventions of
 kernel documentation
Message-ID: <b77cceab-d374-4b20-b330-2dd4c0826ef8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
 <20250816000007.2622326-3-paulmck@kernel.org>
 <47d4f9df-4fd5-48e6-9769-58c6d6497620@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d4f9df-4fd5-48e6-9769-58c6d6497620@gmail.com>

On Sat, Aug 16, 2025 at 10:30:24AM +0900, Akira Yokosawa wrote:
> On Fri, 15 Aug 2025 17:00:07 -0700, Paul E. McKenney wrote:
> > From: Akira Yokosawa <akiyks@gmail.com>
> > 
> > Here is a list of conventions applied here:
> > 
> > - Don't mark up function names, to be taken care of by the automarkup
> >   extension.  Just say func().
> > - Instead of ".. code-block:: none", just say "::".
> > - Mark inline literals by a pair of ``xxxx``.  Don't use rust doc's
> >   dialect of `yyyy`.
> > - Instead of emphasizing headings by **strong emphasis**, use sub-level
> >   title adornments, in this case "^^^^^^^^^^" and make them proper
> >   sub-sections under "Hotplug CPU".
> > 
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
> 
> Missing S-o-b of Paul?

My fault when pulling in changes from Neeraj, will fix, thank you!

> Joel, I'd rather like to have your ack here.  Could you?

I would be happy to add that as well.  ;-)

							Thanx, Paul

>         Thanks, Akira
> 
> > ---
> >  .../RCU/Design/Requirements/Requirements.rst  | 52 +++++++++----------
> >  1 file changed, 24 insertions(+), 28 deletions(-)
> > 
> [...]
> 
