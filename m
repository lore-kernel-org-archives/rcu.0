Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B471DD0EF;
	Thu,  1 May 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136160; cv=none; b=AKcZuUA61tcLq5anVXyBhH9cR43sLOvbVdB9CJ9hV5a3mbKLLgIOcjcDPs+5YG79L6u6EYr4yETexlOHyQE/Mv6METe1u7xKxojhpC0nxdsBImFhJeguJ6PNkh3heWBUNYtTdTKvuCEXBF2TsYdhQviajc4BYZFlW4rR5OxOvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136160; c=relaxed/simple;
	bh=WOZxd5NvwxFSHlNx186hEgXGLwFGTlHTNP0LW7PRhas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWVgLH1w1yNfM7Sie1LmzF3UcJX1nQnmxXJzYYkNiT01Amfu47Y+4GaU7hSDvXPRfgxxG2xo1yARD1FBhBgE4NTeOKcJm16v5yb4FllzbVqFYUX/0SI/dmIssCzM3Z4fAukP0M+RG3NuLskQ/XIC7TzI871S6zBAwREt4YSvS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+HczsLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+HczsLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1089BC4CEE3;
	Thu,  1 May 2025 21:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746136157;
	bh=WOZxd5NvwxFSHlNx186hEgXGLwFGTlHTNP0LW7PRhas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+HczsLlYALnYCqoB5iTdtjzetnGWrD2QpUKIHKkzqhrBXrGbY1pe32UtS6S+xoI6
	 bYOYklyOkoXzp+m0Ir1/e0ym9E5pESXE2H56eJM8Z6iGF7ftm0vUJCgo+JVh647B4c
	 4+siYSGnROftxZ7OtD4zahpU/XBSJ3PGHNTqe2Pnu79fV5dgVXA5g7xRThEU9rPdta
	 i6ay42pbiTn0Fqhgu3XY61ZE02cNDfUgpkmqx/G3DjkxL48+1yWid7N5L4ETlcHrlh
	 BtjRm0bVYrwMzn7Xwgw1CggnSDNFrlfOiB3hI6gfyBGNxBuSK0VA2HcW1+4ltYb5Ud
	 5COu0EvF9wBfw==
Date: Thu, 1 May 2025 23:49:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Paul E McKenney <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within
 hotplug IPI's blindspot
Message-ID: <aBPsWkw0juAXDVU8@pavilion.home>
References: <20250429134304.3824863-1-frederic@kernel.org>
 <20250429134304.3824863-6-frederic@kernel.org>
 <8609B469-5CB0-4EBC-94D3-FE3F90697ABC@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8609B469-5CB0-4EBC-94D3-FE3F90697ABC@nvidia.com>

Le Wed, Apr 30, 2025 at 02:20:31AM +0000, Joel Fernandes a écrit :
> 
> 
> > On Apr 29, 2025, at 9:44 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> Hi Frederic,
> These all look good to me. Do you wish for
> these to go into the upcoming merge window or
> can I push them to a for-Neeraj branch as he
> is doing the merge window after the next?

Your call :-)

If that can help, there is nothing urgent in there.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
