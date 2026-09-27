Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25537C924
	for <rcu@vger.kernel.org>; Sun, 27 Sep 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529994; cv=none; b=AiGgS8eE8htgxG4zw7JT0NEyOrPXVnKVuAt95fl8WZWC3n84hkaV5LkLCdNz81ymeQ40ApUjEKeceMyltHRssRPtVMDj1OCDGxnH1hJdHQNcE2T6a6d+xXw6LCs7hoXUV5cJvfwUdFRb+KT9Rjr/h9yo96iD2Zz8pfpuZOmE29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529994; c=relaxed/simple;
	bh=u7TkxzW3x4juS+OVk4UuUwfeHl9Utob1vgraqXPTrB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5CR2RJeSu2bmD9GfRoOnPN7dkwbUBJk77fYajLKfge+Gf9TuVkK9PtmBKUPaEprVmJu5AnjjXdI94QfXT3VM5ZxluCQw7R6NxhYPIx7OLVOxDkLi4BzyHcajKqaqgQ4/t4QTBQfSO0Ylj5oxhf2ZQshnpHiL2ZcTaTv7rUyaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqW9Sd1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqW9Sd1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F6B1F000FF;
	Sun, 27 Sep 2026 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529993;
	bh=TuuaDpekgfgDG1xsd5kQIZDXGrc07KFH/CrVSLpmawc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MqW9Sd1Mgc2XcmVUMggmcQ5NkOmifOx9I/UQGPTyVM92+fYAOWHjt473hcfNoY7cj
	 ah73PUmxjrVxszCYl1cGxQcBRTu+NKcQlwVEQX0WuUIixVfZr5EquRmOSsBxnaKzK/
	 YDgWiQrHlcVCgZnb6bnsK0Si2JqhWJBXCCD9oAhFvGZtruIURWKaFWhabYe+G6YfVx
	 0uU3VOcsPvbyp/0tIBZDAIoKRLDg9xUbuSZu7u06GgjXwfQh5k1Re4C3KJxTt6AdYs
	 lzw+9+KGvgMbOr9njvowVfn+KnSj1IZc5dnJ3WcVG93IIjOg0iY0M57sf0bhS/flzs
	 NaPpq+y9pPJ6g==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4051DF40066;
	Sun, 27 Sep 2026 13:26:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 27 Sep 2026 13:26:32 -0400
X-ME-Sender: <xms:yFG5agQWDTsP5n8jo6vDFzXuwr-TcodWS7WWdl86tuwnwGVpqKFOtg>
    <xme:yFG5apz1wYqmXeIW4lktC72m82_ArdeXs9qXUm9Mm6aQ8ZPEM0cXs2jHoUrnPlrHw
    SKQJRzb0ojwy9x-bMCJ7IKTpNPTD7FiV_Exvb70MeeLqIWvbTxYdg>
X-ME-Received: <xmr:yFG5agAM042Yp9cAZd_GIP_sN2L-1ifcNviRft9omAC5WpFsvoYoljI_xw3n>
X-ME-Proxy-Cause: dmFkZTF2wYukihSOr307lfKZHsXSU41dCS/+c7pM1vG1Ie3zgbM85D04/zRSSOZocH4w95
    SYQwC1Aax+ksTT5qFIOeCIAqu2VtGNONzEJXyJvSH6I8HN71yP5sjf/6VHzagOzvqVy1FX
    nIBFdWVlI+S9SiuxiWGqBnPw5qa4SYX2WZKXuxi7rCkb0ZQ7Mb0ORUyLT6GbaItL+/kDFR
    NNicQNdX+26Sk2fxcqqAzcEJc0z0uPNE08whGuESuh7HiuZh60M961WaBytJ8uy7om7YZs
    InOwEhfcW9WgeZKV0ybWZSq7EuY7pYRvN2IBNNMbfbzATO+6YvKqEBqBZTRW7kXpGzmqSr
    pqmhT5teSJnkmU0xQCFbzWbAxfIX8qFSwD2lgmMZ9h41VsV6ijJW0mcudUaK9glqXtXaFj
    wole5IL0AdhiCpr3b1pD4mrG+0Jfhui6aOS5Tom9O8CzNEi76puj0aZe5QDwv2pOBAO5h4
    /DRhg2/W4zvMXxIZijAotf/tZZr6k/iIUSXthAy5f+pTvtyB6X22mz9JG0HclYSPl2ObKC
    n2CpyrHTvwowyQBSwq+635tni+mFzZMg4gJKJMjJzE+VUFXfA1d1zehTqujuWZwF5dvqPB
    mlub6jZJG64V0F237ooidcHiKjBES8emAEmbomLzp7Q94uUfGWsXH21yaydw
X-ME-Proxy: <xmx:yFG5alH8V0JrDPLYkCbKC07Ws_ulZApEgMy5szsyzBTKivgWlBLDBg>
    <xmx:yFG5anMJ8atfAtV6k4c376SW_9JV5TbTmnfF-hHVyOPk93hlLGNtLA>
    <xmx:yFG5am4Nr0GVNUJ3EM8sIaFptdCL8jrHVE25cHBom9GY-iQW8jHHGw>
    <xmx:yFG5aqi7gYSq2WjpbUwf_8Vu6NFotUGX-DS0IWAn8qigDoWY2ZtN7w>
    <xmx:yFG5areMV7rHdM52PwAHkgQ5mGXv6sjarlE5OBn6YCKo1ZYdxzHziUw9>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 13:26:31 -0400 (EDT)
Date: Sun, 27 Sep 2026 19:26:30 +0200
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <arlRxkYsNzEKFqgO@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>

On Sun, Sep 27, 2026 at 01:15:39PM -0400, Mathieu Desnoyers wrote:
[...]
> > > With this change, the scan on per-CPU slots don't need to expect a
> > > wildcard anymore, because none can be produced by readers. Wildcards are
> > > only expected within overflow lists.
> > > 
> > 
> > Ok, I was missing something, but I think it's better to call it out.
> > Wildcards can only exist in the overflow lists when the context is not
> > preemptible. In other words, there won't be a preempted readers blocking
> > the synchronize_hazptr() with a wilcard in the overflow list.
> 
> Exactly ! Wildcard slots only exist during the short time-frame of the
> preempt-off read-side code region (few instructions). And with this
> patch, this does not even happen very often, because the fast path don't
> rely on the wildcards.
> 
> > 
> > So no more design trade-off question from me :)
> > 
> 
> Are you sure ? Scrolling down....
> 

I do feel with scan thread support and call_hazptr() support, we will
need to tweak the design and implementation some more, but right now it
does look good to me :)

Regards,
Boqun

[...]
