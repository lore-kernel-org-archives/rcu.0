Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6718595F;
	Thu, 12 Dec 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030648; cv=none; b=WlSg7nwNS+WCko3Uq734d0p26gQegWQbkXAZINltMEmFnpJiKR+RkI4Yp0D+oRQsFC57x0GbR2AJVULLpe2NTyo/Ou2jZSMSeXCKxr37WuRxFCUEnje32sScv0hHJZyD/DiXmY8zb1QfbFOggO7IrFgxxJeA9eHOpg8z6u4Cago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030648; c=relaxed/simple;
	bh=AMznUxMpA41JhEG6jpXa+3ZVKV/cWyO/qDR4WdYSGwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1038Lkp0svkxJ4bpSqH+T6yb705Y+nFLEGhOyqd3rRxlXkwdctIoAplnC61OWY+uWZ5WWniPmHdnTIG/gQ84z7TQ/O1fUr0YqalZ/5HzZYdAp+C+jkTm5F3tLBVCCQE4kz0k3r+e1sFkIRfMIOz0bE8J0Zn30Qo6Y0A2hLlzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCKhh/dc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCKhh/dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533FDC4CECE;
	Thu, 12 Dec 2024 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030648;
	bh=AMznUxMpA41JhEG6jpXa+3ZVKV/cWyO/qDR4WdYSGwI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YCKhh/dc3SwYjPcBpobt0jJvjye3oavE1njWiYZI50TSajTemo+dc97YDnT1b7oT+
	 00Lhb7N0edntEuHd+mcGwXObTacBXYxPemju/9z2FimvTKyxc7RSRuDa+boxkoJSOL
	 JvcSQKft6T659fK0xudg3nYb4iSkzh+zwXmGrc3NP8IJh0v99lgC/NhKsV9mY8TuhL
	 EyD4X8DikNFWwCYSbLUPbQ2iYiqemZn6+zXQJ9a5tAIbJhQfsjg99+qGgz7sq2fgF8
	 pi7z3dXa2yz6e7LfGTXn2rFdqTc0YVWDmd5DvthayJmcpUz057NJqlKaVRpwi6IRUM
	 bPngJcvzDm/pA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF29BCE0DFC; Thu, 12 Dec 2024 11:10:47 -0800 (PST)
Date: Thu, 12 Dec 2024 11:10:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <ab3c9f52-1643-4dfa-9a04-d6db4dfcf29a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241212180208.274813-1-urezki@gmail.com>
 <4f739c61-24c0-3790-8114-988f02c7caea@gentwo.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f739c61-24c0-3790-8114-988f02c7caea@gentwo.org>

On Thu, Dec 12, 2024 at 10:30:28AM -0800, Christoph Lameter (Ampere) wrote:
> On Thu, 12 Dec 2024, Uladzislau Rezki (Sony) wrote:
> 
> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > here:
> 
> I do not see any use of internal slab interfaces by this code. It seems to
> be using rcu internals though. So it would best be placed with the rcu
> code.

That is indeed the current state.  The point of moving it is to later
take advantage of internal slab state.

							Thanx, Paul
