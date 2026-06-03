Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D582FD1A5;
	Wed,  3 Jun 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500477; cv=none; b=INqyEc/TPlzIKuWwUm9jJ/du/ZQRNKKYd7T7u0ZTd4VL7sTN+HHe2fuSo1d6xT35wOc0/J07BtUvQAjb2QhtbGgj2/urApHSOxHMlA4FA9xM7rtp1EVeGSv53V5AHXeypJZ7Xd9h9zoJwcJ+R/bW6YhDL6SXpk0UiynMSB86mtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500477; c=relaxed/simple;
	bh=cLYx5gU2K4YqXcOcv+t+qzKSAh9InXjUJVOiOEMrnKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4iZhb361YfPds3lm8MCdcCTsZ+wWlW6AhaUjPRjttrFkgGwe4xtIkjtfQwniZnB740HVUEcboJ0KYfAsFTciXVRCXwG5yUuuLk0es9BDjFUfrVuJJkJuvq06VgVOH/4mltImMYe8RpFhsg1VkwBaLiL1t8tlc6y7al2h3u4QWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTG3XiIA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTG3XiIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D371F00893;
	Wed,  3 Jun 2026 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500476;
	bh=K+bfaBhhfVxJ+5PosWIBpa30vhMSj2ZrC2KP9ibybps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YTG3XiIA4lEkW6USncgIYJGRHNpQDPLciLotkx2Wnu9D5uPLatoR7F9iPzIY+jjLc
	 synIEaA9022E+tQ7B11Pd6eumHT22IiKPiL8eU7VRdgBocGZH8FntLeiRzaXTUBujG
	 xqcB8V9UvPMYamQ5BRCka8mBn5hVd2OvTBzCcLlAjXDqjbrI0q4KXPEi5xC5REIuTm
	 SOOzjBK2NImrWvR1/W4f/m0ucPtprM9EP4bsdbTT62YoPpEj3BnYxxSEOlJA1ydDgk
	 fQpbToVNKJCJAda6LL/L3HOKp8uxZpaIsKSDDDDx5JMJHjC1FOODRn3vmZlAkZ2CtS
	 /sJZA8v616kkQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18696F4006B;
	Wed,  3 Jun 2026 11:27:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 11:27:55 -0400
X-ME-Sender: <xms:-kcgag28QaxgoFEtnI1MM3lEiAOF5YRzeUxOGIzVFzHxAxVq7ff6UQ>
    <xme:-kcgan3pUacMK7IS0HEccWpLRK9oQQjelrBdkU4ClsTYE-DjYxZce2-cpj0S5-buW
    70KyH_L2GP4KvNxi4TYu2BL3evalYIcGF-YVgsdzz1oH0AyfqShvA>
X-ME-Received: <xmr:-kcgaoeCBEMffASuQAA3Add7q83W99Rd8iHEaPwxI6GnPjDzL5OQ0yWspuo>
X-ME-Proxy-Cause: dmFkZTFQXNCvmOzgkX75TjCKgGMKfTtH3s/7r74Ezl2XZ5yvsEMt8Ui7QAFfwJza3HYn0J
    2C2S295tge/p0vK7WXqUKkqMcrUWGBIYguRWCGr+MnKBMzNtI6UQRqXF5AlLH9ltoqm+GC
    FCkGmZ8LRYfnmLXOHQVI/9BOmNFSZ1UWCv5DIbhZUqLBsXQ1NI3ul6h6/a1AS39xF8v3l+
    XVYnONAelNCIDQki2r16u88xtIJ5nIddoJ6fued53Zhd4jZbm3CSnk8QDm+uzZXjRfbtUR
    Hz7L82eI/aV5v9pcrakU2WlFx4e2rNcXjSS8N2znD3YJPelbPYAdTKKB8aa77VVxK6CkMK
    zqHwVwFfXuGrvWzgeP/MhSwN5OD5A/NcWB8N2Wwu7zLOypszKRQoh6yRUZAHltAMrtVM4F
    ehXmK/PSRYtGAvPL0tgQAIjY9I7dX+oSflFsKCji4cj5+uf+ToGoNHA9rEEY9OUfF/VS2F
    QopTxqYY/UZxEjjJ4+ebKZvBtbeEVJ7KxVWaxhy8vGK6FqSmHbBePswBr+gpKo+KYo8bGI
    SieMa/bynUC5Tcaf4/HU8/hK4gP69ALsRCAytDCBov0lA2qPnFJpA13Rs+NIoy25iIxlt3
    2nc5gqUhMjgshlCmgTBoysOUZQu3F2QBwcxCwVYqqb3L8hlRgTf1H7/dSjQg
X-ME-Proxy: <xmx:-kcgaic4CdAoBGQtkuBJWb_SdlBOwFG7P_DWfjPTs7FRK-JzDwlj9g>
    <xmx:-0cganVVvvmgmFEFepBpmN1EzAQNMXWnGJeRDhpAHUP_XFDGWX-iOQ>
    <xmx:-0cgai7Fhuku_eLsxja1_NdJCdz5s-Jc49WMFaBqAcTfeKfCWiJP9g>
    <xmx:-0cgavM2gyQryNA5doZ0VSn-ydjKqDn3jmFfkYTlCziSdobpxjuoew>
    <xmx:-0cgalhheN81mBJZV_y6XmJAJ45NThKHACmq70FWN0CqDkkowUqgo-gA>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:27:54 -0400 (EDT)
Date: Wed, 3 Jun 2026 08:27:51 -0700
From: Boqun Feng <boqun@kernel.org>
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Igor Korotin <igor.korotin@linux.dev>,	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
Message-ID: <aiBH95n4HqrNtgtz@tardis-2.local>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-4-phasta@kernel.org>
 <ahr9gtzQLSbPeBx_@tardis.local>
 <e8b16f3b40d42f3b0a8814180fa9b06f82c9d901.camel@mailbox.org>
 <ah2L-TMT5UHSd_Hs@tardis-2.local>
 <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>

On Wed, Jun 03, 2026 at 11:33:27AM +0200, Philipp Stanner wrote:
> > > > and Philipp can use the `RcuKBox` in this patchset. We also need to impl
> > > > InPlaceInit for RcuBox, but that can be added later.
> > > 
> > > So shall we merge my series with Alice's patch, and later we add your
> > > patch and other features, or would you prefer to have the additional
> > > boxes from your patch from the get-go?
> > > 
> > 
> > I would like to have it from the get-go mainly because of RcuBox vs
> > RcuKBox naming. Thank you!
> 
> Fine by me. Just process-wise: how should we do it?
> 
> I could include your patch on top of Alice's. Would be a bit more
> consistent regarding the git-workflow if we'd squash the two patches,
> but then you two would have to agree on authorship.
> 

Keeping it as a separate patch is fine by me.

Regards,
Boqun

> All is fine by me, but I wanted to ask instead of just do A or B.
> 
> 
[...]
