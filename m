Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D11DA3D
	for <rcu@vger.kernel.org>; Wed, 19 Feb 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984532; cv=none; b=W7QYo1702S/wCE/IdCzrZg6VzGO1m3IYC0HHPVft9px7FnNziV2cAJzfZImsg3wxXWUzawR7tjYvM1YB6tUVTZ7cpSKdb7Yon8/jBKojqxKuMbtfqXJa7baS9HRu4v3rS07mggDK8Xu3joAH8kD8345VEe9w17Fq6Ale5581J6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984532; c=relaxed/simple;
	bh=28z8E4FcI9eI12cGXdrJ3ubj6U2DbVOKk0rRipl9sOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY7plPSjzmVSMfRdB956pEWdWhZ4cQ0P7zG400G3X82CEBjUamZOyrQwKWQ2mLjqyjwBNDwbvEr0mBHYyoVfF7FLXRtSdkGTKng8pwhJZ/lX6yNKPUbgEILQ0dGwlwVB1vhml01sNN4/kreR5dj0Ip1mSrL3h14bqoc5Vd2bNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq/B05+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq/B05+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C280C4CED1;
	Wed, 19 Feb 2025 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739984532;
	bh=28z8E4FcI9eI12cGXdrJ3ubj6U2DbVOKk0rRipl9sOM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dq/B05+mTxfnqzG/A5uhfAlJAMlnph5IsTlcRAUwUpIao6sqSWqvwyf0Fn/rJnEEd
	 w+EL1iQVmDvRu8JPDa6THRIzLXzNhqMyF5vBFiquHfAncp613tJo0rIyXbeHU48iDO
	 /eVE+2E8zCDmDY8YR6YF+9++7e5B+Zi/JMv3hqZmxRXazl0+ZcJPoU+LjoX43iWeDK
	 BGVG21SyE5HCzpSDOWwDLMy07LdZfVfc53fPNISoS9ftU79q8VIHDvzdbeV0WlHAzo
	 0upKC6W+KXGC/4apqpiSldJi1yfJHkt0F7mtZeEW2b61Djg4hwr+0QJ++15rohszye
	 pUr8+S1F6yngA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0983CE03D1; Wed, 19 Feb 2025 09:02:11 -0800 (PST)
Date: Wed, 19 Feb 2025 09:02:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: The rdp->gpwrap behavior
Message-ID: <fcb3ea88-9c11-4bbb-8eb9-480935da0703@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
 <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
 <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
 <03416b20-789a-464e-8c2a-f9a96eec4b68@nvidia.com>
 <b613df84-a176-4333-8c7b-2f3a75c7fdaa@paulmck-laptop>
 <04e2c857-d66c-4ab6-8db8-33dd88160910@nvidia.com>
 <f23140ec-2676-48a0-ab59-51ee18f22238@paulmck-laptop>
 <7dd7431d-a8d9-4ac1-9c28-e43c7c1fcbce@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd7431d-a8d9-4ac1-9c28-e43c7c1fcbce@nvidia.com>

On Wed, Feb 19, 2025 at 10:57:29AM -0500, Joel Fernandes wrote:
> On 2/19/2025 8:54 AM, Paul E. McKenney wrote:
> >>> the system, by scaling the default by the number of CPUs.  After all,
> >>> we want to test both the ->gpwrap path *and* the non-->gpwrap path.
> >> Agreed. But do we want to test both these paths only under rcutorture testing or
> >> were you considering we do it for regular operation as well? i.e. wrap in 10
> >> minutes in regular operation. I am guessing you want it only for rcutorture
> >> _and_ have a 10 minute default.
> >>
> >> If that is the case, we would then need rcu_gpnum_ovf() to consult rcutorture,
> >> if it is enabled, about what what the threshold is.
> > The rcu_gp_slow() function does something similar for the grace-period
> > kthread's injected delays, so that can work.  Probably better than putting
> > the module parameter in tree.c, because putting it in rcutorture makes
> > in more clear that it is for debugging.
> 
> Ok thanks, just to clarify:
> 
> Normal operation is still ULONG/2 threshold.

Yes, please keep this be the default.

> rcutorture operation will be 10 minutes (overridable by rcutorture module
> option, not module option in non-test kernel code itself).

That sounds good also.

> If we are in disagreement about this, please let me know. Otherwise I will work
> on a patch as a next step on this.

Very good, looking forward to seeing what you come up with!

							Thanx, Paul
