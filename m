Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53D29B781;
	Mon, 22 Jun 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153990; cv=none; b=IKnSuHl5EC0p7rjJJGnaENkGRR/0WZvW+j0Bjx4RW+izjCSI4ofs7x4Ng1fkqDRIrwb+0bs/DOkNLBim45Y1Ldp+5KND5G2K7fyP2WO8YzWLzPQWZ9y80KCPrMN5vVYBkLO30Y9aVaFrgiDx4DtkT0vx61Rxn2YcSpNgCWS4edE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153990; c=relaxed/simple;
	bh=t5ph3wiqKU3VNHK6wx0lo3wW666g+OlPUKp6Ns/UsEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hRjaCJZmLD8Do8h5nyY6JLprVAGxLiMuQXWyrr8qngSOAYYgyw5Tt83x4xXkb85cx/Pk4O1ddxuQvCH3Ew6CIlJKJdE/LV41xSu+e7AYqBcDUdk/LQUpjlYrVnTFY0hKlKB2+AmwRgtxcjy6MbzVdPq2/z+9tzOBzKSeoR8Yen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5JDDg16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5JDDg16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E677D1F000E9;
	Mon, 22 Jun 2026 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782153988;
	bh=liL7tmJ6GOuD4jO/2yGo9UceXee7KH6ey0qVEMF53JA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=O5JDDg16BsqCl/Rm2ukrcWHRM7OlxgC1Aif/rDe2GZcQCC0YlnzkhTFsCz0cTVSy3
	 6sz9BAZc300lQGtkX2CHoMR5vApFKJw9pW0UkZmUiDh5LWW0tIayT655MD+TQOomUP
	 YbzDl2oqhsNNZPI4AY5igAX6CK/uJCkchUKlmsaYgsu8esc7djv8JlizLmBpPc0sqo
	 mEnMsojV88aH5gqVZ2n3ix5Yu6PfqEhLoQve1GIEhuHCopXZQtyJqKEVhfzeGBbu8g
	 yBBPSCfloMOZx1HuTR0X6RRJDtjL/JSGLdAG6c5myCc5NIFJjdQprXwVmIjhzhEXlO
	 I2ZvqLD/p6Klw==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 20:46:21 +0200
Message-Id: <DJFSV0OS9NEG.G9W8K1OHQ8D5@kernel.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for
 synchronize_rcu()
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Lyude
 Paul" <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Christian
 Schrefl" <chrisi.schrefl@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <rcu@vger.kernel.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-3-phasta@kernel.org>
In-Reply-To: <20260622173250.411377-3-phasta@kernel.org>

On Mon Jun 22, 2026 at 7:32 PM CEST, Philipp Stanner wrote:
> +/// Wait for one RCU grace period.
> +///
> +/// You typically do this to wait for everyone holding a [`Guard`].

NIT: "typically" reads a bit as if there were other reasons to call
synchronize_rcu() than to wait for all concurrent RCU read side critical
sections.

Also, while it's implicit, it might still be worth to explicitly call out t=
hat
this means concurrently held Guard objects (concurrent read side critical
sections), i.e. subsequent read side critical sections may still run
concurrently.

> +#[inline]
> +pub fn synchronize_rcu() {
> +    // SAFETY: `synchronize_rcu()` is always safe to be called. It just =
waits for a grace period.
> +    unsafe { bindings::synchronize_rcu() };
> +}
> --=20
> 2.54.0

