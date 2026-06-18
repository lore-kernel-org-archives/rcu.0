Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECC3F58E7;
	Thu, 18 Jun 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786861; cv=none; b=gYoCB+nibqnH6GWWMyJiBNYw1Ls/to6NGnGZuxfGWy3uORRkXwnR2EngYj2b1YUbXXpV02dIsgKYA9gqPqnScCOSKbJdy8ato75n7jgY3Y0rMEbLCu2tY3hQ8lYtV36MS/zzMLm006Poi1ggkNCWaVWHdKtc+aNiZHItHPktyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786861; c=relaxed/simple;
	bh=9QDuDUPn/qp1WTN9rrbLR5TYf7RBhyTeasebaxUk7ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjDZ49KFIJsXHExWE9H20+PpZCgBzMJab0QuPDURKLFURUur8GbyHvsdl3iycQ/LMUvmd+Hy/kiY2oT2jDDbVAV3vfGS1zvdTuOLcjo8VM2YGVwmY+x9WFxsbbaXa8oJpug7rYq3imbie0sKh6KqAoq99mQUKA69YYnkukfqOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ejymsP0B; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ejymsP0B"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gh0qp753Vz9vD9;
	Thu, 18 Jun 2026 14:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781786855; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QDuDUPn/qp1WTN9rrbLR5TYf7RBhyTeasebaxUk7ys=;
	b=ejymsP0BX2pyuCwdyqHd8uqZFPQYMuft36MslBYHfEVVQ4gNON5IeHK2182C6tS3ItjAlA
	+aOLMppeSFjCJNxcmvC9dqSgtmSxJdo4fu5eb27Ey4Tlu67G0YfKvCst3w4JotnasBpHhd
	M/LBUxMd9vizx9o+X5E2kN9QoztA017/FR0JCZcCdtPShp73NTI2OZQFMY1BXlkfUKlnz6
	VOKio+H8lGJXSUI2VFqwEYirbILhKfMDJU//pftG9qI1wD2GnKbclLg4QeubZwEqQgF55W
	2h5UJ81UoY1d35EgxK6QEhmrcFw24MD5Xw88gCuy25tJ2K3cdznC6OXKogWtqA==
Message-ID: <81c530248789f79da265da772a6f248a0d524eed.camel@mailbox.org>
Subject: Re: [PATCH 1/3] rust: sync: Add abstraction for synchronize_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Alice Ryhl <aliceryhl@google.com>, phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich	 <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lyude Paul
 <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay	
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt	 <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Christian Schrefl	
 <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 rcu@vger.kernel.org
Date: Thu, 18 Jun 2026 14:47:22 +0200
In-Reply-To: <ajPa4_U_gcxr8SKO@google.com>
References: <20260618095952.3687099-1-phasta@kernel.org>
	 <20260618095952.3687099-2-phasta@kernel.org>
	 <15e81f5bf354cbe3cde765526762e4ebb3ef6970.camel@mailbox.org>
	 <ajPa4_U_gcxr8SKO@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 6c77894625fed4cbbd8
X-MBO-RS-META: jk46pjimor85d6j9p35yhyttdo7smzm9

On Thu, 2026-06-18 at 11:47 +0000, Alice Ryhl wrote:
> On Thu, Jun 18, 2026 at 01:40:05PM +0200, Philipp Stanner wrote:
> > Moreover, this would be an opportunity to change the naming convention
> > to rcu::synchronize()
> >=20
> > But since Boqun & Alice are pushing for rcu::RcuKBox for the reason
> > that it seems desirable to explicitly highlight that that's a special
> > Box, I guess we should be consistent with that and also have "rcu" in
> > the name here.
>=20
> I prefer the naming of synchronize_rcu() here.

We might be tempted to at least call it rcu_synchronize(), though. It's
also RcuKBox, not KBoxRcu.

But I don't have hard emotions on that topic.


P.

>=20
> Alice
