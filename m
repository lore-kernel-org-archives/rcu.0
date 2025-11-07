Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC926E6F9;
	Fri,  7 Nov 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534635; cv=none; b=upQyVKNt3wKfcrFOc2nxBRX7jZltGUIv/Na6hY0ymmKxl+If00kJABRoBAwUEYsr2UNSIZnkhiOh+EFTa/nFDUUA/wp6CDs3LF+EiTLvh8JeMDZIdEgRXLi/50DPtwf7JP5VvQ0YVYhwWV2wVrjdEkh82Yn9RrqVjlXU7TzDNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534635; c=relaxed/simple;
	bh=FC7BBrTdY+EiZ9gICXhEg1UmVOH+HVKMUlJ3F6NHaJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPeslnl/GIy0sIUfa0aV1z4mLZjgp0RoSYDvS96hqf+7Qmw2p0RqcTuOUb4yWoeQw/4y7HZvtX/b7C0RZd5uZ0h49a6IJIIwW286ebGHneqAfyxvWnpOkKJeHfMdFwRY2TBADTG9flrI4pUhhf80K1hF5lTaryenWCJwvkt86Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0+y0n4T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0+y0n4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F93C4CEF7;
	Fri,  7 Nov 2025 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762534635;
	bh=FC7BBrTdY+EiZ9gICXhEg1UmVOH+HVKMUlJ3F6NHaJ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=k0+y0n4Tal798IkvWqzhtQXPUlR0rZdYQgr2H4ncu/EvEskZFFGRjBGKhuNh7pRhW
	 UmiPVXIXJPzLb+7TsT17kYX7ALVyuwzpcb25g7dqKV6Bn59sFsl+bUvofQns6AD9Ge
	 G2dFWrQAXZWIlxzveP3GJzlsnW4cHUuQSQlK0HAU8MDNl5uH82EJnl7FrmlbQq1tgL
	 yXRYeB1xqoQAGbmgSdZQ3aJzcxIjQH32tVZZZhDDIOO8d7hsul4Wvr5wG2U4TWddyG
	 TjqdwrTf9STwGSZymawPrsGHj3nv1QTf30xokyxH/0j1KA7Y+p1vNDuTH7zDEg48I9
	 4F7xFg0Vl27+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C3A5CE0D38; Fri,  7 Nov 2025 08:57:11 -0800 (PST)
Date: Fri, 7 Nov 2025 08:57:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/16] SRCU updates for v6.19
Message-ID: <793fa040-edb3-47d1-8958-d40dcaacc960@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <aQvXA3A5XHn-Tjhh@pavilion.home>
 <20251106110610.44599177@batman.local.home>
 <aQ3qmdoxktGZRUiL@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ3qmdoxktGZRUiL@localhost.localdomain>

On Fri, Nov 07, 2025 at 01:48:25PM +0100, Frederic Weisbecker wrote:
> Le Thu, Nov 06, 2025 at 11:06:10AM -0500, Steven Rostedt a écrit :
> > On Thu, 6 Nov 2025 00:00:19 +0100
> > Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > > Applied to rcu/srcu, thanks!
> > 
> > I have issues with patch 10, so please do not apply it.
> 
> Ok, dropping it, thanks!

Thank you, Frederic, and apologies for both the delay and the hassle!

							Thanx, Paul
