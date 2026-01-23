Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CED18787A
	for <rcu@vger.kernel.org>; Fri, 23 Jan 2026 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153323; cv=none; b=kLURrEsZY+EY1dS2vSy9Tze7XKkApmxgzwgnCYinFXUULCB3JrOgoPzpfFd+RuZqcw2oGW4g+FQgsCL7UPuYQgr73sM3w1i1w9UC/FEE8qMBjpVCKlDjSEHCUcwFwFnm72Kd8Jer8gwj0APExDrhwOBpBL+A8lXyIMfkQWV1wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153323; c=relaxed/simple;
	bh=0+XcF/DKpKJlNk6gvVQ80r03ERq08zSyXtZRvvv3D2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBAupKcaFNUUxBpB1NWzt3SKc05e8UuuuKfFS7p9+RUVx9mfvwttGWELkRI96/xDq6XQn28eNB3a020t0pyc6XZ6O0xMAglAZfdN7yi9w34oMiPtLrCYx3YNCPUHxcZgxBaUmssIICFwq9tTwY2vOgjUBq3WO9cwb0yiUU5qURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il7zCkMZ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il7zCkMZ"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso1557021241.1
        for <rcu@vger.kernel.org>; Thu, 22 Jan 2026 23:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153321; x=1769758121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpNcbqq3QKYz3lgJbaD3XSigUERyy/+zoCPLiX3NuWs=;
        b=il7zCkMZRkcWlSng3sV9se7U21Q43+xSQTXQPeHszoPfZqUDmdkosylsvQZB3yx0v7
         StcsT34p804B3lDOIQ1CtVQiSMEQjuqe3Os0LCbo5Dor2RmpsIpK2AHdL1nrWCMDYQ8G
         ozlesF+AzCewUG+I4HX1QBENSNuM7Jz6ZTMQN/uw3t05cZ3M8N6sEBrsXBR5xVVqeiNp
         4LwZCHQimpu7TdhNfwwpjbTJKClmWb+7cAv0G5ZwY2DKN/wWwsD6IBoGS0lIAWG5ylmm
         KEjkKUfKyicRE/QiRnujORXPkaprwzGOXJ/eAKe8ZhcNd46RVh5dcXohyqinhiPEVB0K
         c1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153321; x=1769758121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cpNcbqq3QKYz3lgJbaD3XSigUERyy/+zoCPLiX3NuWs=;
        b=sOq03p4FGsYR+UbExyFpAlXSbqo21YU5dGBPsDU2pj7DtTrEFlRCHOajcA4j2PRrgy
         +EyB30IpKQujXGsx4KMQ3KOYv4QszqMlWpelzB1iafN+nbwwf4kVX01wKeNyiRF4wTNB
         VScYipt8SeIXzEbnXQUlY/JDLz8A/kvZPiDi2JWxaFvMqVULu+V2N4d/kjgOc0Bn/6eC
         uJC8bYzXXeID3DE4XDkMZpvouhlJyQ+DAzO0WTHroJm75/4a2iiZMUL6keTiO8S7deZW
         t2k7HBLull+7w1GlXCQZqueVpiCrEXqARoeqDOUKFlGi7zhw0jFdTsyP/FeuiV7BHSTX
         5VZg==
X-Forwarded-Encrypted: i=1; AJvYcCUeII5XOh/E9PyY4BzM3nvrwWPX7jxaGmzYuZTnb+iZF5oOJxARarAyXaKxSxD99AxpVyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0obR7J/rtazFpCLGNE9otbau5IeK7EzRaKE4m/CO/un+shC+L
	C1DM971Xfj0y3mrBuHVcuRXbM1iqKKKUrlx9KJOmFizww71Jymu/lUOIVJHUMw==
