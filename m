Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8189C2D1;
	Mon, 27 Jan 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978543; cv=none; b=jS3Rz9dweL6CJOUM5XT0TWcfzRDgXbr2bIOYmuqrGGTwyqvKMgHtf007mO6p5ybxQMzBVZnxfPATAOOhjlDQaLtSWdQd+9VlEoS/r7LNZTFihcI0BR0IogYxl/+Iv9JwC3IfaxVDLVqGc19r3bB0HAC6WGiIncZ29d/8TMYokIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978543; c=relaxed/simple;
	bh=CLNjcx/RRZ5lFASlZ9QtVe/8pLthVs2eF4jSlHiSqNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQfa786wngVTZ9mLqI11lUMc6Iki15mOhqUmFJ1aVEdzFNE920x1BEo7fFmrKy3b+rZAfQRz6XN8u+4K+opwiCxd0hprgMCqBc9SlS2tHQ9WyiYcqjHQoWSn+GiYqGM3DZ7ZilsgNkbFFYzPlyWQDVgpeGz/9hDT6jsbeL3ZIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=LOweZGQP; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="LOweZGQP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CLNjcx/RRZ5lFASlZ9QtVe/8pLthVs2eF4jSlHiSqNs=; b=LOweZGQPOztA8q2wHK3gHVIKqv
	nfNPZ1hQYcD80GQAYW9PzbiYxchGyKBDYXyGzaT4GJqr0M/bp5QMl7h53jFlOQxckJ6cQNbKeAvgA
	UeERi6gZAtyzl/iBvrRF89H7jUPuxbOOCJsnATQLKAdSaUkW+4NCF+XHv6j9nIf92F/JBABjCa/pk
	z+QWJa+U7beDwEQDegqSHmQ0m4pq2maP+b3QCE7XmjzJ7yL1fKarGre9wng1tU6KczqvmSHUS+W4o
	g7Wa3gg6MuWFf9Yp4D6iy0DEB5GgPYx8+lGUAeIevhCSpr5xEEF/nkj2h2JYc72Xie1boXKw2pz/2
	r+5KGNkw==;
Received: from minute.unseen.parts ([139.162.151.61]:35262 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tcNbX-00031C-1H;
	Mon, 27 Jan 2025 12:48:35 +0100
Date: Mon, 27 Jan 2025 12:48:33 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5dykQAAMSo6r8oS@minute>
References: <Z5UAFAD6xCSpKJYw@minute>
 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
 <Z5Uit9F7xF0ZlMk2@minute>
 <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
 <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>
 <Z5U__sztq2P2UKWk@minute>
 <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk>
 <Z5Vtl8PzOY66bp9K@minute>
 <Z5Y__QtiySs8UeTK@minute>
 <CA+=Fv5QOxs4mp0CEiyhFQJNxunye1aJMXDSzZ5U04QeQEYzt+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5QOxs4mp0CEiyhFQJNxunye1aJMXDSzZ5U04QeQEYzt+A@mail.gmail.com>

On Sun, Jan 26, 2025 at 08:15:41PM +0100, Magnus Lindholm wrote:
> I've applied the patches provided by Ivan, so far both systems are
> running fine, compiling kernels and such to provide some load.

Thanks, Magnus! I'm going to submit this patchset in a couple of days.

Ivan.
