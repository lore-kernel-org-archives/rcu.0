Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A144C8FEF;
	Thu,  4 Jun 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595411; cv=none; b=kPwiH3N8KDa0KQgtsRFVpt//Z0eNxUh646szh09uf0vFHTrwwZKJBM0TlixVeVjGU904Fh7TDY0wxE5w3IjbPHuXkCnxaKW6piOCqIefA6hi6kzCAPYKmLUh5NFgi3DbYKg6Dv5C1e/Ph/fdIL8E03/C0FXFd/T9V0ppeGdSUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595411; c=relaxed/simple;
	bh=uH3DN8+vwbtEFnrUkdFiU7sXwLD0nEKjCJu2NvZm0Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEX09FSUQYOsVn6v9mj9uA/VzTwS6lhaE7ZJKmm0U8DHuAUS95EcZ7rVY9ujSkGWd7vg7wYF/FNH0B4Y6kU7/uR9Q7GuNnurYX69kiHf4YzgAUr0C5cSKi8wCEEcJc68FZ5DGWakZx2JNOlxboJ/mLzAQWjNbBgs6RqBA/pEejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltNEM1qX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltNEM1qX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFC21F00893;
	Thu,  4 Jun 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595410;
	bh=Vi3s9rwTzUobC7ambNJchfKIUv646AOhB4wzLDGNaaw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ltNEM1qX2BkGBQ/D3OEWWqRgXfXpQCbN33puk+Mqfo6NDmVytoJ7K4dLTi/IfBMQB
	 Paa319mYAGxo+YjAD1h15nmuIFtbXL7uPCRbvjLiEA4BXOAEjlp5hO86H2dy+7+KoD
	 3dwTnewEYiKXXZCEwFDX/FltCfkskju7aisL5fZ93moa7P8tfMcaakEtkaF3xwjEcW
	 hG2zZH0DOKOR/lfplGkMS3upclklgrFPSWLXlkD8g45VMo1E3kMbnbOTvkB88ACAuj
	 +gMwEnQWJYY5+45s857LuqFqKseea+55J3zsXLlA/+aAp3i9ZRvqwDFG3J06F0lkWo
	 PAUV+LX9HDiFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E612CE0555; Thu,  4 Jun 2026 10:50:09 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:50:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Message-ID: <f76235e4-33f9-46bb-b01e-2af8c76beac9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev>
 <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
 <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop>
 <20260530062730.38077-1-work@onurozkan.dev>
 <3ef86db1-edc4-4e50-8614-2dd7270540b4@paulmck-laptop>
 <CANiq72=jVHEu5veW_k9B66avYgVR2aHDN2QmDny=j4EK2uRXbw@mail.gmail.com>
 <20260531191107.35357-1-work@onurozkan.dev>
 <CANiq72mdeiG79tS4=xbCzHT-n5ZDTB5_QKwhF3Z=XeuWkr8BXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mdeiG79tS4=xbCzHT-n5ZDTB5_QKwhF3Z=XeuWkr8BXw@mail.gmail.com>

On Mon, Jun 01, 2026 at 11:29:40AM +0200, Miguel Ojeda wrote:
> On Mon, Jun 1, 2026 at 11:17 AM Onur Özkan <work@onurozkan.dev> wrote:
> >
> > I am waiting for the v9 [1] reviews. If we get a complain on the current
> > approach we can consider the Rust-specific clean-up C function +
> > disallowed_methods from Clippy.
> 
> Just to clarify, I only meant to reply to Paul about linting in Rust
> in general, i.e. I didn't mean to ask for a particular approach here.

Apologies for being slow!  Onur, could you please use whichever method
works best so that inappropriate use of the new C-language SRCU functions
for Rust get complained about?

							Thanx, Paul