X-Gm-Gg: AZuq6aLWOypVGgywRVj/01i1Utildi9aYLonVnf11Y8klgMx056KCVVjX49pw/9bNry
	/JSd1JxT5PqSMxBgUCHb1bhRHZDhl4W3BusqtLwdqLPY9YyCPOtNd8xsFXrsd4gY/Tre8BlPGAL
	xjxUdQjOJUQpoj2Ktbh3pVX8c5/2iHyswPhFhl2opu9V+dQFKL7+xlOZ9NGmNeWZe4+PzQ9+yN/
	xOih43gm1vxXcGLnpvHrgWjd0DYmjdEI5IOxQejLRK7K/xl3Ecq4ugCT1UrZcocHF7zedukcKRV
	4w7tYMA1dGWQz8jFFFCelTHhIxz6AGn7AbWfwjvkYvB19eT4SNuANoW010BZht6xI2LJ16625s7
	/+DiGzZ66WbXHuqjY/MY6pJTlYCyYTtNkANxYethHmfCePAb4zf5LKP6Kluzm2j/lNkbJj8+z2m
	3JmPWMHypiRqQswkYxFn62X7thQLR87VAwMEvIc8tbylqV/qwnVUwNfBaikHyrrABTvyAhyYwoP
	eC/R1juaYmfIP4=
X-Received: by 2002:ac8:5a8a:0:b0:4f1:ab28:d9f6 with SMTP id d75a77b69052e-502f7725200mr27683781cf.26.1769147688575;
        Thu, 22 Jan 2026 21:54:48 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f8702fsm9798031cf.28.2026.01.22.21.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 21:54:48 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6D9CDF40068;
	Fri, 23 Jan 2026 00:54:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 23 Jan 2026 00:54:47 -0500
X-ME-Sender: <xms:Jw1zacNSv72845-XjhCUDb8XV4_xqsR2qDrAqR8lviRFlk3rhJLTxg>
    <xme:Jw1zabUH2n7wnD9HJMJi-sVbpZ1wUOXlR5UmflwV8DbcwOIRF1lWt1qofGE764FW7
    UZE-C8uffzMeohQTrqQANlVVQenNf4_3g3zMAhOz0x8jI0vpGUU7kA>
X-ME-Received: <xmr:Jw1zaVc-YiHrgUiSUFQ3yxt_KkWPQqyd8WIdtUhEnpj_mgcmmtwtlur1uIkPkIn_p1xjIzdujJw-ioxixHI_rc2i0PjV8pew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlih
    hnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhi
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Jw1zacjmaFYKlPW7RL2Oa2zEZHphkSwkL15DTycEfst7U3kjSGpM-g>
    <xmx:Jw1zaWhcM4TsUj_WSAW3mRGJ_o-Z08crbA3Yv5b30xgZZ7x2qsVcDg>
    <xmx:Jw1zaYon0xKAeeaPvuGl3EYpsb5W-d-GTc3_1-I5FTxBXrDpYBMm5A>
    <xmx:Jw1zacx7l3wGN-ztfuAGbiSZji7LtbLDayvno7oRVhdR98BctZdDaw>
    <xmx:Jw1zaXxVwOXUOrAh_HWeI5BLNv59v6fKGC_yclLw11OMOf3Vb5J1BFEL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 00:54:46 -0500 (EST)
Date: Thu, 22 Jan 2026 21:54:45 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v2 0/2] rust: sync: Atomic pointer
Message-ID: <aXMNJZv8H2OQl37t@tardis.local>
References: <20260120140503.62804-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120140503.62804-1-boqun.feng@gmail.com>

On Tue, Jan 20, 2026 at 10:05:01PM +0800, Boqun Feng wrote:
> I've already queued the first 3 patches in v1, but comments on them are
> welcome as well. The RCU pointer patch is not included in this v2 since
> there is not much update and I'm still hoping to get some reviews on
> that for another respin.
> 
> Changes since v1:
> 
> * Add a clarification patch of CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
>   suggested by Dirk and Benno.
> 
> * Add support for Atomic<*const T>.
> 
> v1: https://lore.kernel.org/rust-for-linux/20260117122243.24404-1-boqun.feng@gmail.com/
> 

Queued for v7.1, thanks you all!

Regards,
Boqun

> Regards,
> Boqun
> 
> 
> Boqun Feng (2):
>   rust: sync: atomic: Clarify the need of
>     CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
>   rust: sync: atomic: Add Atomic<*{mut,const} T> support
> 
>  rust/helpers/atomic_ext.c            |  3 ++
>  rust/kernel/sync/atomic.rs           | 12 +++++++-
>  rust/kernel/sync/atomic/internal.rs  | 37 ++++++++++++++--------
>  rust/kernel/sync/atomic/predefine.rs | 46 ++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+), 13 deletions(-)
> 
> -- 
> 2.51.0
> 
