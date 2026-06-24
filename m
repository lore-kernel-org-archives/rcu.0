Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15882857C7
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315011; cv=none; b=ehKRmoTRuZfxE5+XArzp9zsuRA7N0RFJuyVoS2Y7TMUYNF0WkOW+rA/6FXlcxPzxZoDjD+HRevKOD0IES2fZXv5C/QMz42QKIPzsFwzd07FFn9Wn0qtEPssQsRsu7v63PcMx5krhBojvVAMrl+tEaRnetgX4Bj/SX/OgahadY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315011; c=relaxed/simple;
	bh=pmmtEPC9g5MGaKsNYUTo67D6mks85z6RLJHFeAN+7fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsvkpyXJrYjemUWlaM5g9Wm8T3QnFihF7y4Gqz174ZAEwE9UaeRJTjSlo7WSHEF1GeAkvWwYGoDR5NvcDCC+qimV/N8bjMzuvA2QFJkHLVavDgSS48TrvMh3iKXxYw/8/jjD0ysPfTx6pWQrNTqbLmVXOlUvilSgRUSPx2dY4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBN67H3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBN67H3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A16C1F000E9;
	Wed, 24 Jun 2026 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315010;
	bh=Li4nztR+A12EYU4xZ5b8siyZgrruzFPS0/NXxkt+6aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBN67H3L8Lwpc0kPjobstT1Gh3zKgHeLOZXd0RurZ4LZOrnCG9FmLe8qetKyFgOvf
	 zm/Usb/t7CUAKD1YFZ90rEluFJ3gG1dg+gbBfJzka1BtGKOm7hucHvVdwjjW2hMkCj
	 WuFso98CylVurmqduwxh9PTuNNMTayGkIzBGr/gFVkMQ/FB32lUmpezoVtiQvif80e
	 pOG99BqFK4zsVRmJMsyM8H3q+mKi1a+ew4//d0ZLqiYR5SSiE13C+CRrm41erU9tuE
	 UEGyalp1anRYAxZj9QxsyXJ4HrwBW8B7P24lIiQiiP1d+Ms3A8FH7VJfOYaD4unx13
	 P37jGDvFfKK7g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6BE79F4008A;
	Wed, 24 Jun 2026 11:30:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 11:30:08 -0400
X-ME-Sender: <xms:APg7avl2El18ZvjsLLqi41y-NcMzu7zWHxEkwf2uyP0T85qWMkKFHg>
    <xme:APg7atNFvXFz7IlcL4fboigVKfOyeRfDZacQY7IXWL_zOz2pUbxBZZJJa2IV1isB0
    VuvbWLIqPz2Y8gcL4y8X30Mi5JngRqDeagmL0uoT-5wLlRvCvRJKME>
X-ME-Received: <xmr:APg7ahPOr27CmAS2-KqHOn8-i1WEPnb8627zF6gxBVpMSd8NzY6LpIvR_A>
X-ME-Proxy-Cause: dmFkZTFtltOdSru0hacfIxjeZeIqVbTllkh4J8PrQiAW55tOkDIZMe8XCZ/MYw1oswj1we
    S0Ikq1euKxkTbjLFt4xoyCbyOp0PgORxM0HXyn/TG1Kx6VniyKO850YyyB/hrMU2F7T+es
    K895rON2kZrqt7HaUajcd3QFomOMBuS+mubwCSkn4hr7U71THTHfBfA8LlYEqokYS9mt3f
    I6Qxy6wWUg811B+3FVQQ2QEkW3oCxOAm9aaiBrzET+Ac6rt7GxCc4pHnJl9r0VlxQRR2nq
    U94gEM22P+SpJjHg/wqzj3KDiuMpk4/Ng5YOqPoVWOaeGXkIyPSYTDkAVW0JxOzSfEwOjH
    KK24qW8tIW8zsHrUogsnkkyTuSIdL+yNIStygKeoff/EYV/td8giZgqUwafvVPfHgS9Iuf
    zjw/U9VTLpXkVlZCvAFBGgIwA+A5O+byQHppAzjIWf09C3cwoIF5lVSablMMoTOKsN7dKi
    fMZonDDOApItZOScOFLokN1ZthU5HpEG6Rh9/Sr9AfJ2aVAu6qpIpKiwRZTCEL7Juw9rKQ
    RYtIXc6En6yeriTb3VBjczhVj6hDgXs2CSDDlMOFx3Z1+1aAAQ9f/5BrFKdEurCgURuHFE
    9goXoWqpJuD6Dj/EDFIplr1HGExMIeLWM9KKLVL8QvDE2thriEXE2fdXaCBQ
X-ME-Proxy: <xmx:APg7ahmLI9Xp0vO8wu4A4PDycs-5iCqvyYjwhVNgY5cthi-AjgDckg>
    <xmx:APg7anpBX2fIIQ_Yjc3iGCleFDpbEw2aDHEmCEEPfnsKLi7GpArt0Q>
    <xmx:APg7al5JApNgCW8vnhrp3YMI59yb-qg49khT_-9AQLWLhg1YtEN-2w>
    <xmx:APg7ahJpc9avZ5RLho8K6TciC_6ZU6H1uetFPO90QktO53BuqQ6baw>
    <xmx:APg7aplpsVsZ7l9fU7VLbsYRODaaK5RCUHZF7KepUHNIn0MaTii1wcGl>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 11:30:06 -0400 (EDT)
Date: Wed, 24 Jun 2026 08:30:00 -0700
From: Boqun Feng <boqun@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Lyude Paul <lyude@redhat.com>,	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add and use abstraction for synchronize_rcu()
Message-ID: <ajv3-Jkp67yJ8MQ6@MacBook-0RXW5>
References: <20260624150704.1504001-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624150704.1504001-2-phasta@kernel.org>

On Wed, Jun 24, 2026 at 05:07:01PM +0200, Philipp Stanner wrote:
> Changes since v2:
>   - Compromise docu for "RCU versus atomic context" a bit better
>   - Add respective R-b's
> 
> Changes since v1:
>   - Vertically format imports. (Onur)
>   - Make the new function #[inline]. (Alice)
>   - Add Alice's R-b.
> 
> Philipp Stanner (3):
>   rust: sync: Add abstraction for synchronize_rcu()
>   rust: revocable: Use safe synchronize_rcu() abstraction
>   rust: sync: Use safe synchronize_rcu() abstraction in poll
> 
>  rust/kernel/revocable.rs |  9 ++++++---
>  rust/kernel/sync/poll.rs | 10 ++++++----
>  rust/kernel/sync/rcu.rs  | 16 ++++++++++++++++
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 

Queue it in rust-sync

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ rust-sync

Thank you all!

Regards,
Boqun

> 
> base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d
> -- 
> 2.54.0
> 
