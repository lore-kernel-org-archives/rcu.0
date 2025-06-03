Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062364C74
	for <rcu@vger.kernel.org>; Tue,  3 Jun 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986559; cv=none; b=Qn0iu8lzIn25NjvRLLqux7kSYi8Pk/uzRzlTO17La97n98yBmum3uyff71hhzMASnU0oX+d19q8veG7Qdegwa7T2h2BC07ZMLN4erTsUzS5uV0RkT09jaLKws24KpZanvvHJkAa9R9dfNyrx9hxLNxUKCwXV/MBABfAaMpIQn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986559; c=relaxed/simple;
	bh=g9E3CjjkfLQ8l5gECZjPIK6ZKAVG0UCsDee9LZeGJ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z52zo9+qk1HZlR4CTmqm12C7BwICC7QE264OQi5lBGlDjfcxY//FqpHE1q70JLKALP7dzi7g/fwv2U1k/B4vMT1YXfFv8zkEYDgAjXK381CmAuDAA6pf0GZoMfrYKSkxOGZfX8jX3SQ7slZs8ha0flw6OubmoXO5RSvhBgBhU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs4uacen; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs4uacen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65173C4CEED;
	Tue,  3 Jun 2025 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748986558;
	bh=g9E3CjjkfLQ8l5gECZjPIK6ZKAVG0UCsDee9LZeGJ4M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cs4uacenMPEMyZvlEU+/v2z6uQks+Alsg3utngN2QuE+d8rTsPplnb6sFC6/HXbjY
	 2+evtrgm3naatNgRI71Nl+gGp1R3Pnt9nJwNwZ0ua2wjpBoMos2HcI4AevcOTfOfFv
	 9DAP8mUih0U/u4iBei3twDh1kkbJ6ZrY8fB5WkjBje+7sTPk28Gsk0N/dqHZBxySLk
	 llFcHxUeDCYFL71ayIgkhMIFbjhhXQmZtNCShMwcDFKQ0dxaL0GxQQauH0DW5ZD0bj
	 Fk1g+w5b5hf73IINDF9nnzW35T1krbA63uvKHgUXMq0j56FBtAglWrXEMJmdDhNiv2
	 rjpwb1jkLJVjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F32ADCE077B; Tue,  3 Jun 2025 14:35:57 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:35:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: RCU patches in flight
Message-ID: <3dcb2c76-c9ee-4963-abf8-984237dbe0b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
 <aD9exNsGkKng3ac5@tardis.local>
 <4e2211c9-d0ed-4c51-be9d-763c9eef370a@nvidia.com>
 <4741ab72-7150-41c9-b214-b4c0f883ae3c@paulmck-laptop>
 <aD9mTodFDv1rkYlX@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD9mTodFDv1rkYlX@tardis.local>

On Tue, Jun 03, 2025 at 02:17:02PM -0700, Boqun Feng wrote:
> On Tue, Jun 03, 2025 at 02:11:25PM -0700, Paul E. McKenney wrote:
> [...]
> > > Paul and this one too? I dropped it from both my PR and my rcu/dev branch:
> > > Subject: [PATCH 5/5] rcutorture: Fix rcutorture_one_extend_check() splat in RT
> > 
> > Good catch, but I do have that one in my -rcu "dev" branch.  Mostly
> > because I was lazy and never rebased on top of your final pull request.
> > 
> > Which reminds me, it is time to get Joel shared-RCU privileges if he
> > does not already have them, correct?
> 
> Agreed.
> 
> > > >> The above commits must be ordered after this -rcu "dev" commit:
> [...]
> > > > @Joel, do you want me to sync this rcu/dev branch to the rcu repo then?
> > > 
> > > Yes Boqun, go ahead and sync it with rcu's /dev. Thanks.
> > > 
> 
> It is synced already, and a snapshot branch named dev.2025.06.03a.

Very good, thank you, and I will rebase onto that.

							Thanx, Paul
